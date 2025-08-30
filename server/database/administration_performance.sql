-- Administration Performance Database (Domain 4)
-- Create separate tables for Curricular Committee and School Committee
-- Include evaluateid for evaluation period tracking

-- Drop existing tables if they exist
DROP TABLE IF EXISTS curricular_committee;
DROP TABLE IF EXISTS school_committee;

-- Create Curricular Committee table
CREATE TABLE curricular_committee (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20) NOT NULL,
  staff_name VARCHAR(100) NOT NULL,
  evaluateid INT NOT NULL,
  INDEX idx_staff_code (staff_code),
  INDEX idx_evaluateid (evaluateid),
  INDEX idx_staff_eval (staff_code, evaluateid)
) AUTO_INCREMENT = 1;

-- Create School Committee table
CREATE TABLE school_committee (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20) NOT NULL,
  staff_name VARCHAR(100) NOT NULL,
  evaluateid INT NOT NULL,
  INDEX idx_staff_code (staff_code),
  INDEX idx_evaluateid (evaluateid),
  INDEX idx_staff_eval (staff_code, evaluateid)
) AUTO_INCREMENT = 1;

-- Insert Curricular Committee data for Evaluation Period 8
INSERT INTO curricular_committee (staff_code, staff_name, evaluateid) VALUES
('6531503001', 'Dr. John Smith', 8),
('6531503002', 'Prof. Jane Doe', 8),
('6531503003', 'Dr. Michael Johnson', 8),
('6531503004', 'Dr. Sarah Wilson', 8),
('6531503005', 'Prof. Robert Brown', 8),
('6531503006', 'Dr. Emily Davis', 8),
('6531503172', 'Dr. Phyo Min Thein', 8),
('6531503174', 'Dr. Phyo Thiha', 8),
('6431703502', 'Dr. Shwe Yi Oo', 8),
('6531503137', 'Dr. Chit Min Thu', 8);

-- Reset AUTO_INCREMENT for Evaluation Period 9
ALTER TABLE curricular_committee AUTO_INCREMENT = 1;

-- Insert Curricular Committee data for Evaluation Period 9
INSERT INTO curricular_committee (staff_code, staff_name, evaluateid) VALUES
('6531503001', 'Dr. John Smith', 9),
('6531503002', 'Prof. Jane Doe', 9),
('6531503003', 'Dr. Michael Johnson', 9),
('6531503004', 'Dr. Sarah Wilson', 9),
('6531503005', 'Prof. Robert Brown', 9),
('6531503006', 'Dr. Emily Davis', 9),
('6531503172', 'Dr. Phyo Min Thein', 9),
('6531503174', 'Dr. Phyo Thiha', 9),
('6431703502', 'Dr. Shwe Yi Oo', 9),
('6531503137', 'Dr. Chit Min Thu', 9);

-- Insert School Committee data for Evaluation Period 8
INSERT INTO school_committee (staff_code, staff_name, evaluateid) VALUES
('6531503007', 'Dr. Sarah Wilson', 8),
('6531503008', 'Prof. Robert Brown', 8),
('6531503009', 'Dr. Emily Davis', 8),
('6531503010', 'Dr. Mark Thompson', 8),
('6531503011', 'Prof. Lisa Anderson', 8),
('6531503012', 'Dr. James Miller', 8),
('6531503172', 'Dr. Phyo Min Thein', 8),
('6531503174', 'Dr. Phyo Thiha', 8),
('6431703502', 'Dr. Shwe Yi Oo', 8),
('6531503137', 'Dr. Chit Min Thu', 8);

-- Reset AUTO_INCREMENT for Evaluation Period 9
ALTER TABLE school_committee AUTO_INCREMENT = 1;

-- Insert School Committee data for Evaluation Period 9
INSERT INTO school_committee (staff_code, staff_name, evaluateid) VALUES
('6531503007', 'Dr. Sarah Wilson', 9),
('6531503008', 'Prof. Robert Brown', 9),
('6531503009', 'Dr. Emily Davis', 9),
('6531503010', 'Dr. Mark Thompson', 9),
('6531503011', 'Prof. Lisa Anderson', 9),
('6531503012', 'Dr. James Miller', 9),
('6531503172', 'Dr. Phyo Min Thein', 9),
('6531503174', 'Dr. Phyo Thiha', 9),
('6431703502', 'Dr. Shwe Yi Oo', 9),
('6531503137', 'Dr. Chit Min Thu', 9);
