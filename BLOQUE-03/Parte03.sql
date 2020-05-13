--03.11

select isnull(m.nombre,'-') as MANZANA,isnull(m.idsector,0) as [ID SECTOR],
a.idencuestador  as [ID ENCUESTADOR],a.idmanzana as [ID MANZANA],
isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO], 
isnull(a.fecfin,'9999-12-31') as [FECHA FIN], m.estado
from Manzana m right join Asignacion a on m.idmanzana=a.idmanzana
where isnull(m.estado,1)=1

--03.12

--FULL OUTER JOIN
select isnull(m.nombre,'-') as MANZANA,isnull(m.idsector,0) as [ID SECTOR],
a.idencuestador  as [ID ENCUESTADOR],a.idmanzana as [ID MANZANA],
isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO], 
isnull(a.fecfin,'9999-12-31') as [FECHA FIN], m.estado
from Manzana m full outer join Asignacion a on m.idmanzana=a.idmanzana
--where isnull(m.estado,1)=1

--LEFT JOIN + RIGHT JOIN
select isnull(m.nombre,'-') as MANZANA,isnull(m.idsector,0) as [ID SECTOR],
a.idencuestador  as [ID ENCUESTADOR],a.idmanzana as [ID MANZANA],
isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO], 
isnull(a.fecfin,'9999-12-31') as [FECHA FIN], m.estado
from Manzana m left outer join Asignacion a on m.idmanzana=a.idmanzana
union
select isnull(m.nombre,'-') as MANZANA,isnull(m.idsector,0) as [ID SECTOR],
a.idencuestador  as [ID ENCUESTADOR],a.idmanzana as [ID MANZANA],
isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO], 
isnull(a.fecfin,'9999-12-31') as [FECHA FIN], m.estado
from Manzana m right outer join Asignacion a on m.idmanzana=a.idmanzana

--03.13

select isnull(ltrim(pe.nombres)+' '+ltrim(pe.apellidos),'POR IDENTIFICAR') as ENCUESTADOR,
isnull(m.nombre,'-') as MANZANA,
isnull(ltrim(ps.nombres)+' '+ltrim(ps.apellidos),'POR IDENTIFICAR') as SUPERVISOR, 1 as PAGINA
from Asignacion a
--ENCUESTADOR
left join Trabajador te on a.idencuestador=te.idtrabajador --Encuestador:idencuestador
left join Padron pe on te.idpadron=pe.idpadron
--MANZANA
left join Manzana m on a.idmanzana=m.idmanzana
--SUPERVISOR
left join Trabajador ts on a.idsupervisor=ts.idtrabajador --Supervisor:idsupervisor 
left join Padron ps on ts.idpadron=ps.idpadron
order by ENCUESTADOR asc,MANZANA asc
--Traer los 10 (Página 01)
offset 0 rows 
fetch next 10 rows only