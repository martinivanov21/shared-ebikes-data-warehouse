-- given function with 0 case handling
-- run it on database once

CREATE OR REPLACE FUNCTION haversine_km(lat1 numeric, lon1 numeric,
                                        lat2 numeric, lon2 numeric)
RETURNS numeric AS $$
DECLARE
    distance numeric;
BEGIN
    IF lat1 = lat2 AND lon1 = lon2 THEN
        RETURN 0;
    END IF;

    SELECT 6371 * ACOS(
        COS(radians(lat1))
        * COS(radians(lat2))
        * COS(radians(lon2) - radians(lon1))
        + SIN(radians(lat1)) * SIN(radians(lat2)))
    INTO distance;

    RETURN distance;
END;
$$ LANGUAGE plpgsql IMMUTABLE;


-- test - result should be 0 , and around 0.18
-- SELECT haversine_km(51.2054, 4.41352, 51.2054, 4.41352) AS test_distance_same,
--      haversine_km(51.2054, 4.41352, 51.206, 4.415) AS test_distance_diff;
