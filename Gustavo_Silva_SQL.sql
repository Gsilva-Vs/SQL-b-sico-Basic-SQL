-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 21/05/2026 às 06:38
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `curso`
--
CREATE DATABASE IF NOT EXISTS `curso` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `curso`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `aluno`
--

CREATE TABLE `aluno` (
  `id_aluno` int(11) NOT NULL,
  `nome_aluno` varchar(100) NOT NULL,
  `data_nascimento` date DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `id_sala` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `aluno`
--

INSERT INTO `aluno` (`id_aluno`, `nome_aluno`, `data_nascimento`, `cpf`, `email`, `telefone`, `endereco`, `id_sala`) VALUES
(1, 'Carlos Silva', '2006-03-15', '123.456.789-00', 'carlos.silva@email.com', '(17) 99999-1111', 'Rua A, 123', 1),
(2, 'Ana Souza', '2005-07-22', '987.654.321-00', 'ana.souza@email.com', '(17) 98888-2222', 'Rua B, 456', 2),
(3, 'João Pereira', '2007-01-10', '111.222.333-44', 'joao.p@email.com', '(17) 97777-3333', 'Rua C, 789', 1),
(4, 'Mariana Costa', '2004-11-30', '555.666.777-88', 'mariana.c@email.com', '(17) 96666-4444', 'Av. Central, 100', 3),
(5, 'Pedro Almeida', '2006-05-18', '999.888.777-66', 'pedro.a@email.com', '(17) 95555-5555', 'Rua D, 321', 4);

-- --------------------------------------------------------

--
-- Estrutura para tabela `curso`
--

CREATE TABLE `curso` (
  `id_curso` int(11) NOT NULL,
  `nome_curso` varchar(100) NOT NULL,
  `carga_horaria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `curso`
--

INSERT INTO `curso` (`id_curso`, `nome_curso`, `carga_horaria`) VALUES
(1, 'Informática', 1200),
(2, 'Administração', 1000),
(3, 'Enfermagem', 1800);

-- --------------------------------------------------------

--
-- Estrutura para tabela `sala`
--

CREATE TABLE `sala` (
  `id_sala` int(11) NOT NULL,
  `nome_sala` varchar(50) NOT NULL,
  `id_curso` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `sala`
--

INSERT INTO `sala` (`id_sala`, `nome_sala`, `id_curso`) VALUES
(1, 'Sala A', 1),
(2, 'Sala B', 2),
(3, 'Sala C', 3),
(4, 'Sala D', 1);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_aluno_anonimizado`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_aluno_anonimizado` (
`id_aluno` int(11)
,`nome_aluno` varchar(100)
,`cpf_anonimizado` varchar(14)
,`email_anonimizado` varchar(107)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_aluno_curso`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_aluno_curso` (
`id_aluno` int(11)
,`nome_aluno` varchar(100)
,`nome_curso` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_aluno_sala`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_aluno_sala` (
`id_aluno` int(11)
,`nome_aluno` varchar(100)
,`nome_sala` varchar(50)
);

-- --------------------------------------------------------

--
-- Estrutura stand-in para view `vw_aluno_sala_curso`
-- (Veja abaixo para a visão atual)
--
CREATE TABLE `vw_aluno_sala_curso` (
`id_aluno` int(11)
,`nome_aluno` varchar(100)
,`nome_sala` varchar(50)
,`nome_curso` varchar(100)
);

-- --------------------------------------------------------

--
-- Estrutura para view `vw_aluno_anonimizado`
--
DROP TABLE IF EXISTS `vw_aluno_anonimizado`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_aluno_anonimizado`  AS SELECT `aluno`.`id_aluno` AS `id_aluno`, `aluno`.`nome_aluno` AS `nome_aluno`, concat(left(`aluno`.`cpf`,3),'.***.***-**') AS `cpf_anonimizado`, concat(left(`aluno`.`email`,3),'***@',substring_index(`aluno`.`email`,'@',-1)) AS `email_anonimizado` FROM `aluno` ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_aluno_curso`
--
DROP TABLE IF EXISTS `vw_aluno_curso`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_aluno_curso`  AS SELECT `a`.`id_aluno` AS `id_aluno`, `a`.`nome_aluno` AS `nome_aluno`, `c`.`nome_curso` AS `nome_curso` FROM ((`aluno` `a` join `sala` `s` on(`a`.`id_sala` = `s`.`id_sala`)) join `curso` `c` on(`s`.`id_curso` = `c`.`id_curso`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_aluno_sala`
--
DROP TABLE IF EXISTS `vw_aluno_sala`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_aluno_sala`  AS SELECT `a`.`id_aluno` AS `id_aluno`, `a`.`nome_aluno` AS `nome_aluno`, `s`.`nome_sala` AS `nome_sala` FROM (`aluno` `a` join `sala` `s` on(`a`.`id_sala` = `s`.`id_sala`)) ;

-- --------------------------------------------------------

--
-- Estrutura para view `vw_aluno_sala_curso`
--
DROP TABLE IF EXISTS `vw_aluno_sala_curso`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vw_aluno_sala_curso`  AS SELECT `a`.`id_aluno` AS `id_aluno`, `a`.`nome_aluno` AS `nome_aluno`, `s`.`nome_sala` AS `nome_sala`, `c`.`nome_curso` AS `nome_curso` FROM ((`aluno` `a` join `sala` `s` on(`a`.`id_sala` = `s`.`id_sala`)) join `curso` `c` on(`s`.`id_curso` = `c`.`id_curso`)) ;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `aluno`
--
ALTER TABLE `aluno`
  ADD PRIMARY KEY (`id_aluno`),
  ADD UNIQUE KEY `cpf` (`cpf`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `id_sala` (`id_sala`);

--
-- Índices de tabela `curso`
--
ALTER TABLE `curso`
  ADD PRIMARY KEY (`id_curso`);

--
-- Índices de tabela `sala`
--
ALTER TABLE `sala`
  ADD PRIMARY KEY (`id_sala`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `aluno`
--
ALTER TABLE `aluno`
  ADD CONSTRAINT `aluno_ibfk_1` FOREIGN KEY (`id_sala`) REFERENCES `sala` (`id_sala`);

--
-- Restrições para tabelas `sala`
--
ALTER TABLE `sala`
  ADD CONSTRAINT `sala_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id_curso`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
