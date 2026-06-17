CREATE OR REPLACE FUNCTION get_avg_water_level(p_region_id IN NUMBER, p_month IN NUMBER) RETURN NUMBER IS
    v_avg_level NUMBER;
BEGIN
    SELECT NVL(AVG(current_level), 0) INTO v_avg_level 
    FROM reservoir 
    WHERE region_id = p_region_id 
    AND EXTRACT(MONTH FROM SYSDATE) = p_month;
    
    RETURN v_avg_level;
EXCEPTION WHEN NO_DATA_FOUND THEN
    RETURN 0;
END;
/
