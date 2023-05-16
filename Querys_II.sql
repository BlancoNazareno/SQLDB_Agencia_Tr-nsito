--DUDAS: 
--1.Al momento de tirar un COUNT donde hay inner join, es decir, interacción de más de una tabla, y lo que importa es que cuente los registros, 
--¿técnicamente se puede poner cualquier columna, pero se suele usar alguna que sea PK, no? 
--2.Cuando se usa Group by, la cantidad columnas en el group by deben ser 

--use AgenciaTransito

--1) Listado con la cantidad de agentes
Select COUNT(*) as 'Cantidad de Agentes' from Agentes

--2) Listado con importe de referencia promedio de los tipos de infracciones
Select AVG(ImporteReferencia) as 'AVG Imp.Ref.' from TipoInfracciones

--3) Listado con la suma de los montos de las multas. Indistintamente de si fueron pagadas o no
Select SUM(Monto) as 'Total multas' from Multas

--4) Listado con la cantidad de pagos que se realizaron.
Select COUNT(*) as 'Multas pagadas' from Multas where Pagada = 1

--5) Listado con la cantidad de multas realizadas en la provincia de Buenos Aires.
--NOTA: Utilizar el nombre 'Buenos Aires' de la provincia.
Select COUNT(*) as 'Cantidad de multas en BA' from Multas as M
inner join Localidades as L on M.IDLocalidad = L.IDLocalidad
inner join Provincias as P on L.IDProvincia = P.IDProvincia	
where P.Provincia = 'Buenos Aires'

--6) Listado con el promedio de antigüedad de los agentes que se encuentren activos.
Select AVG(DATEDIFF (YEAR, A.FechaIngreso , 
GETDATE())-
case 
	when MONTH(getdate()) < MONTH(A.FechaIngreso) or 
	(MONTH(getdate()) = MONTH(A.FechaIngreso) and DAY(getdate()) < DAY(A.FechaIngreso)) then 1
	else 0
end
)
as 'AVG_Antiguedad' from Agentes as A 
where A.Activo = 1

--7) Listado con el monto más elevado que se haya registrado en una multa.
Select MAX(Monto) as 'MAX_Monto_Multa' from Multas

--8) Listado con el importe de pago más pequeño que se haya registrado.
Select MIN(Monto) as 'MIN_Multa_Pagada' from Multas where Pagada = 1

--9) Por cada agente, listar Legajo, Apellidos y Nombres y la cantidad de multas que registraron.
Select A.Legajo, A.Apellidos, A.Nombres, COUNT(M.IdMulta) as 'Cantidad_multas' from Agentes as A 
inner join Multas as M on A.IdAgente = M.IdAgente
Group by A.Legajo, A.Apellidos, A.Nombres

--10) Por cada tipo de infracción, listar la descripción y el promedio de montos de las multas asociadas a dicho tipo de infracción.
Select TI.Descripcion as 'Tipo_de_infracción', AVG(M.Monto) as 'AVG_Multas_x_Tipo' from TipoInfracciones as TI 
inner join Multas as M on TI.IdTipoInfraccion = M.IdTipoInfraccion
Group by TI.Descripcion

--11) Por cada multa, indicar la fecha, la patente, el importe de la multa y la cantidad de pagos realizados. 
--Solamente mostrar la información de las multas que hayan sido pagadas en su totalidad.
Select M.IdMulta, M.FechaHora, M.Patente, M.Monto, COUNT(P.IDPago) as 'Cantidad_Pagos_x_Multa', SUM(P.Importe) as 'Suma_Pagos_X_Multa' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.IdMulta, M.FechaHora, M.Patente, M.Monto
Having (SUM(P.Importe) >= M.Monto)

--12) Listar todos los datos de las multas que hayan registrado más de un pago.
Select M.IdMulta, M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, M.FechaHora, M.Monto, M.Pagada, COUNT(M.IdMulta) as 'Cantidad_Pagos_X_Multa' from Multas as M  
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.IdMulta, M.IdTipoInfraccion, M.IDLocalidad, M.IdAgente, M.Patente, M.FechaHora, M.Monto, M.Pagada
Having(COUNT(M.IdMulta) > 1)

--13) Listar todos los datos de todos los agentes que hayan registrado multas con un monto que en promedio supere los $10000
Select A.IdAgente , A.Legajo, A.Nombres, A.Apellidos, A.FechaNacimiento, A.FechaIngreso, A.Email, A.Telefono, A.Celular, A.Activo, 
AVG(M.Monto) as 'Promedio_Multas_X_Agente' from Agentes as A
inner join Multas as M on A.IdAgente = M.IdAgente
Group by A.IdAgente, A.Legajo, A.Nombres, A.Apellidos, A.FechaNacimiento, A.FechaIngreso, A.Email, A.Telefono, A.Celular, A.Activo
Having (AVG(M.Monto) > 10000)

--14) Listar el tipo de infracción que más cantidad de multas haya registrado.
Select top 1 TI.Descripcion, count(TI.IdTipoInfraccion) as 'Cantidad_Multas_X_Tipo' from TipoInfracciones as TI
inner join Multas as M on TI.IdTipoInfraccion = M.IdTipoInfraccion
group by TI.IdTipoInfraccion, TI.Descripcion 
order by count(TI.IdTipoInfraccion) desc
--
--no permite porque refiere a una subconsulta
Select MAX(COUNT(TI.Descripcion)) as 'Multa_Más_Cometida' from TipoInfracciones as TI
Inner join Multas as M on TI.IdTipoInfraccion = M.IdTipoInfraccion

--15) Listar por cada patente, la cantidad de infracciones distintas que se cometieron.
Select M.Patente, TI.Descripcion as 'Tipo_Infraccion', count(TI.IdTipoInfraccion) as 'Cantidades de incidencias' from Multas as M
inner join TipoInfracciones as TI on M.IDTipoInfraccion = TI.IDTipoInfraccion
group by TI.Descripcion, M.Patente
order by M.Patente, count(TI.Descripcion) desc



--16) Listar por cada patente, el texto literal 'Multas pagadas' y el monto total de los pagos registrados por esa patente. 
--Además, por cada patente, el texto literal 'Multas por pagar' y el monto total de lo que se adeuda.
--
--me trae los pagos hechos por patente, indistintamente de si cubren o no el monto de la multa
Select M.Patente, SUM(P.Importe) as 'Suma_Pagos_X_Multa' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente
-----------------------------------------------------------------------------------------------------
--Me trae las patentes con multas pagadas
Select M.Patente, SUM(P.Importe) as 'Suma_Pagos_X_Multa_Completamente_Pagas' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente, M.Monto
Having (SUM(P.Importe) >= M.Monto)
--
--Me trae las patentes con multas por pagar
Select M.Patente, SUM(P.Importe) as 'Suma_Pagos_X_Multa_Parcialmente_Pagas' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente, M.Monto
Having (SUM(P.Importe) < M.Monto)
-------------------------------------------------------------------------------------------------------------
--Arquetipo de la consulta
Select M.Patente, () as 'Multas pagadas', () as 'Multas por pagar'  
from Multas as M
inner join Pagos as P on M.IDMulta = P.IDMulta
-------------------------------------------------------------------------------------------------------------
--Sería la consulta completa, con subconsultas integradas
Select M.Patente, (
Select M.Patente, SUM(P.Importe) as 'Suma_Pagos_X_Multa_Completamente_Pagas' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente, M.Monto
Having (SUM(P.Importe) >= M.Monto)
) as 'Multas pagadas', 
(
Select M.Patente, SUM(P.Importe) as 'Suma_Pagos_X_Multa_Completamente_Pagas' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente, M.Monto
Having (SUM(P.Importe) < M.Monto)
) as 'Multas por pagar'  
from Multas as M
inner join Pagos as P on M.IDMulta = P.IDMulta

--Realizado (y resuelto) con una tabla auxiliar:
Select Aux.Patente, 
	(case
	when Aux.Suma_Pagos_X_Multa >= Aux.Monto then Suma_Pagos_X_Multa
	end) as 'Multas pagadas',
	(case
	when Aux.Suma_Pagos_X_Multa < Aux.Monto then Suma_Pagos_X_Multa
	end) as 'Multas por pagar'
from (
Select M.Patente, M.Monto, SUM(P.Importe) as 'Suma_Pagos_X_Multa' from Multas as M
inner join Pagos as P on M.IdMulta = P.IdMulta
Group by M.Patente, M.Monto
) as Aux


--17) Listado con los nombres de los medios de pagos que se hayan utilizado más de 3 veces.
Select MP.Nombre, count(P.IDMedioPago) as 'Veces_utilizado' from MediosPago as MP
inner join Pagos as P on MP.IDMedioPago = P.IDMedioPago
Group by MP.Nombre
Having (count(P.IDMedioPago) > 3)	
Order by count(P.IDMedioPago) desc

--18)Los legajos, apellidos y nombres de los agentes que hayan labrado más de 2 multas con tipos de infracciones distintas.
Select A.Legajo, A.Apellidos, A.Nombres, TI.Descripcion, count(M.IDMulta) as 'Cantidad_Multas_X_Tipo' from TipoInfracciones as TI
inner join Multas as M on TI.IdTipoInfraccion = M.IdTipoInfraccion
inner join Agentes as A on M.IdAgente = A.IdAgente
Group by A.IdAgente, A.Legajo, A.Apellidos, A.Nombres, TI.Descripcion
Order by A.IdAgente asc, count(M.IDMulta) desc
--esto me trae la cantidad de multas por agente, por tipo

--tendría que contar la cantidad de veces que aparece cada agente en los registros, y el que aparezca >= 3 veces, 
--cumple la condición, ya que ordena una registro por tipo distinto de infracción

Select Aux.Legajo, Aux.Apellidos, Aux.Nombres, Count(Aux.Legajo) as 'Tipos_Infracciones_Hechas' from 
(
Select A.Legajo, A.Apellidos, A.Nombres, TI.Descripcion, count(M.IDMulta) as 'Cantidad_Multas_X_Tipo' from TipoInfracciones as TI
inner join Multas as M on TI.IdTipoInfraccion = M.IdTipoInfraccion
inner join Agentes as A on M.IdAgente = A.IdAgente
Group by A.IdAgente, A.Legajo, A.Apellidos, A.Nombres, TI.Descripcion
)
as Aux
Group by Aux.Legajo, Aux.Apellidos, Aux.Nombres
Having (Count(Aux.Legajo) >= 3)

--19)  El total recaudado en concepto de pagos discriminado por nombre de medio de pago.
Select MP.Nombre, SUM(P.Importe) as 'Total_X_MedioDePago' from MediosPago as MP
inner join Pagos as P on MP.IDMedioPago = P.IDMedioPago
Group by MP.Nombre
Order by SUM(P.Importe) desc

--20) Un listado con el siguiente formato:
/*
Descripción        Tipo           Recaudado
-----------------------------------------------
Tigre              Localidad      $xxxx
San Fernando       Localidad      $xxxx
Rosario            Localidad      $xxxx
Buenos Aires       Provincia      $xxxx
Santa Fe           Provincia      $xxxx
Argentina          País           $xxxx
*/

--Intentos que no resultaron
Select Pv.Provincia, L.Localidad, SUM(Pg.Importe) as 'Recaudación' from Provincias as Pv
inner join Localidades as L on Pv.IDProvincia = L.IDLocalidad
inner join Multas as M on L.IDLocalidad = M.IDLocalidad
inner join Pagos as Pg on M.IdMulta = Pg.IDMulta
Group by Pv.Provincia, L.Localidad
--
Select L.Localidad, SUM(Pg.Importe) as 'Recaudación' from Localidades as L
inner join Multas as M on L.IDLocalidad = M.IDLocalidad
inner join Pagos as Pg on M.IdMulta = Pg.IDMulta
Group by L.Localidad
----------------------------------------------------------------------------------------------
--Forma que sí resulta
Select L.Localidad as 'Descripcion', 'Localidad' as 'Tipo', SUM(Pg.Importe) as 'Recaudado' from Localidades as L
inner join Multas as M on L.IDLocalidad = M.IdLocalidad
inner join Pagos as Pg on Pg.IDMulta = M.IDMulta
Group by L.Localidad
UNION
Select Pv.Provincia as 'Descripción', 'Provincia' as 'Tipo', SUM(Pg.Importe) as 'Recaudado' from Provincias as Pv
inner join Localidades as L on Pv.IDProvincia = L.IDLocalidad
inner join Multas as M on L.IDLocalidad = M.IDLocalidad
INNER JOIN Pagos as Pg ON M.IDMulta = Pg.IDMulta
Group by Pv.Provincia
UNION
Select 'Argentina' as 'Descripción', 'País' as 'Tipo', SUM(Pg.Importe) as 'Recaudado' from Pagos as Pg

