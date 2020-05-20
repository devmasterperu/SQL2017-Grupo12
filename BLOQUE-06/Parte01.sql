--05.04
select count(idficha) from ficha where idmanzana=1
select count(idficha) from ficha where idmanzana=2
select count(idficha) from ficha where idmanzana=3

select 
m.nombre as MANZANA,
(select count(idficha) from ficha f where f.idmanzana=m.idmanzana) as TOTAL,
case 
when (select count(idficha) from ficha f where f.idmanzana=m.idmanzana)=0 then 'Sin recorrido' 
when (select count(idficha) from ficha f where f.idmanzana=m.idmanzana) between 1 and 59 then 'Manzana con poco recorrido'
when (select count(idficha) from ficha f where f.idmanzana=m.idmanzana) between 60 and 99 then 'Manzana medianamente recorrida'
when (select count(idficha) from ficha f where f.idmanzana=m.idmanzana)>=100 then 'Manzana con gran recorrido'
else 'Sin mensaje'
end as MENSAJE
from Manzana m

--05.05

select count(idficha) from Ficha --947

select cast(round(13.2512,3) as decimal(5,1))

select 
usuario,
(select count(idficha) from ficha f where f.idencuestador=t.idtrabajador) as TOTAL_U,
(select count(idficha) from Ficha) as TOTAL,
cast(round((select count(idficha) from ficha f where f.idencuestador=t.idtrabajador)*100.000/(select count(idficha) from Ficha),3) 
as decimal(5,3)) as PORCENTAJE
from Trabajador t where tipo='E'

--05.07

--FORMA_01
select 
m.idmanzana as ID,
m.nombre as MANZANA,
isnull((select count(idficha) from ficha f where f.idmanzana=m.idmanzana),0) as TOTAL,
isnull((select max(montopago) from ficha f where f.idmanzana=m.idmanzana),0) as MAXIMO_MTOPAGO,
isnull((select min(montopago) from ficha f where f.idmanzana=m.idmanzana),0) as MINIMO_MTOPAGO,
isnull((select avg(montopago) from ficha f where f.idmanzana=m.idmanzana),0) as PROMEDIO_MTOPAGO
from Manzana m

--FORMA_02
select 
m.idmanzana as ID,
m.nombre as MANZANA,
isnull(rm.TOTAL,0) as TOTAL,
isnull(rm.MAXIMO_MTOPAGO,0) as MAXIMO_MTOPAGO,
isnull(rm.MINIMO_MTOPAGO,0) as MINIMO_MTOPAGO,
isnull(rm.PROMEDIO_MTOPAGO,0) as PROMEDIO_MTOPAGO
from Manzana m
left join
(
select idmanzana,count(idficha) as TOTAL,max(montopago) as MAXIMO_MTOPAGO,
min(montopago) as MINIMO_MTOPAGO,avg(montopago) as PROMEDIO_MTOPAGO from Ficha
group by idmanzana
) as rm on m.idmanzana=rm.idmanzana