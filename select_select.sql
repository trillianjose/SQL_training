--1
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

--2
SELECT name FROM world
  WHERE continent='Europe' AND gdp/population > (SELECT gdp/population FROM world
   WHERE name = 'United Kingdom')

--3
SELECT name, continent
FROM world
  WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina',
  'Australia')) ORDER BY name

--4
SELECT name, population
FROM world
  WHERE population > (SELECT population FROM world WHERE name = 'Canada') AND
  population < (SELECT population FROM world WHERE name = 'Poland')

--5
SELECT name, CONCAT(ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100), '%') AS porcentage_Germany
FROM world
  WHERE continent = 'Europe'

--6
SELECT name
FROM world
  WHERE gdp > ALL (SELECT gdp FROM world WHERE continent = 'Europe' AND NOT gdp =
  0)

--7
SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area > 0)

--8
SELECT continent, name
FROM world x
  WHERE name <= ALL (SELECT name FROM world y
        WHERE y.continent=x.continent)

--9
SELECT name, continent, population
FROM world
WHERE continent IN (SELECT continent
FROM world x
WHERE 25000000 > ALL (SELECT DISTINCT population
FROM world y
WHERE y.continent = x.continent))

--10
SELECT name, continent
FROM world x
WHERE  population/3 > ALL (SELECT population
FROM world y
where y.continent = x.continent AND x.name <> y.name)
