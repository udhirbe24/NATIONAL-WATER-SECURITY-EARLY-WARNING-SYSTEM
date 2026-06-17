CREATE OR REPLACE PROCEDURE generate_water_report(p_region_id IN NUMBER) IS
    v_region_name VARCHAR2(100);
    v_alerts_count NUMBER;
    v_avg_level NUMBER;
    v_latest_rainfall NUMBER;
    v_latest_gw_depth NUMBER;
BEGIN
    BEGIN
        SELECT region_name INTO v_region_name FROM water_region WHERE region_id = p_region_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        v_region_name := 'Unknown';
    END;
    
    BEGIN
        SELECT COUNT(*) INTO v_alerts_count FROM alert WHERE region_id = p_region_id AND is_resolved = 'N';
    EXCEPTION WHEN NO_DATA_FOUND THEN
        v_alerts_count := 0;
    END;
    
    BEGIN
        SELECT NVL(AVG(current_level), 0) INTO v_avg_level FROM reservoir WHERE region_id = p_region_id;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        v_avg_level := 0;
    END;
    
    BEGIN
        SELECT rainfall_amount INTO v_latest_rainfall FROM (
            SELECT rainfall_amount FROM rainfall_record WHERE region_id = p_region_id ORDER BY record_date DESC
        ) WHERE ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN 
        v_latest_rainfall := 0; 
    END;
    
    BEGIN
        SELECT depth INTO v_latest_gw_depth FROM (
            SELECT depth FROM groundwater_record WHERE region_id = p_region_id ORDER BY record_date DESC
        ) WHERE ROWNUM = 1;
    EXCEPTION WHEN NO_DATA_FOUND THEN 
        v_latest_gw_depth := 0; 
    END;
    
    DBMS_OUTPUT.PUT_LINE('Region: ' || v_region_name);
    DBMS_OUTPUT.PUT_LINE('Active Alerts: ' || v_alerts_count);
    DBMS_OUTPUT.PUT_LINE('Average Reservoir Level: ' || ROUND(v_avg_level, 2));
    DBMS_OUTPUT.PUT_LINE('Latest Rainfall: ' || v_latest_rainfall || ' mm');
    DBMS_OUTPUT.PUT_LINE('Latest Groundwater Depth: ' || v_latest_gw_depth || ' m');
END;
/
