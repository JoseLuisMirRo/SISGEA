# SISGEA-UTEZ: Sistema de Gestión de Aulas

## Descripción General

El Sistema de Gestión de Uso de Aulas (SISGEA-UTEZ) es un proyecto desarrollado para la Universidad Tecnológica Emiliano Zapata (UTEZ) con el objetivo de optimizar la gestión de espacios dentro de la institución. El sistema permitirá a los administrativos, docentes y alumnos  cómputo y salones especiales, facilitando así el uso eficiente de estos recursos.realizar y consultar reservas de aulas, centros de

## Objetivo General

El objetivo principal del sistema es mejorar la gestión de los espacios de la UTEZ mediante un sistema de reservas intuitivo y eficiente. SISGEA-UTEZ permitirá a los usuarios visualizar la disponibilidad de espacios en tiempo real y realizar reservaciones, optimizando el uso de las instalaciones académicas.

## Alcance del Proyecto

### Requerimientos Funcionales

1. **Visualización de Disponibilidad de Espacios:**  
   - Todos los usuarios podrán ver la disponibilidad de espacios en forma de calendario y horario, filtrando por día, mes y año.

2. **Reserva de Espacios:**  
   - Los docentes podrán reservar espacios disponibles y editar o eliminar sus propias reservas.

3. **Integración con Horarios Académicos:**  
   - El sistema evitará superposiciones entre clases y reservas mediante la integración con los horarios académicos existentes.

4. **Registro de Actividades:**  
   - Se mantendrá un historial de todas las reservas realizadas.

5. **Funciones de Administración:**  
   - Un administrador podrá gestionar usuarios, horarios, espacios, reservas y días festivos (CRUD completo).

6. **Notificaciones:**  
   - Los docentes serán notificados por correo electrónico si un administrador cancela o modifica una reservación.

7. **Datos Precargados:**  
   - El sistema estará precargado con los horarios actuales de la División Académica de Tecnologías de la Información y Diseño, así como con los feriados oficiales.

8. **Seguridad:**  
   - Inicio de sesión mediante correo institucional.  
   - Tres roles: Administrador, Docente y Alumno.  
   - El administrador asigna las contraseñas, que no pueden ser modificadas por los usuarios.

### Requerimientos No Funcionales

- **Interfaz:**  
  Interfaz intuitiva y fácil de usar, similar a Google Calendar, diseñada para dispositivos de escritorio.

- **Escalabilidad:**  
  El sistema debe ser escalable para soportar un mayor número de usuarios y espacios en el futuro.

- **Seguridad:**  
  Las credenciales de usuario estarán cifradas para garantizar su seguridad.

- **Disponibilidad:**  
  El sistema estará disponible 24/7.

- **Usabilidad:**  
  Diseño basado en las 10 heurísticas de Jakob Nielsen para garantizar la usabilidad.

- **Alojamiento:**  
  El sistema estará alojado en un servidor web en la nube.

## Detalles
  - Versión de JDK: 17
  - Versión de Tomcat: 10.2.4
  - Uusario de prueba (root): 
      Correo: rootsisgea@utez.edu.mx
      Contraseña: soLSol60!*
