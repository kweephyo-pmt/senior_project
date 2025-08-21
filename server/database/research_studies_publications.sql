-- Research Studies and Research Publications Tables
-- Two separate tables for detailed project tracking

-- Create Research Studies table
DROP TABLE IF EXISTS research_studies;
CREATE TABLE research_studies (
  id INT PRIMARY KEY AUTO_INCREMENT,
  staff_code VARCHAR(20) NOT NULL,
  evaluateid INT NOT NULL,
  level DECIMAL(3,1) NOT NULL,
  project_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_staff_code (staff_code),
  INDEX idx_evaluateid (evaluateid),
  INDEX idx_level (level)
);

-- Create Research Publications table
DROP TABLE IF EXISTS research_publications;
CREATE TABLE research_publications (
  id INT PRIMARY KEY AUTO_INCREMENT,
  staff_code VARCHAR(20) NOT NULL,
  evaluateid INT NOT NULL,
  level DECIMAL(3,1) NOT NULL,
  project_name VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  
  INDEX idx_staff_code (staff_code),
  INDEX idx_evaluateid (evaluateid),
  INDEX idx_level (level)
);

-- Insert Research Studies data for all staff members
INSERT INTO research_studies (staff_code, evaluateid, level, project_name) VALUES

-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 1, 'Self Project'),
('6531503172', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503172', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503172', 9, 4, 'Smart Campus Initiative'),
('6531503172', 9, 5, 'Educational Data Mining Project'),
('6531503172', 9, 6, 'Student Success Prediction Model'),
('6531503172', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 1, 'Self Project'),
('6531503174', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503174', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503174', 9, 4, 'Smart Campus Initiative'),
('6531503174', 9, 5, 'Educational Data Mining Project'),
('6531503174', 9, 6, 'Student Success Prediction Model'),
('6531503174', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 1, 'Self Project'),
('6531503176', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503176', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503176', 9, 4, 'Smart Campus Initiative'),
('6531503176', 9, 5, 'Educational Data Mining Project'),
('6531503176', 9, 6, 'Student Success Prediction Model'),
('6531503176', 9, 7.1, 'Blockchain in Education'),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 1, 'Self Project'),
('6631205226', 9, 2, 'RECAI (Research Centre Reform)'),
('6631205226', 9, 3, 'AI-Enhanced Learning Analytics'),
('6631205226', 9, 4, 'Smart Campus Initiative'),
('6631205226', 9, 5, 'Educational Data Mining Project'),
('6631205226', 9, 6, 'Student Success Prediction Model'),
('6631205226', 9, 7.1, 'Blockchain in Education'),

-- Staff 6431703502 (Dr. Apinya Wongkham) - Current period (1/2025)
('6431703502', 9, 1, 'Self Project'),
('6431703502', 9, 2, 'RECAI (Research Centre Reform)'),
('6431703502', 9, 3, 'AI-Enhanced Learning Analytics'),
('6431703502', 9, 4, 'Smart Campus Initiative'),
('6431703502', 9, 5, 'Educational Data Mining Project'),
('6431703502', 9, 6, 'Student Success Prediction Model'),
('6431703502', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 1, 'Self Project'),
('6531503017', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503017', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503017', 9, 4, 'Smart Campus Initiative'),
('6531503017', 9, 5, 'Educational Data Mining Project'),
('6531503017', 9, 6, 'Student Success Prediction Model'),
('6531503017', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 1, 'Self Project'),
('6531503069', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503069', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503069', 9, 4, 'Smart Campus Initiative'),
('6531503069', 9, 5, 'Educational Data Mining Project'),
('6531503069', 9, 6, 'Student Success Prediction Model'),
('6531503069', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 1, 'Self Project'),
('6531503070', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503070', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503070', 9, 4, 'Smart Campus Initiative'),
('6531503070', 9, 5, 'Educational Data Mining Project'),
('6531503070', 9, 6, 'Student Success Prediction Model'),
('6531503070', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 1, 'Self Project'),
('6531503074', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503074', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503074', 9, 4, 'Smart Campus Initiative'),
('6531503074', 9, 5, 'Educational Data Mining Project'),
('6531503074', 9, 6, 'Student Success Prediction Model'),
('6531503074', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 1, 'Self Project'),
('6531503137', 9, 2, 'RECAI (Research Centre Reform)'),
('6531503137', 9, 3, 'AI-Enhanced Learning Analytics'),
('6531503137', 9, 4, 'Smart Campus Initiative'),
('6531503137', 9, 5, 'Educational Data Mining Project'),
('6531503137', 9, 6, 'Student Success Prediction Model'),
('6531503137', 9, 7.1, 'Blockchain in Education'),

-- Staff 6531503172 (Dr. Phyo Min Thein) - Previous period (2/2024)
('6531503172', 8, 1, 'Self Project'),
('6531503172', 8, 2, 'RECAI (Research Centre Reform)'),
('6531503172', 8, 3, 'AI-Enhanced Learning Analytics'),
('6531503172', 8, 4, 'Smart Campus Initiative'),
('6531503172', 8, 5, 'Educational Data Mining Project'),
('6531503172', 8, 6, 'Student Success Prediction Model'),
('6531503172', 8, 7.1, 'Blockchain in Education');

-- Insert Research Publications data for all staff members
INSERT INTO research_publications (staff_code, evaluateid, level, project_name) VALUES

-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 1, 'Self Research Highlights'),
('6531503172', 9, 2, 'Gold Chain of Knowledge'),
('6531503172', 9, 3, 'Machine Learning in Education'),
('6531503172', 9, 4, 'Adaptive Learning Systems'),
('6531503172', 9, 5, 'Educational Technology Integration'),
('6531503172', 9, 6, 'Digital Assessment Methods'),
('6531503172', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 1, 'Self Research Highlights'),
('6531503174', 9, 2, 'Gold Chain of Knowledge'),
('6531503174', 9, 3, 'Machine Learning in Education'),
('6531503174', 9, 4, 'Adaptive Learning Systems'),
('6531503174', 9, 5, 'Educational Technology Integration'),
('6531503174', 9, 6, 'Digital Assessment Methods'),
('6531503174', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 1, 'Self Research Highlights'),
('6531503176', 9, 2, 'Gold Chain of Knowledge'),
('6531503176', 9, 3, 'Machine Learning in Education'),
('6531503176', 9, 4, 'Adaptive Learning Systems'),
('6531503176', 9, 5, 'Educational Technology Integration'),
('6531503176', 9, 6, 'Digital Assessment Methods'),
('6531503176', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 1, 'Self Research Highlights'),
('6631205226', 9, 2, 'Gold Chain of Knowledge'),
('6631205226', 9, 3, 'Machine Learning in Education'),
('6631205226', 9, 4, 'Adaptive Learning Systems'),
('6631205226', 9, 5, 'Educational Technology Integration'),
('6631205226', 9, 6, 'Digital Assessment Methods'),
('6631205226', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6431703502 (Dr. Apinya Wongkham) - Current period (1/2025)
('6431703502', 9, 1, 'Self Research Highlights'),
('6431703502', 9, 2, 'Gold Chain of Knowledge'),
('6431703502', 9, 3, 'Machine Learning in Education'),
('6431703502', 9, 4, 'Adaptive Learning Systems'),
('6431703502', 9, 5, 'Educational Technology Integration'),
('6431703502', 9, 6, 'Digital Assessment Methods'),
('6431703502', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 1, 'Self Research Highlights'),
('6531503017', 9, 2, 'Gold Chain of Knowledge'),
('6531503017', 9, 3, 'Machine Learning in Education'),
('6531503017', 9, 4, 'Adaptive Learning Systems'),
('6531503017', 9, 5, 'Educational Technology Integration'),
('6531503017', 9, 6, 'Digital Assessment Methods'),
('6531503017', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 1, 'Self Research Highlights'),
('6531503069', 9, 2, 'Gold Chain of Knowledge'),
('6531503069', 9, 3, 'Machine Learning in Education'),
('6531503069', 9, 4, 'Adaptive Learning Systems'),
('6531503069', 9, 5, 'Educational Technology Integration'),
('6531503069', 9, 6, 'Digital Assessment Methods'),
('6531503069', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 1, 'Self Research Highlights'),
('6531503070', 9, 2, 'Gold Chain of Knowledge'),
('6531503070', 9, 3, 'Machine Learning in Education'),
('6531503070', 9, 4, 'Adaptive Learning Systems'),
('6531503070', 9, 5, 'Educational Technology Integration'),
('6531503070', 9, 6, 'Digital Assessment Methods'),
('6531503070', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 1, 'Self Research Highlights'),
('6531503074', 9, 2, 'Gold Chain of Knowledge'),
('6531503074', 9, 3, 'Machine Learning in Education'),
('6531503074', 9, 4, 'Adaptive Learning Systems'),
('6531503074', 9, 5, 'Educational Technology Integration'),
('6531503074', 9, 6, 'Digital Assessment Methods'),
('6531503074', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 1, 'Self Research Highlights'),
('6531503137', 9, 2, 'Gold Chain of Knowledge'),
('6531503137', 9, 3, 'Machine Learning in Education'),
('6531503137', 9, 4, 'Adaptive Learning Systems'),
('6531503137', 9, 5, 'Educational Technology Integration'),
('6531503137', 9, 6, 'Digital Assessment Methods'),
('6531503137', 9, 7.1, 'Learning Analytics Dashboard'),

-- Staff 6531503172 (Dr. Phyo Min Thein) - Previous period (2/2024)
('6531503172', 8, 1, 'Self Research Highlights'),
('6531503172', 8, 2, 'Gold Chain of Knowledge'),
('6531503172', 8, 3, 'Machine Learning in Education'),
('6531503172', 8, 4, 'Adaptive Learning Systems'),
('6531503172', 8, 5, 'Educational Technology Integration'),
('6531503172', 8, 6, 'Digital Assessment Methods'),
('6531503172', 8, 7.1, 'Learning Analytics Dashboard');

-- Sample queries to test the tables
-- SELECT * FROM research_studies WHERE staff_code = '6531503172' AND evaluateid = 9;
-- SELECT * FROM research_publications WHERE staff_code = '6531503172' AND evaluateid = 9;
-- SELECT COUNT(*) as total_studies FROM research_studies WHERE evaluateid = 9;
-- SELECT COUNT(*) as total_publications FROM research_publications WHERE evaluateid = 9;
