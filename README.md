<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
 
</head>
<body>

  <h1>📋 Client Entity Data Quality & Compliance Dashboard</h1>

  <p>This project implements a data validation system for 2,000+ catering client records to identify inconsistencies in tax IDs, contact emails, and billing information. The goal is to enhance audit readiness and improve client data integrity using SQL, Excel (VBA), and Tableau.</p>

  <h2>🔧 Tools Used</h2>
  <ul>
    <li>SQL (SQLite or MS Access)</li>
    <li>Excel (VBA macro-enabled)</li>
    <li>Tableau (or Power BI) for dashboard visualization</li>
  </ul>

  <h2>📂 Files Overview</h2>
  <ul>
    <li><strong>setup_and_checks.sql</strong>: SQL code to create the table, insert sample data, and detect data quality issues</li>
    <li><strong>ExportIssues.bas</strong>: Excel VBA macro to export issue data from SQL into a formatted worksheet</li>
    <li><strong>client_data.accdb</strong>: Example database file (if using Access/SQLite)</li>
  </ul>

  <h2>▶️ How to Run</h2>

  <h3>1. Setup Database</h3>
  <p>Create your database (SQLite or Access) and run the contents of <code>setup_and_checks.sql</code> to:</p>
  <ul>
    <li>Create the <code>client_entities</code> table</li>
    <li>Insert example records</li>
    <li>Create a <code>data_quality_issues</code> view</li>
  </ul>

  <h3>2. Export Issues to Excel</h3>
  <p>Open Excel and press <strong>Alt + F11</strong> to open the VBA Editor. Insert a new module and paste the contents of <code>ExportIssues.bas</code>.</p>
  <p>Create a new worksheet named <code>Issues</code> in your Excel file. Update the connection string in the macro to match your local database path. Run the macro to pull issue data into Excel.</p>

  <h3>3. Visualize in Tableau</h3>
  <p>Connect Tableau to your database and use the <code>data_quality_issues</code> view as the data source.</p>
  <ul>
    <li>Create bar charts by issue type (e.g., Missing Tax ID, Invalid Email)</li>
    <li>Add filters by client name or issue category</li>
    <li>Display total flagged clients and percentages</li>
  </ul>

  <h2>✅ Validations Performed</h2>
  <ul>
    <li>Missing or empty Tax ID</li>
    <li>Improper or malformed email addresses</li>
    <li>Missing or empty Billing ID</li>
  </ul>

  <h2>📊 Optional: Data Quality Scoring</h2>
  <p>Use an additional SQL query to assign a quality score (0–100) to each client based on how complete their records are.</p>
  <pre>
SELECT 
  client_id,
  client_name,
  100 
  - (CASE WHEN tax_id IS NULL OR TRIM(tax_id) = '' THEN 33 ELSE 0 END)
  - (CASE WHEN contact_email NOT LIKE '%@%.%' OR contact_email LIKE '%@@%' THEN 33 ELSE 0 END)
  - (CASE WHEN billing_id IS NULL OR TRIM(billing_id) = '' THEN 34 ELSE 0 END)
  AS quality_score
FROM client_entities;
  </pre>

  <div class="note">
    <strong>Note:</strong> You can expand this project to include automated email alerts, audit trail logging, or integrate with CRM systems for real-time sync.
  </div>

</body>
</html>
