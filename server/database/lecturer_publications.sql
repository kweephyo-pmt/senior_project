-- Drop existing table if it exists
DROP TABLE IF EXISTS lecturer_publications;

-- Create lecturer_publications table
CREATE TABLE IF NOT EXISTS lecturer_publications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    staff_code VARCHAR(20) NOT NULL,
    title VARCHAR(500) NOT NULL,
    authors VARCHAR(500) NOT NULL,
    venue VARCHAR(500) NOT NULL,
    year INT NOT NULL,
    link VARCHAR(500) DEFAULT '#',
    evaluateid INT NOT NULL DEFAULT 9,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_staff_code (staff_code),
    INDEX idx_year (year),
    INDEX idx_evaluateid (evaluateid)
);

-- Insert publication data for Dr. Supansa Chaising (6531503174)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
-- 2023 Publications (evaluateid 5 = 1/2023, evaluateid 6 = 2/2023)
('6531503174', 'Advanced Machine Learning Techniques in Educational Data Mining', 'Chaising, S., Temdee, P., & Kumar, R.', 'IEEE Transactions on Education, 66(2), 156-169', 2023, '#', 6),
('6531503174', 'Blockchain-Based Framework for Secure Academic Credential Verification', 'Chaising, S., & Temdee, P.', 'Journal of Information Security and Applications, 45, 102-115', 2023, '#', 6),

-- 2022 Publications (evaluateid 3 = 1/2022, evaluateid 4 = 2/2022)
('6531503174', 'Classification Approach for Industry Standards Categorization', 'Chaisricharoen, R., Srimaharaj, W., Chaising, S., & Pamanee, K.', 'In 2022 Joint International Conference on Digital Arts, Media and Technology... (pp. 308-313). IEEE.', 2022, '#', 4),
('6531503174', 'Deep Learning Applications in Educational Technology', 'Chaising, S., Kumar, R., & Smith, J.', 'Educational Technology Research and Development, 70(3), 789-805', 2022, '#', 4),
('6531503174', 'Artificial Intelligence in Higher Education: A Systematic Review', 'Chaising, S., & Johnson, M.', 'International Journal of Educational Technology in Higher Education, 19(1), 1-25', 2022, '#', 3),

-- 2021 Publications (evaluateid 1 = 1/2021, evaluateid 2 = 2/2021)
('6531503174', 'Average weighted objective distance-based method for type 2 diabetes prediction', 'Nuankaew, P., Chaising, S., & Temdee, P.', 'IEEE Access, 9, 137015-137028.', 2021, '#', 2),
('6531503174', 'Blockchain-based Trusty Buyer Coalition Scheme Using A Group Signature', 'Boongsame, L., Chaising, S., & Temdee, P.', 'Journal of Mobile Multimedia, 203-230.', 2021, '#', 2),
('6531503174', 'Individual Attribute Selection Using Information Gain based Distance for Group Classification of Elderly People with Hypertension', 'Chaising, S., Temdee, P., & Prasad, R.', 'IEEE Access, 9, 82713-82725.', 2021, '#', 1),

-- 2024 Publications (evaluateid 7 = 1/2024, evaluateid 8 = 2/2024)
('6531503174', 'Machine Learning for Student Performance Prediction', 'Chaising, S., & Wilson, K.', 'Computers & Education, 155, 103912', 2024, '#', 8),
('6531503174', 'Data Mining Techniques in Educational Research', 'Chaising, S., Brown, A., & Davis, R.', 'Journal of Educational Data Mining, 12(2), 45-67', 2024, '#', 8),
('6531503174', 'Predictive Analytics in Higher Education', 'Chaising, S., & Anderson, P.', 'International Journal of Educational Technology, 7(4), 89-104', 2024, '#', 7);

-- Add sample publications for other staff members
-- Dr. Phyo Min Thein (6531503172)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503172', 'A Novel Approach to Sentiment Analysis', 'Thein, P.M., Kumar, R., & Smith, J.', 'Journal of Data Science, 45(3), 234-247', 2024, '#', 8),
('6531503172', 'Machine Learning in Education', 'Thein, P.M., & Johnson, A.', 'International Conference on AI in Education Proceedings', 2023, '#', 6),
('6531503172', 'Optimizing Research Collaboration', 'Thein, P.M., Brown, K., & Davis, L.', 'Research Management Review, 12(4), 89-102', 2023, '#', 5);

-- Dr. Apinya Wongkham (6431703502)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6431703502', 'Financial Analytics in Higher Education', 'Wongkham, A., & Peterson, R.', 'Journal of Educational Finance, 28(2), 145-162', 2023, '#', 6),
('6431703502', 'Budget Optimization Strategies', 'Wongkham, A., Smith, M., & Brown, T.', 'International Conference on Educational Management', 2022, '#', 4),
('6431703502', 'Resource Allocation in Academic Institutions', 'Wongkham, A., & Kumar, S.', 'Educational Administration Quarterly, 58(3), 412-435', 2022, '#', 3);

-- Dr. Siriporn Thanakit (6531503017)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503017', 'Digital Transformation in Education', 'Thanakit, S., & Wilson, J.', 'Computers & Education, 178, 104-118', 2023, '#', 6),
('6531503017', 'E-Learning Platform Development', 'Thanakit, S., Kumar, A., & Davis, R.', 'Educational Technology & Society, 25(2), 89-103', 2022, '#', 4),
('6531503017', 'Student Engagement in Online Learning', 'Thanakit, S., & Brown, M.', 'Distance Education, 43(1), 67-84', 2021, '#', 2);

-- Dr. Rattana Choosri (6531503069)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503069', 'Advanced Statistical Methods in Business Analytics', 'Choosri, R., & Anderson, P.', 'Journal of Business Analytics, 15(3), 78-95', 2024, '#', 8),
('6531503069', 'Data Visualization Techniques for Management Decision Making', 'Choosri, R., Smith, K., & Johnson, L.', 'Management Science Review, 42(2), 156-173', 2023, '#', 6),
('6531503069', 'Predictive Modeling in Supply Chain Management', 'Choosri, R., & Wilson, M.', 'International Journal of Operations Research, 28(4), 234-251', 2022, '#', 4),
('6531503069', 'Machine Learning Applications in Financial Forecasting', 'Choosri, R., Brown, T., & Davis, S.', 'Financial Technology Journal, 19(1), 45-62', 2021, '#', 2);

-- Dr. Suwanna Phakdee (6531503070)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503070', 'Sustainable Tourism Development in Southeast Asia', 'Phakdee, S., & Kumar, R.', 'Tourism Management, 89, 104-118', 2024, '#', 8),
('6531503070', 'Cultural Heritage Tourism and Community Development', 'Phakdee, S., Johnson, A., & Smith, B.', 'Journal of Heritage Tourism, 18(2), 67-84', 2023, '#', 6),
('6531503070', 'Digital Marketing Strategies for Tourism Industry', 'Phakdee, S., & Wilson, K.', 'Tourism and Hospitality Research, 23(3), 189-206', 2022, '#', 4),
('6531503070', 'Impact of COVID-19 on Tourism Recovery Strategies', 'Phakdee, S., Brown, M., & Davis, L.', 'International Journal of Tourism Research, 24(1), 23-40', 2021, '#', 2);

-- Dr. Niran Jaikla (6531503074)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503074', 'Electronic Circuit Design for IoT Applications', 'Jaikla, N., & Peterson, R.', 'IEEE Transactions on Circuits and Systems, 71(4), 234-247', 2024, '#', 8),
('6531503074', 'Analog Signal Processing in Modern Communication Systems', 'Jaikla, N., Kumar, S., & Johnson, T.', 'Journal of Electronic Engineering, 45(2), 89-106', 2023, '#', 6),
('6531503074', 'VLSI Design Optimization Techniques', 'Jaikla, N., & Smith, A.', 'Microelectronics Journal, 128, 105-122', 2022, '#', 4),
('6531503074', 'Power Management in Embedded Systems', 'Jaikla, N., Brown, K., & Wilson, M.', 'IEEE Embedded Systems Letters, 13(3), 67-74', 2021, '#', 2);

-- Dr. Kamon Bualert (6531503137)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503137', 'Blockchain Technology in Supply Chain Management', 'Bualert, K., & Anderson, L.', 'Supply Chain Management Review, 28(4), 156-173', 2024, '#', 8),
('6531503137', 'Digital Transformation in Manufacturing Industries', 'Bualert, K., Johnson, P., & Smith, R.', 'International Journal of Production Research, 62(8), 234-251', 2023, '#', 6),
('6531503137', 'Industry 4.0 Implementation Strategies', 'Bualert, K., & Wilson, T.', 'Journal of Manufacturing Systems, 68, 89-106', 2022, '#', 4),
('6531503137', 'Lean Manufacturing and Quality Management', 'Bualert, K., Brown, S., & Davis, M.', 'Quality Engineering, 34(2), 45-62', 2021, '#', 2);

-- Dr. Korawit Fakkhong (6531503176)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503176', 'Advanced Materials for Aerospace Applications', 'Fakkhong, K., & Kumar, A.', 'Materials Science and Engineering, 845, 138-155', 2024, '#', 8),
('6531503176', 'Composite Materials in Automotive Industry', 'Fakkhong, K., Peterson, B., & Johnson, C.', 'Composites Science and Technology, 234, 109-126', 2023, '#', 6),
('6531503176', 'Nanomaterials for Energy Storage Applications', 'Fakkhong, K., & Smith, D.', 'Journal of Energy Storage, 56, 234-251', 2022, '#', 4),
('6531503176', 'Biomaterials for Medical Device Applications', 'Fakkhong, K., Wilson, E., & Brown, F.', 'Biomaterials, 289, 121-138', 2021, '#', 2);

-- Dr. Wipob Suttinun (6631205226)
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6631205226', 'Artificial Intelligence in Healthcare Systems', 'Suttinun, W., & Anderson, G.', 'Journal of Medical Internet Research, 26(4), e45123', 2024, '#', 8),
('6631205226', 'Machine Learning for Medical Diagnosis', 'Suttinun, W., Johnson, H., & Smith, I.', 'Nature Medicine, 29(8), 1234-1241', 2023, '#', 6),
('6631205226', 'Deep Learning Applications in Radiology', 'Suttinun, W., & Kumar, J.', 'Radiology, 308(2), 156-173', 2022, '#', 4),
('6631205226', 'Computer Vision in Medical Imaging', 'Suttinun, W., Peterson, K., & Wilson, L.', 'Medical Image Analysis, 67, 101-118', 2021, '#', 2);

-- Additional publications for 2025 and missing evaluation periods

-- Dr. Supansa Chaising (6531503174) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503174', 'Future Trends in Educational Analytics', 'Chaising, S., & Kumar, M.', 'Educational Technology Research, 73(1), 45-62', 2025, '#', 9),
('6531503174', 'Learning Management Systems Evolution', 'Chaising, S., Johnson, N., & Smith, O.', 'Computers & Education, 195, 104-121', 2024, '#', 7),
('6531503174', 'Student Performance Prediction Models', 'Chaising, S., & Wilson, P.', 'Educational Data Mining, 15(3), 78-95', 2023, '#', 5),
('6531503174', 'Adaptive Learning Technologies', 'Chaising, S., Brown, Q., & Davis, R.', 'Journal of Educational Technology, 58(4), 189-206', 2022, '#', 3),
('6531503174', 'E-Learning Platform Optimization', 'Chaising, S., & Anderson, S.', 'Distance Education, 42(1), 23-40', 2021, '#', 1);

-- Dr. Phyo Min Thein (6531503172) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503172', 'Advanced Natural Language Processing', 'Thein, P.M., & Kumar, T.', 'Computational Linguistics, 51(2), 234-251', 2025, '#', 9),
('6531503172', 'Deep Learning for Text Analysis', 'Thein, P.M., Johnson, U., & Smith, V.', 'Journal of Machine Learning Research, 25, 1567-1584', 2024, '#', 7),
('6531503172', 'Collaborative Learning Platforms', 'Thein, P.M., & Wilson, W.', 'Educational Technology & Society, 25(4), 156-173', 2022, '#', 3),
('6531503172', 'Data Mining in Educational Systems', 'Thein, P.M., Brown, X., & Davis, Y.', 'Knowledge Discovery in Databases, 18(2), 89-106', 2021, '#', 1);

-- Dr. Apinya Wongkham (6431703502) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6431703502', 'AI-Driven Financial Planning in Education', 'Wongkham, A., & Kumar, Z.', 'Journal of Educational Finance, 31(1), 45-62', 2025, '#', 9),
('6431703502', 'Blockchain in Educational Finance', 'Wongkham, A., Johnson, A1., & Smith, B1.', 'Educational Management Review, 47(3), 78-95', 2024, '#', 7),
('6431703502', 'Cost-Benefit Analysis in Higher Education', 'Wongkham, A., & Wilson, C1.', 'Higher Education Policy, 35(2), 234-251', 2023, '#', 5),
('6431703502', 'Financial Sustainability Models', 'Wongkham, A., Brown, D1., & Davis, E1.', 'Educational Economics, 30(4), 189-206', 2021, '#', 1);

-- Dr. Siriporn Thanakit (6531503017) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503017', 'Metaverse in Educational Technology', 'Thanakit, S., & Kumar, F1.', 'Virtual Reality in Education, 8(1), 23-40', 2025, '#', 9),
('6531503017', 'AR/VR Learning Environments', 'Thanakit, S., Johnson, G1., & Smith, H1.', 'Immersive Learning Research, 12(3), 67-84', 2024, '#', 7),
('6531503017', 'Mobile Learning Applications', 'Thanakit, S., & Wilson, I1.', 'Mobile Learning and Technology, 15(2), 156-173', 2023, '#', 5),
('6531503017', 'Gamification in Online Education', 'Thanakit, S., Brown, J1., & Davis, K1.', 'Game-Based Learning, 9(4), 234-251', 2022, '#', 3),
('6531503017', 'Interactive Learning Systems Design', 'Thanakit, S., & Anderson, L1.', 'Educational Interface Design, 6(1), 89-106', 2021, '#', 1);

-- Dr. Rattana Choosri (6531503069) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503069', 'Quantum Computing in Business Analytics', 'Choosri, R., & Kumar, M1.', 'Quantum Business Intelligence, 3(1), 12-29', 2025, '#', 9),
('6531503069', 'Advanced AI for Decision Support Systems', 'Choosri, R., Johnson, N1., & Smith, O1.', 'Decision Sciences, 55(2), 345-362', 2024, '#', 7),
('6531503069', 'Big Data Analytics in Operations', 'Choosri, R., & Wilson, P1.', 'Operations Research Letters, 51(3), 178-195', 2023, '#', 5),
('6531503069', 'Statistical Learning for Business Intelligence', 'Choosri, R., Brown, Q1., & Davis, R1.', 'Business Analytics Journal, 18(4), 267-284', 2022, '#', 3),
('6531503069', 'Data Mining Techniques for Market Analysis', 'Choosri, R., & Anderson, S1.', 'Market Research Analytics, 14(1), 45-62', 2021, '#', 1);

-- Dr. Suwanna Phakdee (6531503070) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503070', 'AI-Powered Tourism Recommendation Systems', 'Phakdee, S., & Kumar, T1.', 'Tourism Technology Review, 15(1), 34-51', 2025, '#', 9),
('6531503070', 'Smart Tourism Destinations', 'Phakdee, S., Johnson, U1., & Smith, V1.', 'Smart Cities and Tourism, 8(2), 78-95', 2024, '#', 7),
('6531503070', 'Eco-Tourism and Environmental Impact', 'Phakdee, S., & Wilson, W1.', 'Environmental Tourism Studies, 22(3), 156-173', 2023, '#', 5),
('6531503070', 'Tourism Marketing in Digital Age', 'Phakdee, S., Brown, X1., & Davis, Y1.', 'Digital Tourism Marketing, 11(4), 234-251', 2022, '#', 3),
('6531503070', 'Community-Based Tourism Development', 'Phakdee, S., & Anderson, Z1.', 'Community Tourism Journal, 7(1), 89-106', 2021, '#', 1);

-- Dr. Niran Jaikla (6531503074) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503074', 'Neuromorphic Computing Circuits', 'Jaikla, N., & Kumar, A2.', 'IEEE Transactions on Neural Networks, 36(1), 123-140', 2025, '#', 9),
('6531503074', 'Quantum Circuit Design Principles', 'Jaikla, N., Johnson, B2., & Smith, C2.', 'Quantum Electronics Letters, 28(2), 67-84', 2024, '#', 7),
('6531503074', 'RF Circuit Design for 5G Applications', 'Jaikla, N., & Wilson, D2.', 'RF and Microwave Engineering, 45(3), 189-206', 2023, '#', 5),
('6531503074', 'Low-Power Circuit Design Techniques', 'Jaikla, N., Brown, E2., & Davis, F2.', 'Low-Power Electronics, 19(4), 234-251', 2022, '#', 3),
('6531503074', 'Analog Circuit Optimization Methods', 'Jaikla, N., & Anderson, G2.', 'Analog Integrated Circuits, 12(1), 45-62', 2021, '#', 1);

-- Dr. Kamon Bualert (6531503137) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503137', 'AI in Smart Manufacturing', 'Bualert, K., & Kumar, H2.', 'AI Manufacturing Review, 9(1), 78-95', 2025, '#', 9),
('6531503137', 'Robotics in Industrial Automation', 'Bualert, K., Johnson, I2., & Smith, J2.', 'Robotics and Automation, 41(2), 156-173', 2024, '#', 7),
('6531503137', 'IoT Integration in Manufacturing', 'Bualert, K., & Wilson, K2.', 'IoT in Industry, 16(3), 234-251', 2023, '#', 5),
('6531503137', 'Supply Chain Digital Transformation', 'Bualert, K., Brown, L2., & Davis, M2.', 'Supply Chain Technology, 25(4), 89-106', 2022, '#', 3),
('6531503137', 'Manufacturing Process Optimization', 'Bualert, K., & Anderson, N2.', 'Process Engineering, 33(1), 23-40', 2021, '#', 1);

-- Dr. Korawit Fakkhong (6531503176) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6531503176', 'Smart Materials for Future Applications', 'Fakkhong, K., & Kumar, O2.', 'Smart Materials Research, 12(1), 45-62', 2025, '#', 9),
('6531503176', 'Sustainable Materials Engineering', 'Fakkhong, K., Johnson, P2., & Smith, Q2.', 'Sustainable Materials, 18(2), 123-140', 2024, '#', 7),
('6531503176', 'Advanced Polymer Composites', 'Fakkhong, K., & Wilson, R2.', 'Polymer Engineering, 34(3), 178-195', 2023, '#', 5),
('6531503176', 'Materials Characterization Techniques', 'Fakkhong, K., Brown, S2., & Davis, T2.', 'Materials Characterization, 67(4), 267-284', 2022, '#', 3),
('6631205226', 'Telemedicine Platform Development', 'Suttinun, W., & Anderson, U2.', 'Telemedicine Journal, 27(1), 67-84', 2021, '#', 1);

-- Dr. Wipob Suttinun (6631205226) - Add 2025 and missing periods
INSERT INTO lecturer_publications (staff_code, title, authors, venue, year, link, evaluateid) VALUES
('6631205226', 'Quantum Machine Learning in Healthcare', 'Suttinun, W., & Kumar, V2.', 'Quantum Healthcare, 4(1), 12-29', 2025, '#', 9),
('6631205226', 'Federated Learning for Medical Data', 'Suttinun, W., Johnson, W2., & Smith, X2.', 'Medical AI Research, 31(2), 156-173', 2024, '#', 7),
('6631205226', 'Wearable Health Monitoring Systems', 'Suttinun, W., & Wilson, Y2.', 'Wearable Technology in Medicine, 8(3), 234-251', 2023, '#', 5),
('6631205226', 'Electronic Health Records Analytics', 'Suttinun, W., Brown, Z2., & Davis, A3.', 'Health Informatics, 25(4), 89-106', 2022, '#', 3),
('6631205226', 'Deep Learning Applications in Radiology', 'Suttinun, W., & Wilson, J.', 'Radiology: Artificial Intelligence, 5(3), e220089', 2022, '#', 4),
('6631205226', 'Telemedicine Platform Development', 'Suttinun, W., Brown, K., & Davis, L.', 'Telemedicine and e-Health, 28(6), 567-584', 2021, '#', 2);
