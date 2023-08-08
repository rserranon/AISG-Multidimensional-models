SELECT axlVlo.companyCode, axlVlo.station, axlVlo.linea, axlVlo.fecha - 693609 as fecha, axlVlo.eta / 86400.00 as ETA,	
axlSer.tipotecnico, axlSer.empleado, axlSer.fecha - 69360 as fechaTarea, axlSer.horaInicio / 86400.00 as horaIni, axlSer.horaFin / 86400.00 as horaFin,	
axlSer.manHours / 86400.00 as manHours	
FROM	
( SELECT * FROM DBSaleVuelo WHERE linea = 'AAL'	
) AS axlVlo	
INNER JOIN	
( 	
	SELECT 'SER' AS tipotecnico, 
	tmpSer.companyCode, tmpSer.station, tmpSer.linea, tmpSer.fecha, tmpSer.vuelo,
	tmpSer.numeroNomina AS empleado, tmpSer.horaInicio, tmpSer.horaFin,
	CASE WHEN tmpSer.horaInicio > tmpSer.horaFin THEN 86400 - tmpSer.horaInicio + tmpSer.horaFin ELSE tmpSer.horaFin - tmpSer.horaInicio END as manHours
	FROM
    ( SELECT * FROM DBSaleServicio WHERE linea = 'AAL'	
	) as tmpSer
	UNION
	SELECT 'EMP' AS tipotecnico, 
	tmpSer.companyCode, tmpSer.station, tmpSer.linea, tmpSer.fecha, tmpSer.vuelo,
	tmpEmp.empleado, tmpEmp.horaInicio, tmpEmp.horaFin,
	CASE WHEN tmpEmp.horaInicio > tmpEmp.horaFin THEN 86400 - tmpEmp.horaInicio + tmpEmp.horaFin ELSE tmpEmp.horaFin - tmpEmp.horaInicio END as manHours
	FROM
    ( SELECT * FROM DBSaleServicio WHERE linea = 'AAL'	
	) as tmpSer
	INNER JOIN
    ( SELECT * FROM DBSaleEmpleado	
	) as tmpEmp
	ON tmpEmp.objectKeyValue = tmpSer.llave
	
) AS axlSer	
ON axlvlo.companyCode = axlSer.companyCode	
AND axlvlo.station = axlSer.station	
AND axlvlo.linea = axlSer.linea	
AND axlvlo.fecha = axlSer.fecha	
AND axlvlo.vuelo = axlSer.vuelo	
