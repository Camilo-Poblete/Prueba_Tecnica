/*  1. Listado de ventas del mes actual (nombre_sucursal, nombre_vendedor, marca, nombre_producto, 
fecha_venta, unidades_vendidas, precio_unitario, valor_venta)*/

SELECT 
    ve.fecha_venta,
    s.nombre_sucursal,
    v.nombre_vendedor,
    p.marca,
    p.nombre_producto,
    ve.unidades_vendidas,
    p.precio_unitario,
    ve.unidades_vendidas * p.precio_unitario AS valor_venta 
FROM 
    venta ve  
JOIN 
    sucursal s ON ve.id_sucursal = s.id_sucursal 
JOIN
    vendedor v ON ve.id_vendedor = v.id_vendedor	
JOIN
    producto p ON ve.id_producto = p.id_producto
WHERE
    DATE_TRUNC('month', ve.fecha_venta) = DATE_TRUNC('month', CURRENT_DATE);



/*2.Ventas totales por sucursal, vendedor y marca, incluyendo los vendedores que no tuvieron ventas 
(nombre_sucursal, nombre_vendedor, marca, total_venta)  */

SELECT 
    s.nombre_sucursal,
    v.nombre_vendedor,
    p.marca,
    COALESCE(SUM(ve.unidades_vendidas * p.precio_unitario), 0) AS total_venta
FROM 
    sucursal s
CROSS JOIN 
    vendedor v
CROSS JOIN 
    producto p
LEFT JOIN 
    venta ve ON ve.id_sucursal = s.id_sucursal
             AND ve.id_vendedor = v.id_vendedor
             AND ve.id_producto = p.id_producto
GROUP BY
    s.nombre_sucursal, v.nombre_vendedor, p.marca
ORDER BY
    s.nombre_sucursal, v.nombre_vendedor, p.marca;




/* 3. Productos con más de 1000 unidades vendidas en los últimos 2 meses (nombre_producto, marca, 
unidades_vendidas)  */

SELECT 
    p.nombre_producto,
    p.marca,
    SUM(ve.unidades_vendidas) AS "Unidades_vendidas",
    SUM(ve.unidades_vendidas * p.precio_unitario) AS valor_venta
FROM 
    venta ve
JOIN 
    producto p ON ve.id_producto = p.id_producto
WHERE 
    ve.fecha_venta >= CURRENT_DATE - INTERVAL '2 months'
GROUP BY 
    p.nombre_producto, p.marca
HAVING 
    SUM(ve.unidades_vendidas) > 1000;

/* 4. Productos sin ventas en el presente año (nombre_producto, marca) */

SELECT p.nombre_producto AS "nombre_producto", p.marca AS "marca"
FROM producto p LEFT JOIN 
    (
     SELECT id_producto FROM venta
        WHERE EXTRACT(YEAR FROM fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE)
     ) ve ON p.id_producto = ve.id_producto
WHERE 
    ve.id_producto IS NULL;



/* 5. De los productos sin ventas en el presente año, monto total de ventas en el año anterior 
(nombre_producto, marca, total_venta)  */

SELECT 
    p.nombre_producto,
    p.marca,
    COALESCE(SUM(ve2.total_venta), 0) AS total_venta
FROM 
    producto p
LEFT JOIN (
    SELECT 
        v.id_producto,
        SUM(v.unidades_vendidas * p.precio_unitario) AS total_venta
    FROM 
        venta v
    JOIN 
        producto p ON v.id_producto = p.id_producto
    WHERE 
        EXTRACT(YEAR FROM v.fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE) - 1
    GROUP BY 
        v.id_producto
) ve2 ON p.id_producto = ve2.id_producto
LEFT JOIN (
    SELECT 
        v.id_producto
    FROM 
        venta v
    WHERE 
        EXTRACT(YEAR FROM v.fecha_venta) = EXTRACT(YEAR FROM CURRENT_DATE)
) ve ON p.id_producto = ve.id_producto
WHERE 
    ve.id_producto IS NULL
GROUP BY 
    p.nombre_producto, p.marca;




