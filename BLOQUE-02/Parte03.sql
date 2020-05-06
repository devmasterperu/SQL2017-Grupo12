--02.05
--Campo agrupador:idubigeo

select idubigeo,count(idpadron) as TOTAL,
max(fecnacimiento) as MAXFECNAC,
min(fecnacimiento) as MINFECNAC
from Padron
where idtipo<>'06'--No empresas
group by idubigeo --Campo agrupador
order by idubigeo

--02.06
select idsector as IDSECTOR,count(idmanzana) as [TOTAL-M],max(idmanzana) as [MAX-ID-M],
min(idmanzana) as [MIN-ID-M]
from Manzana
where estado=1 --Manzana activa
group by idsector

--02.07
select isnull(sexo,'-') as SEXO,idubigeo as UBIGEO,count(idpadron) as TOTAL,
max(fecnacimiento) as MAXFECNAC,
min(fecnacimiento) as MINFECNAC
from Padron
where idtipo<>'06'--No empresas
group by sexo,idubigeo --Campos agrupadores
order by idubigeo 

update Padron set sexo='F' where idpadron=3 --Asignar el sexo F al registro con id 3
update Padron set sexo='M' where idpadron=2 --Asignar el sexo M al registro con id 2

--02.08
select idubigeo as UBIGEO,isnull(sexo,'-') as SEXO,count(idpadron) as TOTAL,
max(ltrim(apellidos)) as [MAX-APELLIDOS],--Más cercano a la Z
min(ltrim(apellidos)) as [MIN-APELLIDOS]--Más cercano a la A
from Padron
where idtipo<>'06' and apellidos<>''--No empresas
group by sexo,idubigeo --Campos agrupadores
order by idubigeo 

--02.09
--Determinar la cantidad de ocurrencias por nombre(s)
--Ordenar y determinar los 6 primeros con mayor número de ocurrencias
select top(6) rtrim(ltrim(nombres)) as NOMBRES,count(idpadron) as NUMERO
from Padron
where idtipo<>'06' and apellidos<>''--No empresas
group by rtrim(ltrim(nombres)) --Campos agrupadores
order by NUMERO desc --Mayor a menor total

--Ordenar y determinar el primer 6% con mayor número de ocurrencias
select top(6) percent -- 0.06*609=>36.54=37
rtrim(ltrim(nombres)) as NOMBRES,count(idpadron) as NUMERO
from Padron
where idtipo<>'06' and apellidos<>''--No empresas
group by rtrim(ltrim(nombres)) --Campos agrupadores
order by NUMERO desc --Mayor a menor total

--02.10
/*
Ordenar y determinar los 7 primeros, incluyendo empates,
con mayor número de ocurrencias
*/
select top(7) with ties --Ties=>Incluir empates del 7° puesto
rtrim(ltrim(nombres)) as NOMBRES,count(idpadron) as NUMERO
from Padron
where idtipo<>'06' and apellidos<>''--No empresas
group by rtrim(ltrim(nombres)) --Campos agrupadores
order by NUMERO desc --Mayor a menor total

/*
Ordenar y determinar el primer 7%, incluyendo empates,
con mayor número de ocurrencias
*/
select top(7) percent with ties --0.07*609=>42.63=43
rtrim(ltrim(nombres)) as NOMBRES,count(idpadron) as NUMERO
from Padron
where idtipo<>'06' and apellidos<>''--No empresas
group by rtrim(ltrim(nombres)) --Campos agrupadores
order by NUMERO desc --Mayor a menor total

--02.11
select top(2) idsector as SECTOR, 
count(idmanzana) as MANZANAS,
concat('El sector ',idsector,' tiene ',count(idmanzana),' manzanas.') as MENSAJE
from Manzana
where estado=1 --Manzanas activas
group by idsector  --Campos agrupador
order by count(idmanzana) desc

--02.12
select top(2) with ties idsector as SECTOR, 
count(idmanzana) as MANZANAS,
concat('El sector ',idsector,' tiene ',count(idmanzana),' manzanas.') as MENSAJE
from Manzana
where estado=1 --Manzanas activas
group by idsector  --Campos agrupador
order by count(idmanzana) desc

--02.13

select ltrim(nombres)+' '+ltrim(apellidos) as NOMBRE_COMPLETO
from Padron
where idtipo<>'06' and ltrim(nombres)+' '+ltrim(apellidos)<>''--No empresas
order by NOMBRE_COMPLETO asc
--Página 1 y tamaño de página 10=>Posición 1 a la 10.
/*
OFFSET 0 ROWS --Cuantas posiciones dejo atrás.
FETCH NEXT 10 ROWS ONLY --Cuantas posiciones hacia adelante
*/
--Página 2 y tamaño de página 10=>Posición 11 a la 20.
/*
OFFSET 10 ROWS --Cuantas posiciones dejo atrás.
FETCH NEXT 10 ROWS ONLY --Cuantas posiciones hacia adelante
*/
--Página 3 y tamaño de página 10=>Posición 21 a la 30.
/*
OFFSET 20 ROWS --Cuantas posiciones dejo atrás.
FETCH NEXT 10 ROWS ONLY --Cuantas posiciones hacia adelante
*/