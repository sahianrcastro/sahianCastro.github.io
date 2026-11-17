-- ReventaCero BD1-2026-RC. Ejecutar despues de 01_creacion_objetos.sql.
-- Datos ficticios, COP y hora de Colombia UTC-5.
-- activo = 1 representa activo. BOLETA conserva al comprador inicial.
-- RF-01 a RF-17 y relaciones de la revision del modelo suministrado.

INSERT INTO USUARIO (
    documento, nombre_usuario, fecha_registro, estado_cuenta, nombres, 
    apellidos, correo, fecha_nacimiento, tipo_usuario
) VALUES (
    900001, 'admin_demo', DATE '2026-10-01', 'ACTIVA', 'Laura', 
    'Prueba', 'admin@example.com', DATE '1990-05-12', 'ADMINISTRADOR'
);

INSERT INTO ADMINISTRADOR (
    documento, nivel_acceso, fecha_designacion
) VALUES (
    900001, 'GESTION_REVENTA', DATE '2026-10-01'
);

INSERT INTO USUARIO (
    documento, nombre_usuario, fecha_registro, estado_cuenta, nombres, 
    apellidos, correo, fecha_nacimiento, tipo_usuario
) VALUES (
    900002, 'organizador_demo', DATE '2026-10-02', 'ACTIVA', 'Carlos', 
    'Ejemplo', 'organizador@example.com', DATE '1988-03-20', 
    'ORGANIZADOR'
);

INSERT INTO ORGANIZADOR (
    documento, cargo, supervisor_documento
) VALUES (
    900002, 'Coordinador del festival', NULL
);

INSERT INTO USUARIO (
    documento, nombre_usuario, fecha_registro, estado_cuenta, nombres, 
    apellidos, correo, fecha_nacimiento, administrador_documento, 
    fecha_autorizacion, tipo_usuario
) VALUES (
    900003, 'ana_demo', DATE '2026-10-03', 'ACTIVA', 'Ana', 'Muestra', 
    'ana@example.com', DATE '2000-07-15', 900001, DATE '2026-10-10', 
    'USUARIO'
);

INSERT INTO USUARIO (
    documento, nombre_usuario, fecha_registro, estado_cuenta, nombres, 
    apellidos, correo, fecha_nacimiento, administrador_documento, 
    fecha_autorizacion, tipo_usuario
) VALUES (
    900004, 'diego_demo', DATE '2026-10-04', 'ACTIVA', 'Diego', 
    'Ensayo', 'diego@example.com', DATE '1999-11-08', NULL, NULL, 
    'USUARIO'
);

INSERT INTO USUARIO_TELEFONO (
    documento, telefono
) VALUES (
    900003, 'TELEFONO-FICTICIO-001'
);

INSERT INTO USUARIO_TELEFONO (
    documento, telefono
) VALUES (
    900003, 'TELEFONO-FICTICIO-002'
);

INSERT INTO DISPOSITIVO (
    id_dispositivo, identificador_unico, tipo, activo, documento
) VALUES (
    1, 'DISPOSITIVO-DEMO-ANA', 'CELULAR', 1, 900003
);

INSERT INTO DISPOSITIVO (
    id_dispositivo, identificador_unico, tipo, activo, documento
) VALUES (
    2, 'DISPOSITIVO-DEMO-DIEGO', 'CELULAR', 1, 900004
);

INSERT INTO GENERO (
    id_genero, nombre, genero_principal_id
) VALUES (
    1, 'Rock', NULL
);

INSERT INTO GENERO (
    id_genero, nombre, genero_principal_id
) VALUES (
    2, 'Rock alternativo', 1
);

INSERT INTO ARTISTA (
    id_artista, nombre_artistico, pais, id_genero
) VALUES (
    1, 'Horizonte Demo', 'Colombia', 2
);

INSERT INTO ARTISTA (
    id_artista, nombre_artistico, pais, id_genero
) VALUES (
    2, 'Ecos de Prueba', 'Colombia', 1
);

INSERT INTO ARTISTA_RED_SOCIAL (
    id_artista, red_social
) VALUES (
    1, 'https://example.com/horizonte-demo'
);

INSERT INTO COLABORACION (
    artista_principal, artista_invitado
) VALUES (
    1, 2
);

INSERT INTO FESTIVAL (
    id_festival, nombre, edicion, fecha_inicio, fecha_fin, 
    ubicacion_pais, ubicacion_ciudad, ubicacion_direccion, 
    organizador_documento
) VALUES (
    1, 'Festival Sonidos de Prueba', 1, DATE '2026-12-05', 
    DATE '2026-12-06', 'Colombia', 'Bogota', 'Recinto ficticio A', 
    900002
);

INSERT INTO ZONA (
    id_zona, nombre, tipo_zona, aforo_maximo, id_festival
) VALUES (
    1, 'Zona General', 'GENERAL', 1000, 1
);

INSERT INTO ZONA (
    id_zona, nombre, tipo_zona, aforo_maximo, id_festival
) VALUES (
    2, 'Zona Preferencial', 'VIP', 200, 1
);

INSERT INTO ESCENARIO (
    id_festival, nombre_escenario, capacidad
) VALUES (
    1, 'Escenario Principal', 1200
);

INSERT INTO PRESENTACION (
    id_presentacion, fecha, hora_inicio, hora_fin, 
    escenario_festival_id, escenario_nombre, id_artista
) VALUES (
    1, DATE '2026-12-05', 
    TO_DATE('2026-12-05 18:00', 'YYYY-MM-DD HH24:MI'), 
    TO_DATE('2026-12-05 19:00', 'YYYY-MM-DD HH24:MI'), 1, 
    'Escenario Principal', 1
);

INSERT INTO PRESENTACION (
    id_presentacion, fecha, hora_inicio, hora_fin, 
    escenario_festival_id, escenario_nombre, id_artista
) VALUES (
    2, DATE '2026-12-05', 
    TO_DATE('2026-12-05 19:00', 'YYYY-MM-DD HH24:MI'), 
    TO_DATE('2026-12-05 20:00', 'YYYY-MM-DD HH24:MI'), 1, 
    'Escenario Principal', 2
);

INSERT INTO PATROCINADOR (
    id_patrocinador, nombre, tipo, contacto
) VALUES (
    1, 'Empresa Demostrativa', 'EMPRESA', 'patrocinador@example.com'
);

INSERT INTO PATROCINIO (
    id_patrocinio, monto, tipo_aporte, id_patrocinador, id_festival
) VALUES (
    1, 5000000, 'MONETARIO', 1, 1
);

INSERT INTO TIPO_ENTRADA (
    id_tipo_entrada, categoria, precio_base, precio_tope_reventa, 
    id_zona
) VALUES (
    1, 'GENERAL', 100000, 120000, 1
);

INSERT INTO TIPO_ENTRADA (
    id_tipo_entrada, categoria, precio_base, precio_tope_reventa, 
    id_zona
) VALUES (
    2, 'VIP', 250000, 280000, 2
);

INSERT INTO BOLETA (
    codigo_boleta, fecha_emision, id_tipo_entrada, comprador_documento
) VALUES (
    1001, DATE '2026-11-01', 1, 900003
);

INSERT INTO TRANSACCION (
    id_transaccion, fecha_hora, precio, comision_organizador, 
    metodo_pago, codigo_boleta, id_dispositivo, tipo_transaccion
) VALUES (
    1, TO_DATE('2026-11-01 10:00', 'YYYY-MM-DD HH24:MI'), 100000, 0, 
    'SIMULADO', 1001, 1, 'VENTA_PRIMARIA'
);

INSERT INTO VENTA_PRIMARIA (
    id_transaccion, canal_venta
) VALUES (
    1, 'SCRIPT_DEMOSTRACION'
);

INSERT INTO TRANSACCION (
    id_transaccion, fecha_hora, precio, comision_organizador, 
    metodo_pago, codigo_boleta, id_dispositivo, tipo_transaccion
) VALUES (
    2, TO_DATE('2026-11-02 11:00', 'YYYY-MM-DD HH24:MI'), 100000, 0, 
    'SIMULADO', 1001, 1, 'DEVOLUCION'
);

INSERT INTO DEVOLUCION (
    id_transaccion, motivo, porcentaje_reembolso
) VALUES (
    2, 'La compradora no puede asistir', 100
);

INSERT INTO TRANSACCION (
    id_transaccion, fecha_hora, precio, comision_organizador, 
    metodo_pago, codigo_boleta, id_dispositivo, tipo_transaccion
) VALUES (
    3, TO_DATE('2026-11-03 12:00', 'YYYY-MM-DD HH24:MI'), 110000, 
    10000, 'SIMULADO', 1001, 2, 'REVENTA_AUTORIZADA'
);

INSERT INTO REVENTA_AUTORIZADA (
    id_transaccion, vendedor_documento, comprador_documento
) VALUES (
    3, 900003, 900004
);

INSERT INTO LISTA_ESPERA (
    id_lista, id_tipo_entrada
) VALUES (
    1, 2
);

INSERT INTO INSCRIPCION (
    documento, id_lista, fecha_solicitud, estado
) VALUES (
    900004, 1, TO_DATE('2026-11-04 09:00', 'YYYY-MM-DD HH24:MI'), 
    'PENDIENTE'
);

INSERT INTO NOTIFICACION (
    id_notificacion, fecha_hora, canal, mensaje, usuario_documento, 
    id_lista
) VALUES (
    1, TO_DATE('2026-11-04 09:01', 'YYYY-MM-DD HH24:MI'), 'CORREO', 
    'Inscripcion recibida en la lista de espera VIP.', 900004, 1
);

INSERT INTO CONTROL_ACCESO (
    id_acceso, fecha_hora_ingreso, resultado, codigo_boleta
) VALUES (
    1, TO_DATE('2026-12-05 17:30', 'YYYY-MM-DD HH24:MI'), 'PERMITIDO', 
    1001
);
COMMIT;
