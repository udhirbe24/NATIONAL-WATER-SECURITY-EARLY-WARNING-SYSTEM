CREATE SEQUENCE seq_water_region START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_officer START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_login_user START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_reservoir START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_river START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_rainfall START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_groundwater START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_water_quality START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_alert START WITH 1 INCREMENT BY 1;

CREATE TABLE water_region (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2(100) NOT NULL,
    state VARCHAR2(100) NOT NULL,
    population NUMBER,
    climate_type VARCHAR2(50)
);

CREATE TABLE officer (
    officer_id NUMBER PRIMARY KEY,
    officer_name VARCHAR2(100) NOT NULL,
    designation VARCHAR2(100),
    region_id NUMBER,
    CONSTRAINT fk_officer_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);

CREATE TABLE login_user (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL,
    role VARCHAR2(30) CHECK (role IN ('User','ResourceOfficer','MonitoringAuthority')),
    officer_id NUMBER,
    CONSTRAINT fk_login_officer FOREIGN KEY (officer_id) REFERENCES officer(officer_id)
);

CREATE TABLE reservoir (
    reservoir_id NUMBER PRIMARY KEY,
    reservoir_name VARCHAR2(100) NOT NULL,
    capacity NUMBER NOT NULL CHECK (capacity > 0),
    current_level NUMBER CHECK (current_level >= 0),
    region_id NUMBER,
    CONSTRAINT fk_reservoir_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);

CREATE TABLE river (
    river_id NUMBER PRIMARY KEY,
    river_name VARCHAR2(100) NOT NULL,
    flow_rate NUMBER,
    water_level NUMBER,
    region_id NUMBER,
    CONSTRAINT fk_river_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);

CREATE TABLE rainfall_record (
    rainfall_id NUMBER PRIMARY KEY,
    record_date DATE NOT NULL,
    rainfall_amount NUMBER NOT NULL,
    region_id NUMBER,
    inserted_by VARCHAR2(50),
    CONSTRAINT fk_rainfall_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);

CREATE TABLE groundwater_record (
    groundwater_id NUMBER PRIMARY KEY,
    record_date DATE NOT NULL,
    depth NUMBER NOT NULL,
    region_id NUMBER,
    inserted_by VARCHAR2(50),
    CONSTRAINT fk_groundwater_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);

CREATE TABLE water_quality (
    quality_id NUMBER PRIMARY KEY,
    ph_level NUMBER CHECK (ph_level BETWEEN 0 AND 14),
    turbidity NUMBER,
    reservoir_id NUMBER,
    inserted_by VARCHAR2(50),
    CONSTRAINT fk_water_quality_reservoir FOREIGN KEY (reservoir_id) REFERENCES reservoir(reservoir_id)
);

CREATE TABLE alert (
    alert_id NUMBER PRIMARY KEY,
    alert_type VARCHAR2(100) NOT NULL,
    alert_level VARCHAR2(20) CHECK (alert_level IN ('Low','Medium','Critical')),
    alert_timestamp TIMESTAMP DEFAULT SYSTIMESTAMP,
    region_id NUMBER,
    is_resolved CHAR(1) DEFAULT 'N' CHECK (is_resolved IN ('Y','N')),
    resolved_by VARCHAR2(50),
    CONSTRAINT fk_alert_region FOREIGN KEY (region_id) REFERENCES water_region(region_id)
);
