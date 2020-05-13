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