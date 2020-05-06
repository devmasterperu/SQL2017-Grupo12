--03.01
--a
select count(1) from Sector--4
select count(1) from Manzana--16

select s.idsector,m.idmanzana
from Sector as s cross join Manzana as m--4x16=64

--b

select count(1) from Sector--4
select count(1) from Manzana where estado=1--13

select s.idsector,m.idmanzana
from Sector as s cross join Manzana as m--4x13=52
where m.estado=1

select Sector.idsector,idmanzana
from Sector cross join Manzana--4x13=52
where Manzana.estado=1

--c

select count(1) from Sector--4
select count(1) from Manzana where estado=1
and nombre like '001%'--6

select s.idsector,m.idmanzana
from Sector as s cross join Manzana as m--4x6=24
where m.estado=1 and m.nombre like '001%'

--03.02

select idtipo,numdoc,ltrim(nombres)+' '+ltrim(apellidos)as [NOMBRE-COMPLETO],
u.nom_dto as UBIGEO
from Padron p inner join Ubigeo u on p.idubigeo=u.idubigeo
where idtipo<>'06' and (nombres like '%JORGE%' or apellidos like '%CAMARGO%')--Personas