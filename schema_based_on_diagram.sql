-- Table: Patient
CREATE TABLE Patient (
  id INT PRIMARY KEY,
  name VARCHAR(255),
  date_of_birth DATE
);

-- Table: Medical_Histories
CREATE TABLE Medical_Histories (
  id INT PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT,
  status VARCHAR(50),
  CONSTRAINT fk_patient_id FOREIGN KEY (patient_id) REFERENCES Patient(id)
);

CREATE INDEX idx_patient_id ON Patient(id);

-- Table: Treatments
CREATE TABLE Treatments (
  id INT PRIMARY KEY,
  type VARCHAR(255),
  name VARCHAR(255)
);

-- Table: Medical_History_Treatments (for many-to-many relationship)
CREATE TABLE Medical_History_Treatments (
  id INT PRIMARY KEY,  
  medical_history_id INT,
  treatment_id INT,
  CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id),
  CONSTRAINT fk_treatment_history_id FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);


CREATE INDEX idx_treatment_history ON Medical_History_Treatments (treatment_id, medical_history_id)

-- Table: Invoices
CREATE TABLE Invoices (
  id INT PRIMARY KEY,
  total_amount DECIMAL,
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT,
  CONSTRAINT fk_medical_history_id FOREIGN KEY (medical_history_id) REFERENCES Medical_Histories(id)
);


CREATE INDEX idx_invoice_medical_history_id ON Invoices (medical_history_id);

-- Table: Invoice_Items
CREATE TABLE Invoice_Items (
  id INT PRIMARY KEY,
  unit_price DECIMAL(10, 2),
  quantity INT,
  total_price DECIMAL(10, 2),
  invoice_id INT,
  treatment_id INT,
  CONSTRAINT fk_invoice_id FOREIGN KEY (invoice_id) REFERENCES Invoices(id),
  CONSTRAINT fk_treatment_id FOREIGN KEY (treatment_id) REFERENCES Treatments(id)
);


CREATE INDEX idx_invoice_items ON Invoice_Items(invoice_id, treatment_id);
