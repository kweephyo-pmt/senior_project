-- Add evaluation ID 8 data for domain 3 (academic service) using existing chart labels
-- This ensures chart labels remain the same when switching between evaluation periods

-- Remove existing academic_service_performance evaluation ID 8 data first
DELETE FROM academic_service_performance WHERE evaluateid = 8;

-- Academic Service Performance - Evaluation ID 8 (using exact 7 categories from database)
INSERT INTO academic_service_performance (staff_code, evaluateid, category, internal_score, external_score, non_revenue_score, revenue_score, display_order) VALUES
-- Staff 6431703502
('6431703502', 8, 'Other Services', 0, 0, 0, 0, 1),
('6431703502', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6431703502', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6431703502', 8, 'Reviewer', 6, 0, 0, 0, 4),
('6431703502', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6431703502', 8, 'Guest Lecturer', 22, 24, 0, 0, 6),
('6431703502', 8, 'Academic Service Activities', 0, 0, 23, 23, 7),

-- Staff 6531503017
('6531503017', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503017', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503017', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503017', 8, 'Reviewer', 4, 0, 0, 0, 4),
('6531503017', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503017', 8, 'Guest Lecturer', 20, 22, 0, 0, 6),
('6531503017', 8, 'Academic Service Activities', 0, 0, 21, 21, 7),

-- Staff 6531503069
('6531503069', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503069', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503069', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503069', 8, 'Reviewer', 5, 0, 0, 0, 4),
('6531503069', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503069', 8, 'Guest Lecturer', 18, 20, 0, 0, 6),
('6531503069', 8, 'Academic Service Activities', 0, 0, 19, 19, 7),

-- Staff 6531503070
('6531503070', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503070', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503070', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503070', 8, 'Reviewer', 7, 0, 0, 0, 4),
('6531503070', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503070', 8, 'Guest Lecturer', 24, 26, 0, 0, 6),
('6531503070', 8, 'Academic Service Activities', 0, 0, 25, 25, 7),

-- Staff 6531503074
('6531503074', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503074', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503074', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503074', 8, 'Reviewer', 8, 0, 0, 0, 4),
('6531503074', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503074', 8, 'Guest Lecturer', 26, 28, 0, 0, 6),
('6531503074', 8, 'Academic Service Activities', 0, 0, 27, 27, 7),

-- Staff 6531503137
('6531503137', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503137', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503137', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503137', 8, 'Reviewer', 3, 0, 0, 0, 4),
('6531503137', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503137', 8, 'Guest Lecturer', 16, 18, 0, 0, 6),
('6531503137', 8, 'Academic Service Activities', 0, 0, 17, 17, 7),

-- Staff 6531503172
('6531503172', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503172', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503172', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503172', 8, 'Reviewer', 4, 0, 0, 0, 4),
('6531503172', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503172', 8, 'Guest Lecturer', 22, 24, 0, 0, 6),
('6531503172', 8, 'Academic Service Activities', 0, 0, 25, 25, 7),

-- Staff 6531503174
('6531503174', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503174', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503174', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503174', 8, 'Reviewer', 9, 0, 0, 0, 4),
('6531503174', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503174', 8, 'Guest Lecturer', 30, 33, 0, 0, 6),
('6531503174', 8, 'Academic Service Activities', 0, 0, 31, 31, 7),

-- Staff 6531503176
('6531503176', 8, 'Other Services', 0, 0, 0, 0, 1),
('6531503176', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6531503176', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6531503176', 8, 'Reviewer', 5, 0, 0, 0, 4),
('6531503176', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6531503176', 8, 'Guest Lecturer', 21, 25, 0, 0, 6),
('6531503176', 8, 'Academic Service Activities', 0, 0, 22, 22, 7),

-- Staff 6631205226
('6631205226', 8, 'Other Services', 0, 0, 0, 0, 1),
('6631205226', 8, 'Visiting Professor', 0, 0, 0, 0, 2),
('6631205226', 8, 'Additional Assigned Tasks', 0, 0, 0, 0, 3),
('6631205226', 8, 'Reviewer', 6, 0, 0, 0, 4),
('6631205226', 8, 'Committee/Advisor', 0, 0, 0, 0, 5),
('6631205226', 8, 'Guest Lecturer', 24, 27, 0, 0, 6),
('6631205226', 8, 'Academic Service Activities', 0, 0, 24, 24, 7);