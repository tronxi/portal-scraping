select * from rooms;


SELECT 
    c.name, COUNT(*) as city_total
FROM
    rooms AS r
        INNER JOIN
    cities AS c ON r.city_id = c.id
GROUP BY c.id 
UNION ALL SELECT 
    'TOTAL', COUNT(*)
FROM
    rooms
ORDER BY city_total desc;


SELECT 
    r.*
FROM
    rooms AS r
        INNER JOIN
    cities AS c ON r.city_id = c.id
WHERE
    c.name = 'manchester';