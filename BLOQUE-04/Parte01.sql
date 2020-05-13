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
           ,'MARÍA ELIZABETH'
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
           ('01','46173387',null,'MARÍA JUANA','MALLMA CRUZ','F','1980-01-01','PSJ. JUAN BARRETO 424',1 ,getdate()),
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
     select '01','46173389',null,'FELIX ALBERTO','MANRIQUE QUIÑONES','M','1970-01-01','PSJ. JUAN BARRETO 425',1 ,getdate() union
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