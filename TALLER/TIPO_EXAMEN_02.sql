select distinct tipo from dbo.Telefono
select distinct tipo from comercial.Telefono

--01
select * from comercial.Telefono

select 
t.tipo,t.numero,c.razonsocial,c.direccion
from dbo.Telefono t
left join dbo.Cliente c on t.idcliente=c.idcliente
--Tel�fonos de clientes del tipo empresa y del tipo WhatsApp
where t.tipo='WSP' and c.tipocliente=2
--Ordenados por n�mero de tel�fono de menor a mayor.
order by t.numero asc
--S�lo los registros de la posici�n 101 a la 120
offset 100 rows
fetch next 20 rows only