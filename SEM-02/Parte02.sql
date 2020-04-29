--02.04
/*
select ltrim('   GIANFRANCO')+' '+ltrim('   MANRIQUE VALENTIN') as NOMBRE_COMPLETO
select * from Ubigeo
select * from TipoDocumento
*/
select idtipo as TIPO,
       numdoc as NUMERO,
       rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) as NOMBRE_COMPLETO,
       direccion as DIRECCION,
	   case idubigeo 
	   when 1 then 'HUACHO' when 2 then 'AMBAR' when 3 then 'CALETA DE CARQUIN'
	   when 4 then 'CHECRAS' when 5 then 'HUALMAY' when 6 then 'HUAURA'
	   when 7 then 'LEONCIO PRADO' when 8 then 'PACCHO' when 9 then 'SANTA LEONOR'
	   when 10 then 'SANTA MARÍA' when 11 then 'SAYAN' when 12 then 'VEGUETA'
	   end as UBIGEO,
	   fecnacimiento
from Padron
where idtipo<>'06' and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos))<>'' --NO EMPRESA
/*
and idubigeo in (1,3,5) --Personas con valor de ubigeo 1,3 y 5.
*/
/*
and fecnacimiento in ('1970-01-01','1970-01-02',.....'1970-12-31')
and fecnacimiento between '1970-01-01' and '1970-12-31' --Personas con fecha de nacimiento entre el "01/01/1970 y el 31/12/1970
and fecnacimiento not between '1970-01-01' and '1970-12-31' --Personas con fecha de nacimiento fuera del rango
*/
/*
and ltrim(nombres)+' '+ltrim(apellidos) LIKE 'A%'--Personas cuyo nombre completo inicie con “A”
and ltrim(nombres)+' '+ltrim(apellidos) LIKE 'E%'--Personas cuyo nombre completo inicie con “E”
*/
/*
and ltrim(nombres)+' '+ltrim(apellidos) LIKE 'ABA'--Personas cuyo nombre completo sea “ABA”
and ltrim(nombres)+' '+ltrim(apellidos) LIKE '%ABA%'--Personas cuyo nombre completo contenga “ABA”
and direccion LIKE '%GRAU%' --Direccion contenga "GRAU"
*/
/*
and ltrim(nombres)+' '+ltrim(apellidos) LIKE '%AN'--Personas cuyo nombre completo finalice en “AN”
*/
/*
and ltrim(nombres)+' '+ltrim(apellidos) LIKE 'O%O'--Personas cuyo nombre completo inicie y finalice con “O”
*/
/*
update padron set nombres='LABAN' where idpadron=1
and ltrim(nombres)+' '+ltrim(apellidos) LIKE '_ABA%' --Personas cuyo nombre completo contenga la secuencia “ABA” desde la 2° posición
*/
/*
and ltrim(nombres)+' '+ltrim(apellidos) LIKE '%M__'--Personas cuyo antepenúltimo carácter del nombre completo sea “M”
*/
/*
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) LIKE '_E%E_'--Personas cuyo segundo y penúltimo carácter del nombre completo sea “E”
*/
/*
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) LIKE '[aeiou]%[aeiou]'--Personas cuyo nombre completo inicie y finalice con una vocal
*/
/*
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) LIKE '[^aeiou]%[^aeiou]' --Personas cuyo nombre completo inicie y finalice con una consonante
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) NOT LIKE '%.%'
*/
/*
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) LIKE '[aeiou]%[^aeiou]' --Personas cuyo nombre completo inicie con una vocal y finalice con una consonante
*/
/*
and direccion like 'A%' and idubigeo in (7,8,9,10)--Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,“Paccho”, “Santa Leonor” y “Santa María”
*/
/*
and rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) like 'E%' or idubigeo in (8,9,10) --Personas cuyo nombre completo inicie con “E” o sean del ubigeo “Paccho”,“Santa Leonor” y “Santa María”
*/
/*
--Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,
--“Paccho”, “Santa Leonor” y “Santa María” Y nombre completo inicie con
--“E” o sean del ubigeo “Paccho”, “Santa Leonor” y “Santa María”
and 
--P [V]
(direccion like 'A%' and idubigeo in (7,8,9,10)) 
and 
--Q [F OR V]=V
(rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) like 'E%' or idubigeo in (8,9,10)) --Q
*/
/*
--Personas cuya dirección inicie con “A” y sean del ubigeo “Leoncio Prado”,
--“Paccho”, “Santa Leonor” y “Santa María” O nombre completo inicie con
--“E” o sean del ubigeo “Paccho”, “Santa Leonor” y “Santa María”.
and 
(
	(direccion like 'A%' and idubigeo in (7,8,9,10)) --P 
	or
	(rtrim(ltrim(nombres))+' '+rtrim(ltrim(apellidos)) like 'E%' or idubigeo in (8,9,10)) --Q
)
*/
--Personas cuya dirección NO cumpla la siguiente condición: Iniciar con “A”
--y sean del ubigeo “Leoncio Prado”, “Paccho”, “Santa Leonor” y “Santa
--María”.
and NOT (direccion like 'A%' and idubigeo in (7,8,9,10)) 
order by NOMBRE_COMPLETO asc --Parte 03