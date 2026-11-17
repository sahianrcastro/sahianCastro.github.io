-- ReventaCero BD1-2026-RC. Ejecutar primero con F5 en un esquema vacio.
-- SQL original suministrado, con delimitador final para el disparador.

CREATE TABLE ADMINISTRADOR 
    ( 
     documento         NUMBER  NOT NULL , 
     nivel_acceso      VARCHAR2 (100) , 
     fecha_designacion DATE 
    ) 
;

ALTER TABLE ADMINISTRADOR 
    ADD CONSTRAINT ADMINISTRADOR_PK PRIMARY KEY ( documento ) ;

CREATE TABLE ARTISTA 
    ( 
     id_artista       NUMBER  NOT NULL , 
     nombre_artistico VARCHAR2 (100) , 
     pais             VARCHAR2 (100) , 
     id_genero        NUMBER  NOT NULL 
    ) 
;

ALTER TABLE ARTISTA 
    ADD CONSTRAINT ARTISTA_PK PRIMARY KEY ( id_artista ) ;

CREATE TABLE ARTISTA_RED_SOCIAL 
    ( 
     id_artista NUMBER  NOT NULL , 
     red_social VARCHAR2 (254)  NOT NULL 
    ) 
;

ALTER TABLE ARTISTA_RED_SOCIAL 
    ADD CONSTRAINT ARTISTA_RED_SOCIAL_PK PRIMARY KEY ( id_artista, red_social ) ;

CREATE TABLE BOLETA 
    ( 
     codigo_boleta       NUMBER  NOT NULL , 
     fecha_emision       DATE , 
     id_tipo_entrada     NUMBER  NOT NULL , 
     comprador_documento NUMBER  NOT NULL 
    ) 
;

ALTER TABLE BOLETA 
    ADD CONSTRAINT BOLETA_PK PRIMARY KEY ( codigo_boleta ) ;

CREATE TABLE COLABORACION 
    ( 
     artista_principal NUMBER  NOT NULL , 
     artista_invitado  NUMBER  NOT NULL 
    ) 
;

ALTER TABLE COLABORACION 
    ADD CONSTRAINT COLABORACION_PK PRIMARY KEY ( artista_principal, artista_invitado ) ;

CREATE TABLE CONTROL_ACCESO 
    ( 
     id_acceso          NUMBER  NOT NULL , 
     fecha_hora_ingreso DATE , 
     resultado          VARCHAR2 (100) , 
     codigo_boleta      NUMBER  NOT NULL 
    ) 
;

ALTER TABLE CONTROL_ACCESO 
    ADD CONSTRAINT CONTROL_ACCESO_PK PRIMARY KEY ( id_acceso ) ;

ALTER TABLE CONTROL_ACCESO 
    ADD CONSTRAINT UK_CONTROL_ACCESO_codigo_bolet UNIQUE ( codigo_boleta ) ;

CREATE TABLE DEVOLUCION 
    ( 
     id_transaccion       NUMBER  NOT NULL , 
     motivo               VARCHAR2 (254) , 
     porcentaje_reembolso NUMBER 
    ) 
;

ALTER TABLE DEVOLUCION 
    ADD CONSTRAINT DEVOLUCION_PK PRIMARY KEY ( id_transaccion ) ;

CREATE TABLE DISPOSITIVO 
    ( 
     id_dispositivo      NUMBER  NOT NULL , 
     identificador_unico VARCHAR2 (254) , 
     tipo                VARCHAR2 (100) , 
     activo              NUMBER , 
     documento           NUMBER  NOT NULL 
    ) 
;

ALTER TABLE DISPOSITIVO 
    ADD CONSTRAINT DISPOSITIVO_PK PRIMARY KEY ( id_dispositivo ) ;

CREATE TABLE ESCENARIO 
    ( 
     id_festival      NUMBER  NOT NULL , 
     nombre_escenario VARCHAR2 (100)  NOT NULL , 
     capacidad        NUMBER 
    ) 
;

ALTER TABLE ESCENARIO 
    ADD CONSTRAINT ESCENARIO_PK PRIMARY KEY ( id_festival, nombre_escenario ) ;

CREATE TABLE FESTIVAL 
    ( 
     id_festival           NUMBER  NOT NULL , 
     nombre                VARCHAR2 (100) , 
     edicion               NUMBER , 
     fecha_inicio          DATE , 
     fecha_fin             DATE , 
     ubicacion_pais        VARCHAR2 (100) , 
     ubicacion_ciudad      VARCHAR2 (100) , 
     ubicacion_direccion   VARCHAR2 (254) , 
     organizador_documento NUMBER  NOT NULL 
    ) 
;

ALTER TABLE FESTIVAL 
    ADD CONSTRAINT FESTIVAL_PK PRIMARY KEY ( id_festival ) ;

CREATE TABLE GENERO 
    ( 
     id_genero           NUMBER  NOT NULL , 
     nombre              VARCHAR2 (100) , 
     genero_principal_id NUMBER 
    ) 
;

ALTER TABLE GENERO 
    ADD CONSTRAINT GENERO_PK PRIMARY KEY ( id_genero ) ;

CREATE TABLE INSCRIPCION 
    ( 
     documento       NUMBER  NOT NULL , 
     id_lista        NUMBER  NOT NULL , 
     fecha_solicitud DATE , 
     estado          VARCHAR2 (100) 
    ) 
;

ALTER TABLE INSCRIPCION 
    ADD CONSTRAINT INSCRIPCION_PK PRIMARY KEY ( documento, id_lista ) ;

CREATE TABLE LISTA_ESPERA 
    ( 
     id_lista        NUMBER  NOT NULL , 
     id_tipo_entrada NUMBER  NOT NULL 
    ) 
;

ALTER TABLE LISTA_ESPERA 
    ADD CONSTRAINT LISTA_ESPERA_PK PRIMARY KEY ( id_lista ) ;

ALTER TABLE LISTA_ESPERA 
    ADD CONSTRAINT UK_LISTA_ESPERA_id_tipo_entrad UNIQUE ( id_tipo_entrada ) ;

CREATE TABLE NOTIFICACION 
    ( 
     id_notificacion   NUMBER  NOT NULL , 
     fecha_hora        DATE , 
     canal             VARCHAR2 (100) , 
     mensaje           VARCHAR2 (2000) , 
     usuario_documento NUMBER  NOT NULL , 
     id_lista          NUMBER  NOT NULL 
    ) 
;

ALTER TABLE NOTIFICACION 
    ADD CONSTRAINT NOTIFICACION_PK PRIMARY KEY ( id_notificacion ) ;

CREATE TABLE ORGANIZADOR 
    ( 
     documento            NUMBER  NOT NULL , 
     cargo                VARCHAR2 (100) , 
     supervisor_documento NUMBER 
    ) 
;

ALTER TABLE ORGANIZADOR 
    ADD CONSTRAINT ORGANIZADOR_PK PRIMARY KEY ( documento ) ;

CREATE TABLE PATROCINADOR 
    ( 
     id_patrocinador NUMBER  NOT NULL , 
     nombre          VARCHAR2 (100) , 
     tipo            VARCHAR2 (100) , 
     contacto        VARCHAR2 (254) 
    ) 
;

ALTER TABLE PATROCINADOR 
    ADD CONSTRAINT PATROCINADOR_PK PRIMARY KEY ( id_patrocinador ) ;

CREATE TABLE PATROCINIO 
    ( 
     id_patrocinio   NUMBER  NOT NULL , 
     monto           NUMBER , 
     tipo_aporte     VARCHAR2 (100) , 
     id_patrocinador NUMBER  NOT NULL , 
     id_festival     NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PATROCINIO 
    ADD CONSTRAINT PATROCINIO_PK PRIMARY KEY ( id_patrocinio ) ;

CREATE TABLE PRESENTACION 
    ( 
     id_presentacion       NUMBER  NOT NULL , 
     fecha                 DATE , 
     hora_inicio           DATE , 
     hora_fin              DATE , 
     escenario_festival_id NUMBER  NOT NULL , 
     escenario_nombre      VARCHAR2 (100)  NOT NULL , 
     id_artista            NUMBER  NOT NULL 
    ) 
;

ALTER TABLE PRESENTACION 
    ADD CONSTRAINT PRESENTACION_PK PRIMARY KEY ( id_presentacion ) ;

CREATE TABLE REVENTA_AUTORIZADA 
    ( 
     id_transaccion      NUMBER  NOT NULL , 
     vendedor_documento  NUMBER  NOT NULL , 
     comprador_documento NUMBER  NOT NULL 
    ) 
;

ALTER TABLE REVENTA_AUTORIZADA 
    ADD CONSTRAINT REVENTA_AUTORIZADA_PK PRIMARY KEY ( id_transaccion ) ;

CREATE TABLE TIPO_ENTRADA 
    ( 
     id_tipo_entrada     NUMBER  NOT NULL , 
     categoria           VARCHAR2 (100) , 
     precio_base         NUMBER , 
     precio_tope_reventa NUMBER , 
     id_zona             NUMBER  NOT NULL 
    ) 
;

ALTER TABLE TIPO_ENTRADA 
    ADD CONSTRAINT TIPO_ENTRADA_PK PRIMARY KEY ( id_tipo_entrada ) ;

CREATE TABLE TRANSACCION 
    ( 
     id_transaccion       NUMBER  NOT NULL , 
     fecha_hora           DATE , 
     precio               NUMBER , 
     comision_organizador NUMBER , 
     metodo_pago          VARCHAR2 (100) , 
     codigo_boleta        NUMBER  NOT NULL , 
     id_dispositivo       NUMBER  NOT NULL , 
     tipo_transaccion     VARCHAR2 (20) DEFAULT 'TRANSACCION'  NOT NULL 
    ) 
;

ALTER TABLE TRANSACCION 
    ADD 
    CHECK (tipo_transaccion IN ('DEVOLUCION', 'REVENTA_AUTORIZADA', 'TRANSACCION', 'VENTA_PRIMARIA')) 
;

ALTER TABLE TRANSACCION 
    ADD CONSTRAINT TRANSACCION_PK PRIMARY KEY ( id_transaccion ) ;

CREATE TABLE USUARIO 
    ( 
     documento               NUMBER  NOT NULL , 
     nombre_usuario          VARCHAR2 (100) , 
     contrasenia             VARCHAR2 (255) , 
     fecha_registro          DATE , 
     estado_cuenta           VARCHAR2 (100) , 
     nombres                 VARCHAR2 (100) , 
     apellidos               VARCHAR2 (100) , 
     correo                  VARCHAR2 (254) , 
     fecha_nacimiento        DATE , 
     administrador_documento NUMBER , 
     fecha_autorizacion      DATE , 
     tipo_usuario            VARCHAR2 (20) DEFAULT 'USUARIO'  NOT NULL 
    ) 
;

ALTER TABLE USUARIO 
    ADD 
    CHECK (tipo_usuario IN ('ADMINISTRADOR', 'ORGANIZADOR', 'USUARIO')) 
;

ALTER TABLE USUARIO 
    ADD CONSTRAINT USUARIO_PK PRIMARY KEY ( documento ) ;

CREATE TABLE USUARIO_TELEFONO 
    ( 
     documento NUMBER  NOT NULL , 
     telefono  VARCHAR2 (40)  NOT NULL 
    ) 
;

ALTER TABLE USUARIO_TELEFONO 
    ADD CONSTRAINT USUARIO_TELEFONO_PK PRIMARY KEY ( documento, telefono ) ;

CREATE TABLE VENTA_PRIMARIA 
    ( 
     id_transaccion NUMBER  NOT NULL , 
     canal_venta    VARCHAR2 (100) 
    ) 
;

ALTER TABLE VENTA_PRIMARIA 
    ADD CONSTRAINT VENTA_PRIMARIA_PK PRIMARY KEY ( id_transaccion ) ;

CREATE TABLE ZONA 
    ( 
     id_zona      NUMBER  NOT NULL , 
     nombre       VARCHAR2 (100) , 
     tipo_zona    VARCHAR2 (100) , 
     aforo_maximo NUMBER , 
     id_festival  NUMBER  NOT NULL 
    ) 
;

ALTER TABLE ZONA 
    ADD CONSTRAINT ZONA_PK PRIMARY KEY ( id_zona ) ;

ALTER TABLE ADMINISTRADOR 
    ADD CONSTRAINT FK_ADMINISTRADOR_USUARIO FOREIGN KEY 
    ( 
     documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE ARTISTA 
    ADD CONSTRAINT FK_ARTISTA_GENERO FOREIGN KEY 
    ( 
     id_genero
    ) 
    REFERENCES GENERO 
    ( 
     id_genero
    ) 
;

ALTER TABLE ARTISTA_RED_SOCIAL 
    ADD CONSTRAINT FK_ARTISTA_RED_SOCIAL_ARTISTA FOREIGN KEY 
    ( 
     id_artista
    ) 
    REFERENCES ARTISTA 
    ( 
     id_artista
    ) 
;

ALTER TABLE BOLETA 
    ADD CONSTRAINT FK_BOLETA_TIPO_ENTRADA FOREIGN KEY 
    ( 
     id_tipo_entrada
    ) 
    REFERENCES TIPO_ENTRADA 
    ( 
     id_tipo_entrada
    ) 
;

ALTER TABLE BOLETA 
    ADD CONSTRAINT FK_BOLETA_USUARIO FOREIGN KEY 
    ( 
     comprador_documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE COLABORACION 
    ADD CONSTRAINT FK_COLAB_ARTISTA_INVITADO FOREIGN KEY 
    ( 
     artista_invitado
    ) 
    REFERENCES ARTISTA 
    ( 
     id_artista
    ) 
;

ALTER TABLE COLABORACION 
    ADD CONSTRAINT FK_COLAB_ARTISTA_PRINCIPAL FOREIGN KEY 
    ( 
     artista_principal
    ) 
    REFERENCES ARTISTA 
    ( 
     id_artista
    ) 
;

ALTER TABLE CONTROL_ACCESO 
    ADD CONSTRAINT FK_CONTROL_ACCESO_BOLETA FOREIGN KEY 
    ( 
     codigo_boleta
    ) 
    REFERENCES BOLETA 
    ( 
     codigo_boleta
    ) 
;

ALTER TABLE DEVOLUCION 
    ADD CONSTRAINT FK_DEVOLUCION_TRANSACCION FOREIGN KEY 
    ( 
     id_transaccion
    ) 
    REFERENCES TRANSACCION 
    ( 
     id_transaccion
    ) 
;

ALTER TABLE DISPOSITIVO 
    ADD CONSTRAINT FK_DISPOSITIVO_USUARIO FOREIGN KEY 
    ( 
     documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE ESCENARIO 
    ADD CONSTRAINT FK_ESCENARIO_FESTIVAL FOREIGN KEY 
    ( 
     id_festival
    ) 
    REFERENCES FESTIVAL 
    ( 
     id_festival
    ) 
;

ALTER TABLE FESTIVAL 
    ADD CONSTRAINT FK_FESTIVAL_ORGANIZADOR FOREIGN KEY 
    ( 
     organizador_documento
    ) 
    REFERENCES ORGANIZADOR 
    ( 
     documento
    ) 
;

ALTER TABLE GENERO 
    ADD CONSTRAINT FK_GENERO_GENERO FOREIGN KEY 
    ( 
     genero_principal_id
    ) 
    REFERENCES GENERO 
    ( 
     id_genero
    ) 
;

ALTER TABLE INSCRIPCION 
    ADD CONSTRAINT FK_INSCRIPCION_LISTA_ESPERA FOREIGN KEY 
    ( 
     id_lista
    ) 
    REFERENCES LISTA_ESPERA 
    ( 
     id_lista
    ) 
;

ALTER TABLE INSCRIPCION 
    ADD CONSTRAINT FK_INSCRIPCION_USUARIO FOREIGN KEY 
    ( 
     documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE LISTA_ESPERA 
    ADD CONSTRAINT FK_LISTA_ESPERA_TIPO_ENTRADA FOREIGN KEY 
    ( 
     id_tipo_entrada
    ) 
    REFERENCES TIPO_ENTRADA 
    ( 
     id_tipo_entrada
    ) 
;

ALTER TABLE NOTIFICACION 
    ADD CONSTRAINT FK_NOTIFICACION_INSCRIPCION FOREIGN KEY 
    ( 
     usuario_documento,
     id_lista
    ) 
    REFERENCES INSCRIPCION 
    ( 
     documento,
     id_lista
    ) 
;

ALTER TABLE ORGANIZADOR 
    ADD CONSTRAINT FK_ORGANIZADOR_ORGANIZADOR FOREIGN KEY 
    ( 
     supervisor_documento
    ) 
    REFERENCES ORGANIZADOR 
    ( 
     documento
    ) 
;

ALTER TABLE ORGANIZADOR 
    ADD CONSTRAINT FK_ORGANIZADOR_USUARIO FOREIGN KEY 
    ( 
     documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE PATROCINIO 
    ADD CONSTRAINT FK_PATROCINIO_FESTIVAL FOREIGN KEY 
    ( 
     id_festival
    ) 
    REFERENCES FESTIVAL 
    ( 
     id_festival
    ) 
;

ALTER TABLE PATROCINIO 
    ADD CONSTRAINT FK_PATROCINIO_PATROCINADOR FOREIGN KEY 
    ( 
     id_patrocinador
    ) 
    REFERENCES PATROCINADOR 
    ( 
     id_patrocinador
    ) 
;

ALTER TABLE PRESENTACION 
    ADD CONSTRAINT FK_PRESENTACION_ARTISTA FOREIGN KEY 
    ( 
     id_artista
    ) 
    REFERENCES ARTISTA 
    ( 
     id_artista
    ) 
;

ALTER TABLE PRESENTACION 
    ADD CONSTRAINT FK_PRESENTACION_ESCENARIO FOREIGN KEY 
    ( 
     escenario_festival_id,
     escenario_nombre
    ) 
    REFERENCES ESCENARIO 
    ( 
     id_festival,
     nombre_escenario
    ) 
;

ALTER TABLE REVENTA_AUTORIZADA 
    ADD CONSTRAINT FK_REVENTA_TRANSACCION FOREIGN KEY 
    ( 
     id_transaccion
    ) 
    REFERENCES TRANSACCION 
    ( 
     id_transaccion
    ) 
;

ALTER TABLE REVENTA_AUTORIZADA 
    ADD CONSTRAINT FK_REVENTA_USUARIO_COMPRADOR FOREIGN KEY 
    ( 
     comprador_documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE REVENTA_AUTORIZADA 
    ADD CONSTRAINT FK_REVENTA_USUARIO_VENDEDOR FOREIGN KEY 
    ( 
     vendedor_documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE TIPO_ENTRADA 
    ADD CONSTRAINT FK_TIPO_ENTRADA_ZONA FOREIGN KEY 
    ( 
     id_zona
    ) 
    REFERENCES ZONA 
    ( 
     id_zona
    ) 
;

ALTER TABLE TRANSACCION 
    ADD CONSTRAINT FK_TRANSACCION_BOLETA FOREIGN KEY 
    ( 
     codigo_boleta
    ) 
    REFERENCES BOLETA 
    ( 
     codigo_boleta
    ) 
;

ALTER TABLE TRANSACCION 
    ADD CONSTRAINT FK_TRANSACCION_DISPOSITIVO FOREIGN KEY 
    ( 
     id_dispositivo
    ) 
    REFERENCES DISPOSITIVO 
    ( 
     id_dispositivo
    ) 
;

ALTER TABLE USUARIO 
    ADD CONSTRAINT FK_USUARIO_ADMINISTRADOR FOREIGN KEY 
    ( 
     administrador_documento
    ) 
    REFERENCES ADMINISTRADOR 
    ( 
     documento
    ) 
;

ALTER TABLE USUARIO_TELEFONO 
    ADD CONSTRAINT FK_USUARIO_TELEFONO_USUARIO FOREIGN KEY 
    ( 
     documento
    ) 
    REFERENCES USUARIO 
    ( 
     documento
    ) 
;

ALTER TABLE VENTA_PRIMARIA 
    ADD CONSTRAINT FK_VENTA_PRIMARIA_TRANSACCION FOREIGN KEY 
    ( 
     id_transaccion
    ) 
    REFERENCES TRANSACCION 
    ( 
     id_transaccion
    ) 
;

ALTER TABLE ZONA 
    ADD CONSTRAINT FK_ZONA_FESTIVAL FOREIGN KEY 
    ( 
     id_festival
    ) 
    REFERENCES FESTIVAL 
    ( 
     id_festival
    ) 
;

CREATE OR REPLACE TRIGGER ARC_EXCLUSION_T_VENTA_PRIMARIA 
BEFORE INSERT OR UPDATE OF id_transaccion 
ON VENTA_PRIMARIA 
FOR EACH ROW 
DECLARE 
    d VARCHAR2 (20); 
BEGIN 
    SELECT A.tipo_transaccion INTO d 
    FROM TRANSACCION A 
    WHERE A.id_transaccion = :new.id_transaccion; 
    IF (d IS NULL OR d <> 'VENTA_PRIMARIA') THEN 
        raise_application_error(-20223,'FK FK_VENTA_PRIMARIA_TRANSACCION in Table VENTA_PRIMARIA violates Arc constraint on Table TRANSACCION - discriminator column tipo_transaccion doesn''t have value ''VENTA_PRIMARIA'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END;
/
