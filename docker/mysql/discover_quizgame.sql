-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 31, 2019 at 11:02 PM
-- Server version: 5.6.39-cll-lve
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `discover_lara3`
--

-- --------------------------------------------------------

--
-- Table structure for table `albums`
--

CREATE TABLE `albums` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `album` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `year` int(11) NOT NULL,
  `created_at` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `updated_at` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `albums`
--

INSERT INTO `albums` (`id`, `post_id`, `album`, `year`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Let Go', 2002, '2017-02-12 17:02:15', '2017-02-12 17:02:15', NULL),
(3, 2, 'Mutter', 2001, '2017-02-12 17:09:38', '2017-02-12 17:09:38', NULL),
(4, 4, 'Anti', 2016, '2017-02-12 17:16:54', '2017-02-12 17:16:54', NULL),
(5, 2, 'Reise, Reise', 2004, '2017-02-12 17:24:00', '2017-02-12 17:24:00', NULL),
(6, 2, 'Rammlied', 2009, '2017-02-12 17:33:10', '2017-02-12 17:33:10', NULL),
(7, 3, 'Untouchables1', 2002, '2017-02-12 17:39:47', '2017-03-13 10:33:29', NULL),
(8, 3, 'Take a Look in the Morror', 2003, '2017-02-12 17:45:39', '2017-02-12 17:45:39', NULL),
(9, 6, 'Sale el Sol', 2010, '2017-02-12 17:47:35', '2017-02-12 17:47:35', NULL),
(10, 5, 'Infinite', 1996, '2017-02-12 17:53:14', '2017-02-12 17:53:14', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2016_07_23_203935_create_posts_table', 1),
('2016_07_26_203838_ad_column_to_table_posts', 1),
('2017_02_08_172827_create_albums_table', 1),
('2017_02_08_190450_ad_column_to_table_albums', 1),
('2017_02_10_162049_create_songs_table', 1),
('2017_02_10_162152_ad_column_to_table_songs', 1);

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `text`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Avril Lavigne', '2017-02-12 14:01:48', '2017-02-12 14:01:48', NULL),
(2, 'Rammstein', '2017-02-12 14:07:11', '2017-02-12 14:07:11', NULL),
(3, 'Korn', '2017-02-12 14:14:46', '2017-02-12 14:14:46', NULL),
(4, 'Rihanna', '2017-02-12 14:15:45', '2017-02-12 14:15:45', NULL),
(5, 'Eminem', '2017-02-12 14:15:59', '2017-02-12 14:15:59', NULL),
(6, 'Shakira', '2017-02-12 14:16:07', '2017-02-12 14:16:07', NULL),
(7, 'Oomph!', '2017-02-12 15:29:02', '2017-02-12 15:29:02', NULL),
(8, 'Mmmm', '2017-02-20 08:05:38', '2017-09-08 11:51:22', '2017-09-08 11:51:22'),
(9, 'Metallica', '2017-09-08 11:51:12', '2017-09-08 11:51:12', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_answers`
--

CREATE TABLE `quiz_game_answers` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('Y','N') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_answers`
--

INSERT INTO `quiz_game_answers` (`id`, `user_id`, `question_id`, `answer`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Меркурий', 'Y', '2018-10-14 09:13:03', '2018-10-14 09:13:03'),
(2, 1, 1, 'Сатурн', 'N', '2018-10-14 09:13:03', '2018-10-14 09:13:03'),
(3, 1, 1, 'Уран', 'N', '2018-10-14 09:13:03', '2018-10-14 09:13:03'),
(4, 1, 1, 'Венера', 'N', '2018-10-14 09:13:03', '2018-10-14 09:13:03'),
(5, 1, 2, 'Арктики', 'N', '2018-10-14 09:15:34', '2018-10-14 09:15:34'),
(6, 1, 2, 'Экватора', 'Y', '2018-10-14 09:15:34', '2018-10-14 09:15:34'),
(7, 1, 2, 'Антарктиды', 'N', '2018-10-14 09:15:34', '2018-10-14 09:15:34'),
(8, 1, 2, 'Австралии', 'N', '2018-10-14 09:15:34', '2018-10-14 09:15:34'),
(9, 1, 3, 'Экватором', 'N', '2018-10-14 09:16:40', '2018-10-14 09:16:40'),
(10, 1, 3, 'Центром', 'N', '2018-10-14 09:16:40', '2018-10-14 09:16:40'),
(11, 1, 3, 'Азимутом', 'N', '2018-10-14 09:16:40', '2018-10-14 09:16:40'),
(12, 1, 3, 'Меридианом', 'Y', '2018-10-14 09:16:40', '2018-10-14 09:16:40'),
(13, 1, 4, 'Перинеи', 'N', '2018-10-14 09:17:54', '2018-10-14 09:17:54'),
(14, 1, 4, 'Гималаи', 'Y', '2018-10-14 09:17:54', '2018-10-14 09:17:54'),
(15, 1, 4, 'Кардильеры', 'N', '2018-10-14 09:17:54', '2018-10-14 09:17:54'),
(16, 1, 4, 'Анды', 'N', '2018-10-14 09:17:54', '2018-10-14 09:17:54'),
(17, 1, 5, 'Бромо', 'N', '2018-10-14 09:18:53', '2018-10-14 09:18:53'),
(18, 1, 5, 'Ключевская сопка', 'Y', '2018-10-14 09:18:53', '2018-10-14 09:18:53'),
(19, 1, 5, 'Килиманджаро', 'N', '2018-10-14 09:18:53', '2018-10-14 09:18:53'),
(20, 1, 5, 'Северная точка', 'N', '2018-10-14 09:18:53', '2018-10-14 09:18:53'),
(21, 1, 6, 'Гималайские', 'N', '2018-10-14 09:19:39', '2018-10-14 09:19:39'),
(22, 1, 6, 'Кавказские', 'N', '2018-10-14 09:19:39', '2018-10-14 09:19:39'),
(23, 1, 6, 'Уральские', 'Y', '2018-10-14 09:19:39', '2018-10-14 09:19:39'),
(24, 1, 6, 'Северные', 'N', '2018-10-14 09:19:39', '2018-10-14 09:19:39'),
(25, 1, 7, 'Argentina', 'N', '2018-10-14 09:29:20', '2018-10-14 09:29:20'),
(26, 1, 7, 'Brazil', 'Y', '2018-10-14 09:29:20', '2018-10-14 09:29:20'),
(27, 1, 7, 'France', 'N', '2018-10-14 09:29:20', '2018-10-14 09:29:20'),
(28, 1, 7, 'Belgium', 'N', '2018-10-14 09:29:20', '2018-10-14 09:29:20'),
(29, 1, 8, 'Belarus', 'N', '2018-10-14 09:30:01', '2018-10-14 09:30:01'),
(30, 1, 8, 'Hungary', 'N', '2018-10-14 09:30:01', '2018-10-14 09:30:01'),
(31, 1, 8, 'Japan', 'Y', '2018-10-14 09:30:01', '2018-10-14 09:30:01'),
(32, 1, 8, 'Thailand', 'N', '2018-10-14 09:30:01', '2018-10-14 09:30:01'),
(33, 1, 9, 'Senegal', 'N', '2018-10-14 09:31:00', '2018-10-14 09:31:00'),
(34, 1, 9, 'Zimbabwe', 'Y', '2018-10-14 09:31:00', '2018-10-14 09:31:00'),
(35, 1, 9, 'South Africa', 'N', '2018-10-14 09:31:00', '2018-10-14 09:31:00'),
(36, 1, 9, 'Siria', 'N', '2018-10-14 09:31:00', '2018-10-14 09:31:00'),
(37, 1, 10, 'Poland', 'N', '2018-10-14 09:31:52', '2018-10-14 09:31:52'),
(38, 1, 10, 'Germany', 'N', '2018-10-14 09:31:52', '2018-10-14 09:31:52'),
(39, 1, 10, 'Belarus', 'N', '2018-10-14 09:31:52', '2018-10-14 09:31:52'),
(40, 1, 10, 'Russia', 'Y', '2018-10-14 09:31:52', '2018-10-14 09:31:52'),
(41, 1, 11, 'Thailand', 'N', '2018-10-14 09:32:33', '2018-10-14 09:32:33'),
(42, 1, 11, 'Vietnam', 'N', '2018-10-14 09:32:33', '2018-10-14 09:32:33'),
(43, 1, 11, 'India', 'Y', '2018-10-14 09:32:33', '2018-10-14 09:32:33'),
(44, 1, 11, 'Australia', 'N', '2018-10-14 09:32:33', '2018-10-14 09:32:33'),
(45, 1, 12, 'Spain', 'N', '2018-10-14 09:33:17', '2018-10-14 09:33:17'),
(46, 1, 12, 'South Africa', 'N', '2018-10-14 09:33:17', '2018-10-14 09:33:17'),
(47, 1, 12, 'Hawaii', 'Y', '2018-10-14 09:33:17', '2018-10-14 09:33:17'),
(48, 1, 12, 'Israel', 'N', '2018-10-14 09:33:17', '2018-10-14 09:33:17'),
(49, 1, 13, 'Poland', 'N', '2018-10-14 09:34:10', '2018-10-14 09:34:10'),
(50, 1, 13, 'Russia', 'Y', '2018-10-14 09:34:10', '2018-10-14 09:34:10'),
(51, 1, 13, 'China', 'N', '2018-10-14 09:34:10', '2018-10-14 09:34:10'),
(52, 1, 13, 'Mongolia', 'N', '2018-10-14 09:34:10', '2018-10-14 09:34:10'),
(53, 1, 14, 'Washington', 'N', '2018-10-14 09:45:32', '2018-10-14 09:45:32'),
(54, 1, 14, 'Texas', 'Y', '2018-10-14 09:45:32', '2018-10-14 09:45:32'),
(55, 1, 14, 'Ohaio', 'N', '2018-10-14 09:45:32', '2018-10-14 09:45:32'),
(56, 1, 14, 'Nevada', 'N', '2018-10-14 09:45:32', '2018-10-14 09:45:32'),
(57, 1, 15, 'Belarus', 'N', '2018-10-14 10:49:03', '2018-10-14 10:49:03'),
(58, 1, 15, 'Australia', 'Y', '2018-10-14 10:49:03', '2018-10-14 10:49:03'),
(59, 1, 15, 'United States', 'N', '2018-10-14 10:49:03', '2018-10-14 10:49:03'),
(60, 1, 15, 'Thailand', 'N', '2018-10-14 10:49:03', '2018-10-14 10:49:03'),
(61, 1, 16, 'Russia', 'Y', '2018-10-14 10:49:46', '2018-10-14 10:49:46'),
(62, 1, 16, 'Canada', 'N', '2018-10-14 10:49:46', '2018-10-14 10:49:46'),
(63, 1, 16, 'Finland', 'N', '2018-10-14 10:49:46', '2018-10-14 10:49:46'),
(64, 1, 16, 'Norway', 'N', '2018-10-14 10:49:46', '2018-10-14 10:49:46'),
(65, 1, 17, 'democracy', 'N', '2018-10-14 10:50:29', '2018-10-14 10:50:29'),
(66, 1, 17, 'republic', 'N', '2018-10-14 10:50:29', '2018-10-14 10:50:29'),
(67, 1, 17, 'kingdom', 'N', '2018-10-14 10:50:29', '2018-10-14 10:50:29'),
(68, 1, 17, 'sultanate', 'Y', '2018-10-14 10:50:29', '2018-10-14 10:50:29'),
(69, 1, 18, 'Scotland', 'Y', '2018-10-14 10:51:14', '2018-10-14 10:51:14'),
(70, 1, 18, 'Germany', 'N', '2018-10-14 10:51:14', '2018-10-14 10:51:14'),
(71, 1, 18, 'Great Britain', 'N', '2018-10-14 10:51:14', '2018-10-14 10:51:14'),
(72, 1, 18, 'Italy', 'N', '2018-10-14 10:51:14', '2018-10-14 10:51:14'),
(73, 1, 19, 'United States', 'N', '2018-10-14 10:51:50', '2018-10-14 10:51:50'),
(74, 1, 19, 'Australia', 'N', '2018-10-14 10:51:50', '2018-10-14 10:51:50'),
(75, 1, 19, 'Canada', 'N', '2018-10-14 10:51:50', '2018-10-14 10:51:50'),
(76, 1, 19, 'India', 'Y', '2018-10-14 10:51:50', '2018-10-14 10:51:50'),
(77, 1, 20, 'Canada', 'Y', '2018-10-14 10:52:17', '2018-10-14 10:52:17'),
(78, 1, 20, 'China', 'N', '2018-10-14 10:52:17', '2018-10-14 10:52:17'),
(79, 1, 20, 'India', 'N', '2018-10-14 10:52:17', '2018-10-14 10:52:17'),
(80, 1, 20, 'Russia', 'N', '2018-10-14 10:52:17', '2018-10-14 10:52:17'),
(81, 1, 21, 'France', 'N', '2018-10-14 10:52:49', '2018-10-14 10:52:49'),
(82, 1, 21, 'Thailand', 'N', '2018-10-14 10:52:49', '2018-10-14 10:52:49'),
(83, 1, 21, 'England', 'Y', '2018-10-14 10:52:49', '2018-10-14 10:52:49'),
(84, 1, 21, 'Poland', 'N', '2018-10-14 10:52:49', '2018-10-14 10:52:49'),
(85, 1, 22, 'France', 'N', '2018-10-14 10:54:23', '2018-10-14 10:54:23'),
(86, 1, 22, 'Switzerland', 'Y', '2018-10-14 10:54:23', '2018-10-14 10:54:23'),
(87, 1, 22, 'Germany', 'N', '2018-10-14 10:54:23', '2018-10-14 10:54:23'),
(88, 1, 22, 'Belgium', 'N', '2018-10-14 10:54:23', '2018-10-14 10:54:23'),
(89, 1, 23, 'Saudi Arabia', 'Y', '2018-10-14 11:03:04', '2018-10-14 11:03:04'),
(90, 1, 23, 'China', 'N', '2018-10-14 11:03:04', '2018-10-14 11:03:04'),
(91, 1, 23, 'Oman', 'N', '2018-10-14 11:03:04', '2018-10-14 11:03:04'),
(92, 1, 23, 'France', 'N', '2018-10-14 11:03:04', '2018-10-14 11:03:04'),
(93, 1, 24, 'Madrid river', 'N', '2018-10-14 11:04:12', '2018-10-14 11:04:12'),
(94, 1, 24, 'River Side', 'N', '2018-10-14 11:04:12', '2018-10-14 11:04:12'),
(95, 1, 24, 'River Seine', 'Y', '2018-10-14 11:04:12', '2018-10-14 11:04:12'),
(96, 1, 24, 'Chaupchraya river', 'N', '2018-10-14 11:04:12', '2018-10-14 11:04:12'),
(97, 1, 25, 'Isle Big Ban', 'N', '2018-10-14 11:05:26', '2018-10-14 11:05:26'),
(98, 1, 25, 'Isle of Man', 'Y', '2018-10-14 11:05:26', '2018-10-14 11:05:26'),
(99, 1, 25, 'Isle of Woman', 'N', '2018-10-14 11:05:26', '2018-10-14 11:05:26'),
(100, 1, 25, 'Isle of Britain', 'N', '2018-10-14 11:05:26', '2018-10-14 11:05:26'),
(101, 1, 26, 'Skopye', 'N', '2018-10-14 11:06:53', '2018-10-14 11:06:53'),
(102, 1, 26, 'Kiev', 'N', '2018-10-14 11:06:53', '2018-10-14 11:06:53'),
(103, 1, 26, 'Ljubljana', 'Y', '2018-10-14 11:06:53', '2018-10-14 11:06:53'),
(104, 1, 26, 'Warshawa', 'N', '2018-10-14 11:06:53', '2018-10-14 11:06:53'),
(105, 1, 27, 'Belgium', 'N', '2018-10-14 11:08:58', '2018-10-14 11:08:58'),
(106, 1, 27, 'Italy', 'N', '2018-10-14 11:08:58', '2018-10-14 11:08:58'),
(107, 1, 27, 'Thailand', 'N', '2018-10-14 11:08:58', '2018-10-14 11:08:58'),
(108, 1, 27, 'Germany', 'Y', '2018-10-14 11:08:58', '2018-10-14 11:08:58'),
(109, 1, 28, 'Thailand', 'N', '2018-10-14 11:10:29', '2018-10-14 11:10:29'),
(110, 1, 28, 'Mongolia', 'Y', '2018-10-14 11:10:29', '2018-10-14 11:10:29'),
(111, 1, 28, 'Brazil', 'N', '2018-10-14 11:10:29', '2018-10-14 11:10:29'),
(112, 1, 28, 'Vietnam', 'N', '2018-10-14 11:10:29', '2018-10-14 11:10:29'),
(113, 1, 29, 'Port of Rotterdam', 'Y', '2018-10-14 11:12:10', '2018-10-14 11:12:10'),
(114, 1, 29, 'Berlin', 'N', '2018-10-14 11:12:10', '2018-10-14 11:12:10'),
(115, 1, 29, 'Birmingham', 'N', '2018-10-14 11:12:10', '2018-10-14 11:12:10'),
(116, 1, 29, 'Barcelona', 'N', '2018-10-14 11:12:10', '2018-10-14 11:12:10'),
(117, 1, 30, 'Cairo', 'N', '2018-10-14 11:16:32', '2018-10-14 11:16:32'),
(118, 1, 30, 'Bermuda', 'Y', '2018-10-14 11:16:32', '2018-10-14 11:16:32'),
(119, 1, 30, 'Vialette', 'N', '2018-10-14 11:16:32', '2018-10-14 11:16:32'),
(120, 1, 30, 'Kual Lumpur', 'N', '2018-10-14 11:16:32', '2018-10-14 11:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_games`
--

CREATE TABLE `quiz_game_games` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `for_specific_user` int(191) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_games`
--

INSERT INTO `quiz_game_games` (`id`, `user_id`, `title`, `for_specific_user`, `created_at`, `updated_at`) VALUES
(1, 1, 'География', 0, '2018-10-14 09:20:15', '2018-10-14 09:23:09'),
(2, 1, 'Geographic quiz', 0, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(3, 1, 'World Questions', 0, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(4, 1, 'World Quiz 2', 0, '2018-10-14 11:25:09', '2018-10-14 11:25:09');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_game_items`
--

CREATE TABLE `quiz_game_game_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `game_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_game_items`
--

INSERT INTO `quiz_game_game_items` (`id`, `game_id`, `question_id`, `created_at`, `updated_at`) VALUES
(1, 1, 1, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(2, 1, 2, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(3, 1, 3, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(4, 1, 4, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(5, 1, 5, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(6, 1, 6, '2018-10-14 09:20:15', '2018-10-14 09:20:15'),
(7, 2, 7, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(8, 2, 8, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(9, 2, 9, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(10, 2, 12, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(11, 2, 11, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(12, 2, 10, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(13, 2, 13, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(14, 2, 14, '2018-10-14 10:32:29', '2018-10-14 10:32:29'),
(15, 3, 15, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(16, 3, 16, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(17, 3, 17, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(18, 3, 18, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(19, 3, 19, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(20, 3, 20, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(21, 3, 21, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(22, 3, 22, '2018-10-14 10:55:37', '2018-10-14 10:55:37'),
(23, 4, 23, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(24, 4, 24, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(25, 4, 25, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(26, 4, 26, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(27, 4, 27, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(28, 4, 28, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(29, 4, 29, '2018-10-14 11:25:09', '2018-10-14 11:25:09'),
(30, 4, 30, '2018-10-14 11:25:09', '2018-10-14 11:25:09');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_game_results`
--

CREATE TABLE `quiz_game_game_results` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `status` enum('Y','N') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'N',
  `time` int(11) NOT NULL,
  `game_type` enum('P','G') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'P',
  `game_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_game_results`
--

INSERT INTO `quiz_game_game_results` (`id`, `user_id`, `game_id`, `question_id`, `answer_id`, `status`, `time`, `game_type`, `game_code`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 1, 'Y', 7, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(2, 1, 1, 2, 8, 'N', 6, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(3, 1, 1, 3, 12, 'Y', 5, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(4, 1, 1, 4, 13, 'N', 4, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(5, 1, 1, 5, 18, 'Y', 8, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(6, 1, 1, 6, 23, 'Y', 7, 'P', NULL, '2018-10-14 09:21:21', '2018-10-14 09:21:21'),
(7, 1, 2, 7, 26, 'Y', 3, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(8, 1, 2, 8, 30, 'N', 9, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(9, 1, 2, 9, 34, 'Y', 8, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(10, 1, 2, 12, 45, 'N', 8, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(11, 1, 2, 11, 43, 'Y', 5, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(12, 1, 2, 10, 38, 'N', 8, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(13, 1, 2, 13, 50, 'Y', 9, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(14, 1, 2, 14, 56, 'N', 7, 'P', NULL, '2018-10-14 10:33:34', '2018-10-14 10:33:34'),
(15, 1, 1, 1, 2, 'N', 8, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(16, 1, 1, 2, 6, 'Y', 2, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(17, 1, 1, 3, 12, 'Y', 3, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(18, 1, 1, 4, 14, 'Y', 6, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(19, 1, 1, 5, 18, 'Y', 4, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(20, 1, 1, 6, 23, 'Y', 7, 'P', NULL, '2018-10-14 10:42:07', '2018-10-14 10:42:07'),
(21, 1, 2, 7, 26, 'Y', 9, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(22, 1, 2, 8, 31, 'Y', 8, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(23, 1, 2, 9, 34, 'Y', 8, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(24, 1, 2, 12, 46, 'N', 8, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(25, 1, 2, 11, 43, 'Y', 8, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(26, 1, 2, 10, 40, 'Y', 6, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(27, 1, 2, 13, 50, 'Y', 7, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08'),
(28, 1, 2, 14, 56, 'N', 8, 'P', NULL, '2018-10-14 10:43:08', '2018-10-14 10:43:08');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_migrations`
--

CREATE TABLE `quiz_game_migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_migrations`
--

INSERT INTO `quiz_game_migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2018_09_15_155303_create_questions_table', 1),
(4, '2018_09_15_155321_create_answers_table', 1),
(5, '2018_09_15_155335_create_games_table', 1),
(6, '2018_09_17_064505_create_game_items_table', 2),
(7, '2018_09_23_183829_create_game_results_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_password_resets`
--

CREATE TABLE `quiz_game_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_questions`
--

CREATE TABLE `quiz_game_questions` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `question` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_questions`
--

INSERT INTO `quiz_game_questions` (`id`, `user_id`, `question`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ближайшая к Солнцу планета', '2018-10-14 09:13:03', '2018-10-14 09:13:03'),
(2, 1, 'Наибольший угол падения солнечных лучей два раза в год наблюдается в районе', '2018-10-14 09:15:34', '2018-10-14 09:15:34'),
(3, 1, 'Линия, условно проведенная от одного полюса Земли к другому, называется', '2018-10-14 09:16:40', '2018-10-14 09:16:40'),
(4, 1, 'Самые высокие горы на Земле', '2018-10-14 09:17:54', '2018-10-14 09:17:54'),
(5, 1, 'Вулкан на полуострове Камчатка', '2018-10-14 09:18:53', '2018-10-14 09:18:53'),
(6, 1, 'Горы, разделяющие Европу и Азию', '2018-10-14 09:19:39', '2018-10-14 09:19:39'),
(7, 1, 'What is the only country through which both the equator and the Tropic of Capricorn pass?', '2018-10-14 09:29:20', '2018-10-14 09:29:20'),
(8, 1, 'What country calls itself Nippon?', '2018-10-14 09:30:01', '2018-10-14 09:30:01'),
(9, 1, 'What country was known as Rhodesia?', '2018-10-14 09:31:00', '2018-10-14 09:31:00'),
(10, 1, 'Where was the greatest difference between annual high and low temperatures recorded?', '2018-10-14 09:31:52', '2018-10-14 09:31:52'),
(11, 1, 'In which country were bananas first grown?', '2018-10-14 09:32:33', '2018-10-14 09:32:33'),
(12, 1, 'Where is the world’s highest annual average rainfall?', '2018-10-14 09:33:17', '2018-10-14 09:33:17'),
(13, 1, 'What country has the most wild bears?', '2018-10-14 09:34:10', '2018-10-14 09:34:10'),
(14, 1, 'Which American state has the most interstate highway kilometers?', '2018-10-14 09:45:32', '2018-10-14 09:45:32'),
(15, 1, 'In what country is the death penalty for crime forbidden?', '2018-10-14 10:49:03', '2018-10-14 10:49:03'),
(16, 1, 'In what country are the world’s ten coldest cities located?', '2018-10-14 10:49:46', '2018-10-14 10:49:46'),
(17, 1, 'What kind of government is that of Oman?', '2018-10-14 10:50:29', '2018-10-14 10:50:29'),
(18, 1, 'In what country might you find the Loch Ness monster?', '2018-10-14 10:51:14', '2018-10-14 10:51:14'),
(19, 1, 'What country does not use the dollar?', '2018-10-14 10:51:50', '2018-10-14 10:51:50'),
(20, 1, 'What is the world’s second largest country?', '2018-10-14 10:52:17', '2018-10-14 10:52:17'),
(21, 1, 'In what country does Arsenal play?', '2018-10-14 10:52:49', '2018-10-14 10:52:49'),
(22, 1, 'What nation is divided into cantons?', '2018-10-14 10:54:23', '2018-10-14 10:54:23'),
(23, 1, 'What is the only country with a coastline on both the Red Sea and the Persian Gulf?', '2018-10-14 11:03:04', '2018-10-14 11:03:04'),
(24, 1, 'Which river flows through Paris?', '2018-10-14 11:04:12', '2018-10-14 11:04:12'),
(25, 1, 'Where in the British isles is Lady Isabella, the world’s largest working water wheel?', '2018-10-14 11:05:26', '2018-10-14 11:05:26'),
(26, 1, 'What is the capital city of Slovenia, formerly part of the state of Yugoslavia?', '2018-10-14 11:06:53', '2018-10-14 11:06:53'),
(27, 1, 'Which European country shares its border with the most neighbours (nine)?', '2018-10-14 11:08:58', '2018-10-14 11:08:58'),
(28, 1, 'Which Asian country is bigger than France, Spain and Germany combined but has a population of little over two million?', '2018-10-14 11:10:29', '2018-10-14 11:10:29'),
(29, 1, 'What is Europe’s largest port?', '2018-10-14 11:12:10', '2018-10-14 11:12:10'),
(30, 1, 'Hamilton is the capital of which island in the North Atlantic Ocean?', '2018-10-14 11:16:32', '2018-10-14 11:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_game_users`
--

CREATE TABLE `quiz_game_users` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `quiz_game_users`
--

INSERT INTO `quiz_game_users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Maksim', 'maksim@gmail.com', NULL, '$2y$10$oYVnm33HckQaQlnIzwqMZefcrSs37nNGRxpK5.0WOoggNengYeVuG', 'LoQjERO7NYPm7xH6HwFTiqL7StqIFBCObHWjuFP9PqV2TdF5IsHrnX3Hcsyz', '2018-09-15 13:01:12', '2018-09-15 13:01:12'),
(2, 'Anna', 'anna@gmail.com', NULL, '$2y$10$K/Y2Jdij.i6Lt1UDsXeN7eZsScIxP5lh1vG4UCQaqOEaLc58NugnO', NULL, '2018-09-24 15:24:47', '2018-09-24 15:24:47'),
(3, 'John', 'john@gmail.com', NULL, '$2y$10$5qAH7sZ/9Vjv1pDVEpOzRe/8l638uxyBKX/5AyRaKHADoZ4fro4x.', 'g5PqkeVKBkaXnL8lccDa9GphfxSMb6srrmfmbKPq5thHEcWJmAqd7n7s1vyK', '2018-09-24 17:33:40', '2018-09-24 17:33:40');

-- --------------------------------------------------------

--
-- Table structure for table `songs`
--

CREATE TABLE `songs` (
  `id` int(10) UNSIGNED NOT NULL,
  `album_id` int(10) UNSIGNED NOT NULL,
  `track_title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `duration` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `songs`
--

INSERT INTO `songs` (`id`, `album_id`, `track_title`, `duration`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Loosing Grip', '3:54', '2017-02-12 14:02:38', '2017-02-12 14:02:38', NULL),
(2, 1, 'Complicated', '4:05', '2017-02-12 14:03:02', '2017-02-12 14:03:02', NULL),
(3, 1, 'Skater Boy', '3:24', '2017-02-12 14:03:24', '2017-02-12 14:03:24', NULL),
(4, 1, 'I\'m With You', '3:44', '2017-02-12 14:03:49', '2017-02-12 14:03:49', NULL),
(5, 1, 'Mobile', '3:32', '2017-02-12 14:04:09', '2017-02-12 14:04:09', NULL),
(6, 1, 'Unwanted', '3:41', '2017-02-12 14:04:25', '2017-02-12 14:04:25', NULL),
(7, 1, 'Tomorrow', '3:49', '2017-02-12 14:04:42', '2017-02-12 14:04:42', NULL),
(8, 1, 'Anything But Ordinary', '4:11', '2017-02-12 14:05:13', '2017-02-12 14:05:13', NULL),
(9, 1, 'Things I\'ll Never Say', '3:44', '2017-02-12 14:05:39', '2017-02-12 14:05:39', NULL),
(10, 1, 'My World', '3:27', '2017-02-12 14:05:58', '2017-02-12 14:05:58', NULL),
(11, 1, 'Nobody\'s Fool', '3:57', '2017-02-12 14:06:18', '2017-02-12 14:06:18', NULL),
(12, 1, 'Too Much to Ask', '3:45', '2017-02-12 14:06:40', '2017-02-12 14:06:40', NULL),
(13, 1, 'Naked', '4:28', '2017-02-12 14:06:56', '2017-02-12 14:06:56', NULL),
(15, 3, 'Mein Herz Brennt', '4:40', '2017-02-12 14:10:00', '2017-02-12 14:10:00', NULL),
(16, 3, 'Links 2-3-4', '3:37', '2017-02-12 14:11:11', '2017-02-12 14:11:11', NULL),
(17, 3, 'Sonne', '4:33', '2017-02-12 14:11:29', '2017-02-12 14:11:29', NULL),
(18, 3, 'Ich Will', '3:38', '2017-02-12 14:11:47', '2017-02-12 14:11:47', NULL),
(19, 3, 'Feuer Frei!', '3:11', '2017-02-12 14:12:12', '2017-02-12 14:12:12', NULL),
(20, 3, 'Mutter', '4:32', '2017-02-12 14:12:29', '2017-02-12 14:12:29', NULL),
(21, 3, 'Spieluhr', '4:46', '2017-02-12 14:12:56', '2017-02-12 14:12:56', NULL),
(22, 3, 'Zwitter', '4:17', '2017-02-12 14:13:12', '2017-02-12 14:13:12', NULL),
(23, 3, 'Rein Raus', '3:10', '2017-02-12 14:13:36', '2017-02-12 14:13:36', NULL),
(24, 3, 'Adios', '3:48', '2017-02-12 14:13:51', '2017-02-12 14:13:51', NULL),
(25, 3, 'Nebel', '4:55', '2017-02-12 14:14:06', '2017-02-12 14:14:06', NULL),
(26, 4, 'Consideration', '2:41', '2017-02-12 14:17:25', '2017-02-12 14:17:25', NULL),
(27, 4, 'James Joint', '1:12', '2017-02-12 14:18:28', '2017-02-12 14:18:28', NULL),
(28, 4, 'Kiss It Better', '4:13', '2017-02-12 14:19:00', '2017-02-12 14:19:00', NULL),
(29, 4, 'Work', '3:39', '2017-02-12 14:19:16', '2017-02-12 14:19:16', NULL),
(30, 4, 'Desperado', '3:06', '2017-02-12 14:19:41', '2017-02-12 14:19:41', NULL),
(31, 4, 'Woo', '3:56', '2017-02-12 14:19:55', '2017-02-12 14:19:55', NULL),
(32, 4, 'Needed Me', '3:12', '2017-02-12 14:20:13', '2017-02-12 14:20:13', NULL),
(33, 4, 'Yeah, I Said It', '2:13', '2017-02-12 14:20:38', '2017-02-12 14:20:38', NULL),
(34, 4, 'Some OI\'Mistakes', '6:31', '2017-02-12 14:21:08', '2017-02-12 14:21:08', NULL),
(35, 4, 'Never Ending', '3:23', '2017-02-12 14:21:27', '2017-02-12 14:21:27', NULL),
(36, 4, 'Love On the Brain', '3:44', '2017-02-12 14:21:59', '2017-02-12 14:21:59', NULL),
(37, 4, 'Heigher', '2:01', '2017-02-12 14:22:17', '2017-02-12 14:22:17', NULL),
(38, 4, 'Close to You', '3:43', '2017-02-12 14:22:35', '2017-02-12 14:22:35', NULL),
(39, 5, 'Reise, Reise', '4:11', '2017-02-12 14:25:05', '2017-02-12 14:25:05', NULL),
(40, 5, 'Mein Teil', '4:32', '2017-02-12 14:25:26', '2017-02-12 14:25:26', NULL),
(41, 5, 'Dalai Lama', '5:38', '2017-02-12 14:25:45', '2017-02-12 14:25:45', NULL),
(42, 5, 'Keine Lust', '3:45', '2017-02-12 14:26:06', '2017-02-12 14:26:06', NULL),
(43, 5, 'Los', '4:25', '2017-02-12 14:26:21', '2017-02-12 14:26:21', NULL),
(44, 5, 'Amerika', '3:47', '2017-02-12 14:26:43', '2017-02-12 14:26:43', NULL),
(45, 5, 'Moskau', '4:16', '2017-02-12 14:26:59', '2017-02-12 14:26:59', NULL),
(46, 5, 'Morgenstern', '4:00', '2017-02-12 14:27:23', '2017-02-12 14:27:23', NULL),
(47, 5, 'Stein um Stein', '3:56', '2017-02-12 14:27:44', '2017-02-12 14:27:44', NULL),
(48, 5, 'Ohne Dich', '4:32', '2017-02-12 14:28:05', '2017-02-12 14:28:05', NULL),
(49, 5, 'Amour', '4:51', '2017-02-12 14:28:26', '2017-02-12 14:28:26', NULL),
(50, 6, 'Rammlied', '5:19', '2017-02-12 14:33:31', '2017-02-12 14:33:31', NULL),
(51, 6, 'Ich Tu dir Weh', '5:02', '2017-02-12 14:33:57', '2017-02-12 14:33:57', NULL),
(52, 6, 'Waidmanns Heil', '3:33', '2017-02-12 14:34:23', '2017-02-12 14:34:23', NULL),
(53, 6, 'Heifisch', '3:45', '2017-02-12 14:34:49', '2017-02-12 14:34:49', NULL),
(54, 6, 'B********', '4:15', '2017-02-12 14:35:07', '2017-02-12 14:35:07', NULL),
(55, 6, 'Fruhling in Paris', '4:45', '2017-02-12 14:35:37', '2017-02-12 14:35:37', NULL),
(56, 6, 'Wiener Blut', '3:53', '2017-02-12 14:36:00', '2017-02-12 14:36:00', NULL),
(57, 5, 'Pussy', '4:00', '2017-02-12 14:36:18', '2017-02-12 14:36:18', NULL),
(58, 6, 'Liebe ist fur alle Da', '3:26', '2017-02-12 14:36:53', '2017-02-12 14:36:53', NULL),
(59, 6, 'Mehr', '4:09', '2017-02-12 14:37:10', '2017-02-12 14:37:10', NULL),
(60, 6, 'Roter Sand', '3:59', '2017-02-12 14:37:34', '2017-02-12 14:37:34', NULL),
(61, 6, 'Fuhre Mich', '4:34', '2017-02-12 14:37:55', '2017-02-12 14:37:55', NULL),
(62, 6, 'Donaukinder', '5:18', '2017-02-12 14:38:19', '2017-02-12 14:38:19', NULL),
(63, 6, 'Halt', '4:21', '2017-02-12 14:38:35', '2017-02-12 14:38:35', NULL),
(64, 6, 'Liese', '3:56', '2017-02-12 14:38:54', '2017-02-12 14:38:54', NULL),
(65, 7, 'Here To Stay', '4:32', '2017-02-12 14:40:14', '2017-02-12 14:40:14', NULL),
(66, 7, 'Make Believe', '4:37', '2017-02-12 14:40:38', '2017-02-12 14:40:38', NULL),
(67, 7, 'Blame', '3:51', '2017-02-12 14:40:54', '2017-02-12 14:40:54', NULL),
(68, 7, 'Hollow Life', '4:09', '2017-02-12 14:41:18', '2017-02-12 14:41:18', NULL),
(69, 7, 'Bottled Up Inside', '4:00', '2017-02-12 14:41:43', '2017-02-12 14:41:43', NULL),
(70, 7, 'Thoughtless', '4:33', '2017-02-12 14:42:01', '2017-02-12 14:42:01', NULL),
(71, 7, 'Hating', '5:10', '2017-02-12 14:42:18', '2017-02-12 14:42:18', NULL),
(72, 7, 'One More Time', '4:39', '2017-02-12 14:42:37', '2017-02-12 14:42:37', NULL),
(73, 7, 'Alone I Break', '4:17', '2017-02-12 14:42:59', '2017-02-12 14:42:59', NULL),
(74, 7, 'Embrace', '4:27', '2017-02-12 14:43:16', '2017-02-12 14:43:16', NULL),
(75, 7, 'Beat It Upright', '4:16', '2017-02-12 14:43:51', '2017-02-12 14:43:51', NULL),
(76, 7, 'Wake Up Hate', '3:13', '2017-02-12 14:44:22', '2017-02-12 14:44:22', NULL),
(77, 7, 'I\'m Hiding', '3:57', '2017-02-12 14:44:45', '2017-02-12 14:44:45', NULL),
(78, 7, 'No One\'s There', '5:01', '2017-02-12 14:45:06', '2017-02-12 14:45:06', NULL),
(79, 9, 'Sale el Sol', '3:21', '2017-02-12 14:47:57', '2017-09-08 11:53:23', NULL),
(80, 9, 'Loka', '3:13', '2017-02-12 14:48:15', '2017-02-12 14:48:15', NULL),
(81, 9, 'Antes de las Seis', '2:55', '2017-02-12 14:48:48', '2017-02-12 14:48:48', NULL),
(82, 9, 'Gordita', '3:26', '2017-02-12 14:49:08', '2017-02-12 14:49:08', NULL),
(83, 9, 'Addicted to You', '2:27', '2017-02-12 14:49:28', '2017-02-12 14:49:28', NULL),
(84, 9, 'Lo que mas', '2:27', '2017-02-12 14:49:49', '2017-02-12 14:49:49', NULL),
(85, 9, 'Mariposa', '3:47', '2017-02-12 14:50:11', '2017-02-12 14:50:11', NULL),
(86, 9, 'Rabiosa', '2:50', '2017-02-12 14:50:34', '2017-02-12 14:50:34', NULL),
(87, 9, 'Devocion', '3:30', '2017-02-12 14:50:53', '2017-02-12 14:50:53', NULL),
(88, 9, 'Islands', '2:43', '2017-02-12 14:51:10', '2017-02-12 14:51:10', NULL),
(89, 9, 'Tu Boca', '3:26', '2017-02-12 14:51:30', '2017-02-12 14:51:30', NULL),
(90, 9, 'Waka Waka', '3:04', '2017-02-12 14:51:49', '2017-02-12 14:51:49', NULL),
(91, 10, 'Infinite', '4:01', '2017-02-12 14:53:33', '2017-02-12 14:53:33', NULL),
(92, 10, 'W.E.G.O', '2:56', '2017-02-12 14:53:54', '2017-02-12 14:53:54', NULL),
(93, 10, 'It\'s OK', '3:29', '2017-02-12 14:54:13', '2017-02-12 14:54:13', NULL),
(94, 10, 'Tonite', '3:43', '2017-02-12 14:54:33', '2017-02-12 14:54:33', NULL),
(95, 1, '313', '4:11', '2017-02-12 14:54:53', '2017-02-12 14:54:53', NULL),
(96, 10, 'Maxine', '3:55', '2017-02-12 14:55:09', '2017-02-12 14:55:09', NULL),
(97, 10, 'Open Mic', '4:02', '2017-02-12 14:55:26', '2017-02-12 14:55:26', NULL),
(98, 10, 'Never 2 Far', '3:38', '2017-02-12 14:55:51', '2017-02-12 14:55:51', NULL),
(99, 10, 'Searchin', '3:45', '2017-02-12 14:56:14', '2017-02-12 14:56:14', NULL),
(100, 10, 'Backstabber', '3:24', '2017-02-12 14:56:35', '2017-02-12 14:56:35', NULL),
(101, 10, 'Jealousy Woes II', '3:19', '2017-02-12 14:57:03', '2017-02-12 14:57:03', NULL),
(102, 1, 'ghjk', 'ghjkl', '2017-02-14 02:25:30', '2017-02-14 02:25:30', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `albums`
--
ALTER TABLE `albums`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_answers`
--
ALTER TABLE `quiz_game_answers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_games`
--
ALTER TABLE `quiz_game_games`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_game_items`
--
ALTER TABLE `quiz_game_game_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_game_results`
--
ALTER TABLE `quiz_game_game_results`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_migrations`
--
ALTER TABLE `quiz_game_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_questions`
--
ALTER TABLE `quiz_game_questions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_game_users`
--
ALTER TABLE `quiz_game_users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `songs`
--
ALTER TABLE `songs`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `albums`
--
ALTER TABLE `albums`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `quiz_game_answers`
--
ALTER TABLE `quiz_game_answers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `quiz_game_games`
--
ALTER TABLE `quiz_game_games`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `quiz_game_game_items`
--
ALTER TABLE `quiz_game_game_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `quiz_game_game_results`
--
ALTER TABLE `quiz_game_game_results`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `quiz_game_migrations`
--
ALTER TABLE `quiz_game_migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `quiz_game_questions`
--
ALTER TABLE `quiz_game_questions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `quiz_game_users`
--
ALTER TABLE `quiz_game_users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `songs`
--
ALTER TABLE `songs`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
