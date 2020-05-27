--06.01

--SUBCONSULTAS FROM
select idficha as [ID FICHA],numhabitantes as [NUM HAB],rm.nombre as [NOM MZA],
rm.num_fichas as [M NUM FICHAS],
rm.tot_hab as [M TOT HAB],
rm.max_hab as [M MAX HAB],
rm.min_hab as [M MIN HAB],
rm.prom_hab as [M PROM HAB]
from Ficha f 
left join (
	select f.idmanzana,m.nombre,count(idficha) as num_fichas,sum(f.numhabitantes) as tot_hab,
	max(f.numhabitantes) as max_hab,min(f.numhabitantes) as min_hab,avg(f.numhabitantes) as prom_hab
	from Ficha f
	left join Manzana m on f.idmanzana=m.idmanzana
	group by f.idmanzana,m.nombre
) rm on f.idmanzana=rm.idmanzana
order by rm.nombre

--OVER+FUNCIONES AGRUPAMIENTO
create function F_REPORTE_FICHA() returns table as
return
	select idficha as [ID FICHA],numhabitantes as [NUM HAB],m.nombre as [NOM MZA],
	count(idficha)     OVER(PARTITION BY m.nombre) as [M NUM FICHAS],
	sum(numhabitantes) OVER(PARTITION BY m.nombre) as [M TOT HAB],
	max(numhabitantes) OVER(PARTITION BY m.nombre) as [M MAX HAB],
	min(numhabitantes) OVER(PARTITION BY m.nombre) as [M MIN HAB],
	avg(numhabitantes) OVER(PARTITION BY m.nombre) as [M PROM HAB]
	from Ficha f left join Manzana m on f.idmanzana=m.idmanzana

select * from F_REPORTE_FICHA() order by [NOM MZA]

--06.03
	create function F_REPORTE_MANZANA(@idmanzana int) returns table as
	alter function F_REPORTE_MANZANA(@idmanzana int) returns table as
	return
	select 
	m.nombre as [MANZANA],
	idficha as [IDFICHA],
	numhabitantes as [NHABITANTES],
	ROW_NUMBER()OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as [RN],
	RANK()OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as [RK],
	DENSE_RANK()OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as [DRK],
	NTILE(4)OVER(PARTITION BY m.nombre ORDER BY f.numhabitantes ASC) as NTILE4
	from Ficha f left join Manzana m on f.idmanzana=m.idmanzana
	where f.idmanzana=case when @idmanzana=0 then f.idmanzana else @idmanzana end

	select * from F_REPORTE_MANZANA(0)
	--order by m.nombre asc, f.numhabitantes ASC
