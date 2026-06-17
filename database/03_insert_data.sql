-- Insert Water Regions (12 rows)
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Sutlej Basin', 'Punjab', 27000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Indira Gandhi Canal', 'Rajasthan', 68000000, 'Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Godavari Basin', 'Maharashtra', 112000000, 'Tropical');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Narmada Valley', 'Gujarat', 60000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Periyar Basin', 'Kerala', 34000000, 'Tropical Wet');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Ganga Basin', 'Uttar Pradesh', 199000000, 'Humid Subtropical');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Chambal Basin', 'Madhya Pradesh', 72000000, 'Subtropical');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Yamuna Basin', 'Haryana', 25000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Kaveri Basin', 'Karnataka', 61000000, 'Tropical Monsoon');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Brahmaputra Valley', 'Assam', 31000000, 'Tropical Rainforest');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Mahanadi Basin', 'Odisha', 41000000, 'Tropical Savannah');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Krishna Basin', 'Andhra Pradesh', 49000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Tapti Basin', 'Madhya Pradesh', 18000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Pennar Basin', 'Andhra Pradesh', 14000000, 'Tropical Wet and Dry');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Luni Basin', 'Rajasthan', 22000000, 'Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Sabarmati Basin', 'Gujarat', 32000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Mahi Basin', 'Gujarat', 15000000, 'Semi-Arid');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Subarnarekha Basin', 'Jharkhand', 12000000, 'Tropical Savannah');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Brahmani Basin', 'Odisha', 11000000, 'Tropical Wet');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Baitarani Basin', 'Odisha', 8000000, 'Tropical Wet');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Cauvery Delta', 'Tamil Nadu', 45000000, 'Tropical Monsoon');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Damodar Basin', 'West Bengal', 21000000, 'Humid Subtropical');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Barak Basin', 'Manipur', 6000000, 'Tropical Rainforest');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Jhelum Basin', 'Jammu & Kashmir', 13000000, 'Alpine');
INSERT INTO water_region VALUES (seq_water_region.NEXTVAL, 'Chenab Basin', 'Himachal Pradesh', 7000000, 'Alpine');

-- Insert Officers (14 rows)
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Ramesh Kumar', 'Regional Head', 1);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Sunita Sharma', 'Senior Officer', 2);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Vikram Singh', 'Field Officer', 3);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Priya Patel', 'Field Officer', 4);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Amit Desai', 'Regional Head', 5);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Karthik N', 'Senior Officer', 6);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Sanjay Yadav', 'Field Officer', 7);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Neha Das', 'Field Officer', 8);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Arun Verma', 'Senior Officer', 9);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Pooja Reddy', 'Regional Head', 10);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Suresh Pillai', 'Field Officer', 11);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Anita Roy', 'Regional Head', 12);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Deepak Jain', 'Senior Officer', 1);
INSERT INTO officer VALUES (seq_officer.NEXTVAL, 'Meera Menon', 'Field Officer', 2);

-- Insert Login Users (14 rows)
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'user1', 'user123', 'User', 1);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'user2', 'user123', 'User', 2);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer1', 'off123', 'ResourceOfficer', 3);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer2', 'off123', 'ResourceOfficer', 4);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer3', 'off123', 'ResourceOfficer', 5);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'monitor1', 'mon123', 'MonitoringAuthority', 6);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'monitor2', 'mon123', 'MonitoringAuthority', 7);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer4', 'off123', 'ResourceOfficer', 8);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'user3', 'user123', 'User', 9);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'monitor3', 'mon123', 'MonitoringAuthority', 10);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer5', 'off123', 'ResourceOfficer', 11);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'user4', 'user123', 'User', 12);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer6', 'off123', 'ResourceOfficer', 13);
INSERT INTO login_user VALUES (seq_login_user.NEXTVAL, 'officer7', 'off123', 'ResourceOfficer', 14);

-- Insert Reservoirs (12 rows)
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Bhakra Dam', 9340, 7500, 1);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Bisalpur Dam', 1095, 300, 2);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Jayakwadi Dam', 2909, 2800, 3);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Sardar Sarovar Dam', 9500, 8900, 4);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Idukki Dam', 1999, 1500, 5);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Tehri Dam', 3540, 3000, 6);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Gandhi Sagar Dam', 7322, 4000, 7);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Hathnikund Barrage', 500, 450, 8);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Krishna Raja Sagara', 1400, 1100, 9);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Subansiri Dam', 5000, 4200, 10);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Hirakud Dam', 5818, 4500, 11);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Nagarjuna Sagar', 11472, 8500, 12);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Ukai Dam', 7414, 5200, 13);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Somasila Dam', 1994, 1500, 14);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Jawai Dam', 1000, 800, 15);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Dharoi Dam', 1200, 950, 16);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Kadana Dam', 1540, 1100, 17);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Chandil Dam', 850, 600, 18);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Rengali Dam', 3400, 2900, 19);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Salandi Dam', 650, 450, 20);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Mettur Dam', 2640, 2100, 21);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Maithon Dam', 1350, 1100, 22);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Tipaimukh Dam', 5200, 4100, 23);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Uri Dam', 450, 300, 24);
INSERT INTO reservoir VALUES (seq_reservoir.NEXTVAL, 'Salal Dam', 600, 450, 25);

-- Insert Rivers (25 rows)
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Sutlej', 150, 4.5, 1);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Luni', 80, 2.5, 2);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Godavari', 350, 8.2, 3);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Narmada', 280, 6.5, 4);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Periyar', 190, 5.0, 5);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Ganges', 500, 12.0, 6);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Chambal', 120, 3.8, 7);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Yamuna', 450, 10.5, 8);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Kaveri', 210, 6.2, 9);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Brahmaputra', 800, 15.5, 10);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Mahanadi', 310, 7.8, 11);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Krishna', 400, 9.0, 12);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Tapti', 220, 5.5, 13);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Pennar', 180, 4.2, 14);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Sukri', 40, 1.5, 15);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Sabarmati', 110, 3.1, 16);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Mahi', 160, 4.8, 17);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Subarnarekha', 130, 3.9, 18);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Brahmani', 200, 5.0, 19);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Baitarani', 90, 2.8, 20);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Kollidam', 140, 4.5, 21);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Damodar', 170, 5.1, 22);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Barak', 250, 7.0, 23);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Jhelum', 320, 8.5, 24);
INSERT INTO river VALUES (seq_river.NEXTVAL, 'Chenab', 380, 9.2, 25);

-- Insert Multi-Day Rainfall Records for Charts (Region 1-3 as examples)
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-6, 10, 1, 'officer1');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-5, 25, 1, 'officer1');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-4, 45, 1, 'officer1');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-3, 60, 1, 'officer1');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-2, 120, 1, 'officer1');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-1, 80, 1, 'officer1');

INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-6, 5, 2, 'officer2');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-5, 0, 2, 'officer2');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-4, 0, 2, 'officer2');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-3, 10, 2, 'officer2');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-2, 5, 2, 'officer2');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-1, 0, 2, 'officer2');

INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-6, 50, 3, 'officer3');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-5, 55, 3, 'officer3');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-4, 70, 3, 'officer3');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-3, 85, 3, 'officer3');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-2, 60, 3, 'officer3');
INSERT INTO rainfall_record VALUES (seq_rainfall.NEXTVAL, SYSDATE-1, 40, 3, 'officer3');

-- Insert Groundwater Records
INSERT INTO groundwater_record VALUES (seq_groundwater.NEXTVAL, SYSDATE-5, 45.5, 1, 'officer1');
INSERT INTO groundwater_record VALUES (seq_groundwater.NEXTVAL, SYSDATE-5, 85.0, 2, 'officer2');
INSERT INTO groundwater_record VALUES (seq_groundwater.NEXTVAL, SYSDATE-5, 25.4, 3, 'officer3');
INSERT INTO groundwater_record VALUES (seq_groundwater.NEXTVAL, SYSDATE-5, 30.1, 4, 'officer4');

-- Insert Water Quality 
INSERT INTO water_quality VALUES (seq_water_quality.NEXTVAL, 7.2, 2.5, 1, 'officer1');
INSERT INTO water_quality VALUES (seq_water_quality.NEXTVAL, 7.5, 3.0, 2, 'officer2');
INSERT INTO water_quality VALUES (seq_water_quality.NEXTVAL, 8.1, 4.5, 3, 'officer3');
INSERT INTO water_quality VALUES (seq_water_quality.NEXTVAL, 6.8, 2.1, 4, 'officer4');

-- Insert Alerts 
INSERT INTO alert VALUES (seq_alert.NEXTVAL, 'Flood Warning', 'Critical', SYSTIMESTAMP - INTERVAL '2' DAY, 3, 'N', NULL);
INSERT INTO alert VALUES (seq_alert.NEXTVAL, 'High Turbidity', 'Medium', SYSTIMESTAMP - INTERVAL '5' DAY, 7, 'Y', 'user1');
INSERT INTO alert VALUES (seq_alert.NEXTVAL, 'Drought Risk', 'Critical', SYSTIMESTAMP - INTERVAL '1' DAY, 2, 'N', NULL);
INSERT INTO alert VALUES (seq_alert.NEXTVAL, 'Normal Operations', 'Low', SYSTIMESTAMP - INTERVAL '10' DAY, 1, 'Y', 'user2');
INSERT INTO alert VALUES (seq_alert.NEXTVAL, 'Contamination Detected', 'Medium', SYSTIMESTAMP - INTERVAL '3' DAY, 5, 'N', NULL);

COMMIT;
