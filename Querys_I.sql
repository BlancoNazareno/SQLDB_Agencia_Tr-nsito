--1) Listado con las localidaAdes, su ID, nombre y el nombre de la provincia a la que pertenece. 
select L.IDLocalidad, L.Localidad, P.Provincia from Localidades	as L
inner join Provincias as P on L.IDProvincia = P.IDProvincia

--2) Listado que informe el ID de la multa, el monto a abonar y los datos del agente que la realizó. 
--Debe incluir los apellidos y nombres de los agentes. Así como también la fecha de nacimiento y la edad.
Select M.IDMulta, M.Monto, A.Apellidos, A.Nombres, A.FechaNacimiento, DATEDIFF (YEAR, A.FechaNacimiento , 
GETDATE())-
case 
	when MONTH(getdate()) < MONTH(A.FechaNacimiento) or 
	(MONTH(getdate()) = MONTH(A.FechaNacimiento) and DAY(getdate()) < DAY(A.FechaNacimiento)) then 1
	else 0
end
as Edad from Multas as M
inner join Agentes as A on M.IDAgente = A.IDAgente	

--3) Listar todos los datos de todas las multas realizadas por agentes que a la fecha de hoy tengan más de 5 años de antigüedad
--Select M.IDMulta, M.IDLocalidad, M.IDTipoInfraccion, M.IDAgente, M.Patente, M.Monto, M.FechaHora, M.Pagada
-- el M.* permite obtener todas las columnas sólo de la tabla M, no de todas las del join
Select M.* from Multas as M inner join  Agentes as A on M.IDAgente = A.IDAgente
where 
(DATEDIFF (YEAR, A.FechaIngreso ,
GETDATE())-
case 
	when MONTH(getdate()) < MONTH(A.FechaIngreso) or 
	(MONTH(getdate()) = MONTH(A.FechaIngreso) and DAY(getdate()) < DAY(A.FechaIngreso)) then 1
	else 0 
end
) > 5 

--4) Listar todos los datos de todas las multas cuyo importe de referencia supere los $15000
Select M.IDMulta, M.IDLocalidad, M.IDTipoInfraccion, M.IDAgente, M.Patente, M.Monto, M.FechaHora, M.Pagada 
from Multas as M 
inner join  TipoInfracciones as T on M.IDTipoInfraccion = T.IDTipoInfraccion
where T.ImporteReferencia > 15000

--5) Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas en la provincia de Buenos Aires o en Cordoba
Select distinct A.Nombres, A.Apellidos from Agentes as A 
inner join Multas as M on A.IDAgente = M.IDAgente
inner join Localidades as L on M.IDLocalidad = L.IDLocalidad
inner join Provincias as P on L.IDProvincia = P.IDProvincia
where P.Provincia = 'Buenos Aires' or P.Provincia = 'Cordoba'

--6) Listar los nombres y apellidos de los agentes, sin repetir, que hayan labrado multas del tipo "Exceso de velocidad"
Select distinct A.Nombres, A.Apellidos from Agentes as A 
inner join Multas as M on A.IDAgente = M.IDAgente
inner join TipoInfracciones as T on M.IDTipoInfraccion = T.IDTipoInfraccion
where T.Descripcion = 'Exceso de velocidad'

--7) Listar apellidos y nombres de los agentes que no hayan labrado multas
Select A.IDAgente, A.Nombres, A.Apellidos from Agentes as A 
left join Multas as M on A.IDAgente = M.IDAgente
where M.IDAgente is null

--8) Por cada multa, lista el nombre de la localidad y provincia, el tipo de multa,
--los apellidos y nombres de los agentes y su legajo, el monto de la multa y la diferencia en 
--pesos en relación al tipo de infracción cometida
Select L.Localidad, P.Provincia, T.Descripcion, A.Apellidos, A.Nombres, A.Legajo, M.Monto, (M.Monto - T.ImporteReferencia) as Diferencia
from Multas as M inner join Localidades as L on M.IDLocalidad = L.IDLocalidad
inner join Provincias as P on L.IDProvincia = P.IDProvincia
inner join TipoInfracciones as T on M.IDTipoInfraccion = T.IDTipoInfraccion
inner join Agentes as A on M.IDAgente = A.IDAgente

--9) Listar las localidades en las que no se hayan registrado multas
Select L.IDLocalidad, L.Localidad from Localidades as L
left join Multas as M on L.IDLocalidad = M.IDLocalidad
where M.IDLocalidad is null

--10) Listar los datos de las multas pagadas que se hayan labrado en la provincia de Buenos Aires
Select M.IDMulta, M.IDLocalidad, M.IDTipoInfraccion, M.IDAgente, M.Patente, M.Monto, M.FechaHora, M.Pagada 
from Multas as M inner join Localidades as L on M.IDLocalidad = L.IDLocalidad
inner join Provincias as P on L.IDLocalidad	= P.IDProvincia
where P.Provincia = 'Buenos Aires' and M.Pagada = '1'

--11) Listar el ID de la multa, la patente, el monto y el importe de referencia a partir del tipo de infracción cometida. 
--También incluir una columna llamada TipoDeImporte a partir de las siguientes condiciones:
--'Punitorio' si el monto de la multa es mayor al importe de referencia
--'Leve' si el monto de la multa es menor al importe de referencia
--'Justo' si el monto de la multa es igual al importe de referencia
Select M.IDMulta, M.Patente, M.Monto as ImporteReal, T.ImporteReferencia, case 
	when M.Monto > T.ImporteReferencia then 'Punitorio'
	when M.Monto < T.ImporteReferencia then 'Leve'
	else 'Justo'
end
as TipoDeImporte 
from Multas as M inner join TipoInfracciones as T on M.IDTipoInfraccion = T.IDTipoInfraccion