select * from rooms;

/*Numero de barrios por ciudad*/
SELECT 
    c.name, COUNT(distinct(neighbourhood)) as city_total
FROM
    rooms AS r
        INNER JOIN
    cities AS c ON r.city_id = c.id
GROUP BY c.id 
UNION ALL SELECT 
    'TOTAL', COUNT(distinct(neighbourhood)) 
FROM
    rooms
ORDER BY city_total desc;

/*Numero de anuncios por ciudad*/
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

/*Anuncios para ciudad concreta*/
SELECT 
    r.*
FROM
    rooms AS r
        INNER JOIN
    cities AS c ON r.city_id = c.id
WHERE
    c.name = 'lisbon';

/*Anuncios para ciudad y barrio concreto*/
SELECT 
    r.*
FROM
    rooms AS r
        INNER JOIN
    cities AS c ON r.city_id = c.id
WHERE
    c.name = 'madrid'
    and r.neighbourhood = ' Lavapiés- Embajadores (Centro)';