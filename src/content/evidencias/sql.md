---
title: SQL
description: Scripts Oracle SQL de ReventaCero — DDL, inserción de datos de prueba y consultas.
order: 3
draft: false

downloads:
  - label: Descargar scripts .sql (ZIP)
    url: /documentos/reventacero-sentencias-sql.zip

# Los scripts se leen directamente de public/documentos/sql/.
# "lines: [desde, hasta]" toma ese rango de líneas del archivo.
# mode "queries" separa cada consulta usando su comentario como título;
# filter "basic" = consultas sin JOIN, "join" = consultas con JOIN.
sql:
  intro:
    - "Estos scripts corresponden al diseño físico de la base de datos de ReventaCero, nuestra plataforma de reventa autorizada de boletas: la creación de las tablas con sus restricciones (PK, FK, UNIQUE, CHECK y un disparador), la inserción de datos de prueba y las consultas sobre esos datos."
    - "Están escritos para Oracle Database (XE / Free) y se ejecutan en orden desde Oracle SQL Developer con F5 (Run Script). Los importes están en pesos colombianos (COP) y las fechas en hora de Colombia (UTC-5)."
  facts:
    - value: "25"
      label: tablas
    - value: "37"
      label: inserciones
    - value: "17"
      label: consultas
    - value: "1"
      label: disparador
  groups:
    - title: "1. DDL — Creación de tablas y restricciones"
      description: "01_creacion_objetos.sql · Define las 25 tablas del esquema con sus llaves primarias, restricciones UNIQUE y CHECK, las llaves foráneas y el disparador que valida la especialización de TRANSACCIÓN."
      file: /documentos/sql/01_creacion_objetos.sql
      sections:
        - title: "Tablas, llaves primarias, UNIQUE y CHECK"
          description: "CREATE TABLE de cada entidad seguido de su ALTER TABLE … ADD CONSTRAINT."
          lines: [1, 328]
        - title: "Llaves foráneas (integridad referencial)"
          description: "ALTER TABLE … ADD CONSTRAINT … FOREIGN KEY que conectan las tablas según el modelo relacional."
          lines: [330, 695]
        - title: "Disparador ARC_EXCLUSION_T_VENTA_PRIMARIA"
          description: "Impide registrar una VENTA_PRIMARIA si la TRANSACCIÓN asociada no tiene tipo_transaccion = 'VENTA_PRIMARIA'."
          lines: [697, 716]
    - title: "2. DML — Inserción de datos de prueba"
      description: "02_insercion_datos.sql · 37 INSERT ficticios en un orden que respeta las llaves foráneas: usuarios, festival, zonas, escenario, artistas, tipos de entrada y la boleta 1001 con su venta primaria, devolución y reventa autorizada. Termina con COMMIT."
      file: /documentos/sql/02_insercion_datos.sql
      sections:
        - title: "Inserción de datos de demostración"
    - title: "3. Consultas básicas — SELECT, WHERE y ORDER BY"
      description: "03_consultas_varias.sql · Consultas sobre una sola tabla con filtros y ordenamiento. Cada una indica el requerimiento funcional (RF) que atiende."
      file: /documentos/sql/03_consultas_varias.sql
      mode: queries
      filter: basic
    - title: "4. Consultas con JOIN"
      description: "03_consultas_varias.sql · Consultas que combinan varias tablas, incluida una autorrelación sobre GENERO para obtener cada subgénero con su género principal."
      file: /documentos/sql/03_consultas_varias.sql
      mode: queries
      filter: join
---
