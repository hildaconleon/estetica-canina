-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 14-03-2026 a las 00:36:11
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `estetica canina`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area`
--

CREATE TABLE `area` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `area`
--

INSERT INTO `area` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Gerente', 'Responsable de la administración general del negocio.'),
(2, 'Recepcionista', 'Apoya en tareas administrativas básicas como cobros y registros de los principales módulos.\r\n'),
(5, 'Estilista (Groomer)', 'Especialista en el cuidado estético y de higiene de mascotas, Evalúa el estado del pelaje y piel.\r\n');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$M66fTKcEio8I7A0FnwL3iQ$FqqJYwx7A2ldycg9r0QHgaTNQ2j822thmxlkb7pFZ3A=', NULL, 1, 'anaan', '', '', 'anaantoniocova@gmail.com', 1, 1, '2026-02-19 21:52:01.723340'),
(2, 'pbkdf2_sha256$600000$PSrFFpxyHRESxNvh8jTkeU$SdMX6kU0dxDGkBe7VHyCVa19g1tHlbm8BCr1xJTNp9M=', NULL, 1, 'anaana', '', '', 'anaantoniocova@gmail.com', 1, 1, '2026-02-19 21:52:42.688933'),
(3, 'pbkdf2_sha256$600000$3s9H2xKh8guhdSxedHz5yo$cGUeFZFllZ68Gx+l6XkTejlsIx7aRoFvLF1PjEJ2kho=', '2026-02-19 22:07:22.787363', 1, 'anita', '', '', 'anaantoniocova@gmail.com', 1, 1, '2026-02-19 22:06:33.700265');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cita`
--

CREATE TABLE `cita` (
  `clave` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `observaciones` text DEFAULT NULL,
  `condicion_pelo` varchar(100) DEFAULT NULL,
  `condicion_piel` varchar(100) DEFAULT NULL,
  `estado_cita` int(11) NOT NULL,
  `mascota` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cita`
--

INSERT INTO `cita` (`clave`, `fecha`, `hora`, `observaciones`, `condicion_pelo`, `condicion_piel`, `estado_cita`, `mascota`) VALUES
(1, '2026-03-20', '05:00:00', 'un poco agresivo cuidar eso', 'Corto (seco)', 'ninguna', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `primerApel` varchar(50) NOT NULL,
  `segApel` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `estado` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`clave`, `nombre`, `primerApel`, `segApel`, `correo`, `estado`) VALUES
(5, 'Ana', 'Antonio', 'Cova', 'anaantoniocova@gmail.com', 2),
(6, 'Jose', 'Antonio', 'Rodriguez', 'jose@gmail.com', 1),
(7, 'Hilda', 'De leon', 'Martinez', 'hilda@gmail.com', 2),
(8, 'Fernando', 'Estrada', '', 'fer@gmail.com', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_cita`
--

CREATE TABLE `detalle_cita` (
  `servicio` int(11) NOT NULL,
  `cita` int(11) NOT NULL,
  `precioAplicado` decimal(8,2) NOT NULL,
  `empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-19 21:49:16.824213'),
(2, 'auth', '0001_initial', '2026-02-19 21:49:17.071667'),
(3, 'admin', '0001_initial', '2026-02-19 21:49:17.124958'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-19 21:49:17.124958'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-19 21:49:17.141045'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-02-19 21:49:17.157068'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-02-19 21:49:17.188531'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-02-19 21:49:17.188531'),
(9, 'auth', '0004_alter_user_username_opts', '2026-02-19 21:49:17.204629'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-02-19 21:49:17.220623'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-02-19 21:49:17.220623'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-02-19 21:49:17.220623'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-02-19 21:49:17.236299'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-02-19 21:49:17.236299'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-02-19 21:49:17.258601'),
(16, 'auth', '0011_update_proxy_permissions', '2026-02-19 21:49:17.267005'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-02-19 21:49:17.276458'),
(18, 'sessions', '0001_initial', '2026-02-19 21:49:17.283693');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('65gl40gcbkmn2u2aaxqe6me2vhc3zvgm', '.eJxVjEEOwiAQRe_C2hBgKLQu3XsGMjOAVA0kpV0Z765NutDtf-_9lwi4rSVsPS1hjuIsQJx-N0J-pLqDeMd6a5JbXZeZ5K7Ig3Z5bTE9L4f7d1Cwl289odfZaIfgLA9GTZQSEqNRlgyjo5FIocnAI4B21vtIQGqIJvuoPYv3B-6YOD4:1vtCB8:7c9vVsRhSw2Bt56ez6GkKU7toOb9yCDxgHunuWNVgq0', '2026-03-05 22:07:22.792521'),
('8nm5b2ubk2wgr0ee9p2yhge49kmv5atu', 'eyJlbXBsZWFkb19pZCI6MSwiZW1wbGVhZG9fbm9tYnJlIjoiTWFyaWEifQ:1w13xq:jKH5g6CZSIZ0RWsvtO0BxJJfO8_Lqst9wW37j6JpVqA', '2026-03-27 07:58:10.906188'),
('ris9kokvf7uedun4xjkeeb5syrl5fdnn', 'eyJlbXBsZWFkb19pZCI6MywiZW1wbGVhZG9fbm9tYnJlIjoiQW5hIn0:1w0VnR:0b1fusYFXiXeKSBtQ_ijDQUxu7N5f1l6jURsmcXIKgo', '2026-03-25 19:29:09.669560'),
('uw7tdjyyp7ittbltzdpk8szd4ksix9yo', 'eyJlbXBsZWFkb19pZCI6MSwiZW1wbGVhZG9fbm9tYnJlIjoiTWFyaWEifQ:1vx9bk:JbS8qcwwMAjOqJ4pfWlVmE0SkVk5kaB_vOXy8o_Q0uk', '2026-03-16 12:11:12.037738');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `primerApel` varchar(50) NOT NULL,
  `segApel` varchar(50) DEFAULT NULL,
  `fechaContra` date NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `claveAcceso` varchar(255) NOT NULL,
  `puesto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`clave`, `nombre`, `primerApel`, `segApel`, `fechaContra`, `usuario`, `claveAcceso`, `puesto`) VALUES
(1, 'Maria ', 'Lopez ', 'De La Torre ', '2022-02-09', 'MariaT', 'MT090222', 4),
(3, 'Ana', 'García', 'López', '2024-01-15', 'gerente', 'Gerente2024', 7),
(5, 'Hilda', 'De Leon', 'Martinez', '2022-02-09', 'hilda', 'hilda123', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_cita`
--

CREATE TABLE `estado_cita` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_cita`
--

INSERT INTO `estado_cita` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Pendiente', 'La cita fue registrada pero aún no confirmada'),
(2, 'Confirmada', 'El cliente confirmó la cita'),
(3, 'En proceso', 'La mascota está siendo atendida'),
(4, 'Completada', 'La cita terminó exitosamente'),
(5, 'Cancelada', 'La cita fue cancelada por el cliente o la estética'),
(6, 'Reprogramada', 'La cita fue movida a otra fecha'),
(7, 'No asistió', 'El cliente no se presentó a la cita');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_cliente`
--

CREATE TABLE `estado_cliente` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_cliente`
--

INSERT INTO `estado_cliente` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Activo', 'Cliente con relación vigente con la estética'),
(2, 'Inactivo', 'Cliente dado de baja del sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_mascota`
--

CREATE TABLE `estado_mascota` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `estado_mascota`
--

INSERT INTO `estado_mascota` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Activo', 'Mascota activa en el sistema'),
(2, 'Inactivo', 'Mascota dada de baja en el sistema');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascota`
--

CREATE TABLE `mascota` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fechaNac` date DEFAULT NULL,
  `peso` decimal(5,2) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  `estado_mascota` int(11) NOT NULL DEFAULT 1,
  `cliente` int(11) NOT NULL,
  `raza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `mascota`
--

INSERT INTO `mascota` (`clave`, `nombre`, `fechaNac`, `peso`, `observaciones`, `estado_mascota`, `cliente`, `raza`) VALUES
(1, 'Toby', '2018-12-12', 3.50, 'Muerde y ladra sin control (tener cuidado)', 1, 8, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pago`
--

CREATE TABLE `pago` (
  `clave` int(11) NOT NULL,
  `fecha_Pago` datetime NOT NULL DEFAULT current_timestamp(),
  `Monto_total` decimal(10,2) NOT NULL,
  `tipo_pago` int(11) NOT NULL,
  `cita` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `pago`
--

INSERT INTO `pago` (`clave`, `fecha_Pago`, `Monto_total`, `tipo_pago`, `cita`) VALUES
(1, '2026-03-10 19:23:48', 500.00, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `puesto`
--

CREATE TABLE `puesto` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `area` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `puesto`
--

INSERT INTO `puesto` (`clave`, `nombre`, `descripcion`, `area`) VALUES
(1, 'Estilista Nivel 1', 'Cortes básicos y baños simples', 5),
(3, 'Estilista Nivel 2', 'Cortes avanzados, grooming creativo', 5),
(4, 'Recepcionista', 'Atención al cliente, citas, cobros', 2),
(7, 'Gerente General', 'Supervisión total del negocio', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `raza`
--

CREATE TABLE `raza` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tamaño` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `raza`
--

INSERT INTO `raza` (`clave`, `nombre`, `tamaño`) VALUES
(1, 'Chihuahua', 1),
(2, 'Pug', 1),
(3, 'Shih Tzu', 1),
(4, 'Yorkshire Terrier', 1),
(5, 'Maltés', 1),
(6, 'Pomerania', 1),
(7, 'Dachshund Miniatura', 1),
(8, 'Boston Terrier', 1),
(9, 'Bichón Frisé', 1),
(10, 'Pinscher Miniatura', 1),
(11, 'Cavalier King Charles Spaniel', 1),
(12, 'Papillón', 1),
(13, 'Terrier Escocés', 1),
(14, 'West Highland White Terrier', 1),
(15, 'Beagle', 2),
(16, 'Cocker Spaniel', 2),
(17, 'Bulldog Francés', 2),
(18, 'Border Collie', 2),
(19, 'Schnauzer Mediano', 2),
(20, 'Staffordshire Bull Terrier', 2),
(21, 'Whippet', 2),
(22, 'Fox Terrier', 2),
(23, 'Basenji', 2),
(24, 'Samoyedo', 2),
(25, 'Perro Criollo', 2),
(26, 'Golden Retriever', 3),
(27, 'Labrador Retriever', 3),
(28, 'Pastor Alemán', 3),
(29, 'Husky Siberiano', 3),
(30, 'Rottweiler', 3),
(31, 'Doberman', 3),
(32, 'Boxer', 3),
(33, 'Akita Inu', 3),
(34, 'San Bernardo', 3),
(35, 'Gran Danés', 3),
(36, 'Mastín Napolitano', 3),
(37, 'Dogo Argentino', 3),
(38, 'Alaskan Malamute', 3),
(39, 'Leonberger', 3),
(40, 'Terranova', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `servicio`
--

CREATE TABLE `servicio` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `precio` decimal(8,2) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `servicio`
--

INSERT INTO `servicio` (`clave`, `nombre`, `precio`, `descripcion`) VALUES
(1, 'Baño básico', 250.00, 'Incluye shampoo neutro y secado'),
(2, 'Baño medicado', 350.00, 'Uso de shampoo especial para piel sensible o con tratamiento'),
(3, 'Corte de pelo básico', 300.00, 'Corte estético estándar según raza'),
(4, 'Corte de pelo especializado', 450.00, 'Corte profesional con estilo específico'),
(5, 'Cepillado y desenredado', 200.00, 'Eliminación de nudos y cepillado completo'),
(6, 'Corte de uñas', 120.00, 'Recorte seguro de uñas'),
(7, 'Limpieza de oídos', 100.00, 'Limpieza profunda y revisión de oídos'),
(8, 'Limpieza dental', 400.00, 'Cepillado y limpieza dental básica'),
(9, 'Desparasitación externa', 350.00, 'Aplicación de tratamiento contra pulgas y garrapatas'),
(10, 'Desparasitación interna', 300.00, 'Administración de antiparasitario oral'),
(11, 'Tratamiento de piel', 500.00, 'Aplicación de productos especiales para piel delicada'),
(12, 'Spa canino', 600.00, 'Baño, masaje relajante y aromaterapia'),
(13, 'Perfume y accesorios', 150.00, 'Aplicación de fragancia y colocación de moño o pañuelo'),
(14, 'Baño antipulgas', 380.00, 'Baño con shampoo antipulgas y garrapatas'),
(15, 'Baño y corte completo', 550.00, 'Servicio integral de baño y corte de pelo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tamaño`
--

CREATE TABLE `tamaño` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(20) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tamaño`
--

INSERT INTO `tamaño` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Chico', 'Perros pequeños, hasta 10 kg'),
(2, 'Mediano', 'Perros medianos, entre 10 y 25 kg'),
(3, 'Grande', 'Perros grandes, más de 25 kg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono_cliente`
--

CREATE TABLE `telefono_cliente` (
  `clave` int(11) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `cliente` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `telefono_cliente`
--

INSERT INTO `telefono_cliente` (`clave`, `Telefono`, `cliente`) VALUES
(1, '6642804000', 5),
(2, '6645236985', 7),
(3, '6645302806', 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `telefono_empleado`
--

CREATE TABLE `telefono_empleado` (
  `clave` int(11) NOT NULL,
  `Telefono` varchar(15) NOT NULL,
  `empleado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_pago`
--

CREATE TABLE `tipo_pago` (
  `clave` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_pago`
--

INSERT INTO `tipo_pago` (`clave`, `nombre`, `descripcion`) VALUES
(1, 'Efectivo', 'Pago realizado en billetes o monedas'),
(2, 'Tarjeta de Débito', 'Pago con tarjeta bancaria de débito'),
(3, 'Tarjeta de Crédito', 'Pago con tarjeta bancaria de crédito'),
(4, 'Transferencia Bancaria', 'Pago realizado mediante transferencia electrónica');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `area`
--
ALTER TABLE `area`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `cita`
--
ALTER TABLE `cita`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_cita_estado` (`estado_cita`),
  ADD KEY `fk_cita_mascota` (`mascota`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `correo` (`correo`),
  ADD KEY `fk_cliente_estado` (`estado`);

--
-- Indices de la tabla `detalle_cita`
--
ALTER TABLE `detalle_cita`
  ADD PRIMARY KEY (`servicio`,`cita`),
  ADD KEY `fk_detalle_cita` (`cita`),
  ADD KEY `fk_detalle_empleado` (`empleado`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `usuario` (`usuario`),
  ADD KEY `fk_empleado_puesto` (`puesto`);

--
-- Indices de la tabla `estado_cita`
--
ALTER TABLE `estado_cita`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `estado_cliente`
--
ALTER TABLE `estado_cliente`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `estado_mascota`
--
ALTER TABLE `estado_mascota`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_mascota_cliente` (`cliente`),
  ADD KEY `fk_mascota_raza` (`raza`),
  ADD KEY `fk_mascota_estado` (`estado_mascota`);

--
-- Indices de la tabla `pago`
--
ALTER TABLE `pago`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `cita` (`cita`),
  ADD KEY `fk_pago_tipo` (`tipo_pago`);

--
-- Indices de la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_puesto_area` (`area`);

--
-- Indices de la tabla `raza`
--
ALTER TABLE `raza`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_raza_tamaño` (`tamaño`);

--
-- Indices de la tabla `servicio`
--
ALTER TABLE `servicio`
  ADD PRIMARY KEY (`clave`);

--
-- Indices de la tabla `tamaño`
--
ALTER TABLE `tamaño`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `telefono_cliente`
--
ALTER TABLE `telefono_cliente`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_telefono_cliente` (`cliente`);

--
-- Indices de la tabla `telefono_empleado`
--
ALTER TABLE `telefono_empleado`
  ADD PRIMARY KEY (`clave`),
  ADD KEY `fk_telefono_empleado` (`empleado`);

--
-- Indices de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  ADD PRIMARY KEY (`clave`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `area`
--
ALTER TABLE `area`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT de la tabla `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cita`
--
ALTER TABLE `cita`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `cliente`
--
ALTER TABLE `cliente`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `empleado`
--
ALTER TABLE `empleado`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `estado_cita`
--
ALTER TABLE `estado_cita`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `estado_cliente`
--
ALTER TABLE `estado_cliente`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `estado_mascota`
--
ALTER TABLE `estado_mascota`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `mascota`
--
ALTER TABLE `mascota`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `pago`
--
ALTER TABLE `pago`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `puesto`
--
ALTER TABLE `puesto`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `raza`
--
ALTER TABLE `raza`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT de la tabla `servicio`
--
ALTER TABLE `servicio`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tamaño`
--
ALTER TABLE `tamaño`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `telefono_cliente`
--
ALTER TABLE `telefono_cliente`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `telefono_empleado`
--
ALTER TABLE `telefono_empleado`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tipo_pago`
--
ALTER TABLE `tipo_pago`
  MODIFY `clave` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `cita`
--
ALTER TABLE `cita`
  ADD CONSTRAINT `fk_cita_estado` FOREIGN KEY (`estado_cita`) REFERENCES `estado_cita` (`clave`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_cita_mascota` FOREIGN KEY (`mascota`) REFERENCES `mascota` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD CONSTRAINT `fk_cliente_estado` FOREIGN KEY (`estado`) REFERENCES `estado_cliente` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `detalle_cita`
--
ALTER TABLE `detalle_cita`
  ADD CONSTRAINT `fk_detalle_cita` FOREIGN KEY (`cita`) REFERENCES `cita` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_empleado` FOREIGN KEY (`empleado`) REFERENCES `empleado` (`clave`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_detalle_servicio` FOREIGN KEY (`servicio`) REFERENCES `servicio` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `fk_empleado_puesto` FOREIGN KEY (`puesto`) REFERENCES `puesto` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `mascota`
--
ALTER TABLE `mascota`
  ADD CONSTRAINT `fk_mascota_cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mascota_estado` FOREIGN KEY (`estado_mascota`) REFERENCES `estado_mascota` (`clave`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_mascota_raza` FOREIGN KEY (`raza`) REFERENCES `raza` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `pago`
--
ALTER TABLE `pago`
  ADD CONSTRAINT `fk_pago_cita` FOREIGN KEY (`cita`) REFERENCES `cita` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pago_tipo` FOREIGN KEY (`tipo_pago`) REFERENCES `tipo_pago` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `puesto`
--
ALTER TABLE `puesto`
  ADD CONSTRAINT `fk_puesto_area` FOREIGN KEY (`area`) REFERENCES `area` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `raza`
--
ALTER TABLE `raza`
  ADD CONSTRAINT `fk_raza_tamaño` FOREIGN KEY (`tamaño`) REFERENCES `tamaño` (`clave`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `telefono_cliente`
--
ALTER TABLE `telefono_cliente`
  ADD CONSTRAINT `fk_telefono_cliente` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `telefono_empleado`
--
ALTER TABLE `telefono_empleado`
  ADD CONSTRAINT `fk_telefono_empleado` FOREIGN KEY (`empleado`) REFERENCES `empleado` (`clave`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
