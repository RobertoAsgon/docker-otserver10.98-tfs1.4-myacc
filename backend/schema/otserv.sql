-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 12-Fev-2023 às 21:31
-- Versão do servidor: 5.7.41
-- versão do PHP: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `otserv`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT '1',
  `premium_ends_at` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `email` varchar(255) NOT NULL DEFAULT '',
  `key` varchar(64) NOT NULL DEFAULT '',
  `blocked` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'internal usage',
  `created` int(11) NOT NULL DEFAULT '0',
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(3) NOT NULL DEFAULT '',
  `web_lastlogin` int(11) NOT NULL DEFAULT '0',
  `web_flags` int(11) NOT NULL DEFAULT '0',
  `email_hash` varchar(32) NOT NULL DEFAULT '',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int(11) NOT NULL DEFAULT '0',
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `email_next` int(11) NOT NULL DEFAULT '0',
  `premium_points` int(11) NOT NULL DEFAULT '0',
  `email_verified` tinyint(1) NOT NULL DEFAULT '0',
  `creation` int(11) NOT NULL DEFAULT '0',
  `vote` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `secret`, `type`, `premium_ends_at`, `email`, `key`, `blocked`, `created`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_new`, `email_new_time`, `email_code`, `email_next`, `premium_points`, `email_verified`, `creation`, `vote`) VALUES
(1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', NULL, 5, 0, 'admin@admin.com', '', 0, 1676234685, '', '', 'us', 0, 3, '', '', 0, '', 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_storage`
--

CREATE TABLE `account_storage` (
  `account_id` int(11) NOT NULL,
  `key` int(10) UNSIGNED NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(3) UNSIGNED NOT NULL DEFAULT '0',
  `notify` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `logo_name` varchar(255) NOT NULL DEFAULT 'default.gif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Acionadores `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT '0',
  `targetguild` int(11) NOT NULL DEFAULT '0',
  `warid` int(11) NOT NULL DEFAULT '0',
  `time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `guild_id` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT '0',
  `guild2` int(11) NOT NULL DEFAULT '0',
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `started` bigint(20) NOT NULL DEFAULT '0',
  `ended` bigint(20) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `warnings` int(11) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '0',
  `bid` int(11) NOT NULL DEFAULT '0',
  `bid_end` int(11) NOT NULL DEFAULT '0',
  `last_bid` int(11) NOT NULL DEFAULT '0',
  `highest_bidder` int(11) NOT NULL DEFAULT '0',
  `size` int(11) NOT NULL DEFAULT '0',
  `beds` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_history`
--

CREATE TABLE `market_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(4) NOT NULL DEFAULT '0',
  `price` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_account_actions`
--

CREATE TABLE `myaac_account_actions` (
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `date` int(11) NOT NULL DEFAULT '0',
  `action` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_account_actions`
--

INSERT INTO `myaac_account_actions` (`account_id`, `ip`, `ipv6`, `date`, `action`) VALUES
(1, 2887254017, 0x00000000000000000000000000000000, 1676234685, 'Account created.'),
(2, 2887254017, 0x00000000000000000000000000000000, 1676235073, 'Account created.'),
(2, 2887254017, 0x00000000000000000000000000000000, 1676235073, 'Created character <b>Teste</b>.'),
(2, 2887254017, 0x00000000000000000000000000000000, 1676235221, 'Account password changed.'),
(3, 2887254017, 0x00000000000000000000000000000000, 1676235679, 'Account created.'),
(3, 2887254017, 0x00000000000000000000000000000000, 1676235679, 'Created character <b>Testeew</b>.'),
(4, 2887254017, 0x00000000000000000000000000000000, 1676236204, 'Account created.'),
(4, 2887254017, 0x00000000000000000000000000000000, 1676236205, 'Created character <b>Testeasd</b>.');

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_admin_menu`
--

CREATE TABLE `myaac_admin_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `flags` int(11) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_bugtracker`
--

CREATE TABLE `myaac_bugtracker` (
  `account` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `text` text NOT NULL,
  `id` int(11) NOT NULL DEFAULT '0',
  `subject` varchar(255) NOT NULL DEFAULT '',
  `reply` int(11) NOT NULL DEFAULT '0',
  `who` int(11) NOT NULL DEFAULT '0',
  `uid` int(11) NOT NULL,
  `tag` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_changelog`
--

CREATE TABLE `myaac_changelog` (
  `id` int(11) NOT NULL,
  `body` varchar(500) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',
  `where` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - server, 2 - site',
  `date` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_changelog`
--

INSERT INTO `myaac_changelog` (`id`, `body`, `type`, `where`, `date`, `player_id`, `hidden`) VALUES
(1, 'MyAAC installed. (:', 3, 2, 1676234632, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_charbazaar`
--

CREATE TABLE `myaac_charbazaar` (
  `id` int(11) NOT NULL,
  `account_old` int(11) NOT NULL,
  `account_new` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `date_end` datetime NOT NULL,
  `date_start` datetime NOT NULL,
  `bid_account` int(11) NOT NULL,
  `bid_price` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_charbazaar_bid`
--

CREATE TABLE `myaac_charbazaar_bid` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `bid` int(11) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_config`
--

CREATE TABLE `myaac_config` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_config`
--

INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES
(1, 'database_version', '33'),
(2, 'status_online', ''),
(3, 'status_players', '0'),
(4, 'status_playersMax', '0'),
(5, 'status_lastCheck', '0'),
(6, 'status_uptime', '0h 0m'),
(7, 'status_monsters', '0'),
(8, 'last_usage_report', '1674247776'),
(9, 'views_counter', '50');

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_faq`
--

CREATE TABLE `myaac_faq` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(1020) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_forum`
--

CREATE TABLE `myaac_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT '0',
  `last_post` int(11) NOT NULL DEFAULT '0',
  `section` int(3) NOT NULL DEFAULT '0',
  `replies` int(20) NOT NULL DEFAULT '0',
  `views` int(20) NOT NULL DEFAULT '0',
  `author_aid` int(20) NOT NULL DEFAULT '0',
  `author_guid` int(20) NOT NULL DEFAULT '0',
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL DEFAULT '',
  `post_smile` tinyint(1) NOT NULL DEFAULT '0',
  `post_html` tinyint(1) NOT NULL DEFAULT '0',
  `post_date` int(20) NOT NULL DEFAULT '0',
  `last_edit_aid` int(20) NOT NULL DEFAULT '0',
  `edit_date` int(20) NOT NULL DEFAULT '0',
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `sticked` tinyint(1) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_forum_boards`
--

CREATE TABLE `myaac_forum_boards` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `guild` int(11) NOT NULL DEFAULT '0',
  `access` int(11) NOT NULL DEFAULT '0',
  `closed` tinyint(1) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_forum_boards`
--

INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hidden`) VALUES
(1, 'News', 'News commenting', 0, 0, 0, 1, 0),
(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),
(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),
(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),
(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_gallery`
--

CREATE TABLE `myaac_gallery` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_gallery`
--

INSERT INTO `myaac_gallery` (`id`, `comment`, `image`, `thumb`, `author`, `ordering`, `hidden`) VALUES
(1, 'Demon', 'images/gallery/demon.jpg', 'images/gallery/demon_thumb.gif', 'MyAAC', 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_menu`
--

CREATE TABLE `myaac_menu` (
  `id` int(11) NOT NULL,
  `template` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(6) NOT NULL DEFAULT '',
  `category` int(11) NOT NULL DEFAULT '1',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `enabled` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_menu`
--

INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES
(1, 'tibiacom', 'Latest News', 'news', 0, '', 1, 0, 1),
(2, 'tibiacom', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(3, 'tibiacom', 'Event Schedule', 'eventcalendar', 0, '', 1, 2, 1),
(4, 'tibiacom', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(5, 'tibiacom', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(6, 'tibiacom', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(7, 'tibiacom', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(8, 'tibiacom', 'Downloads', 'downloadclient', 0, '', 2, 4, 1),
(9, 'tibiacom', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(10, 'tibiacom', 'Characters', 'characters', 0, '', 3, 0, 1),
(11, 'tibiacom', 'Who Is Online?', 'online', 0, '', 3, 1, 1),
(12, 'tibiacom', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(13, 'tibiacom', 'Last Kills', 'lastkills', 0, '', 3, 3, 1),
(14, 'tibiacom', 'Houses', 'houses', 0, '', 3, 4, 1),
(15, 'tibiacom', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(16, 'tibiacom', 'Polls', 'polls', 0, '', 3, 6, 1),
(17, 'tibiacom', 'Bans', 'bans', 0, '', 3, 7, 1),
(18, 'tibiacom', 'Support List', 'team', 0, '', 3, 8, 1),
(19, 'tibiacom', 'Forum', 'forum', 0, '', 4, 0, 1),
(20, 'tibiacom', 'Creatures', 'creatures', 0, '', 5, 0, 1),
(21, 'tibiacom', 'Spells', 'spells', 0, '', 5, 1, 1),
(22, 'tibiacom', 'Commands', 'commands', 0, '', 5, 2, 1),
(23, 'tibiacom', 'Exp Stages', 'experienceStages', 0, '', 5, 3, 1),
(24, 'tibiacom', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(25, 'tibiacom', 'Server Info', 'serverInfo', 0, '', 5, 5, 1),
(26, 'tibiacom', 'Experience Table', 'experienceTable', 0, '', 5, 6, 1),
(27, 'tibiacom', 'Current Auctions', 'currentcharactertrades', 0, '', 7, 0, 1),
(28, 'tibiacom', 'Auction History', 'pastcharactertrades', 0, '', 7, 1, 1),
(29, 'tibiacom', 'My Bids', 'ownbids', 0, '', 7, 2, 1),
(30, 'tibiacom', 'My Auctions', 'owncharactertrades', 0, '', 7, 3, 1),
(31, 'tibiacom', 'Create Auction', 'createcharacterauction', 0, '', 7, 4, 1),
(32, 'tibiacom', 'Buy Points', 'points', 0, '', 6, 0, 1),
(33, 'tibiacom', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(34, 'tibiacom', 'Shop History', 'gifts/history', 0, '', 6, 2, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_monsters`
--

CREATE TABLE `myaac_monsters` (
  `id` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT '0',
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `speed_lvl` int(11) NOT NULL DEFAULT '1',
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `elements` text NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `pushable` tinyint(1) NOT NULL DEFAULT '0',
  `canpushitems` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonenergy` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonpoison` tinyint(1) NOT NULL DEFAULT '0',
  `canwalkonfire` tinyint(1) NOT NULL DEFAULT '0',
  `runonhealth` tinyint(1) NOT NULL DEFAULT '0',
  `hostile` tinyint(1) NOT NULL DEFAULT '0',
  `attackable` tinyint(1) NOT NULL DEFAULT '0',
  `rewardboss` tinyint(1) NOT NULL DEFAULT '0',
  `defense` int(11) NOT NULL DEFAULT '0',
  `armor` int(11) NOT NULL DEFAULT '0',
  `canpushcreatures` tinyint(1) NOT NULL DEFAULT '0',
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL,
  `summons` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_news`
--

CREATE TABLE `myaac_news` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - news, 2 - ticker, 3 - article',
  `date` int(11) NOT NULL DEFAULT '0',
  `category` tinyint(1) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `last_modified_by` int(11) NOT NULL DEFAULT '0',
  `last_modified_date` int(11) NOT NULL DEFAULT '0',
  `comments` varchar(50) NOT NULL DEFAULT '',
  `article_text` varchar(300) NOT NULL DEFAULT '',
  `article_image` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_news`
--

INSERT INTO `myaac_news` (`id`, `title`, `body`, `type`, `date`, `category`, `player_id`, `last_modified_by`, `last_modified_date`, `comments`, `article_text`, `article_image`, `hidden`) VALUES
(1, 'Hello!', 'MyAAC is just READY to use!', 1, 1676234685, 2, 1, 0, 0, 'https://my-aac.org', '', '', 0),
(2, 'Hello tickets!', 'https://my-aac.org', 2, 1676234685, 4, 1, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_news_categories`
--

CREATE TABLE `myaac_news_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `icon_id` int(2) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_news_categories`
--

INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hidden`) VALUES
(1, '', '', 0, 0),
(2, '', '', 1, 0),
(3, '', '', 2, 0),
(4, '', '', 3, 0),
(5, '', '', 4, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_notepad`
--

CREATE TABLE `myaac_notepad` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_pages`
--

CREATE TABLE `myaac_pages` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` text NOT NULL,
  `date` int(11) NOT NULL DEFAULT '0',
  `player_id` int(11) NOT NULL DEFAULT '0',
  `php` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - plain html, 1 - php',
  `enable_tinymce` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1 - enabled, 0 - disabled',
  `access` tinyint(2) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_pages`
--

INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hidden`) VALUES
(1, 'downloads', 'Downloads', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<div style=\"text-align: center;\">We\'re using official Tibia Client <strong>{{ config.client / 100 }}</strong><br />\n<p>Download Tibia Client <strong>{{ config.client / 100 }}</strong>&nbsp;for Windows <a href=\"https://drive.google.com/drive/folders/0B2-sMQkWYzhGSFhGVlY2WGk5czQ\" target=\"_blank\" rel=\"noopener\">HERE</a>.</p>\n<h2>IP Changer:</h2>\n<a href=\"https://static.otland.net/ipchanger.exe\" target=\"_blank\" rel=\"noopener\">HERE</a></div>', 0, 1, 0, 1, 1, 0),
(2, 'commands', 'Commands', '<table style=\"border-collapse: collapse; width: 87.8471%; height: 57px;\" border=\"1\">\n<tbody>\n<tr style=\"height: 18px;\">\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Description</strong></span></td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!example</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">This is just an example</td>\n</tr>\n<tr style=\"height: 18px; background-color: #d4c0a1;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!buyhouse</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy house you are looking at</td>\n</tr>\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\n<td style=\"width: 33.3333%; height: 18px;\"><em>!aol</em></td>\n<td style=\"width: 33.3333%; height: 18px;\">Buy AoL</td>\n</tr>\n</tbody>\n</table>', 0, 1, 0, 1, 1, 0),
(3, 'rules_on_the_page', 'Rules', '1. Names\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\n\n2. Cheating\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\nd) Manipulating the client program or using additional software to play the game.\ne) Trying to steal other players\' account data (\"hacking\").\nf) Playing on more than one account at the same time (\"multi-clienting\").\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\n\n3. Gamemasters\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\n\n4. Player Killing\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\n\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\n\nThese rules may be changed at any time. All changes will be announced on the official website.', 0, 1, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_polls`
--

CREATE TABLE `myaac_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end` int(11) NOT NULL,
  `start` int(11) NOT NULL,
  `answers` int(11) NOT NULL,
  `votes_all` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_polls_answers`
--

CREATE TABLE `myaac_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_spells`
--

CREATE TABLE `myaac_spells` (
  `id` int(11) NOT NULL,
  `spell` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `words` varchar(255) NOT NULL DEFAULT '',
  `category` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - instant, 2 - conjure, 3 - rune',
  `level` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `soul` tinyint(3) NOT NULL DEFAULT '0',
  `conjure_id` int(11) NOT NULL DEFAULT '0',
  `conjure_count` tinyint(3) NOT NULL DEFAULT '0',
  `reagent` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `premium` tinyint(1) NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_spells`
--

INSERT INTO `myaac_spells` (`id`, `spell`, `name`, `words`, `category`, `type`, `level`, `maglevel`, `mana`, `soul`, `conjure_id`, `conjure_count`, `reagent`, `item_id`, `premium`, `vocations`, `hidden`) VALUES
(1, '', 'Annihilation', 'exori gran ico', 0, 1, 0, 0, 300, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(2, '', 'Apprentice\'s Strike', 'exori min flam', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(3, '', 'Berserk', 'exori', 0, 1, 0, 0, 115, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(4, '', 'Brutal Strike', 'exori ico', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(5, '', 'Buzz', 'exori infir vis', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(6, '', 'Chill Out', 'exevo infir frigo hur', 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(7, '', 'Curse', 'utori mort', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(8, '', 'Death Strike', 'exori mort', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(9, '', 'Divine Caldera', 'exevo mas san', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(10, '', 'Divine Missile', 'exori san', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(11, '', 'Electrify', 'utori vis', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(12, '', 'Energy Beam', 'exevo vis lux', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(13, '', 'Energy Strike', 'exori vis', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(14, '', 'Energy Wave', 'exevo vis hur', 0, 1, 0, 0, 170, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(15, '', 'Envenom', 'utori pox', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(16, '', 'Eternal Winter', 'exevo gran mas frigo', 0, 1, 0, 0, 1050, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(17, '', 'Ethereal Spear', 'exori con', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(18, '', 'Fierce Berserk', 'exori gran', 0, 1, 0, 0, 340, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(19, '', 'Fire Wave', 'exevo flam hur', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(20, '', 'Flame Strike', 'exori flam', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(21, '', 'Front Sweep', 'exori min', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(22, '', 'Great Energy Beam', 'exevo gran vis lux', 0, 1, 0, 0, 110, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(23, '', 'Groundshaker', 'exori mas', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(24, '', 'Hell\'s Core', 'exevo gran mas flam', 0, 1, 0, 0, 1100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(25, '', 'Holy Flash', 'utori san', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(26, '', 'Ice Strike', 'exori frigo', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(27, '', 'Ice Wave', 'exevo frigo hur', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(28, '', 'Ignite', 'utori flam', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(29, '', 'Inflict Wound', 'utori kor', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(30, '', 'Lightning', 'exori amp vis', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(31, '', 'Mud Attack', 'exori infir tera', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(32, '', 'Physical Strike', 'exori moe ico', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(33, '', 'Practice Fire Wave', 'exevo dis flam hur', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(34, '', 'Rage of the Skies', 'exevo gran mas vis', 0, 1, 0, 0, 600, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(35, '', 'Scorch', 'exevo infir flam hur', 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(36, '', 'Strong Energy Strike', 'exori gran vis', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(37, '', 'Strong Ethereal Spear', 'exori gran con', 0, 1, 0, 0, 55, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(38, '', 'Strong Flame Strike', 'exori gran flam', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(39, '', 'Strong Ice Strike', 'exori gran frigo', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(40, '', 'Strong Ice Wave', 'exevo gran frigo hur', 0, 1, 0, 0, 170, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(41, '', 'Strong Terra Strike', 'exori gran tera', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(42, '', 'Terra Strike', 'exori tera', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(43, '', 'Terra Wave', 'exevo tera hur', 0, 1, 0, 0, 210, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(44, '', 'Ultimate Energy Strike', 'exori max vis', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(45, '', 'Ultimate Flame Strike', 'exori max flam', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(46, '', 'Ultimate Ice Strike', 'exori max frigo', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(47, '', 'Ultimate Terra Strike', 'exori max tera', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(48, '', 'Whirlwind Throw', 'exori hur', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(49, '', 'Wrath of Nature', 'exevo gran mas tera', 0, 1, 0, 0, 700, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(50, '', 'Bruise Bane', 'exura infir ico', 0, 1, 0, 0, 10, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(51, '', 'Cure Bleeding', 'exana kor', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,4,6,8]', 0),
(52, '', 'Cure Burning', 'exana flam', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(53, '', 'Cure Curse', 'exana mort', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(54, '', 'Cure Electrification', 'exana vis', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(55, '', 'Cure Poison', 'exana pox', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(56, '', 'Divine Healing', 'exura san', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(57, '', 'Heal Friend', 'exura sio', 0, 1, 0, 0, 140, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(58, '', 'Intense Healing', 'exura gran', 0, 1, 0, 0, 70, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(59, '', 'Intense Recovery', 'utura gran', 0, 1, 0, 0, 165, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(60, '', 'Intense Wound Cleansing', 'exura gran ico', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(61, '', 'Light Healing', 'exura', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(62, '', 'Magic Patch', 'exura infir', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(63, '', 'Mass Healing', 'exura gran mas res', 0, 1, 0, 0, 150, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(64, '', 'Practice Healing', 'exura dis', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(65, '', 'Recovery', 'utura', 0, 1, 0, 0, 75, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(66, '', 'Salvation', 'exura gran san', 0, 1, 0, 0, 210, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(67, '', 'Ultimate Healing', 'exura vita', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(68, '', 'Wound Cleansing', 'exura ico', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(69, '', 'Blood Rage', 'utito tempo', 0, 1, 0, 0, 290, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(70, '', 'Cancel Invisibility', 'exana ina', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(71, '', 'Challenge', 'exeta res', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[8]', 0),
(72, '', 'Charge', 'utani tempo hur', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(73, '', 'Creature Illusion', 'utevo res ina', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(74, '', 'Find Person', 'exiva', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(75, '', 'Food', 'exevo pan', 0, 1, 0, 0, 120, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(76, '', 'Great Light', 'utevo gran lux', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(77, '', 'Haste', 'utani hur', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(78, '', 'Invisibility', 'utana vid', 0, 1, 0, 0, 440, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(79, '', 'Levitate', 'exani hur', 0, 1, 0, 0, 50, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(80, '', 'Light', 'utevo lux', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(81, '', 'Magic Rope', 'exani tera', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(82, '', 'Magic Shield', 'utamo vita', 0, 1, 0, 0, 50, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(83, '', 'Protector', 'utamo tempo', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(84, '', 'Sharpshooter', 'utito tempo san', 0, 1, 0, 0, 450, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(85, '', 'Strong Haste', 'utani gran hur', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(86, '', 'Summon Creature', 'utevo res', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(87, '', 'Swift Foot', 'utamo tempo san', 0, 1, 0, 0, 400, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(88, '', 'Ultimate Light', 'utevo vis lux', 0, 1, 0, 0, 140, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(89, '', 'Enchant Party', 'utori mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(90, '', 'Heal Party', 'utura mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(91, '', 'Protect Party', 'utamo mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(92, '', 'Train Party', 'utito mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(93, '', 'Animate Dead Rune', 'adana mort', 0, 1, 0, 0, 600, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(94, '', 'Arrow Call', 'exevo infir con', 0, 1, 0, 0, 10, 1, 0, 0, 0, 0, 0, '[3,7]', 0),
(95, '', 'Avalanche Rune', 'adori mas frigo', 0, 1, 0, 0, 530, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(96, '', 'Blank Rune', 'adori blank', 0, 1, 0, 0, 50, 1, 0, 0, 0, 0, 0, '[2,6,3,7,1,5]', 0),
(97, '', 'Chameleon Rune', 'adevo ina', 0, 1, 0, 0, 600, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(98, '', 'Conjure Arrow', 'exevo con', 0, 1, 0, 0, 100, 1, 0, 0, 0, 0, 0, '[3,7]', 0),
(99, '', 'Conjure Bolt', 'exevo con mort', 0, 1, 0, 0, 140, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(100, '', 'Conjure Explosive Arrow', 'exevo con flam', 0, 1, 0, 0, 290, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(101, '', 'Conjure Piercing Bolt', 'exevo con grav', 0, 1, 0, 0, 180, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(102, '', 'Conjure Poisoned Arrow', 'exevo con pox', 0, 1, 0, 0, 130, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(103, '', 'Conjure Power Bolt', 'exevo con vis', 0, 1, 0, 0, 700, 4, 0, 0, 0, 0, 0, '[7]', 0),
(104, '', 'Conjure Sniper Arrow', 'exevo con hur', 0, 1, 0, 0, 160, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(105, '', 'Convince Creature Rune', 'adeta sio', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(106, '', 'Cure Poison Rune', 'adana pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(107, '', 'Destroy Field Rune', 'adito grav', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(108, '', 'Disintegrate Rune', 'adito tera', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(109, '', 'Enchant Spear', 'exeta con', 0, 1, 0, 0, 350, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(110, '', 'Enchant Staff', 'exeta vis', 0, 1, 0, 0, 80, 0, 0, 0, 0, 0, 0, '[5]', 0),
(111, '', 'Energy Bomb Rune', 'adevo mas vis', 0, 1, 0, 0, 880, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(112, '', 'Energy Field Rune', 'adevo grav vis', 0, 1, 0, 0, 320, 2, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(113, '', 'Energy Wall Rune', 'adevo mas grav vis', 0, 1, 0, 0, 1000, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(114, '', 'Explosion Rune', 'adevo mas hur', 0, 1, 0, 0, 570, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(115, '', 'Fire Field Rune', 'adevo grav flam', 0, 1, 0, 0, 240, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(116, '', 'Fire Bomb Rune', 'adevo mas flam', 0, 1, 0, 0, 600, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(117, '', 'Fire Wall Rune', 'adevo mas grav flam', 0, 1, 0, 0, 780, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(118, '', 'Fireball Rune', 'adori flam', 0, 1, 0, 0, 460, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(119, '', 'Great Fireball Rune', 'adori mas flam', 0, 1, 0, 0, 530, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(120, '', 'Heavy Magic Missile Rune', 'adori vis', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(121, '', 'Holy Missile Rune', 'adori san', 0, 1, 0, 0, 300, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(122, '', 'Icicle Rune', 'adori frigo', 0, 1, 0, 0, 460, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(123, '', 'Intense Healing Rune', 'adura gran', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(124, '', 'Light Magic Missile Rune', 'adori min vis', 0, 1, 0, 0, 120, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(125, '', 'Light Stone Shower Rune', 'adori infir mas tera', 0, 1, 0, 0, 6, 3, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(126, '', 'Lightest Missile Rune', 'adori infir vis', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(127, '', 'Magic Wall Rune', 'adevo grav tera', 0, 1, 0, 0, 750, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(128, '', 'Paralyze Rune', 'adana ani', 0, 1, 0, 0, 1400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(129, '', 'Poison Bomb Rune', 'adevo mas pox', 0, 1, 0, 0, 520, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(130, '', 'Poison Field Rune', 'adevo grav pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(131, '', 'Poison Wall Rune', 'adevo mas grav pox', 0, 1, 0, 0, 640, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(132, '', 'Practice Magic Missile Rune', 'adori dis min vis', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(133, '', 'Soulfire Rune', 'adevo res flam', 0, 1, 0, 0, 420, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(134, '', 'Stalagmite Rune', 'adori tera', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(135, '', 'Stone Shower Rune', 'adori mas tera', 0, 1, 0, 0, 430, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(136, '', 'Sudden Death Rune', 'adori gran mort', 0, 1, 0, 0, 985, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(137, '', 'Thunderstorm Rune', 'adori mas vis', 0, 1, 0, 0, 430, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(138, '', 'Ultimate Healing Rune', 'adura vita', 0, 1, 0, 0, 400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(139, '', 'Wild Growth Rune', 'adevo grav vita', 0, 1, 0, 0, 600, 5, 0, 0, 0, 0, 0, '[2,6]', 0),
(140, '', 'Edit Door', 'aleta grav', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(141, '', 'Invite Guests', 'aleta sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(142, '', 'Kick Guest', 'alana sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(143, '', 'Invite Subowners', 'aleta som', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(144, '', 'Avalanche Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2274, 0, '[]', 0),
(145, '', 'Energy Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2262, 0, '[]', 0),
(146, '', 'Energy Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2277, 0, '[]', 0),
(147, '', 'Energy Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2279, 0, '[]', 0),
(148, '', 'Explosion Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2313, 0, '[]', 0),
(149, '', 'Fire Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2305, 0, '[]', 0),
(150, '', 'Fire Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2301, 0, '[]', 0),
(151, '', 'Fire Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2303, 0, '[]', 0),
(152, '', 'Fireball Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2302, 0, '[]', 0),
(153, '', 'Great Fireball Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2304, 0, '[]', 0),
(154, '', 'Heavy Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2311, 0, '[]', 0),
(155, '', 'Holy Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2295, 0, '[3,7]', 0),
(156, '', 'Icicle Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2271, 0, '[]', 0),
(157, '', 'Light Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2287, 0, '[]', 0),
(158, '', 'Light Stone Shower Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 23722, 0, '[]', 0),
(159, '', 'Lightest Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 19392, 0, '[]', 0),
(160, '', 'Lightest Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 23723, 0, '[]', 0),
(161, '', 'Magic Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2293, 0, '[]', 0),
(162, '', 'Poison Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2286, 0, '[]', 0),
(163, '', 'Poison Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2285, 0, '[]', 0),
(164, '', 'Poison Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2289, 0, '[]', 0),
(165, '', 'Soulfire Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2308, 0, '[]', 0),
(166, '', 'Stalagmite Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2292, 0, '[]', 0),
(167, '', 'Stone Shower Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2288, 0, '[]', 0),
(168, '', 'Sudden Death Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2268, 0, '[]', 0),
(169, '', 'Thunderstorm Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2315, 0, '[]', 0),
(170, '', 'Paralyze Rune Rune', '', 0, 3, 0, 0, 1400, 0, 0, 0, 0, 2278, 0, '[2,6]', 0),
(171, '', 'Wild Growth Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2269, 0, '[2,6]', 0),
(172, '', 'Cure Poison Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2266, 0, '[]', 0),
(173, '', 'Intense Healing Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2265, 0, '[]', 0),
(174, '', 'Ultimate Healing Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2273, 0, '[]', 0),
(175, '', 'Animate Dead Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2316, 0, '[]', 0),
(176, '', 'Convince Creature Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2290, 0, '[]', 0),
(177, '', 'Chameleon Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2291, 0, '[]', 0),
(178, '', 'Disintegrate Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2310, 0, '[]', 0),
(179, '', 'Destroy Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2261, 0, '[]', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_videos`
--

CREATE TABLE `myaac_videos` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `youtube_id` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_visitors`
--

CREATE TABLE `myaac_visitors` (
  `ip` varchar(45) NOT NULL,
  `lastvisit` int(11) NOT NULL DEFAULT '0',
  `page` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `myaac_weapons`
--

CREATE TABLE `myaac_weapons` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `vocations` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `myaac_weapons`
--

INSERT INTO `myaac_weapons` (`id`, `level`, `maglevel`, `vocations`) VALUES
(1294, 0, 0, '[]'),
(2111, 0, 0, '[]'),
(2181, 26, 0, '{\"2\":true}'),
(2182, 7, 0, '{\"2\":true}'),
(2183, 33, 0, '{\"2\":true}'),
(2185, 19, 0, '{\"2\":true}'),
(2186, 13, 0, '{\"2\":true}'),
(2187, 33, 0, '{\"1\":true}'),
(2188, 19, 0, '{\"1\":true}'),
(2189, 26, 0, '{\"1\":true}'),
(2190, 7, 0, '{\"1\":true}'),
(2191, 13, 0, '{\"1\":true}'),
(2377, 20, 0, '{\"4\":true}'),
(2378, 0, 0, '{\"4\":true}'),
(2381, 25, 0, '[]'),
(2387, 25, 0, '{\"4\":true}'),
(2389, 0, 0, '[]'),
(2390, 140, 0, '{\"4\":true}'),
(2391, 50, 0, '{\"4\":true}'),
(2392, 30, 0, '[]'),
(2393, 55, 0, '{\"4\":true}'),
(2396, 0, 0, '[]'),
(2399, 0, 0, '[]'),
(2400, 80, 0, '[]'),
(2407, 30, 0, '[]'),
(2408, 120, 0, '{\"4\":true}'),
(2410, 0, 0, '[]'),
(2413, 0, 0, '{\"4\":true}'),
(2414, 60, 0, '[]'),
(2415, 95, 0, '{\"4\":true}'),
(2421, 85, 0, '[]'),
(2423, 20, 0, '[]'),
(2424, 45, 0, '[]'),
(2425, 20, 0, '[]'),
(2426, 25, 0, '[]'),
(2427, 55, 0, '[]'),
(2429, 20, 0, '[]'),
(2430, 25, 0, '[]'),
(2431, 90, 0, '[]'),
(2432, 35, 0, '[]'),
(2434, 25, 0, '[]'),
(2435, 20, 0, '[]'),
(2436, 30, 0, '[]'),
(2438, 30, 0, '[]'),
(2440, 25, 0, '{\"4\":true}'),
(2443, 70, 0, '{\"4\":true}'),
(2444, 65, 0, '{\"4\":true}'),
(2445, 35, 0, '[]'),
(2446, 45, 0, '[]'),
(2447, 50, 0, '{\"4\":true}'),
(2451, 35, 0, '[]'),
(2452, 70, 0, '{\"4\":true}'),
(2453, 75, 0, '[]'),
(2454, 65, 0, '{\"4\":true}'),
(2543, 0, 0, '[]'),
(2544, 0, 0, '[]'),
(2545, 0, 0, '[]'),
(2546, 0, 0, '[]'),
(2547, 55, 0, '[]'),
(3961, 40, 0, '[]'),
(3962, 30, 0, '[]'),
(3965, 20, 0, '[]'),
(5803, 75, 0, '{\"3\":true}'),
(6528, 75, 0, '{\"4\":true}'),
(6529, 110, 0, '[]'),
(6553, 75, 0, '{\"4\":true}'),
(7363, 30, 0, '[]'),
(7364, 20, 0, '[]'),
(7365, 40, 0, '[]'),
(7366, 0, 0, '[]'),
(7367, 42, 0, '[]'),
(7368, 80, 0, '[]'),
(7378, 25, 0, '[]'),
(7379, 25, 0, '[]'),
(7380, 35, 0, '{\"4\":true}'),
(7381, 20, 0, '[]'),
(7382, 60, 0, '{\"4\":true}'),
(7383, 50, 0, '[]'),
(7384, 60, 0, '[]'),
(7385, 20, 0, '[]'),
(7386, 40, 0, '{\"4\":true}'),
(7387, 25, 0, '[]'),
(7388, 55, 0, '[]'),
(7389, 60, 0, '[]'),
(7390, 75, 0, '[]'),
(7391, 50, 0, '{\"4\":true}'),
(7392, 35, 0, '[]'),
(7402, 45, 0, '{\"4\":true}'),
(7403, 65, 0, '{\"4\":true}'),
(7404, 40, 0, '[]'),
(7405, 70, 0, '{\"4\":true}'),
(7406, 35, 0, '{\"4\":true}'),
(7407, 30, 0, '{\"4\":true}'),
(7408, 25, 0, '[]'),
(7409, 50, 0, '[]'),
(7410, 55, 0, '[]'),
(7411, 50, 0, '[]'),
(7412, 45, 0, '[]'),
(7413, 40, 0, '{\"4\":true}'),
(7414, 60, 0, '{\"4\":true}'),
(7415, 60, 0, '[]'),
(7416, 55, 0, '[]'),
(7417, 65, 0, '[]'),
(7418, 70, 0, '[]'),
(7419, 40, 0, '[]'),
(7420, 70, 0, '[]'),
(7421, 65, 0, '[]'),
(7422, 75, 0, '[]'),
(7423, 85, 0, '{\"4\":true}'),
(7424, 30, 0, '[]'),
(7425, 20, 0, '[]'),
(7426, 40, 0, '[]'),
(7427, 45, 0, '[]'),
(7428, 55, 0, '{\"4\":true}'),
(7429, 75, 0, '[]'),
(7430, 30, 0, '[]'),
(7431, 80, 0, '[]'),
(7432, 20, 0, '[]'),
(7433, 65, 0, '[]'),
(7434, 75, 0, '[]'),
(7435, 85, 0, '[]'),
(7436, 45, 0, '{\"4\":true}'),
(7437, 30, 0, '[]'),
(7449, 25, 0, '{\"4\":true}'),
(7450, 120, 0, '{\"4\":true}'),
(7451, 35, 0, '[]'),
(7452, 30, 0, '{\"4\":true}'),
(7453, 85, 0, '{\"4\":true}'),
(7454, 30, 0, '{\"4\":true}'),
(7455, 80, 0, '[]'),
(7456, 35, 0, '[]'),
(7744, 0, 0, '[]'),
(7745, 50, 0, '[]'),
(7746, 60, 0, '[]'),
(7747, 35, 0, '{\"4\":true}'),
(7748, 45, 0, '{\"4\":true}'),
(7749, 20, 0, '[]'),
(7750, 25, 0, '[]'),
(7751, 60, 0, '[]'),
(7752, 35, 0, '{\"4\":true}'),
(7753, 65, 0, '{\"4\":true}'),
(7754, 20, 0, '[]'),
(7755, 35, 0, '[]'),
(7756, 60, 0, '[]'),
(7757, 35, 0, '[]'),
(7758, 50, 0, '{\"4\":true}'),
(7763, 0, 0, '[]'),
(7764, 50, 0, '[]'),
(7765, 60, 0, '[]'),
(7766, 35, 0, '{\"4\":true}'),
(7767, 45, 0, '{\"4\":true}'),
(7768, 20, 0, '[]'),
(7769, 25, 0, '[]'),
(7770, 60, 0, '[]'),
(7771, 35, 0, '{\"4\":true}'),
(7772, 65, 0, '{\"4\":true}'),
(7773, 20, 0, '[]'),
(7774, 35, 0, '[]'),
(7775, 60, 0, '[]'),
(7776, 35, 0, '[]'),
(7777, 50, 0, '{\"4\":true}'),
(7838, 20, 0, '[]'),
(7839, 20, 0, '[]'),
(7840, 20, 0, '[]'),
(7850, 20, 0, '[]'),
(7854, 0, 0, '[]'),
(7855, 50, 0, '[]'),
(7856, 60, 0, '[]'),
(7857, 35, 0, '{\"4\":true}'),
(7858, 45, 0, '{\"4\":true}'),
(7859, 20, 0, '[]'),
(7860, 25, 0, '[]'),
(7861, 60, 0, '[]'),
(7862, 35, 0, '{\"4\":true}'),
(7863, 65, 0, '{\"4\":true}'),
(7864, 20, 0, '[]'),
(7865, 35, 0, '[]'),
(7866, 60, 0, '[]'),
(7867, 35, 0, '[]'),
(7868, 50, 0, '{\"4\":true}'),
(7869, 0, 0, '[]'),
(7870, 50, 0, '[]'),
(7871, 60, 0, '[]'),
(7872, 35, 0, '{\"4\":true}'),
(7873, 45, 0, '{\"4\":true}'),
(7874, 20, 0, '[]'),
(7875, 25, 0, '[]'),
(7876, 60, 0, '[]'),
(7877, 35, 0, '{\"4\":true}'),
(7878, 65, 0, '{\"4\":true}'),
(7879, 20, 0, '[]'),
(7880, 35, 0, '[]'),
(7881, 60, 0, '[]'),
(7882, 35, 0, '[]'),
(7883, 50, 0, '{\"4\":true}'),
(8849, 45, 0, '{\"3\":true}'),
(8850, 60, 0, '{\"3\":true}'),
(8851, 130, 0, '{\"3\":true}'),
(8852, 100, 0, '{\"3\":true}'),
(8853, 80, 0, '{\"3\":true}'),
(8854, 80, 0, '{\"3\":true}'),
(8855, 50, 0, '{\"3\":true}'),
(8856, 60, 0, '{\"3\":true}'),
(8857, 40, 0, '{\"3\":true}'),
(8858, 70, 0, '{\"3\":true}'),
(8910, 42, 0, '{\"2\":true}'),
(8911, 22, 0, '{\"2\":true}'),
(8912, 37, 0, '{\"2\":true}'),
(8920, 37, 0, '{\"1\":true}'),
(8921, 22, 0, '{\"1\":true}'),
(8922, 42, 0, '{\"1\":true}'),
(8924, 110, 0, '[]'),
(8925, 130, 0, '[]'),
(8926, 120, 0, '{\"4\":true}'),
(8927, 120, 0, '[]'),
(8928, 100, 0, '[]'),
(8929, 100, 0, '{\"4\":true}'),
(8930, 100, 0, '[]'),
(8931, 120, 0, '[]'),
(8932, 100, 0, '{\"4\":true}'),
(11305, 60, 0, '[]'),
(11306, 50, 0, '{\"4\":true}'),
(11307, 55, 0, '[]'),
(11308, 55, 0, '{\"4\":true}'),
(11309, 20, 0, '{\"4\":true}'),
(11323, 25, 0, '[]'),
(12613, 58, 0, '{\"4\":true}'),
(12648, 82, 0, '[]'),
(12649, 82, 0, '[]'),
(13760, 37, 0, '{\"1\":true}'),
(13838, 25, 0, '[]'),
(13871, 40, 0, '{\"4\":true}'),
(13872, 40, 0, '{\"2\":true}'),
(13873, 40, 0, '{\"3\":true}'),
(13880, 40, 0, '{\"1\":true}'),
(15400, 38, 0, '[]'),
(15404, 80, 0, '[]'),
(15414, 90, 0, '[]'),
(15451, 40, 0, '[]'),
(15454, 50, 0, '[]'),
(15492, 70, 0, '[]'),
(15643, 85, 0, '{\"3\":true}'),
(15644, 50, 0, '{\"3\":true}'),
(15647, 48, 0, '[]'),
(15648, 30, 0, '[]'),
(15649, 40, 0, '[]'),
(16111, 150, 0, '{\"3\":true}'),
(18303, 0, 0, '[]'),
(18304, 90, 0, '[]'),
(18390, 65, 0, '{\"1\":true}'),
(18409, 65, 0, '{\"1\":true}'),
(18411, 65, 0, '{\"2\":true}'),
(18412, 65, 0, '{\"2\":true}'),
(18435, 90, 0, '[]'),
(18436, 70, 0, '[]'),
(18437, 70, 0, '[]'),
(18450, 62, 0, '[]'),
(18453, 90, 0, '{\"3\":true}'),
(18454, 105, 0, '{\"3\":true}'),
(19391, 1, 0, '[true]'),
(20092, 15, 0, '[]'),
(20093, 15, 0, '[]'),
(20108, 50, 0, '{\"4\":true}'),
(20139, 20, 0, '[]'),
(21690, 70, 0, '{\"3\":true}'),
(21696, 0, 0, '[]'),
(22398, 75, 0, '{\"4\":true}'),
(22399, 120, 0, '{\"4\":true}'),
(22400, 250, 0, '{\"4\":true}'),
(22401, 75, 0, '{\"4\":true}'),
(22402, 120, 0, '{\"4\":true}'),
(22403, 250, 0, '{\"4\":true}'),
(22404, 75, 0, '{\"4\":true}'),
(22405, 120, 0, '{\"4\":true}'),
(22406, 250, 0, '{\"4\":true}'),
(22407, 75, 0, '{\"4\":true}'),
(22408, 120, 0, '{\"4\":true}'),
(22409, 250, 0, '{\"4\":true}'),
(22410, 75, 0, '{\"4\":true}'),
(22411, 120, 0, '{\"4\":true}'),
(22412, 250, 0, '{\"4\":true}'),
(22413, 75, 0, '{\"4\":true}'),
(22414, 120, 0, '{\"4\":true}'),
(22415, 250, 0, '{\"4\":true}'),
(22416, 75, 0, '{\"3\":true}'),
(22417, 150, 0, '{\"3\":true}'),
(22418, 250, 0, '{\"3\":true}'),
(22419, 75, 0, '{\"3\":true}'),
(22420, 150, 0, '{\"3\":true}'),
(22421, 250, 0, '{\"3\":true}'),
(23529, 60, 0, '[]'),
(23719, 1, 0, '{\"1\":true}'),
(23721, 1, 0, '{\"2\":true}'),
(23839, 1, 0, '[]'),
(24827, 50, 0, '[]'),
(24828, 25, 0, '[]'),
(24839, 37, 0, '{\"2\":true}'),
(25383, 70, 0, '[]'),
(25415, 150, 0, '[]'),
(25416, 150, 0, '[]'),
(25418, 150, 0, '[]'),
(25420, 100, 0, '[]'),
(25421, 65, 0, '{\"1\":true}'),
(25422, 100, 0, '{\"1\":true}'),
(25522, 120, 0, '{\"3\":true}'),
(25523, 120, 0, '{\"3\":true}'),
(25526, 0, 0, '[]');

-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT '1',
  `account_id` int(11) NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `vocation` int(11) NOT NULL DEFAULT '0',
  `health` int(11) NOT NULL DEFAULT '150',
  `healthmax` int(11) NOT NULL DEFAULT '150',
  `experience` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lookbody` int(11) NOT NULL DEFAULT '0',
  `lookfeet` int(11) NOT NULL DEFAULT '0',
  `lookhead` int(11) NOT NULL DEFAULT '0',
  `looklegs` int(11) NOT NULL DEFAULT '0',
  `looktype` int(11) NOT NULL DEFAULT '136',
  `lookaddons` int(11) NOT NULL DEFAULT '0',
  `direction` tinyint(3) UNSIGNED NOT NULL DEFAULT '2',
  `maglevel` int(11) NOT NULL DEFAULT '0',
  `mana` int(11) NOT NULL DEFAULT '0',
  `manamax` int(11) NOT NULL DEFAULT '0',
  `manaspent` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `soul` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `town_id` int(11) NOT NULL DEFAULT '1',
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0',
  `conditions` blob,
  `cap` int(11) NOT NULL DEFAULT '400',
  `sex` int(11) NOT NULL DEFAULT '0',
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `save` tinyint(4) NOT NULL DEFAULT '1',
  `skull` tinyint(4) NOT NULL DEFAULT '0',
  `skulltime` bigint(20) NOT NULL DEFAULT '0',
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `blessings` tinyint(4) NOT NULL DEFAULT '0',
  `onlinetime` bigint(20) NOT NULL DEFAULT '0',
  `deletion` bigint(20) NOT NULL DEFAULT '0',
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT '43200',
  `offlinetraining_skill` int(11) NOT NULL DEFAULT '-1',
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT '2520',
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT '10',
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `created` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `direction`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `created`, `hidden`, `comment`) VALUES
(1, 'Admin', 6, 1, 1, 0, 100, 100, 0, 10, 10, 10, 10, 136, 0, 2, 0, 100, 100, 0, 0, 1, 95, 126, 7, '', 0, 0, 1676236157, 16783532, 1, 0, 0, 1676236301, 0, 179, 0, 0, 43200, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1676234685, 0, ''),
(2, 'Rook Sample', 1, 1, 1, 0, 150, 150, 0, 118, 114, 38, 57, 130, 0, 2, 0, 0, 0, 0, 100, 1, 1000, 1000, 7, '', 400, 1, 1676234687, 2130706433, 1, 0, 0, 1676234687, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1676234687, 1, ''),
(3, 'Sorcerer Sample', 1, 1, 8, 1, 185, 185, 4200, 118, 114, 38, 57, 130, 0, 2, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1676234687, 2130706433, 1, 0, 0, 1676234687, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1676234687, 1, ''),
(4, 'Druid Sample', 1, 1, 8, 2, 185, 185, 4200, 118, 114, 38, 57, 130, 0, 2, 0, 90, 90, 0, 100, 1, 95, 117, 7, '', 470, 1, 1676236152, 16783532, 1, 0, 0, 1676236155, 0, 3, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1676234687, 1, ''),
(5, 'Paladin Sample', 1, 1, 8, 3, 185, 185, 4200, 118, 114, 38, 57, 129, 0, 2, 0, 90, 90, 0, 100, 1, 1000, 1000, 7, '', 470, 1, 1676234687, 2130706433, 1, 0, 0, 1676234687, 0, 0, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1676234687, 1, ''),
(6, 'Knight Sample', 1, 1, 8, 4, 185, 185, 4200, 118, 114, 38, 57, 131, 0, 2, 0, 90, 90, 0, 100, 1, 95, 117, 7, '', 470, 1, 1676236155, 16783532, 1, 0, 0, 1676236157, 0, 2, 0, 0, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 1676234687, 1, '');

--
-- Acionadores `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(11) NOT NULL DEFAULT '1',
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(4) NOT NULL DEFAULT '1',
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(4) NOT NULL DEFAULT '0',
  `unjustified` tinyint(4) NOT NULL DEFAULT '0',
  `mostdamage_unjustified` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `pid` int(11) NOT NULL DEFAULT '0',
  `sid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL DEFAULT '0',
  `count` smallint(6) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(1, 3, 101, 1987, 1, ''),
(1, 4, 102, 2651, 1, ''),
(1, 6, 103, 2382, 1, ''),
(1, 10, 104, 2050, 1, ''),
(1, 101, 105, 2674, 1, 0x0f01);

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT '0',
  `key` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `value` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_storeinboxitems`
--

CREATE TABLE `player_storeinboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT '0',
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '30'),
('motd_hash', ''),
('motd_num', '0'),
('players_record', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `towns`
--

CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `posx` int(11) NOT NULL DEFAULT '0',
  `posy` int(11) NOT NULL DEFAULT '0',
  `posz` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `towns`
--

INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES
(1, 'Trekolt', 95, 117, 7),
(2, 'Rhyves', 159, 387, 6),
(3, 'Varak', 242, 429, 12),
(4, 'Jorvik', 496, 172, 7),
(5, 'Saund', 240, 566, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote`
--

CREATE TABLE `znote` (
  `id` int(10) NOT NULL,
  `version` varchar(30) NOT NULL COMMENT 'Znote AAC version',
  `installed` int(10) NOT NULL,
  `cached` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote`
--

INSERT INTO `znote` (`id`, `version`, `installed`, `cached`) VALUES
(1, '1.5_SVN', 1676230589, NULL),
(2, '1.5_SVN', 1676232372, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_accounts`
--

CREATE TABLE `znote_accounts` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL,
  `created` int(10) NOT NULL,
  `points` int(10) DEFAULT '0',
  `cooldown` int(10) DEFAULT '0',
  `active` tinyint(4) NOT NULL DEFAULT '0',
  `activekey` int(11) NOT NULL DEFAULT '0',
  `flag` varchar(20) NOT NULL,
  `secret` char(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_accounts`
--

INSERT INTO `znote_accounts` (`id`, `account_id`, `ip`, `created`, `points`, `cooldown`, `active`, `activekey`, `flag`, `secret`) VALUES
(1, 1, 0, 1676230589, 0, 0, 0, 0, '', NULL),
(2, 1, 0, 1676232372, 0, 0, 0, 0, '', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_changelog`
--

CREATE TABLE `znote_changelog` (
  `id` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `report_id` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_deleted_characters`
--

CREATE TABLE `znote_deleted_characters` (
  `id` int(11) NOT NULL,
  `original_account_id` int(11) NOT NULL,
  `character_name` varchar(255) NOT NULL,
  `time` datetime NOT NULL,
  `done` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum`
--

CREATE TABLE `znote_forum` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `access` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `guild_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_forum`
--

INSERT INTO `znote_forum` (`id`, `name`, `access`, `closed`, `hidden`, `guild_id`) VALUES
(1, 'Staff Board', 4, 0, 0, 0),
(2, 'Tutors Board', 2, 0, 0, 0),
(3, 'Discussion', 1, 0, 0, 0),
(4, 'Feedback', 1, 0, 1, 0),
(5, 'Staff Board', 4, 0, 0, 0),
(6, 'Tutors Board', 2, 0, 0, 0),
(7, 'Discussion', 1, 0, 0, 0),
(8, 'Feedback', 1, 0, 1, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_posts`
--

CREATE TABLE `znote_forum_posts` (
  `id` int(11) NOT NULL,
  `thread_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_forum_threads`
--

CREATE TABLE `znote_forum_threads` (
  `id` int(11) NOT NULL,
  `forum_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `player_name` varchar(50) NOT NULL,
  `title` varchar(50) NOT NULL,
  `text` text NOT NULL,
  `created` int(11) NOT NULL,
  `updated` int(11) NOT NULL,
  `sticky` tinyint(4) NOT NULL,
  `hidden` tinyint(4) NOT NULL,
  `closed` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_global_storage`
--

CREATE TABLE `znote_global_storage` (
  `key` varchar(32) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_guild_wars`
--

CREATE TABLE `znote_guild_wars` (
  `id` int(11) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_images`
--

CREATE TABLE `znote_images` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `desc` text NOT NULL,
  `date` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `image` varchar(30) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_news`
--

CREATE TABLE `znote_news` (
  `id` int(11) NOT NULL,
  `title` varchar(30) NOT NULL,
  `text` text NOT NULL,
  `date` int(11) NOT NULL,
  `pid` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paygol`
--

CREATE TABLE `znote_paygol` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `service_id` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `keyword` varchar(255) NOT NULL,
  `message` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `operator` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_paypal`
--

CREATE TABLE `znote_paypal` (
  `id` int(11) NOT NULL,
  `txn_id` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `accid` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `points` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_players`
--

CREATE TABLE `znote_players` (
  `id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `created` int(11) NOT NULL,
  `hide_char` tinyint(4) NOT NULL,
  `comment` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `znote_players`
--

INSERT INTO `znote_players` (`id`, `player_id`, `created`, `hide_char`, `comment`) VALUES
(1, 1, 1676230589, 0, ''),
(2, 1, 1676232372, 0, '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_player_reports`
--

CREATE TABLE `znote_player_reports` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `posx` int(6) NOT NULL,
  `posy` int(6) NOT NULL,
  `posz` int(6) NOT NULL,
  `report_description` varchar(255) NOT NULL,
  `date` int(11) NOT NULL,
  `status` tinyint(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop`
--

CREATE TABLE `znote_shop` (
  `id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) DEFAULT NULL,
  `count` int(11) NOT NULL DEFAULT '1',
  `description` varchar(255) NOT NULL,
  `points` int(11) NOT NULL DEFAULT '10'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_logs`
--

CREATE TABLE `znote_shop_logs` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `points` int(11) NOT NULL,
  `time` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_shop_orders`
--

CREATE TABLE `znote_shop_orders` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `type` int(11) NOT NULL,
  `itemid` int(11) NOT NULL,
  `count` int(11) NOT NULL,
  `time` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets`
--

CREATE TABLE `znote_tickets` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `subject` text NOT NULL,
  `message` text NOT NULL,
  `ip` int(11) NOT NULL,
  `creation` int(11) NOT NULL,
  `status` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_tickets_replies`
--

CREATE TABLE `znote_tickets_replies` (
  `id` int(11) NOT NULL,
  `tid` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `message` text NOT NULL,
  `created` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors`
--

CREATE TABLE `znote_visitors` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `znote_visitors_details`
--

CREATE TABLE `znote_visitors_details` (
  `id` int(11) NOT NULL,
  `ip` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `account_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end` int(11) NOT NULL DEFAULT '0',
  `start` int(11) NOT NULL DEFAULT '0',
  `answers` int(11) NOT NULL DEFAULT '0',
  `votes_all` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices para tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices para tabela `account_storage`
--
ALTER TABLE `account_storage`
  ADD PRIMARY KEY (`account_id`,`key`);

--
-- Índices para tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Índices para tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Índices para tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices para tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Índices para tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Índices para tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Índices para tabela `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Índices para tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Índices para tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Índices para tabela `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Índices para tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `myaac_account_actions`
--
ALTER TABLE `myaac_account_actions`
  ADD KEY `account_id` (`account_id`);

--
-- Índices para tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  ADD PRIMARY KEY (`uid`);

--
-- Índices para tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_charbazaar`
--
ALTER TABLE `myaac_charbazaar`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_charbazaar_bid`
--
ALTER TABLE `myaac_charbazaar_bid`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Índices para tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_polls`
--
ALTER TABLE `myaac_polls`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `myaac_visitors`
--
ALTER TABLE `myaac_visitors`
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Índices para tabela `myaac_weapons`
--
ALTER TABLE `myaac_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Índices para tabela `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Índices para tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Índices para tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Índices para tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Índices para tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Índices para tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Índices para tabela `player_storeinboxitems`
--
ALTER TABLE `player_storeinboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Índices para tabela `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Índices para tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Índices para tabela `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índices para tabela `znote`
--
ALTER TABLE `znote`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_accounts`
--
ALTER TABLE `znote_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_changelog`
--
ALTER TABLE `znote_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum`
--
ALTER TABLE `znote_forum`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_global_storage`
--
ALTER TABLE `znote_global_storage`
  ADD UNIQUE KEY `key` (`key`);

--
-- Índices para tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_images`
--
ALTER TABLE `znote_images`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_news`
--
ALTER TABLE `znote_news`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_paygol`
--
ALTER TABLE `znote_paygol`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_paypal`
--
ALTER TABLE `znote_paypal`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_players`
--
ALTER TABLE `znote_players`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop`
--
ALTER TABLE `znote_shop`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_tickets`
--
ALTER TABLE `znote_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_visitors`
--
ALTER TABLE `znote_visitors`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `z_polls`
--
ALTER TABLE `z_polls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_config`
--
ALTER TABLE `myaac_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `myaac_faq`
--
ALTER TABLE `myaac_faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum`
--
ALTER TABLE `myaac_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `myaac_menu`
--
ALTER TABLE `myaac_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_news`
--
ALTER TABLE `myaac_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `myaac_pages`
--
ALTER TABLE `myaac_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `myaac_spells`
--
ALTER TABLE `myaac_spells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=180;

--
-- AUTO_INCREMENT de tabela `myaac_videos`
--
ALTER TABLE `myaac_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `towns`
--
ALTER TABLE `towns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `znote`
--
ALTER TABLE `znote`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `znote_accounts`
--
ALTER TABLE `znote_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `znote_changelog`
--
ALTER TABLE `znote_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_deleted_characters`
--
ALTER TABLE `znote_deleted_characters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_forum`
--
ALTER TABLE `znote_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `znote_forum_posts`
--
ALTER TABLE `znote_forum_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_forum_threads`
--
ALTER TABLE `znote_forum_threads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_images`
--
ALTER TABLE `znote_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_news`
--
ALTER TABLE `znote_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_paygol`
--
ALTER TABLE `znote_paygol`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_paypal`
--
ALTER TABLE `znote_paypal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_players`
--
ALTER TABLE `znote_players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `znote_player_reports`
--
ALTER TABLE `znote_player_reports`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop`
--
ALTER TABLE `znote_shop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop_logs`
--
ALTER TABLE `znote_shop_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_shop_orders`
--
ALTER TABLE `znote_shop_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_tickets`
--
ALTER TABLE `znote_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_tickets_replies`
--
ALTER TABLE `znote_tickets_replies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_visitors`
--
ALTER TABLE `znote_visitors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `znote_visitors_details`
--
ALTER TABLE `znote_visitors_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `z_polls`
--
ALTER TABLE `z_polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `account_storage`
--
ALTER TABLE `account_storage`
  ADD CONSTRAINT `account_storage_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limitadores para a tabela `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `player_storeinboxitems`
--
ALTER TABLE `player_storeinboxitems`
  ADD CONSTRAINT `player_storeinboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Limitadores para a tabela `znote_guild_wars`
--
ALTER TABLE `znote_guild_wars`
  ADD CONSTRAINT `znote_guild_wars_ibfk_1` FOREIGN KEY (`id`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
