--03.06

select t.usuario as USUARIO,t.idtrabajador as [ID ENCUESTADOR],
isnull(a.idmanzana,0) as [ID MANZANA],isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO],
isnull(a.fecfin,'9999-12-31') as [FECHA FIN]
from Trabajador t left join Asignacion a on t.idtrabajador=a.idencuestador
where t.tipo='E' and t.estado=1

--03.07

select m.nombre as MANZANA,case when m.estado=1 then 'ACTIVO' else 'INACTIVO' end as ESTADO,
m.idsector as IDSECTOR,isnull(a.idencuestador,0) as IDENCUESTADOR
from Manzana m left join Asignacion a on m.idmanzana=a.idmanzana
order by m.estado

--03.08
select t.usuario as USUARIO,t.idtrabajador as [ID ENCUESTADOR],
p.nombres+' '+p.apellidos as NOMBRE_COMPLETO,
isnull(a.idmanzana,0) as [ID MANZANA],isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO],
isnull(a.fecfin,'9999-12-31') as [FECHA FIN]
from Trabajador t 
left join Asignacion a on t.idtrabajador=a.idencuestador
--NOMBRE_COMPLETO
inner join Padron p on t.idpadron=p.idpadron
where t.tipo='E' and t.estado=1

--03.09

select t.usuario as USUARIO,
p.nombres+' '+p.apellidos as NOMBRE_COMPLETO,
isnull(m.nombre,'0000') as [MANZANA],isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO],
isnull(a.fecfin,'9999-12-31') as [FECHA FIN]
from Trabajador t 
left join Asignacion a on t.idtrabajador=a.idencuestador
--NOMBRE_COMPLETO
inner join Padron p on t.idpadron=p.idpadron
--MANZANA
left join Manzana m on a.idmanzana=m.idmanzana
where t.tipo='E' and t.estado=1

--03.10
select isnull(t.usuario,'-') as USUARIO,a.idencuestador as [ID ENCUESTADOR],
a.idmanzana as [ID MANZANA],isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO],
isnull(a.fecfin,'9999-12-31') as [FECHA FIN],t.tipo,t.estado
from Trabajador t 
right join Asignacion a on t.idtrabajador=a.idencuestador
--where t.tipo='E' and t.estado=1
where isnull(t.tipo,'E')='E' and isnull(t.estado,1)=1

