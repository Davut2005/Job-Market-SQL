-- Companies offering jobs
CREATE TABLE companies (
    company_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    industry VARCHAR(100)
);

-- Job locations
CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100)
);

-- Job postings
CREATE TABLE jobs (
    job_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    company_id INT REFERENCES companies(company_id),
    location_id INT REFERENCES locations(location_id),
    salary_min INT,
    salary_max INT,
    experience_level VARCHAR(50),
    posted_date DATE
);

-- Skills
CREATE TABLE skills (
    skill_id SERIAL PRIMARY KEY,
    skill_name VARCHAR(100) UNIQUE NOT NULL
);

-- Job-Skill mapping (many-to-many)
CREATE TABLE job_skills (
    job_id INT REFERENCES jobs(job_id),
    skill_id INT REFERENCES skills(skill_id),
    PRIMARY KEY (job_id, skill_id)
);
