--1.La primera consulta realizada para saber qué crimenes se cometieron en la ciudad para la fecha conocida
--y se descubrió que hay solo un crimen para la fecha, del cual se sabe de dos testigos
SELECT * FROM crime_scene_report 
WHERE type = 'murder' 
AND city = 'SQL City';

--2. La segunda consulta realizada es de acuerdo a la información obtenida en la anterior,
--donde sabiamos el nombre de un testigo y su barrio de residencia, el segundo solo sabiamos la casa
--y el barrio y por medio de la busqueda actual encontramos su nombre Morty Schapiro
SELECT DISTINCT name,address_number
FROM person 
WHERE address_street_name  LIKE 'Northwestern Dr' 
order by address_number DESC 
LIMIT 5;

--3. La tercera consulta realizada es en ma misma parte de la anterior, donde buscamos todos los datos de 
--la testigo que teniamos el nombre
SELECT DISTINCT *
FROM person 
WHERE address_street_name LIKE 'Franklin Ave' AND name LIKE'%Anna%' ;

--4. La cuarta consulta realizada es para encontrar el testimonio dado por Annabell y Morty Schapiro
--lo cual nos dio más información acerca del sospechoso, principalemnte por datos de su gimmnasio
SELECT p.name, i.transcript,p.id
FROM person as p 
JOIN interview as i
  ON i.person_id = p.id
WHERE name LIKE 'Morty Schapiro' Or name LIKE 'Annabel Miller'
;
--5. La quinta consulta realizada es para encontrar el nombre del sospechoso,
--por medio de los datos dados por los testigos, de la membresia y que coincidiera con el chech in del 
--9 de enero que comentaba Annabel Miller, lo cual nos dio el nombre de dos posibles sospechosos.

SELECT a.membership_id, m.person_id ,m.name, a.check_in_date
FROM get_fit_now_member as m
JOIN get_fit_now_check_in as a
ON m.id= a.membership_id
WHERE membership_id LIKE "%48Z%" AND check_in_date = 20180109
;
--6. Revisando las placas de carros con el numero que cohincidia con el testimonio de Morty Schapiro, 
--se encontró que Jeremy Bowers cohincidia con ambos testimonios, por lo cual es el presunto asesino
SELECT p.name, d.plate_number
FROM person as p
JOIN drivers_license as d
ON p.license_id= d.id
WHERE plate_number LIKE "%H42W%" 
;

--7. Al revisar el testimonio de Jeremy Bowers, relata el como fue contratado por una mujer para cometer
--el asesinato, así que se decide seguir indagando la mente maestra detrás del crimen.

SELECT p.id, p.name, i.transcript
FROM person as p
JOIN interview as i
ON i.person_id = p.id
WHERE name LIKE "Jeremy Bowers" 

--8.Tras revisar de acuerdo a la información dada por Jeremy Bowers,
--se encuentran 3 posibles muejeres 
SELECT p.name, p.id,d.car_model, d.car_make
FROM drivers_license as d
JOIN person as p
ON d.id = p.license_id
WHERE d.hair_color 
LIKE "red" and d.height between 65 and 67 and gender 
LIKE "female" AND 	car_make = "Tesla"
;
--9. Ahora verificando con el testimonio de Jeremy, la ubicación en el evento en diciembre, se encuentra que 
--Miranda Priestly es la unica de las tres muejres que coincidio con el evento, tres veces, siendo entonces ella 
--la mente intelectual del asesinato

SELECT p.name,e.event_name,e.date
FROM person as p
JOIN facebook_event_checkin as e
ON p.id = e.person_id
WHERE name IN ("Red Korb","Regina George", "Miranda Priestly")

;