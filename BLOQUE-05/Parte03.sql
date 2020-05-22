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