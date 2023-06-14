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

-- Create join table for patient and treatments (many-to-many relationship)
CREATE TABLE Patient_Treatments (
  patient_id INT,
  treatment_id INT,
  PRIMARY KEY (patient_id, treatment_id),
  FOREIGN KEY (patient_id) REFERENCES Patient(id),
  FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- Create join table for medical_histories and treatments (many-to-many relationship)
CREATE TABLE Medical_History_Treatments (
  medical_history_id INT,
  treatment_id INT,
  PRIMARY KEY (medical_history_id, treatment_id),
  FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id),
  FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);

-- Add indexes for foreign keys
CREATE INDEX idx_patient_treatments_patient_id ON Patient_Treatments (patient_id);
CREATE INDEX idx_patient_treatments_treatment_id ON Patient_Treatments (treatment_id);
CREATE INDEX idx_medical_history_treatments_medical_history_id ON Medical_History_Treatments (medical_history_id);
CREATE INDEX idx_medical_history_treatments_treatment_id ON Medical_History_Treatments (treatment_id);
