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

--03.03
select m.nombre as [NOM-MANZANA],isnull(s.nombre,'SIN_NOMBRE') as [NOM-SECTOR],
	   concat('Mi id en la tabla manzana es ' ,m.idmanzana) as mensaje
from Manzana m inner join Sector s on m.idsector=s.idsector
where m.estado=1--Manzanas activas

--03.04
--select getdate():Fecha y hora del servidor.

--update Asignacion set fecfin='2020-05-01' where idmanzana=2 --Cerrando 3 asignaciones

select 
m.nombre as NOMBRE_MANZANA,
ltrim(p.nombres)+' '+ltrim(p.apellidos) as NOMBRE_COMPLETO_ENCUESTADOR,
a.idsupervisor as [ID-SUPERVISOR],
convert(varchar(8),a.fecinicio,112) as FECINICIO,
convert(varchar(8),getdate(),112) as HOY,
convert(varchar(8),a.fecfin,112) as FECFIN
from Asignacion a 
--NOMBRE_MANZANA
inner join Manzana m on a.idmanzana=m.idmanzana 
--NOMBRE_COMPLETO_ENCUESTADOR
inner join Trabajador t on a.idencuestador=t.idtrabajador
inner join Padron p on t.idpadron=p.idpadron
where 
--HOY:convert(varchar(8),getdate(),112)
convert(varchar(8),a.fecinicio,112)<=convert(varchar(8),getdate(),112) and
convert(varchar(8),getdate(),112)<=convert(varchar(8),isnull(a.fecfin,getdate()),112)

--03.05
select 
m.nombre as NOMBRE_MANZANA,
ltrim(p.nombres)+' '+ltrim(p.apellidos) as NOMBRE_COMPLETO_ENCUESTADOR,
ltrim(ps.nombres)+' '+ltrim(ps.apellidos) as NOMBRE_COMPLETO_SUPERVISOR
from Asignacion a 
--NOMBRE_MANZANA
inner join Manzana m on a.idmanzana=m.idmanzana 
--NOMBRE_COMPLETO_ENCUESTADOR
inner join Trabajador t on a.idencuestador=t.idtrabajador
inner join Padron p on t.idpadron=p.idpadron
--NOMBRE_COMPLETO_SUPERVISOR
inner join Trabajador ts on a.idsupervisor=ts.idtrabajador
inner join Padron ps on ts.idpadron=ps.idpadron
where 
--HOY:convert(varchar(8),getdate(),112)
convert(varchar(8),a.fecinicio,112)<=convert(varchar(8),getdate(),112) and
convert(varchar(8),getdate(),112)<=convert(varchar(8),isnull(a.fecfin,getdate()),112)