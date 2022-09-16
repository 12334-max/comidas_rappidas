CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    email varchar(255) NOT NULL,
    password varchar(255) NOT NULL,
    remember_token varchar(100) DEFAULT NULL,
    created_at timestamp NULL DEFAULT NULL,
    updated_at timestamp NULL DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY users_email_unique (email)
) ENGINE=InnoDB;

CREATE TABLE password_resets (
    email varchar(255) NOT NULL,
    token varchar(255) NOT NULL,
    created_at timestamp NULL DEFAULT NULL,
    KEY password_resets_email_index (email)
) ENGINE=InnoDB;

CREATE TABLE restaurant (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(255) NOT NULL,
    nombre_contacto VARCHAR(255) NOT NULL,
    clabe VARCHAR(255) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono CHAR(10) NOT NULL,
    email VARCHAR(255) NOT NULL,
    facebook VARCHAR(255) NOT NULL,
    twitter VARCHAR(255) NOT NULL,
    instagram VARCHAR(255) NOT NULL,
    logotipo VARCHAR(255) NOT NULL,
    status ENUM('ABIERTO','CERRADO') DEFAULT 'CERRADO' NOT NULL,
    ubicacion_lat VARCHAR(255) NOT NULL,
    ubicacion_long VARCHAR(255) NOT NULL,
    verificado  ENUM('SOLICITUD','APROBADO','RECHAZADO') DEFAULT 'SOLICITUD' NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    deleted_at DATETIME,
    INDEX(email), FOREIGN KEY (email) REFERENCES users (email) ON UPDATE CASCADE
) engine=InnoDB;

CREATE TABLE platillo (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_restaurant INT NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    imagen VARCHAR(255) NOT NULL,
    categoria VARCHAR(255) NOT NULL,
    status ENUM('DISPONIBLE','NO DISPONIBLE') NOT NULL DEFAULT 'DISPONIBLE',
    INDEX(id_restaurant), FOREIGN KEY (id_restaurant) REFERENCES restaurant (id)
) engine=InnoDB;
