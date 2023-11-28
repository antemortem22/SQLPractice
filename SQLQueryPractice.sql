/**********************EJERCICIOS DE PRACTICA**********************/
/*1. listar peliculas sin director */
/*2. listar peliculas sin productora */
/*3. listar peliculas sin actores */
/*4. listar actores sin papeles */
/*5. listar cantidad peliculas por productora con recaudacion > $100.000.000 */
/*6. listar los directores con mayor recaudación */
/*7. listar los directores con mayor recaudación en los años 80*/



/*1. listar peliculas sin director */

select *
from Peliculas peli
where peli.id_director is null

/*2. listar peliculas sin productora */

select *
from Peliculas peli
where peli.id_productora is null

/*3. listar peliculas sin actores */

select peli.id_pelicula, peli.titulo, actor.id_actor
from Peliculas peli
	left join Actuaciones act on peli.id_pelicula = act.id_pelicula
	left join Actores actor on actor.id_actor = act.id_actor
where actor.id_actor is null;
----queria probar la logica del left/right
select peli.id_pelicula, peli.titulo, actor.id_actor
from Actores actor
	right join Actuaciones act on actor.id_actor = act.id_actor
	right join Peliculas peli on peli.id_pelicula = act.id_pelicula
where act.id_actor is null;

/*4. listar actores sin papeles */

select actor.id_actor, actor.nombre, act.id_actuacion
from Actores actor
	left join Actuaciones act on actor.id_actor = act.id_actor
where act.id_actor is null

/*5. listar cantidad peliculas por productora con recaudacion > $100.000.000 */

select produ.id_productora, produ.nombre, count(*) cantidad_peliculas, format(sum(peli.recaudacion), 'C0') recaudacion_total
from Peliculas peli
	inner join Productoras produ on peli.id_productora = produ.id_productora
group by produ.id_productora, produ.nombre
having sum(peli.recaudacion) > 100000000.00


/*6. listar los directores con mayor recaudación */

select direc.id_director,  direc.nombre, format(sum(pelis.recaudacion), 'C0') recaudacion_director
from Peliculas pelis
	inner join Directores direc ON direc.id_director = pelis.id_director
group by direc.id_director, direc.nombre
order by sum(pelis.recaudacion) desc;


/*7. listar los directores con mayor recaudación en los años 80*/

select direc.id_director,direc.nombre, pelis.año_estreno, format(sum(pelis.recaudacion), 'C0') as recaudacion_director
from peliculas pelis
    inner join directores direc on direc.id_director = pelis.id_director
where pelis.año_estreno between 1980 and 1989
group by direc.id_director, direc.nombre, pelis.año_estreno
order by sum(pelis.recaudacion) desc;