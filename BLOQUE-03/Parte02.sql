--03.06

select t.usuario as USUARIO,t.idtrabajador as [ID ENCUESTADOR],
isnull(a.idmanzana,0) as [ID MANZANA],isnull(a.fecinicio,'9999-12-31') as [FECHA INICIO],
isnull(a.fecfin,'9999-12-31') as [FECHA FIN]
from Trabajador t left join Asignacion a on t.idtrabajador=a.idencuestador
where t.tipo='E' and t.estado=1

select * from Asignacion
where idencuestador in (49,50)

select * from Trabajador
where idtrabajador in (49,50)