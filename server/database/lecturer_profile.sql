-- Database setup for lecturer dashboard
-- Create tables for lecturer profile, education, research areas, and publications

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS lecturer_publications;
DROP TABLE IF EXISTS lecturer_research_areas;
DROP TABLE IF EXISTS lecturer_education;
DROP TABLE IF EXISTS lecturer_profiles;

-- Create lecturer profiles table
CREATE TABLE lecturer_profiles (
  staff_code VARCHAR(20) PRIMARY KEY,
  staff_name VARCHAR(100),
  phone VARCHAR(20),
  location VARCHAR(100),
  program VARCHAR(100),
  position VARCHAR(50)
);

-- Create education table
CREATE TABLE lecturer_education (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20),
  degree VARCHAR(100),
  institution VARCHAR(100),
  year INT,
  FOREIGN KEY (staff_code) REFERENCES lecturer_profiles(staff_code)
);

-- Create research areas table
CREATE TABLE lecturer_research_areas (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20),
  research_area TEXT,
  FOREIGN KEY (staff_code) REFERENCES lecturer_profiles(staff_code)
);

-- Create publications table
CREATE TABLE lecturer_publications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  staff_code VARCHAR(20),
  title TEXT,
  venue VARCHAR(200),
  year INT,
  link VARCHAR(500),
  FOREIGN KEY (staff_code) REFERENCES lecturer_profiles(staff_code)
);

-- Insert sample lecturer profiles
-- Note: staff_name should match the Google profile displayName for each user
INSERT INTO lecturer_profiles (staff_code, staff_name, phone, location, program, position) VALUES
('6431703502', 'User 6431703502', '081-234-5678', 'Chiang Rai, Thailand', 'Accounting Program', 'Associate Professor'),
('6531503017', 'User 6531503017', '081-345-6789', 'Chiang Rai, Thailand', 'Business Administration', 'Assistant Professor'),
('6531503069', 'User 6531503069', '081-456-7890', 'Chiang Rai, Thailand', 'Economics Program', 'Associate Professor'),
('6531503070', 'User 6531503070', '081-567-8901', 'Chiang Rai, Thailand', 'Tourism Management', 'Assistant Professor'),
('6531503074', 'User 6531503074', '081-678-9012', 'Chiang Rai, Thailand', 'Aviation Management', 'Associate Professor'),
('6531503137', 'User 6531503137', '081-789-0123', 'Chiang Rai, Thailand', 'Hospitality Management', 'Assistant Professor'),
('6531503172', 'Phyo Min Thein', '081-890-1234', 'Chiang Rai, Thailand', 'Accounting Program', 'Assistant Professor'),
('6531503174', 'User 6531503174', '081-901-2345', 'Chiang Rai, Thailand', 'Business Administration', 'Associate Professor'),
('6531503176', 'User 6531503176', '081-012-3456', 'Chiang Rai, Thailand', 'Economics Program', 'Assistant Professor'),
('6631205226', 'User 6631205226', '081-123-4567', 'Chiang Rai, Thailand', 'Tourism Management', 'Associate Professor');

-- Insert sample education data
INSERT INTO lecturer_education (staff_code, degree, institution, year) VALUES
-- Dr. Siriporn Thanakit
('6431703502', 'Ph.D. in Accounting', 'Chulalongkorn University', 2018),
('6431703502', 'M.B.A.', 'Thammasat University', 2014),
('6431703502', 'B.B.A. in Accounting', 'Kasetsart University', 2012),

-- Dr. Wanchai Suksawat
('6531503017', 'Ph.D. in Business Administration', 'Mae Fah Luang University', 2020),
('6531503017', 'M.B.A.', 'Chiang Mai University', 2016),
('6531503017', 'B.B.A.', 'Khon Kaen University', 2014),

-- Dr. Niran Pongpanich
('6531503069', 'Ph.D. in Economics', 'Mahidol University', 2019),
('6531503069', 'M.A. in Economics', 'Chulalongkorn University', 2015),
('6531503069', 'B.A. in Economics', 'Thammasat University', 2013),

-- Dr. Suchada Wongsiri
('6531503070', 'Ph.D. in Tourism Management', 'Prince of Songkla University', 2021),
('6531503070', 'M.B.A. in Tourism', 'Chiang Mai University', 2017),
('6531503070', 'B.B.A. in Tourism', 'Srinakharinwirot University', 2015),

-- Dr. Kritsana Jaidee
('6531503074', 'Ph.D. in Aviation Management', 'Embry-Riddle Aeronautical University', 2020),
('6531503074', 'M.S. in Aviation', 'Kasetsart University', 2016),
('6531503074', 'B.S. in Aviation Technology', 'King Mongkut University', 2014),

-- Dr. Pimchanok Srisuwan
('6531503137', 'Ph.D. in Hospitality Management', 'Cornell University', 2019),
('6531503137', 'M.S. in Hotel Administration', 'Mae Fah Luang University', 2015),
('6531503137', 'B.B.A. in Hotel Management', 'Assumption University', 2013),

-- Dr. Phyo Min Thein
('6531503172', 'Ph.D. in Management', 'Mae Fah Luang University', 2020),
('6531503172', 'M.B.A.', 'Chulalongkorn University', 2015),
('6531503172', 'B.B.A.', 'Chiang Mai University', 2012),

-- Dr. Rattana Chaiyo
('6531503174', 'Ph.D. in Business Administration', 'Thammasat University', 2018),
('6531503174', 'M.B.A.', 'Mahidol University', 2014),
('6531503174', 'B.B.A.', 'Bangkok University', 2012),

-- Dr. Somchai Nakarin
('6531503176', 'Ph.D. in Economics', 'Chiang Mai University', 2021),
('6531503176', 'M.A. in Economics', 'Kasetsart University', 2017),
('6531503176', 'B.A. in Economics', 'Chulalongkorn University', 2015),

-- Dr. Apinya Thepsiri
('6631205226', 'Ph.D. in Tourism and Hospitality', 'Mahidol University', 2020),
('6631205226', 'M.B.A. in Tourism', 'Prince of Songkla University', 2016),
('6631205226', 'B.B.A. in Tourism', 'Suan Dusit University', 2014);

-- Insert sample research areas
INSERT INTO lecturer_research_areas (staff_code, research_area) VALUES
-- Dr. Siriporn Thanakit
('6431703502', 'Financial Accounting and Reporting'),
('6431703502', 'Corporate Governance'),
('6431703502', 'Auditing and Assurance'),

-- Dr. Wanchai Suksawat
('6531503017', 'Strategic Management'),
('6531503017', 'Organizational Behavior'),
('6531503017', 'Leadership Development'),

-- Dr. Niran Pongpanich
('6531503069', 'Macroeconomic Policy'),
('6531503069', 'International Trade'),
('6531503069', 'Development Economics'),

-- Dr. Suchada Wongsiri
('6531503070', 'Sustainable Tourism'),
('6531503070', 'Community-Based Tourism'),
('6531503070', 'Tourism Marketing'),

-- Dr. Kritsana Jaidee
('6531503074', 'Aviation Safety Management'),
('6531503074', 'Airport Operations'),
('6531503074', 'Airline Management'),

-- Dr. Pimchanok Srisuwan
('6531503137', 'Hotel Revenue Management'),
('6531503137', 'Service Quality Management'),
('6531503137', 'Hospitality Technology'),

-- Dr. Phyo Min Thein
('6531503172', 'Business Intelligence and Data Analytics'),
('6531503172', 'Machine Learning Applications in Management'),
('6531503172', 'Higher Education Administration'),
('6531503172', 'Research Collaboration Networks'),

-- Dr. Rattana Chaiyo
('6531503174', 'Digital Marketing'),
('6531503174', 'E-commerce Strategy'),
('6531503174', 'Consumer Behavior'),

-- Dr. Somchai Nakarin
('6531503176', 'Financial Economics'),
('6531503176', 'Monetary Policy'),
('6531503176', 'Banking and Finance'),

-- Dr. Apinya Thepsiri
('6631205226', 'Cultural Tourism'),
('6631205226', 'Tourism Impact Assessment'),
('6631205226', 'Destination Management');

-- Insert sample publications
INSERT INTO lecturer_publications (staff_code, title, venue, year, link) VALUES
-- Dr. Siriporn Thanakit
('6431703502', 'Corporate Governance and Financial Performance in Thai Listed Companies', 'Journal of Asian Finance', 2024, 'https://example.com/paper1'),
('6431703502', 'The Impact of IFRS Adoption on Earnings Quality', 'International Accounting Review', 2023, 'https://example.com/paper2'),
('6431703502', 'Audit Quality and Corporate Transparency', 'Auditing Research Journal', 2023, 'https://example.com/paper3'),

-- Dr. Wanchai Suksawat
('6531503017', 'Strategic Leadership in Digital Transformation', 'Management Science Quarterly', 2024, 'https://example.com/paper4'),
('6531503017', 'Organizational Culture and Innovation Performance', 'Business Strategy Review', 2023, 'https://example.com/paper5'),

-- Dr. Niran Pongpanich
('6531503069', 'ASEAN Economic Integration and Trade Patterns', 'Asian Economic Journal', 2024, 'https://example.com/paper6'),
('6531503069', 'Monetary Policy Effectiveness in Emerging Markets', 'Economics Letters', 2023, 'https://example.com/paper7'),

-- Dr. Suchada Wongsiri
('6531503070', 'Community-Based Tourism Development in Northern Thailand', 'Tourism Management', 2024, 'https://example.com/paper8'),
('6531503070', 'Sustainable Tourism Practices and Local Communities', 'Journal of Sustainable Tourism', 2023, 'https://example.com/paper9'),

-- Dr. Kritsana Jaidee
('6531503074', 'Aviation Safety Management Systems Implementation', 'Aviation Safety Journal', 2024, 'https://example.com/paper10'),
('6531503074', 'Airport Capacity Management in Southeast Asia', 'Transportation Research', 2023, 'https://example.com/paper11'),

-- Dr. Pimchanok Srisuwan
('6531503137', 'Revenue Management Strategies in Boutique Hotels', 'International Journal of Hospitality Management', 2024, 'https://example.com/paper12'),
('6531503137', 'Technology Adoption in Hotel Operations', 'Cornell Hospitality Quarterly', 2023, 'https://example.com/paper13'),

-- Dr. Phyo Min Thein
('6531503172', 'A Novel Approach to Sentiment Analysis', 'Journal of Data Science', 2024, 'https://example.com/paper14'),
('6531503172', 'Machine Learning in Education', 'International Conference on AI', 2023, 'https://example.com/paper15'),
('6531503172', 'Optimizing Research Collaboration', 'Research Management Review', 2023, 'https://example.com/paper16'),

-- Dr. Rattana Chaiyo
('6531503174', 'Digital Marketing Effectiveness in E-commerce', 'Journal of Digital Marketing', 2024, 'https://example.com/paper17'),
('6531503174', 'Consumer Behavior in Online Shopping', 'Marketing Research Journal', 2023, 'https://example.com/paper18'),

-- Dr. Somchai Nakarin
('6531503176', 'Financial Market Integration in ASEAN', 'Finance Research Letters', 2024, 'https://example.com/paper19'),
('6531503176', 'Banking Efficiency and Economic Growth', 'Journal of Banking and Finance', 2023, 'https://example.com/paper20'),

-- Dr. Apinya Thepsiri
('6631205226', 'Cultural Heritage Tourism and Local Development', 'Cultural Tourism Research', 2024, 'https://example.com/paper21'),
('6631205226', 'Tourism Impact on Rural Communities', 'Rural Tourism Journal', 2023, 'https://example.com/paper22');
