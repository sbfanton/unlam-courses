USE [EJERCICIO_4]
GO

--VIVE
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona1','Calle1','Ciudad1');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona2','Calle2','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona3','Calle3','Ciudad3');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona4','Calle4','Ciudad4');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona5','Calle5','Ciudad5');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona6','Calle2','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona7','Calle5','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona8','Calle2','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona9','Calle2','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona10','Calle5','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona11','Calle2','Ciudad2');
INSERT INTO  [dbo].[Vive]([nomPersona], [calle], [ciudad]) VALUES ('Persona12','Calle2','Ciudad2');

 
--[dbo].[Situada_En]
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Empresa1','Ciudad1')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Empresa2','Ciudad2')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Empresa3','Ciudad3')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Banelco','Ciudad4')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Telecom','Ciudad1')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Paulinas','Ciudad2')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Clarin','Ciudad5')
INSERT INTO [dbo].[Situada_En] ([nomEmpresa], [ciudad]) VALUES ('Sony','Ciudad5')

 
--Trabaja
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona1','Empresa1',10000,GETDATE(),NULL);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona2','Banelco',100000,GETDATE(),NULL);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona3','Banelco',100000,GETDATE()-365,getdate());
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona4','Telecom',100000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona5','Telecom',100000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona6','Paulinas',100000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona7','Paulinas',100000,GETDATE()-365,getdate());
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona8','Paulinas',1000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona9','Clarin',50000,GETDATE()-365,null);

INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona10','Sony',50000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona11','Sony',50000,GETDATE()-365,null);
INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona12','Sony',50000,GETDATE()-365,null);

INSERT INTO [dbo].[Trabaja]([nomPersona], [nomEmpresa], [salario], [feIngreso], [feEgreso])
VALUES( 'Persona12','Clarin',50000,GETDATE()-365,null);



--[dbo].[Supervisa]
INSERT INTO [dbo].[Supervisa]([nomPersona], [nomSupervisor]) VALUES ('Persona8','Persona6')
INSERT INTO [dbo].[Supervisa]([nomPersona], [nomSupervisor]) VALUES ('Persona4','Persona5')
