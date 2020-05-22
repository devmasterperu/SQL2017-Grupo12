--05.08

--SUBCONSULTAS
select DAY(getdate()) as DIA,MONTH(getdate()) as MES, YEAR(getdate()) as AÑO

select u.nom_dpto as DPTO,u.nom_prov as PROV,u.nom_dto as DTO,ru.TOTAL,ru.MAXFECNACIMIENTO,
DAY(ru.MAXFECNACIMIENTO) as [DIA NACIMIENTO],
MONTH(ru.MAXFECNACIMIENTO) as [MES NACIMIENTO],
YEAR(ru.MAXFECNACIMIENTO) as [AÑO NACIMIENTO]
from Ubigeo u
left join 
--Por cada ubigeo, total de personas, fecha de nacimiento más reciente
(
select idubigeo,count(idpadron) as TOTAL,max(fecnacimiento) as MAXFECNACIMIENTO
from Padron
where idtipo=1
group by idubigeo
) ru on u.idubigeo=ru.idubigeo

insert into Ubigeo values(99,'LIMA',99,'LIMA',99,'SIN ESPECIFICAR')

--CTES
WITH CTE_RU --NOMBRE_CTE
AS
(   /*CONSULTA_INTERNA*/
	select idubigeo,count(idpadron) as TOTAL,max(fecnacimiento) as MAXFECNACIMIENTO
	from Padron
	where idtipo=1
	group by idubigeo
)
/*CONSULTA_EXTERNA*/
select u.nom_dpto as DPTO,u.nom_prov as PROV,u.nom_dto as DTO,ru.TOTAL,ru.MAXFECNACIMIENTO,
DAY(ru.MAXFECNACIMIENTO) as [DIA NACIMIENTO],
MONTH(ru.MAXFECNACIMIENTO) as [MES NACIMIENTO],
YEAR(ru.MAXFECNACIMIENTO) as [AÑO NACIMIENTO]
from Ubigeo u left join CTE_RU ru on u.idubigeo=ru.idubigeo
left join CTE_RU ru2 on u.idubigeo=ru2.idubigeo

--05.09

--SUBCONSULTAS
select m.idmanzana as ID,m.nombre as MANZANA,
(select count(idficha) from Ficha) as [TOTAL FICHAS],isnull(rf.total,0) as [TOTAL FICHAS MZA],
(select count(1) from Asignacion) as [TOTAL ASIGNA], isnull(ra.total,0) as [TOTAL ASIGNA MZA]
from manzana m
left join
(
select idmanzana,count(idficha) as total from ficha
group by idmanzana
) rf on m.idmanzana=rf.idmanzana
left join
(
select idmanzana,count(1) as total from asignacion
group by idmanzana
) ra on m.idmanzana=ra.idmanzana

--CTES
WITH 
CTE_RF AS (select idmanzana,count(idficha) as total from ficha group by idmanzana),
CTE_RA AS (select idmanzana,count(1) as total from asignacion group by idmanzana)
select m.idmanzana as ID,m.nombre as MANZANA,
(select count(idficha) from Ficha) as [TOTAL FICHAS],isnull(rf.total,0) as [TOTAL FICHAS MZA],
(select count(1) from Asignacion) as [TOTAL ASIGNA], isnull(ra.total,0) as [TOTAL ASIGNA MZA]
from manzana m
left join CTE_RF as rf on m.idmanzana=rf.idmanzana
left join CTE_RA as ra on m.idmanzana=ra.idmanzana

--05.10
--MTOPAGO_PROM
select AVG(montopago) from Ficha --75.78

select tipoconsumidor as TIPO,
ltrim(p.nombres)+' '+ltrim(p.apellidos) as CLIENTE,f.montopago as MTOPAGO,
(select AVG(montopago) from Ficha) as MTOPAGO_PROM
from Ficha f inner join Cliente c on f.idcliente=c.idcliente
inner join Padron p on c.idpadron=p.idpadron
where f.montopago>(select AVG(montopago) from Ficha)
order by MTOPAGO desc

--05.12

--SUBCONSULTAS
--Fichas registradas por cada encuestador
select idtrabajador,count(idficha) as total from Ficha group by idtrabajador
--Promedio de fichas registradas de todos los encuestadores
select AVG(re.total)
from (select idtrabajador,count(idficha) as total from Ficha group by idtrabajador) re

select idtrabajador as [ID ENCUESTADOR],
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as [TOTAL FICHAS],
(select AVG(re.total) from 
	(select idtrabajador,count(idficha) as total from Ficha group by idtrabajador) re
) as [TOTAL PROM]
from Trabajador t
where t.tipo='E' and 
--[TOTAL FICHAS]
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>
--[TOTAL PROM]
(select AVG(re.total) from 
	(select idtrabajador,count(idficha) as total from Ficha group by idtrabajador) re
)

--CTES
WITH CTE_RE AS (select idtrabajador,count(idficha) as total from Ficha group by idtrabajador)
select idtrabajador as [ID ENCUESTADOR],
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as [TOTAL FICHAS],
(select AVG(re.total) from CTE_RE re) as [TOTAL PROM]
from Trabajador t
where t.tipo='E' and 
--[TOTAL FICHAS]
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>
--[TOTAL PROM]
(select AVG(re.total) from CTE_RE re)

--VISTAS
CREATE VIEW dbo.V_REPORTE_E AS --CREAR UNA VISTA
ALTER VIEW dbo.V_REPORTE_E AS --MODIFICAR UNA VISTA
DROP VIEW dbo.V_REPORTE_E --ELIMINAR UNA VISTA
WITH CTE_RE AS (select idtrabajador,count(idficha) as total from Ficha group by idtrabajador)
select idtrabajador as [ID_ENCUESTADOR],
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as [TOTAL FICHAS],
(select AVG(re.total) from CTE_RE re) as [TOTAL PROM],t.estado as ESTADO
from Trabajador t
where t.tipo='E' and 
--[TOTAL FICHAS]
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>
--[TOTAL PROM]
(select AVG(re.total) from CTE_RE re)

select ve.*,t.usuario from V_REPORTE_E ve 
inner join Trabajador t on ve.[ID_ENCUESTADOR]=t.idtrabajador

--FUNCIONES DE VALOR TABLA
CREATE FUNCTION F_REPORTE_E() returns table as --CREAR UNA FUNCION DE VALOR TABLA
ALTER FUNCTION F_REPORTE_E() returns table as --MODIFICAR UNA FUNCION DE VALOR TABLA
DROP FUNCTION F_REPORTE_E --ELIMINAR UNA FUNCION DE VALOR TABLA
return
WITH CTE_RE AS (select idtrabajador,count(idficha) as total from Ficha group by idtrabajador)
select idtrabajador as [ID_ENCUESTADOR],
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as [TOTAL FICHAS],
(select AVG(re.total) from CTE_RE re) as [TOTAL PROM]
from Trabajador t
where t.tipo='E' and 
--[TOTAL FICHAS]
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>
--[TOTAL PROM]
(select AVG(re.total) from CTE_RE re)

--Validación
select * from F_REPORTE_E()
--FUNCION DE VALOR TABLA CON PARAMETRO

ALTER FUNCTION F_REPORTE_E(@idencuestador int,@estado bit) returns table as --CREAR UNA FUNCION DE VALOR TABLA
return
WITH CTE_RE AS (select idtrabajador,count(idficha) as total from Ficha group by idtrabajador)
select idtrabajador as [ID_ENCUESTADOR],
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador) as [TOTAL FICHAS],
(select AVG(re.total) from CTE_RE re) as [TOTAL PROM]
from Trabajador t
where t.tipo='E' and t.idtrabajador=@idencuestador and t.estado=@estado and
--[TOTAL FICHAS]
(select count(idficha) from Ficha f where f.idtrabajador=t.idtrabajador)>
--[TOTAL PROM]
(select AVG(re.total) from CTE_RE re)

select * from F_REPORTE_E(11,1)

--05.13

select GETUTCDATE()

--05.14

--Trabajadores que tienen fichas
select usuario,contrasena,case when estado=1 then 'ACTIVO' else 'INACTIVO' end as estado,
eomonth(getdate()) as CIERRE
from Trabajador t
where exists (select idficha from Ficha where idtrabajador=t.idtrabajador)

--Trabajadores que tienen asignación
select * from Trabajador t
where idtrabajador in (select distinct idencuestador from Asignacion)

--Trabajadores que NO tienen asignación
select * from Trabajador t
where idtrabajador not in (select distinct idencuestador from Asignacion)