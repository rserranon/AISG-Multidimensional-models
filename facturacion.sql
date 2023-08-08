SELECT axlCli.noCliente, axlFac.folio, axlFac.receptorNombre, axlFac.fechaRegistro - 693609 AS fechaEmision, axlFac.horaRegistro / 86400.00 as horaEmision,
axlCon.descripcion, axlCon.cantidad, axlCon.valorUnitario, RIGHT( axlCon.descripcion, 3 ) AS station,
axlPer.periodo
FROM
( SELECT * FROM DBSaleFacturaComprobante WHERE estatus = 1
) axlFac
INNER JOIN
(  SELECT * FROM DBSaleFacturaConcepto WHERE keyObjectId = 'SaleFacturaComprobante' AND descripcion like '%rout%'
) axlCon
ON axlFac.llave = axlCon.objectKeyValue
INNER JOIN
(  SELECT * FROM DBTableCliente WHERE noCliente = 'UAL'
) axlCli
ON axlFac.llaveCliente = axlCli.llave
INNER JOIN
(  SELECT * FROM DBTableUtilPeriodo
) axlPer
ON axlFac.fechaFinal = axlPer.fecha

