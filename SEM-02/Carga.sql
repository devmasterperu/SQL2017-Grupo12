USE ServiciosG12BD

--Carga Tabla Tipo de Documento

INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('01','LIBRETA ELECTORAL O DNI','L.E / DNI')
go 
INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('04','CARNET DE EXTRANJERIA','CARNET EXT.')
go 
INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('06','REG. UNICO DE CONTRIBUYENTES','RUC')
go 
INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('07','PASAPORTE','PASAPORTE')
go 
INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('11','PART. DE NACIMIENTO-IDENTIDAD','P. NAC.')
go 
INSERT INTO TipoDocumento(idtipo,descripcion,descripcion_corta) VALUES ('00','OTROS','OTROS')
go 

select * from TipoDocumento

--Carga Tabla Ubigeo

insert into ubigeo values ('15','LIMA','08','HUAURA','01','HUACHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','02','AMBAR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','03','CALETA DE CARQUIN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','04','CHECRAS') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','05','HUALMAY') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','06','HUAURA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','07','LEONCIO PRADO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','08','PACCHO') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','09','SANTA LEONOR') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','10','SANTA MARÍA') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','11','SAYAN') 
go
insert into ubigeo values ('15','LIMA','08','HUAURA','12','VEGUETA') 
go

select * from Ubigeo

--Tabla Sector

insert into sector values ('SECTOR_NOROESTE','-',1)
go
insert into sector values ('SECTOR_NORESTE','-',1)
go
insert into sector values ('SECTOR_SUROESTE','-',1)
go
insert into sector values ('SECTOR_SURESTE','-',1)
go

select * from Sector

--Tabla Manzana
insert into manzana(nombre,idsector,estado) values ('0001',1,0)
go
insert into manzana(nombre,idsector,estado) values ('0002',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0003',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0004',1,1)
go
insert into manzana(nombre,idsector,estado) values ('0005',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0006',2,0)
go
insert into manzana(nombre,idsector,estado) values ('0007',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0008',2,1)
go
insert into manzana(nombre,idsector,estado) values ('0009',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0010',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0011',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0012',3,1)
go
insert into manzana(nombre,idsector,estado) values ('0013',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0014',4,1)
go
insert into manzana(nombre,idsector,estado) values ('0015',4,0)
go
insert into manzana(nombre,idsector,estado) values ('0016',4,1)
go

select * from Manzana