# Entity-Relationship Diagram - Senior Project Database

## Database: `senior_project`

```
┌─────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                     │
│                           LECTURER PROFILES (Central Entity)                        │
│  ┌───────────────────────────────────────────────────────────────────────────────┐ │
│  │ lecturer_profiles                                                             │ │
│  ├───────────────────────────────────────────────────────────────────────────────┤ │
│  │ PK  staff_code VARCHAR(20)                                                    │ │
│  │     staff_name VARCHAR(100)                                                   │ │
│  │     phone VARCHAR(20)                                                         │ │
│  │     location VARCHAR(100)                                                     │ │
│  │     program VARCHAR(100)                                                      │ │
│  │     position VARCHAR(50)                                                      │ │
│  │     email VARCHAR(255)                                                        │ │
│  │     INDEX: idx_lecturer_profiles_email                                        │ │
│  └───────────────────────────────────────────────────────────────────────────────┘ │
│                                       │                                             │
│                                       │                                             │
│         ┌─────────────────────────────┼─────────────────────────────┐              │
│         │                             │                             │              │
│         │ FK                          │ FK                          │ (No FK)      │
│         ▼                             ▼                             ▼              │
│  ┌──────────────────┐        ┌──────────────────┐        ┌──────────────────┐     │
│  │lecturer_education│        │lecturer_research │        │lecturer_          │     │
│  │                  │        │    _areas        │        │  publications    │     │
│  ├──────────────────┤        ├──────────────────┤        ├──────────────────┤     │
│  │PK id             │        │PK id             │        │PK id             │     │
│  │FK staff_code ────┼────┐   │FK staff_code ────┼────┐   │   staff_code ────┼───┐ │
│  │   degree         │    │   │   research_area  │    │   │   title          │   │ │
│  │   institution    │    │   │   TEXT           │    │   │   authors        │   │ │
│  │   year           │    │   └──────────────────┘    │   │   venue          │   │ │
│  └──────────────────┘    │                           │   │   year           │   │ │
│                          │                           │   │   link           │   │ │
│  Constraint:             │   Constraint:             │   │   evaluateid     │   │ │
│  lecturer_education_     │   lecturer_research_      │   │   created_at     │   │ │
│  ibfk_1                  │   areas_ibfk_1            │   │   updated_at     │   │ │
│                          │                           │   │                  │   │ │
│                          │                           │   │ Indexes:         │   │ │
│                          │                           │   │ - idx_staff_code │   │ │
│                          │                           │   │ - idx_year       │   │ │
│                          │                           │   │ - idx_evaluateid │   │ │
│                          │                           │   └──────────────────┘   │ │
│                          │                           │                          │ │
│                          │   ┌───────────────────────┘                          │ │
│                          │   │                                                  │ │
│                          │   │   ┌──────────────────────────────────────────────┘ │
│                          │   │   │                                                │
│                          └───┼───┼────────────────────────────────────────────────┘
│                              │   │
│                              │   │  ⚠️ MISSING FOREIGN KEY
│                              │   │  (Recommended to add)
└──────────────────────────────┼───┼────────────────────────────────────────────────┘
                               │   │
                               │   │
┌──────────────────────────────┼───┼────────────────────────────────────────────────┐
│                              │   │                                                │
│                    BUDGET SYSTEM (Independent - No FK Currently)                  │
│                              │   │                                                │
│                              ▼   ▼                                                │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │ budget_categories                                                          │  │
│  ├────────────────────────────────────────────────────────────────────────────┤  │
│  │ PK  id INT AUTO_INCREMENT                                                  │  │
│  │     name VARCHAR(100)                                                      │  │
│  │     color VARCHAR(7)                                                       │  │
│  │     total_budget DECIMAL(10,2) DEFAULT 0.00                                │  │
│  │     spent_amount DECIMAL(10,2) DEFAULT 0.00                                │  │
│  │     year INT DEFAULT 2025                                                  │  │
│  │     evaluateid INT DEFAULT 9                                               │  │
│  │     staff_code VARCHAR(20) NOT NULL  ◄─── ⚠️ No FK (Should add)           │  │
│  │     created_at TIMESTAMP                                                   │  │
│  │     updated_at TIMESTAMP                                                   │  │
│  │                                                                            │  │
│  │ Indexes:                                                                   │  │
│  │ - idx_evaluateid (evaluateid)                                             │  │
│  │ - idx_staff_evaluate (staff_code, evaluateid)                             │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
│                                       │                                           │
│                                       │ 1                                         │
│                                       │                                           │
│                                       │ N                                         │
│                                       ▼                                           │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │ budget_projects                                                            │  │
│  ├────────────────────────────────────────────────────────────────────────────┤  │
│  │ PK  id INT AUTO_INCREMENT                                                  │  │
│  │ FK  category_id INT ──────────────────────┐                                │  │
│  │     title VARCHAR(200)                    │                                │  │
│  │     budget_amount DECIMAL(10,2)           │                                │  │
│  │     duration VARCHAR(50)                  │                                │  │
│  │     year INT DEFAULT 2025                 │                                │  │
│  │     evaluateid INT DEFAULT 9              │                                │  │
│  │     staff_code VARCHAR(20)                │                                │  │
│  │     created_at TIMESTAMP                  │                                │  │
│  │     updated_at TIMESTAMP                  │                                │  │
│  │                                           │                                │  │
│  │ Indexes:                                  │                                │  │
│  │ - idx_evaluateid (evaluateid)            │                                │  │
│  │ - idx_staff_evaluate (staff_code, evaluateid)                             │  │
│  │                                           │                                │  │
│  │ Constraint: budget_projects_ibfk_1        │                                │  │
│  │ ON DELETE CASCADE                         │                                │  │
│  └───────────────────────────────────────────┼────────────────────────────────┘  │
│                                              │                                   │
│                                              │ 1                                 │
│                                              │                                   │
│                                              │ N                                 │
│                                              ▼                                   │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │ project_owners                                                             │  │
│  ├────────────────────────────────────────────────────────────────────────────┤  │
│  │ PK  id INT AUTO_INCREMENT                                                  │  │
│  │ FK  project_id INT ───────────────────────┐                                │  │
│  │     owner_name VARCHAR(100)               │                                │  │
│  │     is_primary TINYINT(1) DEFAULT 0       │                                │  │
│  │     created_at TIMESTAMP                  │                                │  │
│  │     evaluateid INT DEFAULT 9              │                                │  │
│  │                                           │                                │  │
│  │ Constraint: project_owners_ibfk_1         │                                │  │
│  │ ON DELETE CASCADE                         │                                │  │
│  └───────────────────────────────────────────┼────────────────────────────────┘  │
│                                              │                                   │
└──────────────────────────────────────────────┼───────────────────────────────────┘
                                               │
                                               │
┌──────────────────────────────────────────────┼───────────────────────────────────┐
│                                              │                                   │
│                    STAFF BUDGET INFO (Lookup Table - No FK)                      │
│                                              │                                   │
│  ┌────────────────────────────────────────────────────────────────────────────┐  │
│  │ staff_budget_info                                                          │  │
│  ├────────────────────────────────────────────────────────────────────────────┤  │
│  │ PK  id INT AUTO_INCREMENT                                                  │  │
│  │ UK  staff_code VARCHAR(20)  ◄─── ⚠️ No FK (Should add)                    │  │
│  │ UK  email VARCHAR(100)                                                     │  │
│  │     staff_name VARCHAR(100)                                                │  │
│  │     department VARCHAR(100)                                                │  │
│  │     created_at TIMESTAMP                                                   │  │
│  │     updated_at TIMESTAMP                                                   │  │
│  └────────────────────────────────────────────────────────────────────────────┘  │
│                                                                                   │
└───────────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔑 Relationship Summary

### ✅ **Existing Foreign Keys (Implemented)**

| Child Table | Parent Table | Foreign Key | Constraint | On Delete |
|------------|--------------|-------------|------------|-----------|
| `lecturer_education` | `lecturer_profiles` | `staff_code` | `lecturer_education_ibfk_1` | - |
| `lecturer_research_areas` | `lecturer_profiles` | `staff_code` | `lecturer_research_areas_ibfk_1` | - |
| `budget_projects` | `budget_categories` | `category_id` | `budget_projects_ibfk_1` | CASCADE |
| `project_owners` | `budget_projects` | `project_id` | `project_owners_ibfk_1` | CASCADE |

### ⚠️ **Missing Foreign Keys (Recommended to Add)**

| Child Table | Parent Table | Column | Reason |
|------------|--------------|--------|--------|
| `budget_categories` | `lecturer_profiles` | `staff_code` | Ensure budgets belong to valid staff |
| `lecturer_publications` | `lecturer_profiles` | `staff_code` | Ensure publications belong to valid staff |
| `staff_budget_info` | `lecturer_profiles` | `staff_code` | Maintain consistency between systems |

---

## 📊 Cardinality Legend

- **1:N** = One-to-Many relationship
- **PK** = Primary Key
- **FK** = Foreign Key
- **UK** = Unique Key
- **─────** = Existing foreign key relationship
- **- - -** = Missing foreign key (recommended)

---

## 🔧 SQL to Add Missing Foreign Keys

```sql
-- Add FK for budget_categories
ALTER TABLE budget_categories 
ADD CONSTRAINT fk_budget_categories_staff 
FOREIGN KEY (staff_code) 
REFERENCES lecturer_profiles(staff_code) 
ON DELETE CASCADE;

-- Add FK for lecturer_publications
ALTER TABLE lecturer_publications 
ADD CONSTRAINT fk_lecturer_publications_staff 
FOREIGN KEY (staff_code) 
REFERENCES lecturer_profiles(staff_code) 
ON DELETE CASCADE;

-- Add FK for staff_budget_info
ALTER TABLE staff_budget_info 
ADD CONSTRAINT fk_staff_budget_info_staff 
FOREIGN KEY (staff_code) 
REFERENCES lecturer_profiles(staff_code) 
ON DELETE CASCADE;
```

---

## 📝 Notes

1. **Central Entity**: `lecturer_profiles` is the core table that other tables reference
2. **Budget System**: Has internal relationships but not connected to lecturer_profiles via FK
3. **Cascade Deletes**: Current FKs use CASCADE, meaning deleting a parent deletes children
4. **Data Integrity**: Adding missing FKs will prevent orphaned records
5. **Insert Order**: With FKs, must insert lecturer_profiles before related records

---

## 🎯 Recommendations

1. ✅ **Add missing foreign keys** for data integrity
2. ✅ **Run validation queries** before adding FKs to check for orphaned data
3. ⚠️ **Consider using `ON DELETE RESTRICT`** instead of CASCADE for safety
4. ✅ **Document cascade behavior** for team awareness

---

**Generated**: October 22, 2025  
**Database Version**: MySQL 8.0.41  
**Project**: Senior Project - KPI Management System
