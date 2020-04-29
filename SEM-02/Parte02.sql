--02.04

select ltrim('   GIANFRANCO')+' '+ltrim('   MANRIQUE VALENTIN') as NOMBRE_COMPLETO
select * from Ubigeo
select * from TipoDocumento
select idtipo as TIPO,
       numdoc as NUMERO,
       ltrim(nombres)+' '+ltrim(apellidos) as NOMBRE_COMPLETO,
       direccion as DIRECCION,
	   case idubigeo 
	   when 1 then 'HUACHO' when 2 then 'AMBAR' when 3 then 'CALETA DE CARQUIN'
	   when 4 then 'CHECRAS' when 5 then 'HUALMAY' when 6 then 'HUAURA'
	   when 7 then 'LEONCIO PRADO' when 8 then 'PACCHO' when 9 then 'SANTA LEONOR'
	   when 10 then 'SANTA MARÍA' when 11 then 'SAYAN' when 12 then 'VEGUETA'
	   end as UBIGEO
from Padron
where idtipo<>'06' and ltrim(nombres)+' '+ltrim(apellidos)<>'' --NO EMPRESA
order by NOMBRE_COMPLETO asc --Parte 03