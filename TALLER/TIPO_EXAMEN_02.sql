select distinct tipo from dbo.Telefono
select distinct tipo from comercial.Telefono

--01
select * from comercial.Telefono

select 
t.tipo,t.numero,c.razonsocial,c.direccion
from dbo.Telefono t
left join dbo.Cliente c on t.idcliente=c.idcliente
--Teléfonos de clientes del tipo empresa y del tipo WhatsApp
where t.tipo='WSP' and c.tipocliente=2
--Ordenados por número de teléfono de menor a mayor.
order by t.numero asc
--Sólo los registros de la posición 101 a la 120
offset 100 rows
fetch next 20 rows only

--02

select 
case 
when cl.tipocliente=1 then cl.nombres+' '+cl.apellidopat+' '+cl.apellidomat
when cl.tipocliente=2 then razonsocial 
else '-' end as cliente,
isnull(p.nombre,'-') as [PLAN],
co.feccontrato,co.ssisredwifi,
isnull(u.nom_dpto,'***') as DPTO,
isnull(u.nom_prov,'***') as PROVINCIA,
isnull(u.nom_dto,'***') as DISTRITO
/*Liste los contratos, independientemente de que los contratos cuenten 
con clientes y planes relacionados*/
from Contrato co 
left join Cliente cl on co.idcliente=cl.idcliente
left join PlanWifi p on co.idplan=p.idplan
left join Zona z on cl.idzona=z.idzona
left join Ubigeo u on z.idubigeo=u.idubigeo
--Presentar solamente los contratos de facturación mensual ‘M’.
where co.periodofactura='M'
--Ordenados por id-plan (Menor a mayor) + id-cliente (Menor a mayor).
order by co.idplan asc, co.idcliente asc

select * from Contrato

--03

--03.01 Teléfonos de Comercial con id de teléfono entre 100 y 200
select * from comercial.Telefono where idtelefono between 100 and 200

--03.02 Insertar en Teléfonos de Sistemas lo de 03.01
begin tran
insert into dbo.Telefono(tipo,numero,idcliente,estado)
select tipo,numero,idcliente,estado from comercial.Telefono where idtelefono between 100 and 200
rollback

select count(1) from Telefono

--04

select isnull(z.idzona,0),isnull(z.nombre,'-'),isnull(z.idubigeo,0),isnull(u.idubigeo,0)
from Zona z full outer join Ubigeo u on z.idubigeo=u.idubigeo