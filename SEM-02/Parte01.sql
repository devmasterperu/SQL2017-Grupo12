--SEMANA 02

--Logica SQL
select idsector,						--columna
       count(idmanzana) as total,		--expresion
	   count(idmanzana)+1 as total2		--(V) Columna(s) a retornar
from Manzana							--(I)Tabla(s) a consultar
where estado=1							--(II) Condiciones
group by idsector						--(III) Hacer grupos
having count(idmanzana)>0				--(IV) Condiciones a grupos
order by total asc						--(VI) Ordenamiento

--Operadores
declare @a int=10 --Variable
declare @b int=5  --Variable

select @a+@b as suma,@a-@b as resta,@a*@b as multiplica,@a/@b as division,
       @a%@b as resto,power(@a,@b) as potencia,sqrt(@a) as raiz_cuadrada

create table numero
(
a int,
b int
)
insert into numero(a,b) values (10,5)
delete from numero where a=100
insert into numero(a,b) values (2,5)

select a+b as suma,a-b as resta,a*b as multiplica,a/b as division,
       a%b as resto,power(a,b) as potencia,sqrt(a) as raiz_cuadrada,
	   power(a,2)+power(b,2)+a*b
from   numero

declare @_a varchar(100)=10 --Variable
declare @_b varchar(100)=5  --Variable

select @_a+@_b as concatenacion,'MI '+'CASA' as concatenacion2 --105

--Uso de DISTINCT
insert into numero(a,b) values (2,5)
insert into numero(a,b) values (10,5)
insert into numero(a,b) values (5,5)

select a from numero
select distinct a from numero
select b from numero
select distinct b from numero
select a,b from numero
select distinct a,b from numero

--Alias de columna
select a as cola, a cola,'cola'=a,a as [Mi columna] from numero

--Alias de tabla
select a,b from numero
select a,num.b from numero as [num]
select a,[mi num].b from numero [mi num]
select n.a,n.b from numero n

select TipoDocumento.descripcion from TipoDocumento
select t.descripcion from TipoDocumento t

--Expresion CASE

select idmanzana,nombre,estado,
case when estado=1 
	 then 'ACTIVO' else 'INACTIVO' end as estado
--case when moneda='SOL' then 'NUEVOS SOLES'
--     when moneda='DOL' then 'DOLARES'
--	   when moneda='EU' then 'EUROS' end as moneda
from Manzana

--02.00
--B)
/*
Progresión geométrica creciente: 1,2,4,8,16,32...
TN=T1*R^(N-1)
T2=1*2^(2-1)=2
T4=1*2^(4-1)=8
*/

declare @t1 int=1 -- Término 1
declare @r int=2  -- Razón
declare @n int=10  -- Número de término

select 'TN'=@t1*power(@r,@n-1)

--02.01

--MANZANA->nombre
--ESTADO->estado+case
--SECTOR->idsector+case

select nombre as MANZANA,case when estado=1 then 'ACTIVO' else'INACTIVO' end as ESTADO,
	   case when idsector=1 then 'SECTOR_NOROESTE'
	   when idsector=2 then 'SECTOR_NORESTE'
	   when idsector=3 then 'SECTOR_SUROESTE'
	   when idsector=4 then 'SECTOR_SURESTE'
	   else 'SIN_SECTOR' end as SECTOR
from Manzana 

--02.02
--SECTOR=>nombre
--ESTADO=>estado
--MENSAJE=>El <nombre> se encuentra <estado>

select nombre as SECTOR,estado,
	  'El '+nombre+' se encuentra '+ 
	   case when estado=0 then 'inactivo' else 'activo' end as mensaje
from Sector

select nombre as SECTOR,estado,
       concat('El ',nombre,' se encuentra ',
       case when estado=0 then 'inactivo' else 'activo' end) as mensaje
from Sector

select nombre as SECTOR,estado,
       case when estado=0 then 'El '+nombre+' se encuentra inactivo'
       else 'El '+nombre+' se encuentra activo' end as mensaje
from Sector

--02.03

select case when idtipo='01' then 'DNI' else 'SIN ESPECIFICAR' end as TIPO,
       numdoc as NUMERO,
       ltrim(nombres) as nombres,
       apellidos
from Padron
where idtipo='01'
--order by nombres asc --Parte 01
--order by nombres desc --Parte 02
order by nombres asc,apellidos desc --Parte 03

