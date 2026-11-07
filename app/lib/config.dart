// Build settings, fixed when the app is built (flutter build ... --dart-define=...).

/// The engine to call, for example --dart-define=NIRNAY_API_URL=https://nirnay.example.com.
/// Left empty, the app runs on the built-in sample engine.
const engineUrl = String.fromEnvironment('NIRNAY_API_URL');

/// Real mode (--dart-define=NIRNAY_REAL=true): real applicants and real documents. The app shows
/// no demo people, sample documents, demo code or "Demo mode" banner, and the applicant types
/// their own details. Use it only with an engine running with NIRNAY_SANDBOX=0.
const realMode = bool.fromEnvironment('NIRNAY_REAL');

/// The demo extras (sample buttons, demo customers, the demo code) show only outside real mode.
const demoMode = !realMode;
