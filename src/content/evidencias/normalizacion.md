---
title: Normalización
description: Taller de normalización (1FN → 2FN → 3FN) con dos casos prácticos — Clínica y Tienda.
order: 2
draft: false

downloads:
  - label: Descargar taller original .xlsx
    url: /documentos/taller-normalizacion.xlsx

# Cómo marcar las columnas de cada tabla:
#   "pk:Columna"   → llave primaria
#   "fk:Columna"   → llave foránea
#   "pkfk:Columna" → llave primaria y foránea a la vez
#   "Columna"      → atributo normal
exercises:
  - title: "Punto 1 — Clínica (CITA_CLINICA)"
    summary: "Registro de citas médicas con datos del paciente, del doctor y del consultorio en una sola tabla."
    steps:
      - label: Tabla sin normalizar
        rule: "Tabla original del taller: toda la información de la cita, del paciente, del doctor y del consultorio vive en una única relación."
        tables:
          - name: CITA_CLINICA
            columns: [ID_Cita, Fecha_Cita, Hora_Cita, ID_Paciente, Nombre_Paciente, Teléfono_Paciente, ID_Doctor, Nombre_Doctor, Especialidad_Doctor, Consultorio_Asignado, Piso_Consultorio, Diagnóstico, Tratamiento_Recomendado]
      - label: 1FN
        status: Ya se cumple
        rule: "1FN exige valores atómicos y ausencia de grupos repetitivos. Cada celda guarda un único dato y la tabla se identifica con la llave primaria ID_Cita."
        analysis: "Ya se cumple 1FN porque cada casilla tiene un solo dato, no hay nada que corregir."
        tables:
          - name: CITA_CLINICA
            columns: [pk:ID_Cita, Fecha_Cita, Hora_Cita, ID_Paciente, Nombre_Paciente, Teléfono_Paciente, ID_Doctor, Nombre_Doctor, Especialidad_Doctor, Consultorio_Asignado, Piso_Consultorio, Diagnóstico, Tratamiento_Recomendado]
      - label: 2FN
        status: Ya se cumple
        rule: "2FN exige que todo atributo no clave dependa de la llave completa. Con una llave simple (ID_Cita) no pueden existir dependencias parciales."
        analysis: "Ya se cumple 2FN porque la clave es solo ID_Cita, entonces no pueden haber dependencias parciales, no hay nada que corregir."
        tables:
          - name: CITA_CLINICA
            columns: [pk:ID_Cita, Fecha_Cita, Hora_Cita, ID_Paciente, Nombre_Paciente, Teléfono_Paciente, ID_Doctor, Nombre_Doctor, Especialidad_Doctor, Consultorio_Asignado, Piso_Consultorio, Diagnóstico, Tratamiento_Recomendado]
      - label: 3FN
        status: Se corrige
        rule: "3FN elimina las dependencias transitivas (ID_Cita → ID_Paciente → Nombre_Paciente). Cada determinante (ID_Paciente, ID_Doctor, Consultorio_Asignado) pasa a ser llave primaria de su propia tabla y en CITA queda como llave foránea."
        problem:
          - "Hay dependencias transitivas, las cuales son los datos del paciente, del doctor y del consultorio, que no dependen de la cita sino de su propio ID."
        consequence:
          - "Los datos de los pacientes, doctores y consultorios se repetirían en todas las citas y, si se quisiera actualizar algún dato de esos, sería necesario actualizar todas las citas registradas."
        dependencies:
          - "ID_Paciente → Nombre_Paciente, Teléfono_Paciente"
          - "ID_Doctor → Nombre_Doctor, Especialidad_Doctor"
          - "Consultorio_Asignado → Piso_Consultorio"
          - "ID_Cita → Fecha_Cita, Hora_Cita, ID_Doctor, ID_Paciente, Consultorio_Asignado, Diagnóstico, Tratamiento_Recomendado"
        analysis: "Al separar PACIENTE, DOCTOR y CONSULTORIO se eliminaron las dependencias parciales; además, teniendo en cuenta el esquema de la 2FN, también se eliminaron las dependencias transitivas, pasando directamente a 3FN."
        tables:
          - name: PACIENTE
            columns: [pk:ID_Paciente, Nombre_Paciente, Teléfono_Paciente]
          - name: DOCTOR
            columns: [pk:ID_Doctor, Nombre_Doctor, Especialidad_Doctor]
          - name: CONSULTORIO
            columns: [pk:Consultorio_Asignado, Piso_Consultorio]
          - name: CITA
            columns: [pk:ID_Cita, Fecha_Cita, Hora_Cita, fk:ID_Doctor, fk:ID_Paciente, fk:Consultorio_Asignado, Diagnóstico, Tratamiento_Recomendado]

  - title: "Punto 2 — Tienda (VENTA_SUCURSAL)"
    summary: "Registro de ventas por sucursal con productos y vendedores en una sola tabla."
    steps:
      - label: Tabla sin normalizar
        rule: "Tabla original del taller: cada fila mezcla datos de la venta, la sucursal, el producto y el vendedor."
        tables:
          - name: VENTA_SUCURSAL
            columns: [ID_Venta, Fecha_Venta, ID_Sucursal, Nombre_Sucursal, Ciudad_Sucursal, ID_Producto, Nombre_Producto, Categoría_Producto, Precio_Unitario, Cantidad_Vendida, ID_Vendedor, Nombre_Vendedor, Comisión_Vendedor]
      - label: 1FN
        status: Ya se cumple
        rule: "1FN exige valores atómicos y sin grupos repetitivos. Como una venta incluye varios productos, la llave primaria es compuesta: (ID_Venta, ID_Producto)."
        analysis: "Ya se cumple 1FN porque cada casilla tiene un solo dato, no hay nada que corregir."
        tables:
          - name: VENTA_SUCURSAL
            columns: [pk:ID_Venta, Fecha_Venta, ID_Sucursal, Nombre_Sucursal, Ciudad_Sucursal, pk:ID_Producto, Nombre_Producto, Categoría_Producto, Precio_Unitario, Cantidad_Vendida, ID_Vendedor, Nombre_Vendedor, Comisión_Vendedor]
      - label: 2FN
        status: Se corrige
        rule: "2FN elimina las dependencias parciales: atributos que dependen solo de una parte de la llave compuesta. Los datos del producto pasan a PRODUCTO, los de la venta a VENTA, y Cantidad_Vendida, que sí depende de la llave completa, queda en PRODUCTO_VENTA."
        problem:
          - "Existen dependencias parciales respecto a la clave primaria compuesta (ID_Venta, ID_Producto)."
          - "ID_Venta → Fecha_Venta, ID_Sucursal, ID_Vendedor"
          - "ID_Producto → Nombre_Producto, Categoría_Producto, Precio_Unitario"
        consequence:
          - "Los datos del producto se repetirían en todas las ventas en las que esté relacionado; también se repetirían datos generales de una venta por cada producto que se incluye."
          - "Al querer cambiar un precio se requeriría actualizar muchas filas."
        dependencies:
          - "ID_Producto → Nombre_Producto, Categoría_Producto, Precio_Unitario"
          - "(ID_Venta, ID_Producto) → Cantidad_Vendida"
          - "ID_Venta → Fecha_Venta, ID_Sucursal, Nombre_Sucursal, Ciudad_Sucursal, ID_Vendedor, Nombre_Vendedor, Comisión_Vendedor"
        analysis: "Al separar PRODUCTO y PRODUCTO_VENTA se eliminaron las dependencias parciales. El esquema ya tiene 2FN pero aún tiene dependencias transitivas."
        tables:
          - name: PRODUCTO
            columns: [pk:ID_Producto, Nombre_Producto, Categoría_Producto, Precio_Unitario]
          - name: PRODUCTO_VENTA
            columns: [pk:ID_Venta, pk:ID_Producto, Cantidad_Vendida]
          - name: VENTA
            columns: [pk:ID_Venta, Fecha_Venta, Cantidad_Vendida, ID_Vendedor, Nombre_Vendedor, Comisión_Vendedor, ID_Sucursal, Nombre_Sucursal, Ciudad_Sucursal]
      - label: 3FN
        status: Se corrige
        rule: "3FN elimina las dependencias transitivas (ID_Venta → ID_Sucursal → Nombre_Sucursal). SUCURSAL y VENDEDOR pasan a tablas propias y en VENTA quedan ID_Sucursal e ID_Vendedor como llaves foráneas. En PRODUCTO_VENTA, ID_Venta e ID_Producto son a la vez llave primaria compuesta y llaves foráneas."
        problem:
          - "Existen dependencias transitivas que aún no se solucionan."
          - "ID_Venta → ID_Sucursal → Nombre_Sucursal, Ciudad_Sucursal"
          - "ID_Venta → ID_Vendedor → Nombre_Vendedor, Comisión_Vendedor"
        consequence:
          - "Si se cambia el nombre de una sucursal o la comisión de un vendedor, se deben actualizar todas las ventas relacionadas, lo que podría generar anomalías de actualización."
        dependencies:
          - "ID_Producto → Nombre_Producto, Categoría_Producto, Precio_Unitario"
          - "ID_Sucursal → Nombre_Sucursal, Ciudad_Sucursal"
          - "ID_Vendedor → Nombre_Vendedor, Comisión_Vendedor"
          - "ID_Venta → Fecha_Venta, ID_Sucursal, ID_Vendedor"
          - "(ID_Venta, ID_Producto) → Cantidad_Vendida"
        analysis: "Al separar SUCURSAL y VENDEDOR, los atributos dejan de depender de atributos no clave; el esquema final cumple con 3FN."
        tables:
          - name: PRODUCTO
            columns: [pk:ID_Producto, Nombre_Producto, Categoría_Producto, Precio_Unitario]
          - name: PRODUCTO_VENTA
            columns: [pkfk:ID_Venta, pkfk:ID_Producto, Cantidad_Vendida]
          - name: SUCURSAL
            columns: [pk:ID_Sucursal, Nombre_Sucursal, Ciudad_Sucursal]
          - name: VENDEDOR
            columns: [pk:ID_Vendedor, Nombre_Vendedor, Comisión_Vendedor]
          - name: VENTA
            columns: [pk:ID_Venta, Fecha_Venta, fk:ID_Vendedor, fk:ID_Sucursal]

comparison:
  title: Comparación de los dos casos
  headers: [Aspecto, Clínica, Tienda]
  rows:
    - [Tabla original, CITA_CLINICA, VENTA_SUCURSAL]
    - [Clave principal, "ID_Cita; además hay claves candidatas compuestas según DF5, DF6 y DF7.", "(ID_Venta, ID_Producto)"]
    - [Forma normal inicial, "1FN; no cumple 2FN al considerar las claves candidatas compuestas.", "1FN; no cumple 2FN."]
    - [Problema principal, "Dependencias parciales y transitivas de paciente, doctor y consultorio.", "Dependencias parciales de venta y producto, además de dependencias transitivas de sucursal y vendedor."]
    - [Paso a 2FN, "Se separan PACIENTE, DOCTOR y CONSULTORIO de CITA.", "Se separan PRODUCTO, PRODUCTO_VENTA y VENTA_2FN."]
    - ["¿Necesita paso adicional a 3FN?", "No. La descomposición a 2FN también elimina las dependencias transitivas.", "Sí. Se separan SUCURSAL y VENDEDOR de VENTA_2FN."]
    - [Tablas finales, "PACIENTE, DOCTOR, CONSULTORIO y CITA.", "PRODUCTO, SUCURSAL, VENDEDOR, VENTA y PRODUCTO_VENTA."]
    - [Anomalías eliminadas, "Repetición y pérdida de datos de pacientes, doctores y consultorios.", "Repetición de precios, datos de sucursal y comisiones de vendedores."]
    - [Beneficio final, "Cada cita referencia al paciente, doctor y consultorio correctos sin repetir sus datos.", "Cada venta se separa de sus productos, sucursal y vendedor, reduciendo inconsistencias."]
---
