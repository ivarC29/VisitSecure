-- Script SQL para Sistema de Gestión de Condominios

-- Tabla Role
CREATE TABLE roles (
    id_role INT PRIMARY KEY NOT NULL,
    role_name CHAR(50) NOT NULL
);

-- Tabla Persona
CREATE TABLE persona (
    id_persona INT PRIMARY KEY NOT NULL,
    nombres CHAR(100) NOT NULL,
    apellidos CHAR(100) NOT NULL,
    tipo_documento ENUM('DNI', 'PASAPORTE', 'CARNET_EXTRANJERIA') NOT NULL,
    numero_documento CHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

-- Tabla Usuario
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY NOT NULL,
    usuario CHAR(50) NOT NULL,
    contraseña CHAR(50) NOT NULL,
    id_persona INT NOT NULL,
    FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Tabla user_role (tabla intermedia para relación muchos a muchos)
CREATE TABLE user_role (
   id_role INT NOT NULL,
   id_usuario INT NOT NULL,
   PRIMARY KEY (id_role, id_usuario),
   FOREIGN KEY (id_role) REFERENCES roles(id_role),
   FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Tabla Condominio
CREATE TABLE condominios (
    id_condominio INT PRIMARY KEY NOT NULL,
    nombre CHAR(50) NOT NULL,
    direccion CHAR(50) NOT NULL
);

-- Tabla Residente
CREATE TABLE residentes (
   id_residente INT PRIMARY KEY NOT NULL,
   id_condominio INT NOT NULL,
   id_persona INT NOT NULL,
   torre CHAR(20) NOT NULL,
   numero_dpto CHAR(20) NOT NULL,
   FOREIGN KEY (id_condominio) REFERENCES condominios(id_condominio),
   FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Tabla Vigilante
CREATE TABLE vigilantes (
   id_vigilante INT PRIMARY KEY NOT NULL,
   id_condominio INT NOT NULL,
   id_persona INT NOT NULL,
   nombres DATE NOT NULL,
   apellidos DATE NOT NULL,
   usuario DATE NOT NULL,
   FOREIGN KEY (id_condominio) REFERENCES condominios(id_condominio),
   FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Tabla Visita
CREATE TABLE visitas (
    id_visita INT PRIMARY KEY NOT NULL,
    id_residente INT NOT NULL,
    fecha_visita DATE NOT NULL,
    hora_ingreso DATE NOT NULL,
    hora_salida DATE NOT NULL,
    FOREIGN KEY (id_residente) REFERENCES residente(id_residente)
);

-- Tabla RegistroAcceso
CREATE TABLE registros_acceso (
    id_registro INT PRIMARY KEY NOT NULL,
    id_visita INT NOT NULL,
    id_vigilante INT NOT NULL,
    hora_acceso TIMESTAMP NOT NULL,
    tipo_acceso ENUM('ENTRADA', 'SALIDA') NOT NULL,
    FOREIGN KEY (id_visita) REFERENCES visitas(id_visita),
    FOREIGN KEY (id_vigilante) REFERENCES vigilantes(id_vigilante)
);

-- Tabla VisitaPersona (tabla intermedia para relacionar Visita con Persona)
CREATE TABLE visitas_persona (
   id_visita INT NOT NULL,
   id_persona INT NOT NULL,
   PRIMARY KEY (id_visita, id_persona),
   FOREIGN KEY (id_visita) REFERENCES visitas(id_visita),
   FOREIGN KEY (id_persona) REFERENCES personas(id_persona)
);

-- Índices para mejorar el rendimiento
CREATE INDEX idx_usuario_persona ON usuario(id_persona);
CREATE INDEX idx_residente_condominio ON residente(id_condominio);
CREATE INDEX idx_residente_persona ON residente(id_persona);
CREATE INDEX idx_vigilante_condominio ON vigilante(id_condominio);
CREATE INDEX idx_vigilante_persona ON vigilante(id_persona);
CREATE INDEX idx_visita_residente ON visita(id_residente);
CREATE INDEX idx_registro_visita ON registros_acceso(id_visita);
CREATE INDEX idx_registro_vigilante ON registros_acceso(id_vigilante);

-- Comentarios sobre las tablas
COMMENT ON TABLE roles IS 'Tabla de roles del sistema';
COMMENT ON TABLE personas IS 'Tabla principal de personas';
COMMENT ON TABLE usuarios IS 'Tabla de usuarios del sistema';
COMMENT ON TABLE user_role IS 'Relación muchos a muchos entre usuarios y roles';
COMMENT ON TABLE condominios IS 'Tabla de condominios';
COMMENT ON TABLE residentes IS 'Tabla de residentes por condominio';
COMMENT ON TABLE vigilantes IS 'Tabla de vigilantes por condominio';
COMMENT ON TABLE visitas IS 'Tabla de visitas programadas';
COMMENT ON TABLE registro_acceso IS 'Tabla de registro de accesos';
COMMENT ON TABLE visitas_persona IS 'Relación entre visitas y personas visitantes';