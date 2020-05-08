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
