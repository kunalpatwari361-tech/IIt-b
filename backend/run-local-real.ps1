# Real mode on this laptop, for testing with your own phone over USB.
#   powershell -ExecutionPolicy Bypass -File backend\run-local-real.ps1
# - Real applicants: no demo people or sample documents.
# - Sign-in codes are random and printed HERE, in this terminal, instead of being sent by SMS
#   (console mode). Only ever run this on your own laptop.
# - Every step is saved as it happens in backend\var\real\nirnay.db (git-ignored), or in
#   Supabase if you set DATABASE_URL before running this.
# - The phone reaches the server through the USB cable (adb reverse), so keep it plugged in.
# - With -Lan, phones on the same Wi-Fi can reach it too (app built by app\build-wifi-apk.ps1).
#   Windows asks once whether Python may accept connections: allow Private networks only.
#   Anyone on your Wi-Fi can then open the sign-in screen; the codes still appear only here.
# - With -Twilio, sign-in codes go by real SMS through Twilio Verify instead. The script asks for
#   the Account SID and the Auth Token. Leave the Verify Service SID blank and it makes (or reuses)
#   a Verify service named "Nirnay" in your Twilio account. It checks the token with Twilio before
#   starting, and remembers the two SIDs (not secret) in backend\var\real\twilio-ids.txt, so next
#   time only the token is asked for. The token itself is never saved: it lives only in this
#   server process (never put it in a file, the repo or a chat). On a Twilio trial account, only
#   numbers you have verified in the Twilio console can receive the texts.
param([switch]$Lan, [switch]$Twilio)
$ErrorActionPreference = "Stop"
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

function Stop-With([string]$why) {
    Write-Host ""
    Write-Host "Stopped: $why" -ForegroundColor Red
    Write-Host "Run the same command again to retry."
    exit 1
}

$env:NIRNAY_SANDBOX = "0"
if (-not $env:NIRNAY_VAR_DIR) { $env:NIRNAY_VAR_DIR = Join-Path $root "backend\var\real" }
New-Item -ItemType Directory -Force $env:NIRNAY_VAR_DIR | Out-Null
if ($Twilio) {
    $idsFile = Join-Path $env:NIRNAY_VAR_DIR "twilio-ids.txt"
    $saved = @{}
    if (Test-Path $idsFile) {
        foreach ($line in Get-Content $idsFile) {
            $kv = $line -split '=', 2
            if ($kv.Count -eq 2 -and $kv[1].Trim()) { $saved[$kv[0].Trim()] = $kv[1].Trim() }
        }
    }
    if (-not $env:TWILIO_ACCOUNT_SID -and $saved["TWILIO_ACCOUNT_SID"]) { $env:TWILIO_ACCOUNT_SID = $saved["TWILIO_ACCOUNT_SID"] }
    if (-not $env:TWILIO_VERIFY_SERVICE_SID -and $saved["TWILIO_VERIFY_SERVICE_SID"]) { $env:TWILIO_VERIFY_SERVICE_SID = $saved["TWILIO_VERIFY_SERVICE_SID"] }

    if ($env:TWILIO_ACCOUNT_SID) { Write-Host "Twilio Account SID: $env:TWILIO_ACCOUNT_SID" }
    else { $env:TWILIO_ACCOUNT_SID = (Read-Host "Twilio Account SID (starts with AC)").Trim() }
    if ($env:TWILIO_ACCOUNT_SID -notmatch '^AC[0-9a-fA-F]{32}$') {
        Remove-Item Env:TWILIO_ACCOUNT_SID
        Stop-With "the Account SID should be AC followed by 32 letters and digits (Twilio console home page)."
    }
    if (-not $env:TWILIO_AUTH_TOKEN) {
        $secret = Read-Host "Twilio Auth Token (typing is hidden)" -AsSecureString
        $bstr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secret)
        try { $env:TWILIO_AUTH_TOKEN = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($bstr).Trim() }
        finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr) }
    }
    if ($env:TWILIO_AUTH_TOKEN.Length -lt 32) { Stop-With "the Auth Token looks too short (it is 32 letters and digits)." }

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $pair = "$($env:TWILIO_ACCOUNT_SID):$($env:TWILIO_AUTH_TOKEN)"
    $auth = @{ Authorization = "Basic " + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($pair)) }
    $verify = "https://verify.twilio.com/v2/Services"

    if (-not $env:TWILIO_VERIFY_SERVICE_SID) {
        $answer = (Read-Host "Twilio Verify Service SID (starts with VA). Leave blank to use one named Nirnay, made now if needed").Trim()
        if ($answer) {
            $env:TWILIO_VERIFY_SERVICE_SID = $answer
        } else {
            try {
                $list = Invoke-RestMethod -Uri "${verify}?PageSize=50" -Headers $auth
                $svc = $list.services | Where-Object { $_.friendly_name -eq "Nirnay" } | Select-Object -First 1
                if ($svc) { Write-Host "Verify service: using your existing 'Nirnay' service." }
                else {
                    $svc = Invoke-RestMethod -Method Post -Uri $verify -Headers $auth -Body @{ FriendlyName = "Nirnay" }
                    Write-Host "Verify service: made a new one named 'Nirnay' in your Twilio account."
                }
                $env:TWILIO_VERIFY_SERVICE_SID = $svc.sid
            } catch {
                Stop-With "Twilio did not accept the Account SID and Auth Token ($($_.Exception.Message)). Check both in the Twilio console."
            }
        }
    }
    if ($env:TWILIO_VERIFY_SERVICE_SID -notmatch '^VA[0-9a-fA-F]{32}$') {
        Stop-With "the Verify Service SID should be VA followed by 32 letters and digits. Leave it blank next time and the script makes one."
    }
    # One call to Twilio before starting, so a wrong token shows up now, not at the first sign-in.
    try { $null = Invoke-RestMethod -Uri "$verify/$($env:TWILIO_VERIFY_SERVICE_SID)" -Headers $auth }
    catch { Stop-With "Twilio refused the details ($($_.Exception.Message)). Check the Auth Token, and that the Verify service belongs to this account." }
    Set-Content -Path $idsFile -Encoding ASCII -Value @(
        "# Twilio IDs for backend\run-local-real.ps1 -Twilio. Not secret; the Auth Token is never saved.",
        "TWILIO_ACCOUNT_SID=$($env:TWILIO_ACCOUNT_SID)",
        "TWILIO_VERIFY_SERVICE_SID=$($env:TWILIO_VERIFY_SERVICE_SID)")
    Write-Host "Twilio:    details accepted. Verify service $($env:TWILIO_VERIFY_SERVICE_SID)"
    $env:NIRNAY_SMS_PROVIDER = "twilio"
    Remove-Item Env:NIRNAY_ALLOW_CONSOLE_OTP -ErrorAction SilentlyContinue
} else {
    $env:NIRNAY_SMS_PROVIDER = "console"
    $env:NIRNAY_ALLOW_CONSOLE_OTP = "1"
}
if (-not $env:NIRNAY_STAFF_KEY) { $env:NIRNAY_STAFF_KEY = [guid]::NewGuid().ToString("N") }

$adb = Join-Path $env:LOCALAPPDATA "Android\Sdk\platform-tools\adb.exe"
if (Test-Path $adb) {
    # adb writes "daemon not running; starting now" to stderr; Windows PowerShell would treat
    # that as an error under "Stop", so run it through cmd and judge by the exit code only.
    cmd /c "`"$adb`" reverse tcp:8000 tcp:8000 >nul 2>&1"
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Phone link: adb reverse tcp:8000 -> this laptop (keep the USB cable in)"
    } else {
        Write-Host "Phone link: NO PHONE FOUND. Plug it in with USB debugging on, then run: adb reverse tcp:8000 tcp:8000"
    }
}
$db = if ($env:DATABASE_URL) { "Supabase / PostgreSQL (DATABASE_URL)" } else { Join-Path $env:NIRNAY_VAR_DIR "nirnay.db" }
Write-Host "Database:  $db"
Write-Host "Staff key: $env:NIRNAY_STAFF_KEY   (for /v1/staff/... calls, header X-Staff-Key)"
$hostAddr = "127.0.0.1"
if ($Lan) {
    $hostAddr = "0.0.0.0"
    $wifi = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias "Wi-Fi*" -ErrorAction SilentlyContinue |
             Where-Object { $_.IPAddress -notmatch '^169\.254' } | Select-Object -First 1).IPAddress
    Write-Host "Wi-Fi:     phones on this Wi-Fi use http://${wifi}:8000 (build the app with app\build-wifi-apk.ps1 -Ip $wifi)"
}
if ($Twilio) {
    Write-Host "Sign-in:   codes go by SMS through Twilio Verify. If one is refused, Twilio's reason appears below."
} else {
    Write-Host "Sign-in codes will appear below."
}
Write-Host "Stop the server with Ctrl+C."
Write-Host "Server:    http://${hostAddr}:8000 (this window shows only sign-in codes and errors)"
# No request log, and only errors from the web server: other programs on this laptop that poll
# port 8000 would otherwise bury the sign-in codes under their 404s and WebSocket warnings.
& (Join-Path $root ".venv\Scripts\python.exe") -m uvicorn backend.app:app --host $hostAddr --port 8000 --no-access-log --log-level error
