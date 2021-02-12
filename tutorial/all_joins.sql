SELECT
    matchid,
    player
FROM
    goal
WHERE
    teamid = 'GER';

SELECT
    id,
    stadium,
    team1,
    team2
FROM
    game
WHERE
    id = '1012';

SELECT
    player,
    teamid,
    stadium,
    mdate
FROM
    game
    JOIN goal ON (id = matchid)
WHERE
    teamid = 'GER';

SELECT
    team1,
    team2,
    player
FROM
    game
    JOIN goal ON (id = matchid)
WHERE
    player LIKE 'MARIO %';

SELECT
    player,
    teamid,
    coach,
    gtime
FROM
    goal
    JOIN eteam ON teamid = id
WHERE
    gtime <= 10;

SELECT
    mdate,
    teamname
FROM
    game
    JOIN eteam ON game.team1 = eteam.id
WHERE
    coach = 'Fernando Santos';

SELECT
    player
FROM
    goal
    JOIN game ON goal.matchid = game.id
WHERE
    stadium = 'National Stadium, Warsaw';

SELECT
    DISTINCT player
FROM
    game
    JOIN goal ON matchid = id
WHERE
    (
        team1 = teamid
        AND team2 = 'GER'
    )
    OR (
        team1 = 'GER'
        AND team2 = teamid
    );

SELECT
    teamname,
    COUNT(player)
FROM
    eteam
    JOIN goal ON id = teamid
GROUP BY
    teamname;

SELECT
    stadium,
    COUNT(player)
FROM
    game
    JOIN goal ON id = matchid
GROUP BY
    stadium;

SELECT
    matchid,
    mdate,
    COUNT(player)
FROM
    game
    JOIN goal ON matchid = id
WHERE
    (
        team1 = 'POL'
        OR team2 = 'POL'
    )
GROUP BY
    matchid,
    mdate;

SELECT
    matchid,
    mdate,
    COUNT(*)
FROM
    game
    JOIN goal ON matchid = id
WHERE
    (teamid = 'GER')
GROUP BY
    matchid,
    mdate;

-- self join
SELECT
    count(id)
FROM
    stops;

SELECT
    id
FROM
    stops
WHERE
    name = 'Craiglockhart';

SELECT
    stops.id,
    stops.name
FROM
    route
    JOIN stops ON route.stop = stops.id
WHERE
    route.num = 4
    AND route.company = 'LRT'
ORDER BY
    route.pos;

SELECT
    company,
    num,
    COUNT(*)
FROM
    route
WHERE
    STOP = 149
    OR STOP = 53
GROUP BY
    company,
    num
HAVING
    count(*) = 2;

SELECT
    a.company,
    a.num,
    a.stop,
    b.stop
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 53
    AND b.stop = 149;

SELECT
    a.company,
    a.num,
    stopa.name,
    stopb.name
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
    JOIN stops stopa ON (a.stop = stopa.id)
    JOIN stops stopb ON (b.stop = stopb.id)
WHERE
    stopa.name = 'Craiglockhart'
    AND stopb.name = 'London Road';

SELECT
    DISTINCT a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.company = b.company
        AND a.num = b.num
    )
WHERE
    a.stop = 115
    AND b.stop = 137
    OR a.stop = 137
    AND b.stop = 115;

SELECT
    a.company,
    a.num
FROM
    route a
    JOIN route b ON (
        a.num = b.num
        AND a.company = b.company
    )
    JOIN stops stopsa ON a.stop = stopsa.id
    JOIN stops stopsb ON b.stop = stopsb.id
WHERE
    stopsa.name = 'Craiglockhart'
    AND stopsb.name = 'Tollcross';

SELECT
    bus1.num,
    bus1.company,
    bus2.transfer,
    bus2.num,
    bus2.company
FROM
    (
        SELECT
            DISTINCT a.num,
            a.company,
            stopb.name AS transfer
        FROM
            route a
            JOIN route b ON (
                a.num = b.num
                AND a.company = b.company
            )
            JOIN stops stopa ON (stopa.id = a.stop)
            JOIN stops stopb ON (stopb.id = b.stop)
        WHERE
            stopa.name = 'Craiglockhart'
    ) AS bus1
    JOIN (
        SELECT
            DISTINCT a.num,
            a.company,
            stopb.name AS transfer
        FROM
            route a
            JOIN route b ON (
                a.num = b.num
                AND a.company = b.company
            )
            JOIN stops stopa ON (stopa.id = a.stop)
            JOIN stops stopb ON (stopb.id = b.stop)
        WHERE
            stopa.name = 'Lochend'
    ) AS bus2 ON (bus1.transfer = bus2.transfer)
ORDER BY
    bus1.num,
    bus1.transfer,
    bus2.num;