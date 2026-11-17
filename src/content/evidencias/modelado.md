---
title: Modelado
description: Espacio para los diagramas y modelos de datos de la asignatura.
order: 1
draft: false
# Cada elemento de "items" es una tarjeta de evidencia.
# Las rutas de "image" y "preview" son relativas a la carpeta public/.
items:
  - title: "GestInvestiga — Gestión de Investigación y Proyectos (MER → MR)"
    description: "Sistema de investigación con participantes, proyectos, sedes, laboratorios y equipos. El MER usa una jerarquía de dos niveles (PARTICIPANTE → INVESTIGADOR / ESTUDIANTE_BECARIO → JUNIOR / SENIOR), la agregación COLABORACIÓN, la relación ternaria Usar y entidades débiles en cascada (SEDE → LABORATORIO → EQUIPO_LABORATORIO). En el MR, las relaciones M:N y la ternaria pasan a entidades intermedias (INV-PRO, PAR-PRO, PRO-EQU-INV) y los atributos multivaluados a entidades propias (CORREO, TELÉFONO)."
    image: /images/evidencias/modelado/gestinvestiga-mer-a-mr.png
    preview: /images/evidencias/modelado/gestinvestiga-mer-a-mr-preview.webp
    alt: "Diagrama MER del sistema GestInvestiga y su transformación al Modelo Relacional en notación de Peter Chen"
    tags:
      - Notación Peter Chen
      - MER
      - Modelo Relacional
      - Cardinalidades
      - Especialización
      - Agregación
      - Relación ternaria
      - Entidades débiles
    links:
      - label: Documentación (PDF)
        url: /documentos/gestinvestiga-documentacion.pdf
      - label: Diagrama en Google Drive
        url: https://drive.google.com/file/d/1rNpqls5EwgVMVG80I4T3S52G8mUF8sg4/view?usp=sharing
  - title: "Hospital — Pacientes, pabellones y personal (MER → MR)"
    description: "Parte de un MER con Patient, Ward, Medicine, Consultant y Nurse (con especialización ISA en General Nurse y Ward Nurse) y lo transforma en el MR con PACIENTE, PABELLÓN, MEDICINA, MÉDICO, ENFERMERA(O) GENERAL y JEFE PABELLÓN. La jerarquía se resuelve en entidades separadas y las relaciones 1:M/M:1 (Comprar, Asignar, Atender, Mandar) se representan con llaves foráneas como id_pabellón e id_médico."
    image: /images/evidencias/modelado/hospital-mer-a-mr.png
    preview: /images/evidencias/modelado/hospital-mer-a-mr-preview.webp
    alt: "MER de un hospital y su transformación al Modelo Relacional en notación de Peter Chen"
    tags:
      - Notación Peter Chen
      - MER
      - Modelo Relacional
      - Cardinalidades
      - Especialización
      - Llaves foráneas
  - title: "Torneo de fútbol — Tabla de posiciones (MER)"
    description: "Relaciona PROGRAMA ACADÉMICO, JUGADOR, EQUIPO y PARTIDO, con TARJETA y TABLA como entidades débiles (relaciones identificadoras Registrar y Pertenecer). Incluye atributos multivaluados (documento, contacto, uniforme), compuestos (nombre_completo, historial_partidos) y derivados (edad), con cardinalidades 1:N y M:N."
    image: /images/evidencias/modelado/torneo-futbol-mer.png
    preview: /images/evidencias/modelado/torneo-futbol-mer-preview.webp
    alt: "MER de un torneo de fútbol con jugadores, equipos, partidos, tarjetas y tabla de posiciones en notación de Peter Chen"
    tags:
      - Notación Peter Chen
      - MER
      - Cardinalidades
      - Entidades débiles
      - Atributos multivaluados
      - Atributos derivados
---
