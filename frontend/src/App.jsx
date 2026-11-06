import { useEffect, useState } from 'react'

const API_URL = import.meta.env.VITE_API_URL || 'http://127.0.0.1:8001'

const initialForm = {
  name: 'Rahul Sharma',
  age: '30',
  monthly_income: '80000',
  years_employed: '5',
  requested_loan_amount: '3000000',
  property_value: '4000000',
  existing_monthly_emi: '5000',
  tenure_years: '20',
  model_type: 'lt',
  bureau_score_1: '0.65',
  bureau_score_2: '0.70',
  bureau_score_3: '0.75',
  employment_type: 'salaried',
  identity_verified: true,
  address_verified: true,
  income_verified: true,
  property_verified: true,
}

function App() {
  const [apiStatus, setApiStatus] = useState('Checking...')
  const [models, setModels] = useState([])
  const [form, setForm] = useState(initialForm)
  const [result, setResult] = useState(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    async function loadDashboard() {
      try {
        const response = await fetch(`${API_URL}/`)
        if (!response.ok) throw new Error('Backend unavailable')
        const health = await response.json()
        setApiStatus(health.status)

        const modelResponse = await fetch(`${API_URL}/api/v1/models`)
        if (!modelResponse.ok) throw new Error('Models API failed')
        const data = await modelResponse.json()
        setModels(data.models || [])
      } catch (err) {
        setApiStatus('Disconnected')
        setError(err.message)
      }
    }
    loadDashboard()
  }, [])

  function updateField(event) {
    setForm({ ...form, [event.target.name]: event.target.value })
  }

  function updateCheckbox(event) {
    setForm({ ...form, [event.target.name]: event.target.checked })
  }

  async function submitApplication(event) {
    event.preventDefault()
    setLoading(true)
    setError('')
    setResult(null)

    const number = (key) => Number(form[key])

    const payload = {
      application_id: `LG-${Date.now()}`,
      model_type: form.model_type,
      declared_name: form.name,
      credit_data: form.model_type === 'lt'
        ? {
            bureau_score: 780,
            credit_history_years: 8,
            loan_amount: number('requested_loan_amount'),
            ltv: (number('requested_loan_amount') / number('property_value')) * 100,
            employment_type: form.employment_type,
          }
        : {
            bureau_score_1: number('bureau_score_1'),
            bureau_score_2: number('bureau_score_2'),
            bureau_score_3: number('bureau_score_3'),
            loan_to_price: number('requested_loan_amount') / number('property_value'),
            years_employed: number('years_employed'),
            employment_type: form.employment_type,
          },
      eligibility_data: {
        age: number('age'),
        monthly_income: number('monthly_income'),
        years_employed: number('years_employed'),
        requested_loan_amount: number('requested_loan_amount'),
        property_value: number('property_value'),
        existing_monthly_emi: number('existing_monthly_emi'),
        tenure_years: number('tenure_years'),
      },
      document_verification: {
        verification_status: (
          form.identity_verified &&
          form.address_verified &&
          form.income_verified &&
          form.property_verified
        ) ? 'matched' : 'mismatch',
        identity_verified: form.identity_verified,
        address_verified: form.address_verified,
        income_verified: form.income_verified,
        property_verified: form.property_verified,
        mismatches: [
          ...(!form.identity_verified ? ['Identity verification incomplete'] : []),
          ...(!form.address_verified ? ['Address verification incomplete'] : []),
          ...(!form.income_verified ? ['Income verification incomplete'] : []),
          ...(!form.property_verified ? ['Property verification incomplete'] : []),
        ],
      },
    }

    try {
      const response = await fetch(`${API_URL}/api/v1/underwriting/evaluate`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      })

      const data = await response.json()
      if (!response.ok) {
        throw new Error(JSON.stringify(data.detail || data))
      }
      setResult(data)
    } catch (err) {
      setError(err.message)
    } finally {
      setLoading(false)
    }
  }

  const inputClass = 'mt-1 w-full rounded-lg border border-slate-300 bg-white px-3 py-3 text-sm outline-none focus:border-cyan-500 focus:ring-2 focus:ring-cyan-100'
  const labelClass = 'block text-sm font-medium text-slate-700'

  function field(label, name, type = 'number', step = 'any') {
    return (
      <label className={labelClass}>
        {label}
        <input
          className={inputClass}
          type={type}
          name={name}
          value={form[name]}
          onChange={updateField}
          step={type === 'number' ? step : undefined}
          min={type === 'number' ? '0' : undefined}
          required
        />
      </label>
    )
  }

  return (
    <div className="min-h-screen bg-slate-50 text-slate-800 md:flex">
      <aside className="w-full bg-slate-950 p-6 text-white md:min-h-screen md:w-64">
        <h1 className="text-2xl font-bold">
          LoanGuard <span className="text-cyan-400">AI</span>
        </h1>
        <p className="mt-1 text-xs text-slate-400">Mortgage Underwriting Platform</p>

        <nav className="mt-10 space-y-3">
          {['Dashboard', 'New Application', 'Credit Assessment', 'Document Verification', 'Fraud Detection', 'Audit Logs'].map((item, index) => (
            <a
              key={item}
              href={index === 1 ? '#application' : '#dashboard'}
              className={`block rounded-lg px-4 py-3 text-sm ${
                index === 0
                  ? 'bg-cyan-500 font-semibold text-slate-950'
                  : 'text-slate-300 hover:bg-slate-800'
              }`}
            >
              {item}
            </a>
          ))}
        </nav>

        <div className="mt-12 rounded-xl border border-slate-700 p-4">
          <p className="text-sm font-semibold">Backend Status</p>
          <p className={`mt-2 text-xs ${apiStatus === 'Disconnected' ? 'text-red-400' : 'text-emerald-400'}`}>
            ● {apiStatus}
          </p>
          <p className="mt-2 text-xs text-slate-400">{API_URL}</p>
        </div>
      </aside>

      <main id="dashboard" className="min-w-0 flex-1 p-6 md:p-9">
        <header className="mb-8">
          <h2 className="text-3xl font-bold">LoanGuard AI Dashboard</h2>
          <p className="mt-2 text-sm text-slate-500">
            AI-powered mortgage underwriting prototype
          </p>
        </header>

        <section className="grid gap-5 sm:grid-cols-3">
          <div className="rounded-2xl border bg-white p-5 shadow-sm">
            <p className="text-sm text-slate-500">Backend Connection</p>
            <h3 className="mt-3 text-xl font-bold">{apiStatus}</h3>
          </div>
          <div className="rounded-2xl border bg-white p-5 shadow-sm">
            <p className="text-sm text-slate-500">Available Models</p>
            <h3 className="mt-3 text-3xl font-bold">{models.length}</h3>
          </div>
          <div className="rounded-2xl border bg-white p-5 shadow-sm">
            <p className="text-sm text-slate-500">Platform</p>
            <h3 className="mt-3 text-xl font-bold">LoanGuard AI</h3>
          </div>
        </section>

        <section id="application" className="mt-8 rounded-2xl border bg-white p-6 shadow-sm">
          <h3 className="text-xl font-bold">New Loan Application</h3>
          <p className="mb-6 mt-1 text-sm text-slate-500">
            Enter applicant and financial details for prototype underwriting
          </p>

          <form onSubmit={submitApplication} className="space-y-7">
            <div>
              <h4 className="mb-4 font-semibold text-slate-800">1. Applicant Details</h4>
              <div className="grid gap-4 md:grid-cols-3">
                {field('Applicant Name', 'name', 'text')}
                {field('Age (years)', 'age')}
                {field('Monthly Income (₹)', 'monthly_income')}
                {field('Years Employed', 'years_employed')}
                <label className={labelClass}>
                  Employment Type
                  <select className={inputClass} name="employment_type" value={form.employment_type} onChange={updateField}>
                    <option value="salaried">Salaried</option>
                    <option value="self_employed">Self Employed</option>
                    <option value="pensioner">Pensioner</option>
                    <option value="other">Other</option>
                  </select>
                </label>
              </div>
            </div>

            <div className="rounded-xl border border-cyan-100 bg-cyan-50/50 p-4">
              <h4 className="font-semibold text-slate-800">Demo Document Verification</h4>
              <p className="mb-4 mt-1 text-xs text-slate-500">
                Test inputs only. These checkboxes do not perform actual KYC or document verification.
              </p>
              <div className="grid gap-3 sm:grid-cols-2">
                {[
                  ['identity_verified', 'Identity verification'],
                  ['address_verified', 'Address verification'],
                  ['income_verified', 'Income verification'],
                  ['property_verified', 'Property verification'],
                ].map(([name, label]) => (
                  <label key={name} className="flex items-center gap-2 text-sm text-slate-700">
                    <input
                      type="checkbox"
                      name={name}
                      checked={form[name]}
                      onChange={updateCheckbox}
                      className="h-4 w-4 accent-cyan-600"
                    />
                    {label}
                  </label>
                ))}
              </div>
            </div>

            <div>
              <h4 className="mb-4 font-semibold text-slate-800">2. Loan Details</h4>
              <div className="grid gap-4 md:grid-cols-3">
                {field('Requested Loan Amount (₹)', 'requested_loan_amount')}
                {field('Property Value (₹)', 'property_value')}
                {field('Existing Monthly EMI (₹)', 'existing_monthly_emi')}
                {field('Loan Tenure (years)', 'tenure_years')}
              </div>
            </div>

            <div>
              <h4 className="mb-2 font-semibold text-slate-800">3. Credit Assessment Inputs</h4>
              <p className="mb-4 text-xs text-amber-700">
                Demo inputs only. Replace with verified bureau data in a real deployment.
              </p>
              <div className="grid gap-4 md:grid-cols-3">
                {field('Bureau Feature 1 (0–1)', 'bureau_score_1')}
                {field('Bureau Feature 2 (0–1)', 'bureau_score_2')}
                {field('Bureau Feature 3 (0–1)', 'bureau_score_3')}
              </div>
            </div>

            <div>
              <h4 className="mb-4 font-semibold text-slate-800">4. Model Selection</h4>
              <select className={inputClass} name="model_type" value={form.model_type} onChange={updateField}>
                {models.map((model) => (
                  <option key={model.model_type} value={model.model_type}>
                    {model.name}
                  </option>
                ))}
                {models.length === 0 && <option value="lt">L&T Model</option>}
                {models.length === 0 && <option value="home_credit">Home Credit Model</option>}
              </select>
            </div>

            <button
              type="submit"
              disabled={loading || apiStatus === 'Disconnected'}
              className="w-full rounded-xl bg-slate-950 px-6 py-4 font-semibold text-white hover:bg-cyan-700 disabled:cursor-not-allowed disabled:opacity-50 md:w-auto"
            >
              {loading ? 'Evaluating Application...' : 'Run AI Underwriting →'}
            </button>
          </form>
        </section>

        {error && (
          <section className="mt-6 rounded-xl border border-red-200 bg-red-50 p-5 text-sm text-red-700">
            <strong>API Error:</strong> {error}
          </section>
        )}

        {result && (() => {
          const data = result.underwriting_result || {};
          const credit = data.credit_assessment || {};
          const eligibility = data.eligibility_assessment || {};
          const fraud = data.fraud_assessment || {};
          const documents = data.document_verification || {};
          const explanation = result.explanation || {};
          const reasons = [
            ...(data.decision_reasons?.rejection_reasons || []),
            ...(data.decision_reasons?.review_reasons || []),
            ...(explanation.decision_reasons || []),
          ];
          const finalDecision = data.final_decision || 'UNKNOWN';
          const finalStyle = finalDecision === 'APPROVE'
            ? 'bg-emerald-100 text-emerald-800'
            : finalDecision === 'REJECT'
              ? 'bg-red-100 text-red-800'
              : 'bg-amber-100 text-amber-800';

          const metricCards = [
            { label: 'Credit Score', value: credit.score ?? 'N/A', note: `Grade ${credit.grade || 'N/A'}` },
            { label: 'Probability of Default', value: credit.probability_of_default != null ? `${(credit.probability_of_default * 100).toFixed(2)}%` : 'N/A', note: 'Model estimate' },
            { label: 'Eligibility', value: eligibility.decision || 'N/A', note: eligibility.status || 'No status' },
            { label: 'Fraud Risk', value: fraud.risk_level || 'N/A', note: `Risk score: ${fraud.risk_score ?? 'N/A'}` },
            { label: 'Loan-to-Value', value: eligibility.metrics?.ltv_percent != null ? `${eligibility.metrics.ltv_percent}%` : 'N/A', note: 'LTV ratio' },
            { label: 'Debt-to-Income', value: eligibility.metrics?.dti_percent != null ? `${eligibility.metrics.dti_percent}%` : 'N/A', note: 'DTI ratio' },
          ];

          return (
            <section className="mt-8 rounded-2xl border bg-white p-6 shadow-sm">
              <div className="flex flex-wrap items-center justify-between gap-4">
                <div>
                  <p className="text-sm font-semibold uppercase tracking-wider text-cyan-700">NIRNAY AI · Decision Engine</p>
                  <h3 className="mt-1 text-2xl font-bold">Underwriting Result</h3>
                  <p className="mt-1 text-sm text-slate-500">Application: {data.application_id || 'Evaluated'}</p>
                </div>
                <span className={`rounded-xl px-6 py-3 text-xl font-extrabold ${finalStyle}`}>
                  {finalDecision}
                </span>
              </div>

              <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
                {metricCards.map((item) => (
                  <div key={item.label} className="rounded-xl border border-slate-200 bg-slate-50 p-5">
                    <p className="text-sm text-slate-500">{item.label}</p>
                    <p className="mt-2 text-2xl font-bold text-slate-900">{item.value}</p>
                    <p className="mt-1 text-xs text-slate-500">{item.note}</p>
                  </div>
                ))}
              </div>

              <div className="mt-6 grid gap-5 lg:grid-cols-2">
                <div className="rounded-xl border p-5">
                  <h4 className="font-bold">Document Verification</h4>
                  <p className="mt-2 text-lg font-semibold">{documents.verification_status || 'Not provided'}</p>
                  <div className="mt-3 space-y-2 text-sm">
                    {[
                      ['Identity', documents.identity_verified],
                      ['Address', documents.address_verified],
                      ['Income', documents.income_verified],
                      ['Property', documents.property_verified],
                    ].map(([label, verified]) => (
                      <div key={label} className="flex justify-between border-b border-slate-100 pb-2">
                        <span>{label}</span>
                        <span className={verified ? 'font-semibold text-emerald-700' : 'font-semibold text-amber-700'}>
                          {verified === true ? 'Verified (demo input)' : 'Pending'}
                        </span>
                      </div>
                    ))}
                  </div>
                </div>

                <div className="rounded-xl border p-5">
                  <h4 className="font-bold">Decision Explanation</h4>
                  <p className="mt-2 text-sm leading-6 text-slate-600">
                    {explanation.decision_summary || 'No explanation available.'}
                  </p>
                  <p className="mt-4 text-sm font-semibold">Risk factors</p>
                  <div className="mt-2 space-y-2">
                    {(explanation.risk_factors || []).map((factor, index) => (
                      <div key={index} className="flex justify-between gap-3 text-sm">
                        <span>{factor.factor}</span>
                        <span className={factor.impact === 'Positive' ? 'text-emerald-700' : 'text-amber-700'}>
                          {factor.points > 0 ? '+' : ''}{factor.points} pts
                        </span>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              <div className="mt-5 rounded-xl border p-5">
                <h4 className="font-bold">Decision Reasons</h4>
                {reasons.length > 0 ? (
                  <ul className="mt-3 list-disc space-y-2 pl-5 text-sm text-slate-600">
                    {[...new Set(reasons)].map((reason, index) => <li key={index}>{reason}</li>)}
                  </ul>
                ) : (
                  <p className="mt-2 text-sm text-emerald-700">No rejection or manual-review reasons reported.</p>
                )}
              </div>

              <div className="mt-5 flex flex-wrap items-center justify-between gap-3 rounded-xl bg-slate-900 p-5 text-white">
                <div>
                  <p className="font-semibold">Audit Trail</p>
                  <p className="mt-1 text-sm text-slate-300">Application: {result.audit?.application_id || data.application_id || 'N/A'}</p>
                </div>
                <span className="rounded-lg bg-emerald-900 px-4 py-2 text-sm font-semibold text-emerald-200">
                  {result.audit?.audit_status || 'Not available'}
                </span>
              </div>

              <details className="mt-5 rounded-xl border p-4">
                <summary className="cursor-pointer text-sm font-semibold">View complete API response (technical details)</summary>
                <pre className="mt-4 max-h-96 overflow-auto rounded-xl bg-slate-950 p-5 text-xs leading-6 text-emerald-300">
                  {JSON.stringify(result, null, 2)}
                </pre>
              </details>
              <p className="mt-4 text-xs text-slate-500">
                Prototype result based on configured demo rules and model inputs. Not an actual lending approval or verified KYC decision.
              </p>
            </section>
          );
        })()}

        <p className="mt-8 text-center text-xs text-slate-400">
          LoanGuard AI · Hackathon Prototype · Demo underwriting only
        </p>
      </main>
    </div>
  )
}

export default App
