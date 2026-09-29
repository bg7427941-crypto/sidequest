CREATE EXTENSION IF NOT EXISTS postgis;

INSERT INTO missions (id, title, description, category, difficulty, xp, location_name, location, radius_meters, is_active) VALUES
('plaza-mayor','El corazón de Lima','Explora los alrededores de la Plaza Mayor y observa su arquitectura. Misión de demostración.','Exploración','Fácil',50,'Plaza Mayor de Lima',ST_SetSRID(ST_MakePoint(-77.0308,-12.0453),4326),180,TRUE),
('parque-reserva','Una pausa verde','Descubre los espacios públicos del Parque de la Reserva. Verifica horarios y accesos antes de ir.','Naturaleza','Media',80,'Parque de la Reserva',ST_SetSRID(ST_MakePoint(-77.0333,-12.0706),4326),220,TRUE),
('parque-kennedy','Detalles de Miraflores','Observa un detalle del paisaje urbano en el entorno del Parque Kennedy.','Fotografía','Fácil',60,'Parque Kennedy',ST_SetSRID(ST_MakePoint(-77.0297,-12.1211),4326),180,TRUE),
('barranco','Arquitectura de Barranco','Pasea por el entorno público del Puente de los Suspiros y observa su arquitectura.','Cultura e historia','Media',90,'Puente de los Suspiros',ST_SetSRID(ST_MakePoint(-77.0222,-12.1493),4326),160,TRUE),
('parque-de-la-amistad','Puerta de Santiago','Explora el entorno del Parque de la Amistad y busca detalles arquitectónicos.','Arquitectura','Fácil',60,'Parque de la Amistad',ST_SetSRID(ST_MakePoint(-76.9958,-12.1117),4326),220,TRUE),
('huaca-pucllana','Ciudad antes de la ciudad','Observa la presencia de la Huaca Pucllana dentro del paisaje urbano de Miraflores.','Cultura e historia','Media',90,'Huaca Pucllana',ST_SetSRID(ST_MakePoint(-77.0359,-12.1107),4326),220,TRUE),
('malecon-miraflores','Horizonte del Pacífico','Recorre un tramo del malecón y observa cómo cambia el paisaje entre ciudad y costa.','Fotografía','Fácil',70,'Malecón de Miraflores',ST_SetSRID(ST_MakePoint(-77.0318,-12.1322),4326),260,TRUE),
('parque-del-amor','Una vista diferente','Busca un detalle artístico en el entorno del Parque del Amor y registra tu descubrimiento.','Arte','Fácil',60,'Parque del Amor',ST_SetSRID(ST_MakePoint(-77.0312,-12.1342),4326),180,TRUE),
('larcomar','Ciudad frente al mar','Observa cómo el espacio urbano se integra con el acantilado y el litoral.','Arquitectura','Fácil',50,'Entorno de Larcomar',ST_SetSRID(ST_MakePoint(-77.0292,-12.1338),4326),220,TRUE),
('puente-de-los-suspiros','Cruza el tiempo','Observa los detalles del entorno del puente y su relación con las calles de Barranco.','Cultura e historia','Fácil',70,'Puente de los Suspiros',ST_SetSRID(ST_MakePoint(-77.0220,-12.1496),4326),140,TRUE),
('bajada-de-banos','Camino al acantilado','Explora visualmente la Bajada de Baños y encuentra un detalle que cuente algo del barrio.','Exploración','Media',80,'Bajada de Baños',ST_SetSRID(ST_MakePoint(-77.0221,-12.1506),4326),180,TRUE),
('parque-reducto','Memoria urbana','Recorre el entorno del parque y observa elementos que conectan espacio público e historia.','Cultura e historia','Media',80,'Parque Reducto Nº 2',ST_SetSRID(ST_MakePoint(-77.0270,-12.1169),4326),220,TRUE),
('parque-el-olivar','Entre olivos','Explora el paisaje del parque y busca un detalle natural que normalmente pase desapercibido.','Naturaleza','Fácil',70,'Bosque El Olivar',ST_SetSRID(ST_MakePoint(-77.0370,-12.1027),4326),260,TRUE),
('parque-mariscal-castilla','Rincones de Lince','Explora el espacio público y encuentra un punto interesante para fotografiar.','Fotografía','Fácil',50,'Parque Mariscal Castilla',ST_SetSRID(ST_MakePoint(-77.0360,-12.0882),4326),220,TRUE),
('campo-de-marte','Gran espacio urbano','Observa cómo un gran espacio abierto funciona dentro de una zona densamente urbana.','Exploración','Fácil',60,'Campo de Marte',ST_SetSRID(ST_MakePoint(-77.0480,-12.0750),4326),300,TRUE),
('plaza-san-martin','Geometría de una plaza','Observa la composición urbana de la plaza y sus edificios alrededor.','Arquitectura','Media',80,'Plaza San Martín',ST_SetSRID(ST_MakePoint(-77.0360,-12.0520),4326),180,TRUE),
('parque-de-la-exposicion','Arte al aire libre','Explora el entorno del Parque de la Exposición y localiza un elemento artístico.','Arte','Fácil',70,'Parque de la Exposición',ST_SetSRID(ST_MakePoint(-77.0322,-12.0582),4326),230,TRUE),
('museo-de-arte-de-lima','Una fachada para recordar','Observa la arquitectura exterior del entorno del museo y sus detalles.','Arte','Media',80,'Museo de Arte de Lima',ST_SetSRID(ST_MakePoint(-77.0325,-12.0592),4326),180,TRUE),
('congreso','Escena republicana','Observa la arquitectura del entorno del Congreso desde espacios públicos permitidos.','Arquitectura','Media',80,'Entorno del Congreso',ST_SetSRID(ST_MakePoint(-77.0288,-12.0439),4326),220,TRUE),
('plaza-bolognesi','Una plaza histórica','Explora la composición de la Plaza Bolognesi y sus edificios circundantes.','Cultura e historia','Fácil',60,'Plaza Bolognesi',ST_SetSRID(ST_MakePoint(-77.0420,-12.0564),4326),180,TRUE),
('parque-de-las-leyendas','Ruta de naturaleza','Descubre el entorno del parque y observa cómo conviven naturaleza, cultura y ciudad.','Naturaleza','Media',90,'Parque de las Leyendas',ST_SetSRID(ST_MakePoint(-77.0920,-12.0474),4326),350,TRUE),
('malecon-de-san-miguel','Atardecer costero','Busca una composición interesante entre cielo, mar y ciudad en el malecón.','Fotografía','Fácil',70,'Malecón de San Miguel',ST_SetSRID(ST_MakePoint(-77.0955,-12.0908),4326),280,TRUE),
('puente-de-la-amistad','Conecta los caminos','Explora un punto de conexión urbana y observa el movimiento del entorno.','Exploración','Fácil',50,'Entorno de Surco',ST_SetSRID(ST_MakePoint(-76.9960,-12.1125),4326),200,TRUE)
ON CONFLICT (id) DO NOTHING;

CREATE INDEX IF NOT EXISTS idx_missions_location_gist ON missions USING GIST (location);
