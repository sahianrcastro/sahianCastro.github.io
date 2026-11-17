# ReventaCero — Scripts SQL

Proyecto BD1-2026-RC. Bases de Datos 1, Universidad El Bosque.

Esta entrega contiene la creación del esquema de 25 tablas suministrado,
37 inserciones de datos ficticios y 17 consultas básicas. Los importes están
en pesos colombianos (COP) y las fechas y horas corresponden a Colombia (UTC-5).

## Contenido

| Archivo | Contenido |
| --- | --- |
| 01_creacion_objetos.sql | CREATE TABLE, ALTER TABLE y el disparador incluido en el SQL original. |
| 02_insercion_datos.sql | 37 INSERT sobre las 25 tablas y COMMIT al final. |
| 03_consultas_varias.sql | 17 consultas con SELECT, WHERE, JOIN y ORDER BY. |

## Requisitos

- Oracle Database en edición gratuita XE o Free. SQL Developer es el cliente.
- Un esquema de pruebas vacío y exclusivo para esta entrega. No ejecutar como SYS ni SYSTEM.
- El usuario del esquema debe tener CREATE SESSION, CREATE TABLE, CREATE TRIGGER
  y cuota suficiente en su tablespace, asignados previamente por el administrador.
- Los tres archivos SQL están codificados en UTF-8. Abrirlos con esa codificación
  para conservar tildes y caracteres del texto.

## Orden de ejecución en Oracle SQL Developer

1. Descomprimir el ZIP. Los cuatro archivos deben quedar en la misma carpeta.
2. Abrir SQL Developer y conectarse al esquema de pruebas vacío.
3. Abrir `01_creacion_objetos.sql`, seleccionar esa conexión y pulsar **F5 / Run Script**.
   Esperar a que termine y revisar **Script Output / Salida de script**. Se deben
   crear las 25 tablas, sus restricciones y el disparador sin errores.
4. Si el primer script terminó sin errores, abrir `02_insercion_datos.sql` con la
   misma conexión y pulsar **F5**. El orden de los INSERT respeta las claves
   foráneas. El COMMIT final confirma los datos de demostración.
5. Si la carga terminó sin errores, abrir `03_consultas_varias.sql` y pulsar **F5**
   para ver todas las consultas y resultados en la salida de script. También se
   puede seleccionar una consulta completa y pulsar **Ctrl+Enter** para ver su
   resultado individual en la cuadrícula de SQL Developer.

No volver a ejecutar los dos primeros scripts sobre el mismo esquema poblado:
la creación repetiría nombres de objetos y la carga repetiría claves primarias.
Si aparece un error, detenerse y revisar su mensaje antes de continuar. El DDL
de Oracle realiza confirmaciones implícitas; un ROLLBACK no elimina las tablas
ya creadas. Para repetir la demostración, utilizar otro esquema vacío.

## Datos de demostración

Los registros incluyen cuatro usuarios ficticios, un festival, dos zonas,
un escenario, dos artistas y dos presentaciones consecutivas sin cruces.
La boleta 1001 tiene tres movimientos: venta primaria a Ana, devolución y
reventa a Diego. El ingreso simulado ocurre después de la reventa. También
se incluyen patrocinio, lista de espera, inscripción y notificación.

- En estos ejemplos, `DISPOSITIVO.activo = 1` representa un dispositivo activo.
- Las contraseñas se dejan NULL; los registros no habilitan autenticación.
- `BOLETA.comprador_documento` conserva a la compradora inicial en estos datos.
  El nuevo comprador se registra en `REVENTA_AUTORIZADA`; las consultas no
  presentan el comprador inicial como titular actual después de la reventa.
- La comisión de 10000 COP y el reembolso del 100 % son datos de ejemplo,
  no políticas generales del proyecto.
- Las fechas sin hora se escriben con `DATE 'AAAA-MM-DD'`. Para las fechas
  con hora se utiliza `TO_DATE` con su formato explícito.

## Alcance y comprobación

Las sentencias originales de creación se conservan completas. Se añade `/`
en una línea independiente al terminar el disparador para ejecutarlo con F5.
Las inserciones y consultas utilizan exactamente las tablas y columnas de
ese esquema. Las consultas evitan TRUNC, subconsultas y funciones analíticas.

Las PK, FK, UNIQUE, CHECK y el disparador son los suministrados en la creación.
Esta entrega no incorpora los mecanismos completos de aforo, no solapamiento,
identidad y reventa previstos para la implementación del proyecto; conservar
estos ejemplos no equivale a implementar todas esas reglas.

Se revisaron la estructura del ZIP, la conservación del SQL original, los
nombres de tablas y columnas y el orden de dependencias de las inserciones.
Estos scripts no se ejecutaron contra una instancia Oracle en esta entrega.
La ejecución en SQL Developer permite obtener la evidencia de funcionamiento.
