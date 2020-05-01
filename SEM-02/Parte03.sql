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
