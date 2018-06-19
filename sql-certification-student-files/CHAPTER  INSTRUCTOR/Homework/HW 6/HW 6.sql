-- -----------------------------------------------------------------------------  
-- EXERCISES USE PM Device Manasgement Worksheet to follow along
/*
    You run the Network Operations Center monitoring devices for your university.
    Your development team has just completed the Next Gen project. Your network
    engineers have started moving devices in the ticketing system from Legacy to
    Next Gen.
    
    The Project Manager has sent you the Project Tracking spreadsheet she is using
    to keep track of the project. 
        
*/
-- -------------------------------------
-- 1. List the devices from the legacy system
--    select * from legacy;
--    How many?
-- -------------------------------------
-- 2. List the devices from the next_gen system
--    select * from next_gen;
--    How many?
-- -------------------------------------
-- NOTE:  We need to use the short mac address name
--
-- 3. Fix any problems in LEGACY
--            select * from legacy where m_short = '8A-F3x87[';
--            update legacy set m_short = '8A-F3' where m_short = '8A-F3x87[';
-- -------------------------------------
-- 3. Fix any problems in NEXTGEN
--    select * from next_gen;
--    OK no problems
-- -------------------------------------
-- 4. List the devices that have been migrated
--    select m_short,bldg, mac_short, building
--    from legacy join next_gen on m_short=mac_short;
-- -------------------------------------
-- 5. What percent have been migrated
-- -------------------------------------
-- 7. List all legacy devices along with migrated devices
--    select *
--    from legacy left join next_gen on m_short=mac_short;
-- -------------------------------------
-- 8. List only devices not yet migrated
--    select *
--    from legacy left join next_gen on m_short=mac_short
--    where mac_short is null;
-- -------------------------------------
-- 9. What percent are not yet migrated

-- -------------------------------------
-- 10. How many devices have been disposed

-- -------------------------------------