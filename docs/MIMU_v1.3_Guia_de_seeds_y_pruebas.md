# MIMU v1.3 — Guía de seeds, cuentas de prueba y flujos

**Versión:** 1.0  
**Propósito:** documentar el escenario de demostración, las cuentas ficticias, sus credenciales de desarrollo y los flujos manuales para probar Mimu v1.3.  
**Entorno objetivo:** base de datos local o de desarrollo.  
**Institución demo:** Centro Infantil Arcoíris (`DEMO-ARCOIRIS`).

> **Advertencia de seguridad:** todas las cuentas y los datos de este documento son ficticios. La contraseña compartida es conocida y está incluida en los archivos SQL. Úsala solamente en un entorno local/de desarrollo aislado. Nunca despliegues estas cuentas ni esta contraseña en producción.

## 1. Alcance del escenario

El seed crea una institución activa en la zona horaria `America/Panama`, usuarios para los cuatro roles oficiales, estructura académica, estudiantes, relaciones familiares y datos de actividad y comunicación.

### 1.1 Institución y estructura académica

- Institución: **Centro Infantil Arcoíris**.
- Código: `DEMO-ARCOIRIS`.
- Zona horaria: `America/Panama`.
- Niveles: Maternal, Prekínder y Prekínder avanzado.
- Grupos: Estrellitas, Exploradores y Pequeños Científicos.
- Período: Año lectivo 2026.
- Materias: Comunicación y lenguaje, Pensamiento lógico, Arte y creatividad.

### 1.2 Estudiantes y familia

| Estudiante | Código interno | Grupo | Vínculos familiares de prueba |
|---|---|---|---|
| Lucía Morales | `LUC-001` | Exploradores | Ana Morales es su tutora principal; Carlos Morales también está vinculado |
| Mateo Morales | `MAT-002` | Estrellitas | Ana Morales es su tutora principal |
| Sofía Castillo | `SOF-003` | Pequeños Científicos | Carlos Morales es su tutor principal |

Los datos personales y de salud son ficticios. En particular, el dato de alergia de Mateo es un dato de demostración y no debe interpretarse como información real.

## 2. Cuentas de prueba

### 2.1 Credenciales compartidas

Todas las cuentas demo del paquete utilizan la siguiente contraseña local:

```text
MimuDemo-2026!
```

Los hashes de `credentials.password_hash` son Argon2id, con los parámetros documentados en el README del paquete (`time_cost=3`, `memory_cost=65536 KiB`, `parallelism=4`). La API debe poder verificar esos hashes. Si la configuración de Argon2id de la API no coincide, regenera los hashes con la misma biblioteca y configuración que use el backend.

### 2.2 Tabla de usuarios

| Nombre | Username / correo de inicio de sesión | Rol | Uso principal | Estado de acceso sembrado |
|---|---|---|---|---|
| Ana Morales | `ana.morales@demo.mimu.example` | `PARENT_GUARDIAN` | Tutora de Lucía y Mateo; probar selector de estudiante | Lista para Home |
| Carlos Morales | `carlos.morales@demo.mimu.example` | `PARENT_GUARDIAN` | Tutor de Lucía y Sofía; probar vínculos compartidos | Lista para Home |
| María Gómez | `maria.gomez@demo.mimu.example` | `TEACHER` | Educadora asignada a Comunicación y lenguaje | Lista para Home/portal docente |
| Daniel Ríos | `daniel.rios@demo.mimu.example` | `TEACHER` | Segundo escenario docente: primer acceso obligatorio | **Primer acceso pendiente** |
| Isabel Vega | `isabel.vega@demo.mimu.example` | `SCHOOL_ADMIN` | Administración escolar de Centro Infantil Arcoíris | Lista para Home/portal administrativo |
| Sofía Pérez | `sofia.perez@demo.mimu.example` | `MIMU_SUPPORT_ADMIN` | Probar rol global de soporte de plataforma | Lista para Home según autorización de la API |

**Username:** en estos seeds es el correo completo.  
**Contraseña:** `MimuDemo-2026!` para todas las cuentas.  
**Dominio:** `.example` es un dominio reservado para ejemplos; estos correos no representan buzones reales.

### 2.3 Qué significa “lista para Home”

En las cuentas listas para Home, `users.must_change_password = false`, `users.terms_accepted = true` y existe una fila de aceptación para la versión demo vigente de términos en `terms_acceptances`. La API debe comprobar la evidencia de aceptación vigente; la bandera por sí sola no la sustituye.

En la cuenta de primer acceso de Daniel Ríos, `must_change_password = true` y `terms_accepted = false`. El flujo esperado es cambiar la contraseña primero y aceptar los términos después. El seed no crea sesiones de renovación ni tokens de recuperación.

## 3. Archivos y orden de ejecución

Ejecutar solamente en una base de desarrollo limpia. Usa el rol propietario/migrador, no el rol runtime `mimu_app`.

1. Aplicar `01-schema.sql`.
2. Aplicar `V004__seed_rbac_catalog.sql` como migración versionada. Ajustar `V004` al historial real de migraciones del proyecto.
3. Ejecutar `00-demo-identity.sql`.
4. Ejecutar `01-demo-academic.sql`.
5. Ejecutar `02-demo-activity.sql`.
6. Ejecutar `03-demo-communications.sql`.
7. Ejecutar `99-validate-demo-data.sql` y revisar cada resultado.

Los archivos demo dependen del catálogo RBAC y de las claves insertadas en los archivos anteriores. El paquete no es idempotente: no lo ejecutes dos veces sobre los mismos registros. Para repetir la prueba, recrea la base local o elimina el conjunto demo de forma controlada.

## 4. Datos funcionales que deben verse en la interfaz

### 4.1 Notas

- Hay calificaciones publicadas que deben poder consultar los tutores autorizados.
- Hay una calificación en borrador con `published_at = NULL`; no debe aparecer en la vista del tutor.
- La lectura de una nota publicada se registra por tutor en `grade_reads`.
- Editar una nota ya publicada debe actualizar su contenido sin retirar `published_at`.

### 4.2 Tareas

- Hay tareas publicadas con asignaciones individuales para estudiantes.
- Existen asignaciones `PENDING` y `SUBMITTED`.
- También hay una tarea en borrador que no debe aparecer como publicada para los tutores.
- Al revertir una tarea a `PENDING`, la API debe limpiar `submitted_at`; al marcarla `SUBMITTED`, debe establecerlo.

### 4.3 Asistencia y seguimiento diario

Se incluyen registros de asistencia y seguimiento diario con estados variados para mostrar historial y tarjetas de Home. La fecha de “hoy” debe interpretarse con `institutions.time_zone`, no suponiendo que el reloj del servidor está en la misma zona horaria.

### 4.4 Avisos, eventos, mensajes y notificaciones

- Hay avisos publicados y un aviso en borrador.
- Hay eventos publicados para el calendario, con destinatarios institucionales o por grupo.
- Hay mensajes/comunicados publicados para la institución o un grupo.
- Hay registros de lectura y notificaciones leídas/no leídas.
- No se debe implementar chat ni notificaciones push por este seed: ambos quedan fuera del MVP actual.

## 5. Flujos de prueba manuales

### Prueba A — Login listo para usar

**Cuenta:** `ana.morales@demo.mimu.example`  
**Contraseña:** `MimuDemo-2026!`

1. Iniciar sesión.
2. Confirmar que no se solicite cambio obligatorio de contraseña.
3. Confirmar que no se solicite de nuevo la aceptación de los términos demo vigentes.
4. Verificar que se abra Home y se muestre la lista de estudiantes vinculados.

**Resultado esperado:** acceso normal, sujeto a que la API valide estado de cuenta, membresía, rol y aceptación vigente.

### Prueba B — Primer acceso

**Cuenta:** `daniel.rios@demo.mimu.example`  
**Contraseña inicial:** `MimuDemo-2026!`

1. Iniciar sesión.
2. La API debe exigir el cambio de contraseña y no permitir el acceso normal a Home todavía.
3. Cambiar la contraseña mediante el flujo real de la aplicación. El nuevo valor debe ser exclusivo del entorno de prueba y no debe guardarse en este documento.
4. Una vez completado el cambio, la API debe solicitar la aceptación de los términos vigentes si no existe una aceptación válida.
5. Aceptar los términos demo.
6. Confirmar que la API actualiza de forma coherente `must_change_password`, `terms_accepted` y `terms_acceptances`.
7. Volver a iniciar sesión y verificar el acceso normal permitido por el rol docente.

**Resultado esperado:** el orden es cambio de contraseña y luego aceptación de términos. No debe ser posible saltarse ninguno de los pasos.

> Si la aplicación no dispone todavía de una interfaz funcional para el cambio de contraseña o la aceptación de términos, este caso sirve como prueba de integración pendiente; no debe simularse marcando las banderas directamente desde el cliente.

### Prueba C — Selector de estudiante y aislamiento de Home

**Cuenta:** `ana.morales@demo.mimu.example`

1. Abrir Home y seleccionar a Lucía Morales.
2. Revisar tareas pendientes, notas nuevas, mensajes no leídos, asistencia, seguimiento diario y próximo evento.
3. Cambiar a Mateo Morales.
4. Comparar los datos y contadores.
5. Intentar consultar desde la API el `student_id` de Sofía Castillo, que no está vinculada a Ana.

**Resultado esperado:** los datos y contadores se recalculan para el estudiante seleccionado. La API debe rechazar o denegar la consulta de un estudiante no vinculado, aunque el cliente conozca su UUID.

### Prueba D — Familia con tutores compartidos

1. Iniciar sesión como Ana y comprobar que aparecen Lucía y Mateo.
2. Iniciar sesión como Carlos y comprobar que aparecen Lucía y Sofía.
3. Confirmar que Lucía puede estar vinculada a ambos tutores, pero que cada tutor tiene su propio estado de lectura de notas.
4. Abrir un comunicado aplicable a ambos tutores y verificar que la lectura se registra por usuario, no globalmente para toda la familia.

**Resultado esperado:** las relaciones familiares no conceden acceso a todos los estudiantes del centro. Cada tutor solo ve estudiantes y registros autorizados.

### Prueba E — Publicación de calificaciones

**Cuenta sugerida:** `maria.gomez@demo.mimu.example` o `daniel.rios@demo.mimu.example` después de completar el primer acceso.

1. Abrir una evaluación asignada a un grupo autorizado.
2. Guardar una nota como borrador y comprobar que el tutor no la ve.
3. Publicar la nota y confirmar que ahora aparece para el tutor del estudiante correspondiente.
4. Iniciar sesión como tutor y abrir la nota; confirmar que se registra la lectura individual en `grade_reads`.
5. Editar una nota ya publicada y comprobar que el cambio aparece sin volver a publicarla.

**Resultado esperado:** una nota solo se muestra si está publicada y el usuario tiene acceso al estudiante.

### Prueba F — Estado de tareas

1. Iniciar sesión como educador con asignación al grupo.
2. Abrir una tarea publicada y cambiar una asignación de `PENDING` a `SUBMITTED`.
3. Confirmar que se registra `submitted_at`.
4. Revertirla a `PENDING`.
5. Confirmar que `submitted_at` vuelve a `NULL`.
6. Iniciar sesión como tutor y verificar que el estado visible coincide con el estado individual de su estudiante.
7. Intentar cambiar el estado como tutor; la API debe denegar la operación.

**Resultado esperado:** el cambio de estado solo está disponible para personal autorizado y se mantiene la coherencia entre estado y fecha.

### Prueba G — Audiencias de comunicaciones

1. Como tutor, abrir los mensajes institucionales.
2. Cambiar el estudiante seleccionado y comprobar los comunicados dirigidos a su grupo o a ese estudiante.
3. Confirmar que no aparecen comunicados dirigidos exclusivamente a un grupo ajeno.
4. Marcar un comunicado como leído y verificar el contador de mensajes no leídos.
5. Comprobar que un borrador no aparece como publicado.

**Resultado esperado:** la API combina institución, audiencia, matrícula, estudiante seleccionado y usuario autenticado para determinar visibilidad.

### Prueba H — Roles y autorización

- `PARENT_GUARDIAN`: solo consulta estudiantes vinculados y datos autorizados; no escribe asistencia ni cambia estados de tareas.
- `TEACHER`: opera únicamente en grupos, materias y períodos asignados.
- `SCHOOL_ADMIN`: administra los datos escolares de su institución.
- `MIMU_SUPPORT_ADMIN`: tiene alcance global de plataforma según las reglas de la API; el rol no implica que existan módulos avanzados de soporte en el MVP.

Probar tanto las acciones permitidas como las denegadas. La presencia de un rol en el token no reemplaza la comprobación de institución, recurso y relación con el estudiante.

### Prueba I — Validaciones de integridad

Ejecutar `99-validate-demo-data.sql` después de insertar todos los seeds. Revisar:

- que exista una institución `DEMO-ARCOIRIS`;
- que existan los cuatro roles requeridos;
- que estén los usuarios y estudiantes demo;
- que ningún estudiante tenga matrículas activas duplicadas;
- que las tareas no mezclen `PENDING` con `submitted_at` no nulo ni `SUBMITTED` con `submitted_at` nulo;
- que las cuentas listas para Home tengan evidencia de aceptación de términos vigente;
- que cada estudiante activo tenga un tutor principal activo.

Las consultas de conteo devuelven cantidades; las comprobaciones etiquetadas como `violations` deben devolver cero.

## 6. Qué no debe sembrarse

- Sesiones `refresh_sessions` activas.
- Tokens de recuperación de contraseña válidos.
- Contraseñas en texto claro dentro de la base de datos.
- Datos reales de estudiantes, familias o salud.
- Tablas aplazadas del MVP, como chat, tickets de soporte, tokens push, outbox o cálculo ponderado avanzado.
- Contadores de Home almacenados como valores independientes.

## 7. Limitaciones y verificaciones pendientes

1. El paquete está preparado para una base limpia y no es idempotente.
2. Los permisos RBAC son un catálogo inicial; antes de integrar deben cotejarse con los códigos que autoriza realmente la API.
3. Verifica que la API valide los hashes Argon2id con los parámetros del seed.
4. Verifica en la aplicación real las rutas de primer acceso, publicación de notas, cambio de tareas y lectura de mensajes.
5. No se ha ejecutado este paquete contra la instancia PostgreSQL del proyecto al preparar este documento. Ejecuta las validaciones en tu entorno y revisa errores antes de usarlo con el equipo.
6. Los registros de ejemplo tienen fechas de 2026. Para probar “hoy”, “próximo evento” y contadores dependientes de fecha, revisa que las fechas sigan siendo pertinentes o ajusta los datos en el entorno local de prueba.

## 8. Referencias del proyecto

- `01-schema.sql`: esquema PostgreSQL activo para Mimu v1.3.
- `V004__seed_rbac_catalog.sql`: catálogo RBAC demo/oficial inicial.
- `00-demo-identity.sql`: institución, usuarios, credenciales, membresías, roles y aceptación de términos.
- `01-demo-academic.sql`: estructura académica, estudiantes, tutores y asignaciones.
- `02-demo-activity.sql`: calificaciones, tareas, asistencia y seguimiento diario.
- `03-demo-communications.sql`: avisos, eventos, mensajes, lecturas y notificaciones.
- `99-validate-demo-data.sql`: comprobaciones de integridad del escenario.
- `MIMU_diseno_tecnico_ERD_v1.3_MVP.md`: reglas funcionales, autorización, primer acceso y contadores de Home.
