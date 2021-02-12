SELECT
  population
FROM
  world
WHERE
  name = 'Germany';

SELECT
  name,
  population
FROM
  world
WHERE
  name IN ('Sweden', 'Norway', 'Denmark');

SELECT
  name,
  area
FROM
  world
WHERE
  area BETWEEN 200000
  AND 250000;

-- select where
SELECT
  name,
  continent,
  population
FROM
  world;

SELECT
  name
FROM
  world
WHERE
  population > 200000000;

SELECT
  name,
  GDP / population
FROM
  world
WHERE
  population > 200000000;

SELECT
  name,
  population / 1000000
FROM
  world
WHERE
  continent = 'South America';

SELECT
  name,
  population
FROM
  world
WHERE
  name IN ('France', 'Germany', 'Italy');

SELECT
  name
FROM
  world
WHERE
  name LIKE '%United%';

SELECT
  name,
  population,
  area
FROM
  world
WHERE
  area > 3000000
  OR population > 250000000;

SELECT
  name,
  population,
  area
FROM
  world
WHERE
  area > 3000000
  xor population > 250000000;

SELECT
  name,
  ROUND(population / 1000000, 2),
  ROUND(gdp / 1000000000, 2)
FROM
  world
WHERE
  continent = 'South America';

SELECT
  name,
  ROUND(GDP / population, -3)
FROM
  world
WHERE
  GDP > 1000000000000;

SELECT
  name,
  capital
FROM
  world
WHERE
  LENGTH(name) = LENGTH(capital);

SELECT
  name,
  capital
FROM
  world
WHERE
  LEFT(name, 1) = LEFT(capital, 1)
  AND name <> capital;

SELECT
  name
FROM
  world
WHERE
  name LIKE '%a%'
  AND name LIKE '%e%'
  AND name LIKE '%i%'
  AND name LIKE '%o%'
  AND name LIKE '%u%'
  AND name NOT LIKE '% %';

-- nobel Nobel Laureates
SELECT
  yr,
  subject,
  winner
FROM
  nobel
WHERE
  yr = 1950;

SELECT
  winner
FROM
  nobel
WHERE
  yr = 1962
  AND subject = 'Literature';

SELECT
  yr,
  subject
FROM
  nobel
WHERE
  winner = 'Albert Einstein';

SELECT
  winner
FROM
  nobel
WHERE
  subject = 'peace'
  AND yr >= 2000;

SELECT
  *
FROM
  nobel
WHERE
  subject = 'literature'
  AND yr BETWEEN 1980
  AND 1989;

SELECT
  *
FROM
  nobel
WHERE
  winner IN (
    'Theodore Roosevelt',
    'Woodrow Wilson',
    'Barack Obama',
    'Jimmy Carter'
  );

SELECT
  winner
FROM
  nobel
WHERE
  winner LIKE 'John%';

SELECT
  *
FROM
  nobel
WHERE
  yr = 1984
  AND subject = 'Chemistry'
UNION
SELECT
  *
FROM
  nobel
WHERE
  yr = 1980
  AND subject = 'Physics';

SELECT
  *
FROM
  nobel
WHERE
  yr = 1980
  AND subject NOT IN ('Chemistry', 'Medicine');

SELECT
  *
FROM
  nobel
WHERE
  yr >= 2004
  AND subject = 'Literature'
UNION
SELECT
  *
FROM
  nobel
WHERE
  yr < 1910
  AND subject = 'Medicine';

SELECT
  *
FROM
  nobel
WHERE
  winner = 'PETER GRÜNBERG';

SELECT
  *
FROM
  nobel
WHERE
  winner = 'EUGENE O\'NEILL';

SELECT
  winner,
  yr,
  subject
FROM
  nobel
WHERE
  winner LIKE 'Sir %'
ORDER BY
  yr DESC;

SELECT
  winner,
  subject
FROM
  nobel
WHERE
  yr = 1984
ORDER BY
  subject IN ('Physics', 'Chemistry'),
  subject,
  winner;

--  SELECT within SELECT Tutorial
SELECT
  name
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Russia'
  );

SELECT
  name
FROM
  world
WHERE
  gdp / population > (
    SELECT
      gdp / population
    FROM
      world
    WHERE
      name = 'United Kingdom'
  )
  AND continent = 'Europe';

SELECT
  name,
  continent
FROM
  world
WHERE
  continent IN (
    SELECT
      continent
    FROM
      world
    WHERE
      name IN ('Argentina', 'Australia')
  )
ORDER BY
  name
SELECT
  name,
  population
FROM
  world
WHERE
  population > (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Canada'
  )
  AND population < (
    SELECT
      population
    FROM
      world
    WHERE
      name = 'Poland'
  )
SELECT
  name,
  ROUND(
    100 * population /(
      SELECT
        population
      FROM
        world
      WHERE
        name = 'Germany'
    )
  ) || '%'
FROM
  world
WHERE
  continent = 'Europe';

SELECT
  name
FROM
  world
WHERE
  GDP > (
    SELECT
      MAX(GDP)
    FROM
      world
    WHERE
      continent = 'Europe'
  );

SELECT
  continent,
  name,
  area
FROM
  world x
WHERE
  area = (
    SELECT
      MAX(area)
    FROM
      world y
    WHERE
      x.continent = y.continent
  );

SELECT
  continent,
  name
FROM
  world x
WHERE
  name <= ALL(
    SELECT
      name
    FROM
      world y
    WHERE
      x.continent = y.continent
  );