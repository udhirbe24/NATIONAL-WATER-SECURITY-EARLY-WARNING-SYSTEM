CREATE OR REPLACE TRIGGER trg_water_quality_alert
AFTER INSERT ON water_quality
FOR EACH ROW
DECLARE
    v_region_id NUMBER;
    v_alert_level VARCHAR2(20);
BEGIN
    IF :NEW.ph_level < 6.5 OR :NEW.ph_level > 8.5 OR :NEW.turbidity > 5 THEN
        SELECT region_id INTO v_region_id FROM reservoir WHERE reservoir_id = :NEW.reservoir_id;
        
        IF :NEW.ph_level < 6.0 OR :NEW.ph_level > 9.0 THEN
            v_alert_level := 'Critical';
        ELSE
            v_alert_level := 'Medium';
        END IF;
        
        INSERT INTO alert (alert_id, alert_type, alert_level, region_id)
        VALUES (seq_alert.NEXTVAL, 'Contamination', v_alert_level, v_region_id);
    END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_reservoir_alert
AFTER INSERT OR UPDATE ON reservoir
FOR EACH ROW
BEGIN
    IF :NEW.current_level < (0.2 * :NEW.capacity) THEN
        INSERT INTO alert (alert_id, alert_type, alert_level, region_id)
        VALUES (seq_alert.NEXTVAL, 'Drought Risk', 'Critical', :NEW.region_id);
    ELSIF :NEW.current_level > (0.9 * :NEW.capacity) THEN
        INSERT INTO alert (alert_id, alert_type, alert_level, region_id)
        VALUES (seq_alert.NEXTVAL, 'Flood Risk', 'Critical', :NEW.region_id);
    END IF;
END;
/
