--05.01

select count(idficha) from Ficha --Total fichas
select count(idficha) from Ficha where tipoconsumidor='G'--Total fichas G
select count(idficha) from Ficha where tipoconsumidor='M'--Total fichas M
select count(idficha) from Ficha where tipoconsumidor='P'--Total fichas P

--FORMA-01
select count(idficha) as [TOTAL-FICHAS],
	   (select count(idficha) from Ficha where tipoconsumidor='G') as [TOTAL-G], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='M') as [TOTAL-M], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='P') as [TOTAL-P]  --CI
from Ficha --CE

--FORMA-02
select (select count(idficha) from Ficha) as [TOTAL-FICHAS],                     --CI
	   (select count(idficha) from Ficha where tipoconsumidor='G') as [TOTAL-G], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='M') as [TOTAL-M], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='P') as [TOTAL-P]  --CI

--05.02
select count(idtrabajador) from Trabajador --TOTAL-E-S
select count(idtrabajador) from Trabajador where tipo='E'--TOTAL-E
select count(idtrabajador) from Trabajador where tipo='S'--TOTAL-S

--FORMA-01
select count(idtrabajador) as [TOTAL-E-S],
       (select count(idtrabajador) from Trabajador where tipo='E') as [TOTAL-E],
	   (select count(idtrabajador) from Trabajador where tipo='S') as [TOTAL-S]
from   Trabajador 

--FORMA-02
select (select count(idtrabajador) from Trabajador) as [TOTAL-E-S],
       (select count(idtrabajador) from Trabajador where tipo='E') as [TOTAL-E],
	   (select count(idtrabajador) from Trabajador where tipo='S') as [TOTAL-S]

--05.03

select * from Ficha where idtrabajador=12

select UPPER('manrique'), --Pasar a mayúscula la expresión
       LOWER('MANRIQUE'),  --Pasar a minúscula la expresión
	   REPLACE('GIANFRANCO MANRIQUE VALENTIN',' ','_') --Remplazar una cadena por otra

select t.usuario as USUARIO,
       UPPER(SUBSTRING(p.nombres,1,1))+LOWER(SUBSTRING(p.nombres,2,LEN(p.nombres)-1)) as PRIMERA_LETRA,
	   REPLACE(UPPER(rtrim(ltrim(p.nombres))),' ','_') as NOMBRES,
	   REPLACE(LOWER(rtrim(ltrim(p.apellidos))),' ','_') as APELLIDOS,
	   (select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as TOTAL,
	   case 
	   when (select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) between 1 and  19
	   then 'Baja productividad'
	   when (select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) between 20 and  29
	   then 'Mediana productividad'
	   when (select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>=30
	   then 'Alta productividad'
	   when (select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)=0
	   then 'Sin fichas'
	   else 'No es posible mostrar mensaje'
	   end as mensaje
from Trabajador t
inner join Padron p on t.idpadron=p.idpadron
where t.tipo='E' --Encuestador

