-- Create table
CREATE TABLE client_entities (
    client_id INT PRIMARY KEY,
    client_name TEXT,
    tax_id TEXT,
    contact_email TEXT,
    billing_id TEXT
);

-- Insert sample data (with some quality issues)
INSERT INTO client_entities VALUES
(1, 'Acme Catering', 'TX12345', 'info@acme.com', 'BILL001'),
(2, 'FoodCorp', NULL, 'support@foodcorp.com', 'BILL002'),
(3, 'EventEats', 'TX54321', 'eventeats@@email.com', NULL),
(4, 'DeliFresh', '', '', 'BILL004'),
(5, 'PlatePro', 'TX77777', 'contact@platepro.com', 'BILL005');

-- Validation View: Flag data issues
CREATE VIEW data_quality_issues AS
SELECT
    client_id,
    client_name,
    CASE 
        WHEN tax_id IS NULL OR TRIM(tax_id) = '' THEN 'Missing Tax ID'
        ELSE NULL END AS tax_issue,
    CASE 
        WHEN contact_email NOT LIKE '%@%.%' OR contact_email LIKE '%@@%' THEN 'Invalid Email'
        ELSE NULL END AS contact_issue,
    CASE 
        WHEN billing_id IS NULL OR TRIM(billing_id) = '' THEN 'Missing Billing ID'
        ELSE NULL END AS billing_issue
FROM client_entities
WHERE 
    tax_id IS NULL OR TRIM(tax_id) = ''
    OR contact_email NOT LIKE '%@%.%' OR contact_email LIKE '%@@%'
    OR billing_id IS NULL OR TRIM(billing_id) = '';
