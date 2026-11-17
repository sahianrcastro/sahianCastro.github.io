-- ReventaCero BD1-2026-RC. Ejecutar despues de 02_insercion_datos.sql.
-- Consultas basicas; cada comentario indica su proposito y RF relacionado.

-- Mostrar los festivales registrados RF-01
SELECT id_festival, nombre, edicion, fecha_inicio, fecha_fin
FROM FESTIVAL
ORDER BY fecha_inicio;

-- Mostrar los artistas y su país RF-04
SELECT id_artista, nombre_artistico, pais
FROM ARTISTA
ORDER BY nombre_artistico;

-- Mostrar las categorías de entrada y sus precios RF-09
SELECT categoria, precio_base, precio_tope_reventa
FROM TIPO_ENTRADA
ORDER BY precio_base;

-- Consultar los usuarios con cuenta activa RF-10
SELECT documento, nombres, apellidos, correo
FROM USUARIO
WHERE estado_cuenta = 'ACTIVA'
ORDER BY apellidos, nombres;

-- Consultar las entradas con precio superior a 200000 COP RF-09
SELECT id_tipo_entrada, categoria, precio_base
FROM TIPO_ENTRADA
WHERE precio_base > 200000;

-- Consultar las zonas VIP del festival 1 RF-02
SELECT id_zona, nombre, aforo_maximo
FROM ZONA
WHERE tipo_zona = 'VIP' AND id_festival = 1;

-- Buscar una boleta por su código RF-20
SELECT codigo_boleta, fecha_emision, id_tipo_entrada,
       comprador_documento
FROM BOLETA
WHERE codigo_boleta = 1001;

-- Consultar ventas primarias o reventas RF-14
SELECT id_transaccion, fecha_hora, tipo_transaccion, precio
FROM TRANSACCION
WHERE tipo_transaccion = 'VENTA_PRIMARIA'
   OR tipo_transaccion = 'REVENTA_AUTORIZADA'
ORDER BY fecha_hora;

-- Mostrar los festivales con los nombres de sus organizadores RF-01
SELECT f.nombre AS festival, u.nombres, u.apellidos, o.cargo
FROM FESTIVAL f
JOIN ORGANIZADOR o ON o.documento = f.organizador_documento
JOIN USUARIO u ON u.documento = o.documento;

-- Consultar programación por escenario y día RF-18
SELECT p.escenario_nombre, p.fecha, p.hora_inicio, p.hora_fin,
       a.nombre_artistico, g.nombre AS genero
FROM PRESENTACION p
JOIN ARTISTA a ON a.id_artista = p.id_artista
JOIN GENERO g ON g.id_genero = a.id_genero
WHERE p.escenario_festival_id = 1
  AND p.fecha >= DATE '2026-12-05'
  AND p.fecha < DATE '2026-12-06'
ORDER BY p.escenario_nombre, p.fecha, p.hora_inicio;

-- Mostrar los tipos de entrada con su zona y festival RF-09
SELECT te.categoria, te.precio_base, z.nombre AS zona,
       f.nombre AS festival
FROM TIPO_ENTRADA te
JOIN ZONA z ON z.id_zona = te.id_zona
JOIN FESTIVAL f ON f.id_festival = z.id_festival
ORDER BY f.nombre, z.nombre;

-- Consultar el historial y los dispositivos de una boleta RF-20
SELECT t.id_transaccion, t.fecha_hora, t.tipo_transaccion,
       t.precio, t.comision_organizador, d.identificador_unico
FROM TRANSACCION t
JOIN DISPOSITIVO d ON d.id_dispositivo = t.id_dispositivo
WHERE t.codigo_boleta = 1001
ORDER BY t.fecha_hora, t.id_transaccion;

-- Consultar reventas por festival con sus participantes RF-21
SELECT f.nombre AS festival, t.codigo_boleta, t.precio,
       t.comision_organizador,
       v.nombres AS nombre_vendedor,
       c.nombres AS nombre_comprador
FROM REVENTA_AUTORIZADA r
JOIN TRANSACCION t ON t.id_transaccion = r.id_transaccion
JOIN USUARIO v ON v.documento = r.vendedor_documento
JOIN USUARIO c ON c.documento = r.comprador_documento
JOIN BOLETA b ON b.codigo_boleta = t.codigo_boleta
JOIN TIPO_ENTRADA te ON te.id_tipo_entrada = b.id_tipo_entrada
JOIN ZONA z ON z.id_zona = te.id_zona
JOIN FESTIVAL f ON f.id_festival = z.id_festival
WHERE f.id_festival = 1;

-- Consultar los patrocinios de un festival RF-24
SELECT f.nombre AS festival, pa.nombre AS patrocinador,
       p.monto, p.tipo_aporte
FROM PATROCINIO p
JOIN FESTIVAL f ON f.id_festival = p.id_festival
JOIN PATROCINADOR pa ON pa.id_patrocinador = p.id_patrocinador
WHERE f.id_festival = 1;

-- Consultar las inscripciones pendientes en lista de espera RF-16
SELECT u.nombres, u.apellidos, te.categoria, i.fecha_solicitud
FROM INSCRIPCION i
JOIN USUARIO u ON u.documento = i.documento
JOIN LISTA_ESPERA le ON le.id_lista = i.id_lista
JOIN TIPO_ENTRADA te ON te.id_tipo_entrada = le.id_tipo_entrada
WHERE i.estado = 'PENDIENTE'
ORDER BY i.fecha_solicitud, i.documento;

-- Consultar los ingresos permitidos al festival RF-17
SELECT ca.codigo_boleta, ca.fecha_hora_ingreso,
       ca.resultado, f.nombre AS festival
FROM CONTROL_ACCESO ca
JOIN BOLETA b ON b.codigo_boleta = ca.codigo_boleta
JOIN TIPO_ENTRADA te ON te.id_tipo_entrada = b.id_tipo_entrada
JOIN ZONA z ON z.id_zona = te.id_zona
JOIN FESTIVAL f ON f.id_festival = z.id_festival
WHERE ca.resultado = 'PERMITIDO' AND f.id_festival = 1;

-- Consultar cada subgénero con su género principal RF-04
SELECT h.nombre AS subgenero, g.nombre AS genero_principal
FROM GENERO h
JOIN GENERO g ON g.id_genero = h.genero_principal_id;