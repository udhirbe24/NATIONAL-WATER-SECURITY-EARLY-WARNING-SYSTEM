CREATE OR REPLACE PROCEDURE print_active_alerts(p_region_id IN NUMBER) IS
    CURSOR c_alerts IS
        SELECT alert_id, alert_type, alert_level, alert_timestamp
        FROM alert
        WHERE region_id = p_region_id AND is_resolved = 'N'
        ORDER BY alert_timestamp DESC;
        
    v_id NUMBER;
    v_type VARCHAR2(100);
    v_level VARCHAR2(20);
    v_timestamp TIMESTAMP;
BEGIN
    OPEN c_alerts;
    LOOP
        FETCH c_alerts INTO v_id, v_type, v_level, v_timestamp;
        EXIT WHEN c_alerts%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id || ' | Type: ' || v_type || ' | Level: ' || v_level || ' | Time: ' || TO_CHAR(v_timestamp, 'YYYY-MM-DD HH24:MI:SS'));
    END LOOP;
    CLOSE c_alerts;
END;
/

