--SUBCONSULTAS SELECT
--01. Obtener la información de clientes incluyendo la cantidad de teléfonos

select 
idcliente,direccion,email,
(select count(numero) from Telefono t where t.idcliente=c.idcliente) as tot_telefonos
from Cliente c

--02. Reporte de totales
--Total de clientes, total de contratos y el total de teléfonos con una sola ejecución
--Subconsultas SELECT
select count(1) from Cliente 
select count(1) from Contrato
select count(1) from Telefono

--Forma 01
select
(select count(1) from Cliente) as tot_clientes,
(select count(1) from Contrato) as tot_contratos,
(select count(1) from Telefono) as tot_telefonos

--Forma 02
select  count(1) as tot_clientes,
(select count(1) from Contrato) as tot_contratos,
(select count(1) from Telefono) as tot_telefonos
from Cliente

--03. Mostrar para los contratos, por cada periodo de facturación:
--C1: Posición irrepetible dentro de cada periodo en base al feccontrato de mas antiguo a reciente.
--C2: Posición que podria repetirse sin salto, dentro de cada periodo en base al feccontrato de mas antiguo a reciente.
--C3: Posición que podria repetirse con salto, dentro de cada periodo en base al feccontrato de mas antiguo a reciente.
--C4: Uno de los 4 grupos al que pertenece el registro, dentro de cada periodo en base al feccontrato de mas antiguo a reciente.

select *,
ROW_NUMBER() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C1,
DENSE_RANK() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C2,
RANK() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C3,
NTILE(4) OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C4
from Contrato
order by periodofactura,feccontrato ASC

--04. Implementar una función de valor tabla que reciba como entrada el idcliente
--y muestra la información de sus contratos en base al idcliente.En caso el idcliente sea "0" mostrar todos los contratos

alter function F_CONRATOS(@idcliente int) returns table
as
return
		select idplan,idcliente as CLIENTE,
		ROW_NUMBER() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C1,
		DENSE_RANK() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C2,
		RANK() OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C3,
		NTILE(4) OVER(PARTITION BY periodofactura ORDER BY feccontrato ASC) as C4
		from Contrato
		where idcliente= case when @idcliente=0 then idcliente else @idcliente end

select * from F_CONRATOS(0) --Contratos del idcliente=0
order by CLIENTE