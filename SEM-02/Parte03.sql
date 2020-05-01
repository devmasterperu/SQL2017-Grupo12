--02.05
--Campo agrupador:idubigeo

select idubigeo,count(idpadron) as TOTAL,
max(fecnacimiento) as MAXFECNAC,
min(fecnacimiento) as MINFECNAC
from Padron
where idtipo<>'06'--No empresas
group by idubigeo --Campo agrupador
order by idubigeo