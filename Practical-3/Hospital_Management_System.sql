CREATE DATABASE IF NOT EXISTS hospital_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE hospital_db;

CREATE TABLE IF NOT EXISTS tbl_Patient (
    col_PatientID INT AUTO_INCREMENT PRIMARY KEY,
    col_PatientFirstName VARCHAR(100) NOT NULL,
    col_PatientLastName VARCHAR(100) NOT NULL,
    col_PatientDOB DATE,
    col_PatientGender ENUM('Male','Female','Other') DEFAULT 'Other',
    col_PatientPhone VARCHAR(20),
    col_PatientEmail VARCHAR(255),
    col_PatientNationalID VARCHAR(50), -- e.g. SSN/Aadhar - optional unique
    col_PatientCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY ux_tbl_Patient_NationalID (col_PatientNationalID),
    INDEX idx_tbl_Patient_LastName (col_PatientLastName),
    INDEX idx_tbl_Patient_Email (col_PatientEmail)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_PatientAddress (
    col_AddressID INT AUTO_INCREMENT PRIMARY KEY,
    col_PatientID INT NOT NULL,
    col_AddressLine1 VARCHAR(255) NOT NULL,
    col_AddressLine2 VARCHAR(255),
    col_City VARCHAR(100),
    col_State VARCHAR(100),
    col_PostalCode VARCHAR(20),
    col_Country VARCHAR(100),
    col_IsPrimary BOOLEAN DEFAULT FALSE,
    col_AddressCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_PatientAddress_tbl_Patient FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID) ON DELETE CASCADE,
    INDEX idx_tbl_PatientAddress_PatientID (col_PatientID),
    INDEX idx_tbl_PatientAddress_City (col_City)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_Doctor (
    col_DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    col_DoctorFirstName VARCHAR(100) NOT NULL,
    col_DoctorLastName VARCHAR(100) NOT NULL,
    col_DoctorPhone VARCHAR(20),
    col_DoctorEmail VARCHAR(255),
    col_DoctorSpecialization VARCHAR(100),
    col_LicenseNumber VARCHAR(100),
    col_DoctorCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY ux_tbl_Doctor_License (col_LicenseNumber),
    INDEX idx_tbl_Doctor_Specialization (col_DoctorSpecialization),
    INDEX idx_tbl_Doctor_LastName (col_DoctorLastName)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_Appointment (
    col_AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    col_PatientID INT NOT NULL,
    col_DoctorID INT NOT NULL,
    col_AppointmentDate DATETIME NOT NULL,
    col_AppointmentStatus ENUM('Scheduled','Completed','Cancelled','NoShow') DEFAULT 'Scheduled',
    col_AppointmentNotes TEXT,
    col_AppointmentCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_Appointment_tbl_Patient FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID) ON DELETE CASCADE,
    CONSTRAINT FK_tbl_Appointment_tbl_Doctor FOREIGN KEY (col_DoctorID) REFERENCES tbl_Doctor(col_DoctorID) ON DELETE RESTRICT,
    INDEX idx_tbl_Appointment_Date (col_AppointmentDate),
    INDEX idx_tbl_Appointment_Patient (col_PatientID),
    INDEX idx_tbl_Appointment_Doctor (col_DoctorID),
    INDEX idx_tbl_Appointment_Status (col_AppointmentStatus)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_Prescription (
    col_PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    col_AppointmentID INT, -- optional: prescription may be attached to an appointment
    col_PatientID INT NOT NULL,
    col_DoctorID INT NOT NULL,
    col_PrescriptionDate DATE DEFAULT (CURRENT_DATE),
    col_Diagnosis TEXT,
    col_Instructions TEXT,
    col_PrescriptionCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_Prescription_tbl_Appointment FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID) ON DELETE SET NULL,
    CONSTRAINT FK_tbl_Prescription_tbl_Patient FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID) ON DELETE CASCADE,
    CONSTRAINT FK_tbl_Prescription_tbl_Doctor FOREIGN KEY (col_DoctorID) REFERENCES tbl_Doctor(col_DoctorID) ON DELETE RESTRICT,
    INDEX idx_tbl_Prescription_Date (col_PrescriptionDate),
    INDEX idx_tbl_Prescription_Patient (col_PatientID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_PrescriptionItem (
    col_PrescriptionItemID INT AUTO_INCREMENT PRIMARY KEY,
    col_PrescriptionID INT NOT NULL,
    col_ItemName VARCHAR(255) NOT NULL, -- medicine name or procedure
    col_ItemType ENUM('Medicine','Procedure','Test','Other') DEFAULT 'Medicine',
    col_Dosage VARCHAR(100), -- e.g. "500mg"
    col_Duration VARCHAR(100), -- e.g. "7 days"
    col_Quantity INT DEFAULT 1,
    col_Price DECIMAL(10,2) DEFAULT 0.00, -- unit price (optional)
    col_PrescriptionItemCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_PrescriptionItem_tbl_Prescription FOREIGN KEY (col_PrescriptionID) REFERENCES tbl_Prescription(col_PrescriptionID) ON DELETE CASCADE,
    INDEX idx_tbl_PrescriptionItem_Prescription (col_PrescriptionID),
    INDEX idx_tbl_PrescriptionItem_ItemName (col_ItemName)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_PrescriptionItem (
    col_PrescriptionItemID INT AUTO_INCREMENT PRIMARY KEY,
    col_PrescriptionID INT NOT NULL,
    col_ItemName VARCHAR(255) NOT NULL, -- medicine name or procedure
    col_ItemType ENUM('Medicine','Procedure','Test','Other') DEFAULT 'Medicine',
    col_Dosage VARCHAR(100), -- e.g. "500mg"
    col_Duration VARCHAR(100), -- e.g. "7 days"
    col_Quantity INT DEFAULT 1,
    col_Price DECIMAL(10,2) DEFAULT 0.00, -- unit price (optional)
    col_PrescriptionItemCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_PrescriptionItem_tbl_Prescription FOREIGN KEY (col_PrescriptionID) REFERENCES tbl_Prescription(col_PrescriptionID) ON DELETE CASCADE,
    INDEX idx_tbl_PrescriptionItem_Prescription (col_PrescriptionID),
    INDEX idx_tbl_PrescriptionItem_ItemName (col_ItemName)
) ENGINE=InnoDB;

-- 7. Bills (header)
CREATE TABLE IF NOT EXISTS tbl_Bill (
    col_BillID INT AUTO_INCREMENT PRIMARY KEY,
    col_PatientID INT NOT NULL,
    col_AppointmentID INT, -- if bill is tied to an appointment
    col_BillDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    col_TotalAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    col_PaidAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    col_BalanceAmount DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    col_BillStatus ENUM('Unpaid','Paid','Partial','Cancelled') DEFAULT 'Unpaid',
    col_PaymentMethod ENUM('Cash','Card','Insurance','Other') DEFAULT 'Cash',
    col_BillingNotes TEXT,
    CONSTRAINT FK_tbl_Bill_tbl_Patient FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID) ON DELETE CASCADE,
    CONSTRAINT FK_tbl_Bill_tbl_Appointment FOREIGN KEY (col_AppointmentID) REFERENCES tbl_Appointment(col_AppointmentID) ON DELETE SET NULL,
    INDEX idx_tbl_Bill_Date (col_BillDate),
    INDEX idx_tbl_Bill_Status (col_BillStatus),
    INDEX idx_tbl_Bill_Patient (col_PatientID)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_BillItem (
    col_BillItemID INT AUTO_INCREMENT PRIMARY KEY,
    col_BillID INT NOT NULL,
    col_Description VARCHAR(255) NOT NULL,
    col_Quantity INT NOT NULL DEFAULT 1,
    col_UnitPrice DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    col_LineTotal DECIMAL(12,2) GENERATED ALWAYS AS (col_Quantity * col_UnitPrice) STORED,
    col_BillItemCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_BillItem_tbl_Bill FOREIGN KEY (col_BillID) REFERENCES tbl_Bill(col_BillID) ON DELETE CASCADE,
    INDEX idx_tbl_BillItem_BillID (col_BillID),
    INDEX idx_tbl_BillItem_Description (col_Description)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS tbl_Insurance (
    col_InsuranceID INT AUTO_INCREMENT PRIMARY KEY,
    col_PatientID INT NOT NULL,
    col_ProviderName VARCHAR(255),
    col_PolicyNumber VARCHAR(100),
    col_CoverageDetails TEXT,
    col_InsuranceCreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT FK_tbl_Insurance_tbl_Patient FOREIGN KEY (col_PatientID) REFERENCES tbl_Patient(col_PatientID) ON DELETE CASCADE,
    INDEX idx_tbl_Insurance_PatientID (col_PatientID),
    UNIQUE KEY ux_tbl_Insurance_Patient_Policy (col_PatientID, col_PolicyNumber)
) ENGINE=InnoDB;

