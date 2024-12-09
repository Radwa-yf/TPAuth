-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : lun. 09 déc. 2024 à 15:55
-- Version du serveur : 11.4.3-MariaDB-deb12
-- Version de PHP : 8.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `laravel`
--

-- --------------------------------------------------------

--
-- Structure de la table `log`
--

CREATE TABLE `log` (
  `idLog` int(11) NOT NULL,
  `typeActionLog` varchar(500) NOT NULL,
  `dateHeureLog` datetime NOT NULL DEFAULT current_timestamp(),
  `adresseIPLog` varchar(15) NOT NULL,
  `idUtilisateur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `log`
--

INSERT INTO `log` (`idLog`, `typeActionLog`, `dateHeureLog`, `adresseIPLog`, `idUtilisateur`) VALUES
(1, 'Inscription', '2024-11-26 08:16:23', '172.18.202.56', 1),
(2, 'Inscription', '2024-12-03 08:09:44', '172.18.202.56', 2),
(3, 'Tentative de connexion échoué ', '2024-12-03 08:18:34', '172.18.202.56', 2),
(4, 'Tentative de connexion échoué ', '2024-12-03 08:18:50', '172.18.202.56', 2),
(5, 'Tentative de connexion échoué ', '2024-12-03 08:19:24', '172.18.202.56', 2),
(7, 'Tentative de connexion échoué ', '2024-12-03 08:27:39', '172.18.202.56', 2),
(8, 'Inscription', '2024-12-03 08:29:29', '172.18.202.56', 3),
(9, 'Tentative de connexion échoué ', '2024-12-03 08:29:50', '172.18.202.56', 3),
(10, 'connexion', '2024-12-03 08:34:37', '172.18.202.56', 1),
(11, 'Inscription', '2024-12-03 08:35:44', '172.18.202.56', 4),
(12, 'connexion', '2024-12-03 08:36:00', '172.18.202.56', 4),
(24, 'Inscription', '2024-12-09 12:52:24', '172.18.202.56', 7),
(25, 'connexion', '2024-12-09 12:53:01', '172.18.202.56', 7),
(26, 'connexion', '2024-12-09 13:18:51', '172.18.202.56', 7),
(27, 'connexion', '2024-12-09 13:21:12', '172.18.202.56', 7),
(28, 'connexion', '2024-12-09 13:23:14', '172.18.202.56', 7),
(29, 'connexion', '2024-12-09 13:26:07', '172.18.202.56', 7),
(30, 'Tentative de connexion échoué ', '2024-12-09 13:30:26', '172.18.202.56', 7),
(31, 'Tentative de connexion échoué ', '2024-12-09 13:39:12', '172.18.202.56', 7),
(32, 'Tentative de connexion échoué ', '2024-12-09 13:44:48', '172.18.202.56', 7),
(33, 'Tentative de connexion échoué ', '2024-12-09 13:46:11', '172.18.202.56', 7),
(34, 'Tentative de connexion échoué ', '2024-12-09 13:49:59', '172.18.202.56', 7),
(35, 'Tentative de connexion échoué ', '2024-12-09 14:06:47', '172.18.202.56', 7),
(36, 'Tentative de connexion échoué ', '2024-12-09 14:18:52', '172.18.202.56', 7),
(37, 'compte réactivé', '2024-12-09 14:25:32', '172.18.202.56', 7);

-- --------------------------------------------------------

--
-- Structure de la table `reactivation`
--

CREATE TABLE `reactivation` (
  `idReactivation` int(11) NOT NULL,
  `codeReactivation` varchar(50) DEFAULT NULL,
  `dateHeureExpirationReactivation` date DEFAULT NULL,
  `idUtilisateur` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `reactivation`
--

INSERT INTO `reactivation` (`idReactivation`, `codeReactivation`, `dateHeureExpirationReactivation`, `idUtilisateur`) VALUES
(1, 'Rw3H8Khibr4afydtpkIcem7Zl0UjxPnz', NULL, 7),
(2, 'w86n1j0thEOyprXWcKFxYTvzfoZGLH92', NULL, 7),
(3, 'mc0N2BrDSWQXO7I1eJtpGHqjEAbuFCly', NULL, 7);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `idUtilisateur` int(11) NOT NULL,
  `emailUtilisateur` varchar(500) NOT NULL,
  `motDePasseUtilisateur` varchar(500) NOT NULL,
  `nomUtilisateur` varchar(500) NOT NULL,
  `prenomUtilisateur` varchar(500) NOT NULL,
  `secretA2FUtilisateur` varchar(500) DEFAULT NULL,
  `tentativesEchoueesUtilisateur` int(11) NOT NULL DEFAULT 0,
  `estDesactiveUtilisateur` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`idUtilisateur`, `emailUtilisateur`, `motDePasseUtilisateur`, `nomUtilisateur`, `prenomUtilisateur`, `secretA2FUtilisateur`, `tentativesEchoueesUtilisateur`, `estDesactiveUtilisateur`) VALUES
(1, 'toto@gmail.com', '$2y$10$0u19dlKJUJ5LD5gWPTn0JuJM6BcjNhfP8pCzThwXbQUdNu3XsveQO', 'toto', 'titi', 'M5VDXX77JA7LDIYX', 0, 0),
(2, 'riri@gmail.com', '$2y$10$YWPpjgCKQTpQbaeLAvdIwOr7MavMlwUtCS8i0q5oR7bWbsIhc65Du', 'yassif', 'radwa', 'M55WEWUIFYKACKE2', 4, 0),
(3, 'fred@gmail.com', '$2y$10$0e7IqwOWnz3usLCHKuSyjuZD3aPF5rAlOM/15UJhkE3Ftzd0.HQri', 'fred', 'frederic', 'OAUHZW5SO5URTFD3', 1, 0),
(4, 'abcdef@gmail.com', '$2y$10$ExN.W9krHLlvD6N/vPdXfex1CxPFDk8YHDnSq9Gh6/HyIjKTT.yae', 'AAA', 'BBB', 'MKTE4JVK4GNCKOFV', 0, 0),
(5, 'max@gmail.com', '$2y$10$.u/mRLOba6akD1QZBG08yeWOVFSIRGO.3Dt9xZzCPe01622bwoaXa', 'titi', 'max', 'T22DVBCNGW2I3PR2', 0, 0),
(7, 'yassifradwa@gmail.com', '$2y$10$yPlmzz/4joDFS0WQYn3ugO9i5EjBqc9X2dbc362wAO/Yx4lZppr4S', 'AAA', 'BBB', '4K7LDW65NXS7IKHY', 0, 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `log`
--
ALTER TABLE `log`
  ADD PRIMARY KEY (`idLog`),
  ADD KEY `idUtilisateur` (`idUtilisateur`);

--
-- Index pour la table `reactivation`
--
ALTER TABLE `reactivation`
  ADD PRIMARY KEY (`idReactivation`),
  ADD KEY `fk_idUtilisateur` (`idUtilisateur`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`idUtilisateur`),
  ADD UNIQUE KEY `emailUtilisateur` (`emailUtilisateur`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `log`
--
ALTER TABLE `log`
  MODIFY `idLog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `reactivation`
--
ALTER TABLE `reactivation`
  MODIFY `idReactivation` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `idUtilisateur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `log`
--
ALTER TABLE `log`
  ADD CONSTRAINT `log_ibfk_1` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`);

--
-- Contraintes pour la table `reactivation`
--
ALTER TABLE `reactivation`
  ADD CONSTRAINT `fk_idUtilisateur` FOREIGN KEY (`idUtilisateur`) REFERENCES `utilisateur` (`idUtilisateur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
