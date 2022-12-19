1.SELECT nombre, count(*) FROM cliente AS A INNER JOIN factura AS B ON A.id = B.cliente_id GROUP BY(A.id) ORDER BY count(*) DESC;    
2.SELECT d.nombre, SUM(ROUND(a.precio*b.cantidad)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id INNER JOIN cliente AS d ON c.cliente_id = d.id GROUP BY (d.id) ORDER BY suma;
3.SELECT moneda.nombre, count(*) AS contador FROM moneda INNER JOIN factura ON moneda.id = factura.moneda_id GROUP BY (moneda.id) ORDER BY contador DESC;
4.SELECT producto.nombre, count(*) FROM producto INNER JOIN proveedor ON producto.proveedor_id = proveedor.id GROUP BY(producto.nombre); 
5.SELECT producto.nombre, SUM(ROUD(factura_detalle.cantidad)) AS suma FROM producto INNER JOIN factura_detalle ON producto.id = factura_detalle.producto_id GROUP BY(producto.nombre) ORDER BY suma DESC;
6.SELECT producto.nombre, SUM(ROUND(factura_detalle.cantidad)) AS suma FROM producto INNER JOIN factura_detalle ON producto.id = factura_detalle.producto_id GROUP BY(producto.nombre) ORDER BY suma ASC;     
7.SELECT factura.fecha_emision, cliente.nombre, cliente.apellido, producto.nombre , factura_detalle.cantidad, factura_tipo.nombre FROM cliente INNER JOIN factura ON cliente.id = factura.cliente_id INNER JOIN factura_detalle ON factura.id = factura_detalle.factura_id INNER JOIN producto ON factura_detalle.producto_id = producto.id INNER JOIN factura_tipo ON factura_tipo.id = factura.factura_tipo_id;
monto + 10monto = 110monto;
10monto
8.SELECT c.id, SUM(ROUND(a.precio*b.cantidad)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id GROUP BY (c.id) ORDER BY suma DESC;
9.SELECT c.id, SUM(ROUND(a.precio*b.cantidad/11)) AS suma FROM producto AS a INNER JOIN factura_detalle AS b ON a.id = b.producto_id INNER JOIN factura AS c ON c.id = b.factura_id GROUP BY (c.id) ORDER BY suma DESC;