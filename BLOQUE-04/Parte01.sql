--04.01
--a 
select * from padron where numdoc='46173385'
--b
INSERT INTO [dbo].[Padron]
           ([idtipo]
           ,[numdoc]
           ,[razon_social]
           ,[nombres]
           ,[apellidos]
           ,[sexo]
           ,[fecnacimiento]
           ,[direccion]
           ,[idubigeo]
           ,[fechoraregistro])
     VALUES
           ('01'
           ,'46173386'
           ,null
           ,'MAR�A ELIZABETH'
           ,'CASAS ROSALES'
           ,'F'
           ,'1990-01-01'
           ,'PSJ. JUAN BARRETO 422'
           ,1
           ,getdate())
GO

select * from padron where numdoc='46173386'

--c

	INSERT INTO [dbo].[Padron]
           ([idtipo]
           ,[numdoc]
           ,[razon_social]
           ,[nombres]
           ,[apellidos]
           ,[sexo]
           ,[fecnacimiento]
           ,[direccion]
           ,[idubigeo]
           ,[fechoraregistro])
     VALUES
           ('01','46173387',null,'MAR�A JUANA','MALLMA CRUZ','F','1980-01-01','PSJ. JUAN BARRETO 424',1 ,getdate()),
		   ('01','46173388',null,'LUIS ALFREDO','LUCAS LOPEZ','M','1970-01-01','AV. 28 DE JULIO 500',1 ,getdate())
GO

select * from Padron where numdoc in ('46173387','46173388')

--d

	INSERT INTO [dbo].[Padron]
           ([idtipo]
           ,[numdoc]
           ,[razon_social]
           ,[nombres]
           ,[apellidos]
           ,[sexo]
           ,[fecnacimiento]
           ,[direccion]
           ,[idubigeo]
           ,[fechoraregistro])
     select '01','46173389',null,'FELIX ALBERTO','MANRIQUE QUI�ONES','M','1970-01-01','PSJ. JUAN BARRETO 425',1 ,getdate() union
	 select '01','46173390',null,'SOFIA LIDIA','VALENTIN CHAVEZ','M','1980-01-01','AV. 28 DE JULIO 510',1 ,getdate()

	 --04.03

	 select * from UnidadUso where idficha=100 --3

	 BEGIN TRAN
		delete from UnidadUso where idficha=100 --3
	 ROLLBACK

	 select * from UnidadUso where idficha=100 --0

	 --04.04
	 select * from UnidadUso u inner join Ficha f on u.idficha=f.idficha
	 where f.idtrabajador=23 --39

	 BEGIN TRAN
		delete u
		from UnidadUso u inner join Ficha f on u.idficha=f.idficha
		where f.idtrabajador=23 --39
	 ROLLBACK

	 select * from UnidadUso u inner join Ficha f on u.idficha=f.idficha
	 where f.idtrabajador=23 --0

	 --04.05
	 select top(5) u.* from UnidadUso u 
	 inner join Ficha f on u.idficha=f.idficha
	 inner join Manzana m on f.idmanzana=m.idmanzana
	 where idsector=1

	 BEGIN TRAN
		 delete top(5) u
		 from UnidadUso u 
		 inner join Ficha f on u.idficha=f.idficha
		 inner join Manzana m on f.idmanzana=m.idmanzana
		 where idsector=1
	 ROLLBACK

	 select  u.* from UnidadUso u 
	 inner join Ficha f on u.idficha=f.idficha
	 inner join Manzana m on f.idmanzana=m.idmanzana
	 where idsector=1 and u.idunidaduso in (4,5,6,10,11)

	 --04.06
	 select top(10) * from Asignacion a 
	 inner join Trabajador t on a.idencuestador=t.idtrabajador
	 inner join Padron p on t.idpadron=p.idpadron
	 inner join Ubigeo u on p.idubigeo=u.idubigeo
	 where u.nom_dto='HUACHO' --10

	 BEGIN TRAN
		 delete top(10) a
		 from Asignacion a 
		 inner join Trabajador t on a.idencuestador=t.idtrabajador
		 inner join Padron p on t.idpadron=p.idpadron
		 inner join Ubigeo u on p.idubigeo=u.idubigeo
		 where u.nom_dto='HUACHO'
	 ROLLBACK

	 select count(1) from Asignacion a --33

	 --04.07
	 select * from Padron where idpadron=1

	 select * from Padron where idpadron=100 --1

	 BEGIN TRAN
		 update p
		 set  direccion='URB. LOS CIPRESES M-24',idubigeo=3,numdoc='22064382',sexo='F',fecnacimiento='1969-04-10'
		 from Padron p
		 where idpadron=100
	 ROLLBACK

	 select * from Padron where idpadron=100

	 --04.08
	 select * from Asignacion where idencuestador=23 and idmanzana=7

	 BEGIN TRAN
		update a
		set  a.fecinicio='2020-02-01',fecfin='2020-12-31',idsupervisor='2020-12-31'
		from Asignacion a
		where idmanzana=7 and idencuestador=23
	 ROLLBACK

	  select * from Asignacion where idencuestador=23 and idmanzana=7

	 --04.09
	     /*
	     begin tran
			 update u
			 set descripcion='COMERCIAL PISO 01'
			 from UnidadUso u 
			 inner join Ficha f on u.idficha=f.idficha
			 inner join Manzana m on f.idmanzana=m.idmanzana
			 where idsector=1 and categoria='COM'
		 rollback

		 select u.*
		 from UnidadUso u 
		 inner join Ficha f on u.idficha=f.idficha
		 inner join Manzana m on f.idmanzana=m.idmanzana
		 where idsector=1 and categoria='COM'
		 */

	  select * from Ficha
	  select * from Ficha where numhabitantes between 2 and 4

	  --FORMULA: Costo Calculado: 10.00+ N� Habitantes * 20.00, solo para las fichas con
	  --n�mero de habitantes entre 2 y 4.

	  BEGIN TRAN
		--update Ficha set costo=10+numhabitantes*20
		update Ficha set costo=10+numhabitantes*20 where numhabitantes between 2 and 4
	  ROLLBACK

	  --select
	  --case when f.MONTO_PAGO>f.COSTO_CALCULADO then 'Cliente genera ganancia' end as MENSAJE
	  --from
	  --(
		  select 
		  ltrim(p.nombres)+' '+ltrim(p.apellidos) as NOMBRE_COMPLETO,
		  montopago as MONTO_PAGO,
		  costo as COSTO_CALCULADO,
		  case 
		  when f.montopago>f.costo then 'Cliente genera ganancia'  
		  when f.montopago<f.costo then 'Cliente genera p�rdida'  
		  else 'Cliente no genera p�rdida ni ganancia'
		  end as MENSAJE1,
		  case 
		  when f.montopago>f.costo then 'Cliente genera ganancia'  
		  else 'Cliente genera p�rdida'
		  end as MENSAJ2
		  from Ficha f 
		  inner join Cliente c on f.idcliente=c.idcliente
		  inner join Padron p on c.idpadron=p.idpadron
		  where f.montopago=f.costo
	  --) f

	  --04.10

	  select tipoconsumidor,
	  case 
	  when tipoconsumidor='P' then 10.00+numhabitantes* 20.00 
	  when tipoconsumidor='M' then 15.00+numhabitantes* 25.00
	  when tipoconsumidor='G' then 20.00+numhabitantes* 30.00
	  end as costo
	  from Ficha

		  update f
		  set    f.costo=NULL
		  from   Ficha f

	  --FORMA 01
	  BEGIN TRAN
		  update f
		  set    f.costo= case 
						  when tipoconsumidor='P' then 10.00+numhabitantes* 20.00 
						  when tipoconsumidor='M' then 15.00+numhabitantes* 25.00
						  when tipoconsumidor='G' then 20.00+numhabitantes* 30.00
						  end
		  from   Ficha f
	  ROLLBACK

	  --FORMA 02
	  BEGIN TRAN
		  update f
		  set    f.costo= 10.00+numhabitantes* 20.00 		 
		  from   Ficha f
		  where  tipoconsumidor='P'

		  update f
		  set    f.costo= 15.00+numhabitantes* 25.00 		 
		  from   Ficha f
		  where  tipoconsumidor='M'

		  update f
		  set    f.costo= 20.00+numhabitantes* 30.00		 
		  from   Ficha f
		  where  tipoconsumidor='G'

	  ROLLBACK

	select concat(p.nombres,' ', p.apellidos) as NOMBRE_COMPLETO,f.tipoconsumidor as TIPO_CONSUMIDOR,
	f.numhabitantes as [N� HABITANTES],f.montopago as MONTO_PAGO,f.costo as COSTO_CALCULADO,
	case 
	when f.montopago>f.costo then 'Cliente genera ganancia'
	when f.montopago<f.costo then 'Cliente genera p�rdida'
	when f.montopago=f.costo then 'Cliente no genera p�rdida ni ganancia'
	else 'No es posible mostrar mensaje' end as MENSAJE
	from Ficha f
	inner join Cliente c on f.idcliente=c.idcliente
	inner join Padron p on c.idpadron=p.idpadron
	where f.montopago=f.costo