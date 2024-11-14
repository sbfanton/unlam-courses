/*
INSERT INTO Vendedor([nombre], [apellido], [DNI]) VALUES ('v1','vp1',1),('v2','vp2',2),('v3','vp3',3),('v4','vp4',4),('v5','vp5',5),('v6','vp6',6),('v7','vp7',7),('v8','vp8',8)

INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Juan Perez', 'Responsable Inscripto', '20-12345678-9');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Maria Gomez', 'Monotributista', '27-87654321-0');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Carlos Fernandez', 'Exento', '23-34567890-1');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Ana Lopez', 'Consumidor Final', '24-98765432-1');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Luis Rodriguez', 'Responsable Inscripto', '20-11223344-5');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Sofia Martinez', 'Monotributista', '27-55667788-6');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Pablo Silva', 'Exento', '23-33445566-2');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Lucia Gonzalez', 'Consumidor Final', '24-22334455-9');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Diego Ramirez', 'Responsable Inscripto', '20-99887766-3');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Valentina Herrera', 'Monotributista', '27-44556677-4');



*/


USE EJERCICIO_3 
INSERT INTO Vendedor (nombre, apellido, DNI) VALUES ('Lucas', 'Pérez', 30500111);
INSERT INTO Vendedor (nombre, apellido, DNI) VALUES ('María', 'González', 27111222);
INSERT INTO Vendedor (nombre, apellido, DNI) VALUES ('Juan', 'Martínez', 33123456);
INSERT INTO Vendedor (nombre, apellido, DNI) VALUES ('Ana', 'Rodríguez', 29456789);


INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Federico Alvarez', 'Consumidor Final', '20-33445566-7');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Laura Suarez', 'Responsable Inscripto', '27-11223344-5');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Miguel Castro', 'Monotributista', '23-55667788-9');
INSERT INTO Cliente (nombre, respIVA, CUIL) VALUES ('Elena Ortiz', 'Exento', '20-99887766-3');


INSERT INTO Proveedor (nombre, respdCivil, cuit) VALUES ('Proveedor A', 'Responsable Inscripto', '30-12345678-9');
INSERT INTO Proveedor (nombre, respdCivil, cuit) VALUES ('Proveedor B', 'Monotributista', '30-98765432-1');
INSERT INTO Proveedor (nombre, respdCivil, cuit) VALUES ('Proveedor C', 'Exento', '30-11223344-5');
INSERT INTO Proveedor (nombre, respdCivil, cuit) VALUES ('Proveedor D', 'Responsable Inscripto', '30-55667788-6');


INSERT INTO Producto (nombre, descrip, estado, idProveedor) VALUES ('Producto 1', 'Desc 1', 'Disponible', 1);
INSERT INTO Producto (nombre, descrip, estado, idProveedor) VALUES ('Producto 2', 'Desc 2', 'en stock', 2);
INSERT INTO Producto (nombre, descrip, estado, idProveedor) VALUES ('Producto 3', 'Desc 3', 'Sin stock', 3);
INSERT INTO Producto (nombre, descrip, estado, idProveedor) VALUES ('Producto 4', 'Desc 4', 'Disponible', 4);
INSERT INTO Producto (nombre, descrip, estado, idProveedor) VALUES ('Producto 5', 'Desc 5', 'Disponible', 2);



INSERT INTO Direccion (idPers, calle, nro, piso, dpto) VALUES (1, 'Av. Siempre Viva', 123, 1, 'A');
INSERT INTO Direccion (idPers, calle, nro, piso, dpto) VALUES (2, 'Calle Falsa', 456, 2, 'B');
INSERT INTO Direccion (idPers, calle, nro, piso, dpto) VALUES (3, 'Boulevard Norte', 789, 3, 'C');
INSERT INTO Direccion (idPers, calle, nro, piso, dpto) VALUES (4, 'Paseo del Sol', 101, 4, 'D');


INSERT INTO Venta (idCliente, fecha, idVendedor) VALUES (1, '2023-11-01 14:30:00', 1);
INSERT INTO Venta (idCliente, fecha, idVendedor) VALUES (2, '2023-11-02 15:45:00', 2);
INSERT INTO Venta (idCliente, fecha, idVendedor) VALUES (3, '2023-11-03 16:00:00', 3);
INSERT INTO Venta (idCliente, fecha, idVendedor) VALUES (4, '2023-11-04 17:20:00', 4);
INSERT INTO Venta (idCliente, fecha, idVendedor) VALUES (4, '2023-11-04 17:20:00', 4);


INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (1, 1, 1, 2, 150.50);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (2, 1, 2, 5, 550.50);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (2, 2, 2, 1, 200.00);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (3, 3, 3, 3, 175.75);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (4, 4, 4, 1, 225.00);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (1, 4, 3, 5, 55555.00);
INSERT INTO Detalle_venta (nro, nroFactura, idProducto, cantidad, precioUnitario) VALUES (1, 5, 3, 5, 55555.00);


