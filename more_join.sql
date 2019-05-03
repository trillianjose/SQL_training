--1
SELECT id, title
 FROM movie
 WHERE yr=1962

--2
SELECT yr
 FROM movie
 WHERE title = 'Citizen Kane'

--3
SELECT id, title, yr
 FROM movie
 WHERE title LIKE 'Star Trek%'
 ORDER BY yr

--4
SELECT id
 FROM actor
 WHERE name = 'Glenn Close'

--5
SELECT id
 FROM movie
 WHERE title = 'Casablanca'

--6
SELECT name
 FROM actor JOIN casting ON id = actorid
 WHERE movieid = 11768

--7
SELECT name
 FROM movie JOIN casting ON id = movieid JOIN actor ON actorid = actor.id
 WHERE title = 'Alien'

--8
SELECT title
 FROM movie JOIN casting ON id = movieid JOIN actor ON actorid = actor.id
 WHERE name = 'Harrison Ford'

--9
SELECT title
 FROM movie JOIN casting ON id = movieid JOIN actor ON actorid = actor.id
 WHERE name = 'Harrison Ford' AND ord > 1

--10
SELECT title, name
 FROM movie JOIN casting ON id = movieid JOIN actor ON actorid = actor.id
 WHERE yr = 1962 AND ord = 1

--11
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)

--12
SELECT title, name
FROM movie JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE movie.id IN (SELECT movie.id
FROM movie JOIN casting ON movie.id = movieid JOIN actor ON actor.id = actorid
WHERE name ='Julie Andrews') AND ord = 1

--13
SELECT name
FROM movie JOIN casting ON movie.id = movieid
JOIN actor ON actor.id = actorid
WHERE ord = 1
GROUP BY name HAVING COUNT(*) >= 30

--14
SELECT title, casted
FROM movie JOIN (SELECT movieid, COUNT(actorid) casted
FROM casting
GROUP BY movieid) t ON movie.id = t.movieid
WHERE yr = 1978
ORDER BY casted DESC, title

--15
SELECT name
FROM casting JOIN actor ON actor.id = actorid
WHERE movieid IN (SELECT movieid FROM casting LEFT JOIN actor ON actorid = actor.id WHERE name = 'Art Garfunkel') AND name <> 'Art Garfunkel'
