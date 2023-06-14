-- Table: Patient
CREATE TABLE Patient (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth DATE
);

-- Table: Medical_Histories
CREATE TABLE Medical_Histories (
  id INT PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(100),
  FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

-- Table: Invoices
CREATE TABLE Invoices (
  id INT PRIMARY KEY,
  total_amount DECIMAL(10, 2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id)
);

-- Table: Treatments
CREATE TABLE Treatments (
  id INT PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(100)
);

-- Table: Invoice_Items
CREATE TABLE Invoice_Items (
  id INT PRIMARY KEY,
  unit_price DECIMAL(10, 2),
  quantity INT,
  total_price DECIMAL(10, 2),
  invoice_id INT,
  treatment_id INT,
  FOREIGN KEY (invoice_id) REFERENCES Invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- Table: Medical_History_Treatments (for many-to-many relationship)
CREATE TABLE Medical_History_Treatments (
  medical_history_id INT,
  treatment_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id),
  FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- Add indexes for foreign keys
CREATE INDEX ON Medical_Histories (patient_id);
CREATE INDEX ON Invoices (medical_history_id);
CREATE INDEX ON Invoice_Items (invoice_id);
CREATE INDEX ON Invoice_Items (treatment_id);
CREATE INDEX ON Medical_History_Treatments (medical_history_id);
CREATE INDEX ON Medical_History_Treatments (treatment_id);
