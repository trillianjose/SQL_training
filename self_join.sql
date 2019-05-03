--1
SELECT COUNT(*)
FROM stops

--2
SELECT id
FROM stops
WHERE name='Craiglockhart'

--3
SELECT id, name FROM stops, route
  WHERE id=stop
    AND company='LRT'
    AND num='4'

--4
SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*)=2

--5
SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop = 53 AND b.stop=149

--6
SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
  AND stopb.name='London Road'

--7
SELECT DISTINCT R1.company, R1.num
  FROM route R1, route R2
  WHERE R1.num=R2.num AND R1.company=R2.company
    AND R1.stop=115 AND R2.stop=137

--8
SELECT R1.company, R1.num
  FROM route R1, route R2, stops S1, stops S2
  WHERE R1.num=R2.num AND R1.company=R2.company
    AND R1.stop=S1.id AND R2.stop=S2.id
    AND S1.name='Craiglockhart'
    AND S2.name='Tollcross'

--9
SELECT DISTINCT S2.name, R2.company, R2.num
FROM stops S1, stops S2, route R1, route R2
WHERE S1.name='Craiglockhart'
  AND S1.id=R1.stop
  AND R1.company=R2.company AND R1.num=R2.num
  AND R2.stop=S2.id

--10
SELECT bus1.num, bus1.company, name, bus2.num, bus2.company FROM (SELECT start1.num, start1.company, stop1.stop FROM route AS start1 JOIN route AS stop1 ON start1.num = stop1.num AND start1.company = stop1.company AND start1.stop != stop1.stop WHERE start1.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')) AS bus1 JOIN (SELECT start2.num, start2.company, start2.stop FROM route AS start2 JOIN route AS stop2 ON start2.num = stop2.num AND start2.company = stop2.company and start2.stop != stop2.stop WHERE stop2.stop = (SELECT id FROM stops WHERE name = 'Lochend')) AS bus2 ON bus1.stop = bus2.stop JOIN stops ON bus1.stop = stops.id ORDER BY bus1.num, bus1.company, name, bus2.num, bus2.company
