-- Update Academic Service Performance Categories
-- This script updates the category names to match the new chart labels

-- First, delete existing data to avoid conflicts
DELETE FROM academic_service_performance;

-- Insert updated academic service performance data with new categories
INSERT INTO academic_service_performance (staff_code, evaluateid, category, internal_score, external_score, non_revenue_score, display_order) VALUES
-- Staff 6531503172 (Dr. Phyo Min Thein) - Current period (1/2025)
('6531503172', 9, 'Other Services', 0, 0, 0, 1),
('6531503172', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503172', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503172', 9, 'Reviewer', 5, 0, 0, 4),
('6531503172', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503172', 9, 'Guest Lecturer', 27, 27, 0, 6),
('6531503172', 9, 'Academic Service Activities', 0, 0, 27, 7),

-- Staff 6531503172 - Previous period (2/2024)
('6531503172', 8, 'Other Services', 0, 0, 0, 1),
('6531503172', 8, 'Visiting Professor', 0, 0, 0, 2),
('6531503172', 8, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503172', 8, 'Reviewer', 3, 0, 0, 4),
('6531503172', 8, 'Committee/Advisor', 0, 0, 0, 5),
('6531503172', 8, 'Guest Lecturer', 20, 20, 0, 6),
('6531503172', 8, 'Academic Service Activities', 0, 0, 20, 7),

-- Staff 6531503017 (Dr. Siriporn Thanakit) - Current period (1/2025)
('6531503017', 9, 'Other Services', 0, 0, 0, 1),
('6531503017', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503017', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503017', 9, 'Reviewer', 4, 0, 0, 4),
('6531503017', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503017', 9, 'Guest Lecturer', 25, 25, 0, 6),
('6531503017', 9, 'Academic Service Activities', 0, 0, 25, 7),

-- Staff 6531503017 - Previous period (2/2024)
('6531503017', 8, 'Other Services', 0, 0, 0, 1),
('6531503017', 8, 'Visiting Professor', 0, 0, 0, 2),
('6531503017', 8, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503017', 8, 'Reviewer', 2, 0, 0, 4),
('6531503017', 8, 'Committee/Advisor', 0, 0, 0, 5),
('6531503017', 8, 'Guest Lecturer', 18, 18, 0, 6),
('6531503017', 8, 'Academic Service Activities', 0, 0, 18, 7),

-- Staff 6531503069 (Dr. Rattana Choosri) - Current period (1/2025)
('6531503069', 9, 'Other Services', 0, 0, 0, 1),
('6531503069', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503069', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503069', 9, 'Reviewer', 6, 0, 0, 4),
('6531503069', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503069', 9, 'Guest Lecturer', 30, 30, 0, 6),
('6531503069', 9, 'Academic Service Activities', 0, 0, 30, 7),

-- Staff 6531503070 (Dr. Suwanna Phakdee) - Current period (1/2025)
('6531503070', 9, 'Other Services', 0, 0, 0, 1),
('6531503070', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503070', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503070', 9, 'Reviewer', 3, 0, 0, 4),
('6531503070', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503070', 9, 'Guest Lecturer', 22, 22, 0, 6),
('6531503070', 9, 'Academic Service Activities', 0, 0, 22, 7),

-- Staff 6531503074 (Dr. Niran Jaikla) - Current period (1/2025)
('6531503074', 9, 'Other Services', 0, 0, 0, 1),
('6531503074', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503074', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503074', 9, 'Reviewer', 7, 0, 0, 4),
('6531503074', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503074', 9, 'Guest Lecturer', 35, 35, 0, 6),
('6531503074', 9, 'Academic Service Activities', 0, 0, 35, 7),

-- Staff 6531503137 (Dr. Kamon Bualert) - Current period (1/2025)
('6531503137', 9, 'Other Services', 0, 0, 0, 1),
('6531503137', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503137', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503137', 9, 'Reviewer', 4, 0, 0, 4),
('6531503137', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503137', 9, 'Guest Lecturer', 28, 28, 0, 6),
('6531503137', 9, 'Academic Service Activities', 0, 0, 28, 7),

-- Staff 6531503174 (Dr. Supansa Chaising) - Current period (1/2025)
('6531503174', 9, 'Other Services', 0, 0, 0, 1),
('6531503174', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503174', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503174', 9, 'Reviewer', 5, 0, 0, 4),
('6531503174', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503174', 9, 'Guest Lecturer', 30, 30, 0, 6),
('6531503174', 9, 'Academic Service Activities', 0, 0, 30, 7),

-- Staff 6531503176 (Dr. Korawit Fakkhong) - Current period (1/2025)
('6531503176', 9, 'Other Services', 0, 0, 0, 1),
('6531503176', 9, 'Visiting Professor', 0, 0, 0, 2),
('6531503176', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6531503176', 9, 'Reviewer', 6, 0, 0, 4),
('6531503176', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6531503176', 9, 'Guest Lecturer', 32, 32, 0, 6),
('6531503176', 9, 'Academic Service Activities', 0, 0, 32, 7),

-- Staff 6631205226 (Dr. Wipob Suttinun) - Current period (1/2025)
('6631205226', 9, 'Other Services', 0, 0, 0, 1),
('6631205226', 9, 'Visiting Professor', 0, 0, 0, 2),
('6631205226', 9, 'Additional Assigned Tasks', 0, 0, 0, 3),
('6631205226', 9, 'Reviewer', 4, 0, 0, 4),
('6631205226', 9, 'Committee/Advisor', 0, 0, 0, 5),
('6631205226', 9, 'Guest Lecturer', 26, 26, 0, 6),
('6631205226', 9, 'Academic Service Activities', 0, 0, 26, 7);
