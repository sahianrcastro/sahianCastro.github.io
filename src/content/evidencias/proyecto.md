---
title: Proyecto
description: ReventaCero — aplicación web full-stack para la reventa autorizada y segura de boletas de festivales musicales.
order: 4
draft: false

project:
  title: "ReventaCero — Plataforma de Reventa Autorizada de Boletas"
  tagline: "Aplicación web full-stack para la reventa autorizada y segura de boletas de festivales musicales."
  summary:
    - "La reventa informal de boletas para festivales expone a los asistentes a fraudes, boletas duplicadas y sobreprecios. ReventaCero centraliza ese proceso: cada boleta queda asociada a un usuario y a un tipo de entrada con precio tope de reventa, y la reventa solo procede cuando un administrador la autoriza."
    - "El modelo de datos cubre el ciclo completo del festival: escenarios, presentaciones y artistas; zonas y tipos de entrada; emisión de boletas, transacciones (venta primaria y devolución), reventas autorizadas, lista de espera, control de acceso con dispositivos y notificaciones."
  stack:
    - Oracle Database
    - Java Spring Boot
    - Angular
    - Modelado E-R
    - Normalización 3FN
  architecture:
    - layer: Frontend
      tech: Angular
      description: "Interfaz web desde la que los usuarios consultan festivales, compran boletas y gestionan sus reventas."
    - layer: Backend
      tech: Java Spring Boot
      description: "Contiene la lógica de negocio (emisión, reventa autorizada, transacciones) y la expone al frontend."
    - layer: Base de datos
      tech: Oracle Database
      description: "Base de datos relacional diseñada a partir del MER y normalizada hasta 3FN."
  resources:
    - title: Repositorio en GitHub
      description: Código fuente del proyecto.
      url: https://github.com/0hsamm/ReventaCero
      kind: github
    - title: Documentación completa
      description: Carpeta del proyecto en Google Drive.
      url: https://drive.google.com/drive/folders/1hab9J9t9gyghHvcXroEF64s33l727gbJ?usp=sharing
      kind: folder
    - title: Diagrama de clases del backend
      description: Diagrama de clases en Google Drive.
      url: https://drive.google.com/file/d/12Szj7T6BgMzV7sdwnJkLpkIfnMs7XC9i/view
      kind: diagram

items:
  - title: "Modelo Entidad-Relación (MER) de ReventaCero"
    description: "Modelo conceptual en notación de Peter Chen. Su núcleo es BOLETA, que se emite por TIPO_ENTRADA (con precio_tope_reventa), pertenece a un USUARIO y puede pasar a REVENTA_AUTORIZADA con aprobación de un ADMINISTRADOR. Incluye la especialización de TRANSACCIÓN en VENTA_PRIMARIA y DEVOLUCIÓN, entidades débiles como ESCENARIO, atributos multivaluados, compuestos y derivados, y la agregación INSCRIPCIÓN para la lista de espera."
    image: /images/evidencias/proyecto/reventacero-mer.png
    preview: /images/evidencias/proyecto/reventacero-mer-preview.webp
    alt: "Modelo Entidad-Relación de ReventaCero en notación de Peter Chen"
    tags:
      - Notación Peter Chen
      - MER
      - Cardinalidades
      - Especialización
      - Agregación
      - Entidades débiles
    links:
      - label: Abrir original en Drive
        url: https://drive.google.com/file/d/1Z6h4dwBQW_yuBFUO_eZi6ZgMGMwIEbxK/view?usp=sharing
---
