--CREACION DE TODAS LAS TABLAS
-- 1. Tablas Catálogo / Referencia
CREATE TABLE Especie (
    idEspecie INT IDENTITY(1,1) NOT NULL,
    NombreComun VARCHAR(100) NOT NULL,
    NombreCientifico VARCHAR(100) NOT NULL,
    CONSTRAINT PK_Especie PRIMARY KEY (idEspecie)
);

CREATE TABLE Salud (
    idSalud INT IDENTITY(1,1) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Salud PRIMARY KEY (idSalud)
);

CREATE TABLE TipoTarea (
    idTipoTarea INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(50) NOT NULL,
    CONSTRAINT PK_TipoTarea PRIMARY KEY (idTipoTarea)
);

CREATE TABLE MotivoReclamo (
    idMotivoReclamo INT IDENTITY(1,1) NOT NULL,
    Descripcion VARCHAR(80) NOT NULL,
    CONSTRAINT PK_MotivoReclamo PRIMARY KEY (idMotivoReclamo)
);

CREATE TABLE Ubicacion (
    idUbicacion INT IDENTITY(1,1) NOT NULL,
    Plaza VARCHAR(100) NOT NULL,
    Calle VARCHAR(100) NOT NULL,
    Altura VARCHAR(20) NOT NULL,
    Coordenadas VARCHAR(100) NOT NULL, 
    CONSTRAINT PK_Ubicacion PRIMARY KEY (idUbicacion)
);

-- 2. Entidades Principales
CREATE TABLE Cuadrilla (
    idCuadrilla INT IDENTITY(1,1) NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Cuadrilla PRIMARY KEY (idCuadrilla)
);

CREATE TABLE Empleados (
    idEmpleado INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    CUIL VARCHAR(20) NOT NULL,
    Telefono VARCHAR(50) NULL,
    FechaIngreso DATE NOT NULL,
    idCuadrilla INT, --quizas cuando lo ingresan todavia no le asignan cuadrilla
    CONSTRAINT PK_Empleados PRIMARY KEY (idEmpleado)
);

CREATE TABLE Arbol (
    idArbol INT IDENTITY(1,1) NOT NULL,
    Codigo VARCHAR(50) NOT NULL,
    FechaPlantado DATE NOT NULL,
    idEspecie INT,
    idUbicacion INT,
    CONSTRAINT PK_Arbol PRIMARY KEY (idArbol)
);

-- 3. Tablas Transaccionales
CREATE TABLE Mediciones (
    idMediciones INT IDENTITY(1,1) NOT NULL,
    FechaMedicion DATE NOT NULL,
    Altura DECIMAL(10,2) NOT NULL,
    idArbol INT,
    idSalud INT,
    CONSTRAINT PK_Mediciones PRIMARY KEY (idMediciones)
);

CREATE TABLE Tarea (
    idTarea INT IDENTITY(1,1) NOT NULL,
    FechaEstimada DATE NOT NULL,
    FechaRealizado DATE NULL,
    Comentario VARCHAR(255) NOT NULL,
    idTipoTarea INT,
    idCuadrilla INT,
    CONSTRAINT PK_Tarea PRIMARY KEY (idTarea)
);

-- Tabla intermedia (Relación Muchos a Muchos)
CREATE TABLE TareaArbol (
    idTarea INT NOT NULL,
    idArbol INT NOT NULL,
    CONSTRAINT PK_TareaArbol PRIMARY KEY (idTarea, idArbol)
);

CREATE TABLE Reclamos (
    idReclamo INT IDENTITY(1,1) NOT NULL,
    mail VARCHAR(255) NOT NULL,
    Fecha DATE NOT NULL,
    FechaAsignacionTarea DATE NULL,
    idArbol INT,
    idMotivo INT,
    idTarea INT,
    CONSTRAINT PK_Reclamos PRIMARY KEY (idReclamo)
);

--RESTRICCIONES
-- RESTRICCIONES UNIQUE (Para evitar datos duplicados lógicamente)
ALTER TABLE Cuadrilla ADD CONSTRAINT UQ_Cuadrilla_Codigo UNIQUE (Codigo);
ALTER TABLE Arbol ADD CONSTRAINT UQ_Arbol_Codigo UNIQUE (Codigo);
ALTER TABLE Empleados ADD CONSTRAINT UQ_Empleados_CUIL UNIQUE (CUIL);
ALTER TABLE Especie ADD CONSTRAINT UQ_Especie_Cientifico UNIQUE (NombreCientifico);

-- FOREIGN KEYS

-- Empleados
ALTER TABLE Empleados ADD CONSTRAINT FK_Empleados_Cuadrilla FOREIGN KEY (idCuadrilla) REFERENCES Cuadrilla(idCuadrilla);

-- Arbol
ALTER TABLE Arbol ADD CONSTRAINT FK_Arbol_Especie FOREIGN KEY (idEspecie) REFERENCES Especie(idEspecie);
ALTER TABLE Arbol ADD CONSTRAINT FK_Arbol_Ubicacion FOREIGN KEY (idUbicacion) REFERENCES Ubicacion(idUbicacion);

-- Mediciones
ALTER TABLE Mediciones ADD CONSTRAINT FK_Mediciones_Arbol FOREIGN KEY (idArbol) REFERENCES Arbol(idArbol);
ALTER TABLE Mediciones ADD CONSTRAINT FK_Mediciones_Salud FOREIGN KEY (idSalud) REFERENCES Salud(idSalud);

-- Tarea
ALTER TABLE Tarea ADD CONSTRAINT FK_Tarea_Tipo FOREIGN KEY (idTipoTarea) REFERENCES TipoTarea(idTipoTarea);
ALTER TABLE Tarea ADD CONSTRAINT FK_Tarea_Cuadrilla FOREIGN KEY (idCuadrilla) REFERENCES Cuadrilla(idCuadrilla);

-- TareaArbol (Tabla intermedia)
ALTER TABLE TareaArbol ADD CONSTRAINT FK_TareaArbol_Tarea FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea);
ALTER TABLE TareaArbol ADD CONSTRAINT FK_TareaArbol_Arbol FOREIGN KEY (idArbol) REFERENCES Arbol(idArbol);

-- Reclamos
ALTER TABLE Reclamos ADD CONSTRAINT FK_Reclamos_Arbol FOREIGN KEY (idArbol) REFERENCES Arbol(idArbol);
ALTER TABLE Reclamos ADD CONSTRAINT FK_Reclamos_Motivo FOREIGN KEY (idMotivo) REFERENCES MotivoReclamo(idMotivoReclamo);
ALTER TABLE Reclamos ADD CONSTRAINT FK_Reclamos_Tarea FOREIGN KEY (idTarea) REFERENCES Tarea(idTarea);