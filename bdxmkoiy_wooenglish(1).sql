-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 05, 2023 at 07:22 AM
-- Server version: 10.5.21-MariaDB-cll-lve
-- PHP Version: 8.1.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bdxmkoiy_wooenglish`
--

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `id` int(11) NOT NULL,
  `announcement_name` text DEFAULT NULL,
  `announcement_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcement`
--

INSERT INTO `announcement` (`id`, `announcement_name`, `announcement_description`, `created_at`, `updated_at`) VALUES
(4, 'dsd', 'desd', '2023-06-20 05:49:59', '2023-06-20 05:49:59');

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `author_image` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`id`, `name`, `author_image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Chetan bhagat', NULL, 'active', '2023-06-13 06:54:56', '2023-06-14 01:32:48'),
(7, 'test Author', NULL, 'active', '2023-06-30 09:38:40', NULL),
(11, 'data', NULL, 'active', '2023-06-21 13:34:01', '2023-06-21 13:34:01'),
(13, 'Thomas Hardy', 'upload/author/758391687454496.jpg', 'active', '2023-06-22 17:21:36', '2023-06-22 17:21:36'),
(15, 'Robert T Kiyosaki', 'upload/author/7638581689599119.jpg', 'active', '2023-07-17 13:05:19', '2023-07-17 13:05:19'),
(16, 'WooEnglish', 'upload/author/2576031690292893.png', 'active', '2023-07-25 13:48:13', '2023-07-25 13:48:13'),
(17, 'Walter Isaacson', 'upload/author/8089571690438573.jpg', 'active', '2023-07-27 06:16:13', '2023-07-27 06:16:13');

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `category` text DEFAULT NULL,
  `english_accent` text DEFAULT NULL,
  `home_category` text DEFAULT NULL,
  `author_name` text DEFAULT NULL,
  `total_words` text DEFAULT NULL,
  `genre` text DEFAULT NULL,
  `total_time` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `language` text DEFAULT NULL,
  `length` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT NULL,
  `english_fluency` text DEFAULT NULL,
  `showbookto` text DEFAULT NULL,
  `book_thumbnail` text DEFAULT NULL,
  `book_description` longtext DEFAULT NULL,
  `video_title` text DEFAULT NULL,
  `audio_title` text DEFAULT NULL,
  `video` text DEFAULT NULL,
  `audio` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `views` bigint(20) NOT NULL DEFAULT 0,
  `is_audio` int(20) DEFAULT 0,
  `rating` double(10,1) NOT NULL DEFAULT 0.0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`id`, `title`, `category`, `english_accent`, `home_category`, `author_name`, `total_words`, `genre`, `total_time`, `level`, `language`, `length`, `status`, `english_fluency`, `showbookto`, `book_thumbnail`, `book_description`, `video_title`, `audio_title`, `video`, `audio`, `created_at`, `updated_at`, `views`, `is_audio`, `rating`) VALUES
(3, 'The 3 Mistakes of My Life Novel by Chetan Bhagat', '21', '1', '2', 'Chetan bhagat', '5435', '1', '4535', '2', '2', '1', 'active', '1', 'all_users', 'upload/book/4188941689227313.jpg', '<p>ntrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the</p>', 'test', '', 'https://www.youtube.com/watch?v=sgNZljTR1n0', '', '2023-06-14 04:25:05', '2023-11-30 10:39:46', 43, 1, 3.6),
(6, '7 habbit for highly effective people', '4', '1', '1', 'Chetan bhagat', '2000', '2', '20', '1', '2', '2', 'active', '1', 'paid_users', 'upload/book/5857521686901392.jpg', '<p>testing data goes here</p>', 'tesing', 'Book content', 'https://www.youtube.com/watch?v=GXWfue9VhTY', 'upload/book/3074181686837262.mp3', '2023-06-15 08:21:40', '2023-11-07 02:36:24', 9, 0, 4.0),
(11, 'test1', '4', '2', '2', 'Chetan bhagat', '5454', '2', '50000', '1', '1', '2', 'active', '2', 'all_users', 'upload/book/862181687327041.png', '<p><strong>testetest</strong></p>', 'test', 'test', 'https://www.youtube.com/watch?v=cYoXlkiw67U', 'upload/book/755521687332824.mp3', '2023-06-21 05:57:21', '2023-11-25 11:16:40', 10, 0, 1.0),
(13, 'Tess of d Urberville', '21', '1', '1', 'Thomas Hardy', '18603', '1', '115', '3', '1', '1', 'active', '4', 'paid_users', 'upload/book/7109041687454220.jpg', '<p><span style=\"font-family: \'helvetica neue\', Helvetica, Arial, sans-serif; font-size: 14px; text-align: justify;\">Once Jack &ndash; the head of the Durbeyfield family, accidentally reveals that his family is descended from the ancient knightly family d&rsquo;Urberville. Jack goes to pub to celebrate the gentility of his family. There he learns that some Mr. Stoke-d&rsquo;Urberville living not far away. The next day on the morning Jack cannot wake up, so Tess had to drive products with the help of their only value possession &ndash; the horse. Tess Young and her little brother went to the town. But unluckily they fall asleep while were driving and their horse crashed into a wood and died. Mother insists that Tess should go to the Stoke-d&rsquo;Urberville. She hopes he might help them as realities. But indeed he hasn&rsquo;t any connection with the d&rsquo;Urbervilles, he only took that name from local history book. But he really liked the young Tess and he is not very shy to show his fondness.</span></p>', 'Tess of d Urberville', NULL, 'https://youtu.be/DhhClNg9Xy0', NULL, '2023-06-22 17:17:00', '2023-10-10 17:50:20', 10, 1, 1.9),
(15, 'Amazon Reviews Exposed', '4', '1', '2', 'Thomas Hardy', '20054', '1', '565', '1', '2', '1', 'active', '1', 'all_users', 'upload/book/155271688649232.jpg', '<p>Amazon Reviews Exposed is an Invaluable Resource for Amazon Authors and Sellers! Anyone that is selling eBooks or other products on Amazon will sooner or later ask the question: \"How do I get reviews?\" Reviews influence sales. And since there is financial gain at stake, certain authors and sellers don\'t hesitate to game the system with fake reviews. This book has valuable information that you NEED to know. How are fake reviews created? And do they work?</p>', NULL, NULL, NULL, NULL, '2023-07-06 13:13:53', '2023-11-24 08:52:13', 40, 1, 2.1),
(18, 'Rich Dad & Poor Dad', '21', '1', '2', 'Robert T Kiyosaki', '200', '3', '3000', '2', '1', '2', 'active', '1', 'all_users', 'upload/book/567521689599039.jpeg', '<h2 style=\"box-sizing: border-box; font-family: Quicksand, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, \'Helvetica Neue\', Arial, \'Noto Sans\', sans-serif, \'Apple Color Emoji\', \'Segoe UI Emoji\', \'Segoe UI Symbol\', \'Noto Color Emoji\'; font-weight: 500; line-height: 1.2; margin: 0px 0px 20px; font-size: 36px; background-color: #ffffff;\">Rich Dad Poor Dad Lessons</h2>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 1: The Rich Don&rsquo;t Work for Money</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 2: Why Teach Financial Literacy?</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 3: Mind Your Own Business</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 4: The History of Taxes and The Power of Corporations</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 5: The Rich Invent Money</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Lesson 6: Work to Learn&mdash;Don&rsquo;t Work for Money</span></li>\r\n</ol>\r\n<h2 style=\"box-sizing: border-box; font-family: Quicksand, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, \'Segoe UI\', Roboto, \'Helvetica Neue\', Arial, \'Noto Sans\', sans-serif, \'Apple Color Emoji\', \'Segoe UI Emoji\', \'Segoe UI Symbol\', \'Noto Color Emoji\'; font-weight: 500; line-height: 1.2; margin: 0px 0px 20px; font-size: 36px; background-color: #ffffff;\">Rich Dad Poor Dad Summary</h2>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;There is a difference between being poor and being broke. Broke is temporary. Poor is eternal.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Money comes and goes, but if you have the education about how money works, you gain power over it and can begin building wealth.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;People&rsquo;s lives are forever controlled by two emotions: fear and greed.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;So many people say, &lsquo;Oh, I&rsquo;m not interested in money.&rsquo; Yet they&rsquo;ll work at a job for eight hours a day.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Thinking that a job makes you secure is lying to yourself.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Intelligence solves problems and produces money.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;You must know the difference between an asset and a liability and buy assets.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">An asset puts money in your pocket. A liability takes money out of your pocket.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Illiteracy, both in words and numbers, is the foundation of financial struggle.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Money often makes obvious our tragic human flaws, putting a spotlight on what we don&rsquo;t know.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Cash flow tells the story of how a person handles money.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Most people don&rsquo;t understand why they struggle financially because they don&rsquo;t understand cash flow.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The number-one expense for most people is taxes.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Higher incomes cause higher taxes. This is known as &ldquo;bracket creep.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;More money seldom solves someone&rsquo;s money problems.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The fear of being different prevents most people from seeking new ways to solve their problems.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;A person can be highly educated, professionally successful, and financially illiterate.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Many financial problems are caused by trying to keep up with the Joneses.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Once you understand the difference between assets and liabilities, concentrate your efforts on buying income-generating assets.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The problem with simply working harder is that each of these three levels takes a greater share of your increased efforts. You need to learn how to have your increased efforts benefit you and your family directly.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Wealth is a person&rsquo;s ability to survive so many numbers of days forward&mdash;or, if I stopped working today, how long could I survive?&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The rich buy assets. The poor only have expenses. The middle-class buy liabilities they think are assets.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The rich focus on their asset columns while everyone else focuses on their income statements.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Financial struggle is often directly the result of people working all their lives for someone else.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The mistake in becoming what you study is that too many people forget to mind their own business. They spend their lives minding someone else&rsquo;s business and making that person rich.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;To become financially secure, a person needs to mind their own business.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Financial struggle is often the result of people working all their lives for someone else.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The primary reason the majority of the poor and middle class are fiscally conservative&mdash;which means, &lsquo;I can&rsquo;t afford to take risks&rsquo;&mdash;is that they have no financial foundation.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;One of the main reasons net worth is not accurate is simply because, the moment you begin selling your assets, you are taxed for any gains.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;A new car loses nearly 25 percent of the price you pay for it the moment you drive it off the lot.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Keep expenses low, reduce liabilities, and diligently build a base of solid assets.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">Kiyosaki says he owns businesses that do not require his presence. &ldquo;<span style=\"box-sizing: border-box;\">If I have to work there, it&rsquo;s not a business. It becomes my job.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">According to Kiyosaki, real assets fall into the following categories:</span></p>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Stocks</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Bonds</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Income-generating real estate</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Notes (IOUs)</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Royalties from intellectual property such as music, scripts, and patents</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Anything else that has value produces income or appreciates, and has a ready market</span></li>\r\n</ol>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;For people who hate real estate, they shouldn&rsquo;t buy it.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Kiyosaki generally holds real estate for less than seven years.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Start minding your own business. Keep your daytime job, but start buying real assets, not liabilities.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">When Kiyosaki says mind your own business, he means building and keeping your asset column strong. Once a dollar goes into it, never let it come out.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The best thing about money is that it works 24 hours a day and can work for generations.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;An important distinction is that rich people buy luxuries last, while the poor and middle class tend to buy luxuries first.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;A true luxury is a reward for investing in and developing a real asset.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Kiyosaki&rsquo;s rich dad did not see Robin Hood as a hero. He called Robin Hood a crook.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;If you work for money, you give the power to your employer. If money works for you, you keep the power and control it.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Each dollar in my asset column was a great employee, working hard to make more employees and buy the boss a new Porsche.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Kiyosaki reminds people that financial IQ is made up of knowledge from four broad areas of expertise: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Accounting</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Investing</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Understanding markets</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">The law</span></li>\r\n</ol>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;A corporation earns, spends everything it can, and is taxed on anything that is left. It&rsquo;s one of the biggest legal tax loopholes that the rich use.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Garret Sutton&rsquo;s books on corporations provide wonderful insight into the power of personal corporations.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Often in the real world, it&rsquo;s not the smart who get ahead, but the bold.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Kiyosaki sees one thing in common in all of us, himself included. We all have tremendous potential, and we all are blessed with gifts. Yet the one thing that holds all of us back is some degree of self-doubt.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">In Kiyosaki&rsquo;s personal experience, your financial genius requires both technical knowledge as well as courage.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Kiyosaki always encourages adult students to look at games as reflecting back to them what they know and what they need to learn.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Games reflect behavior. They are instant feedback systems.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Financial intelligence is simply having more options.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The single most powerful asset we all have is our mind. If it is trained well, it can create enormous wealth.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The world is always handing you opportunities of a lifetime, every day of your life, but all too often, we fail to see them.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Richard uses two main vehicles to achieve financial growth: real estate and small-cap stocks.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Simple math and common sense are all you need to do well financially.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The problem with &lsquo;secure&rsquo; investments is that they are often sanitized, that is, made so safe that the gains are less.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;It is not gambling if you know what you&rsquo;re doing. It is gambling if you&rsquo;re just throwing money into a deal and praying.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Most people never get wealthy simply because they are not trained financially to recognize opportunities right in front of them.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Great opportunities are not seen with your eyes. They are seen with your mind.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;You want to know a little about a lot,&rdquo; was rich dad&rsquo;s suggestion.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Job is an acronym for &lsquo;Just Over Broke.&rsquo;&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Look down the road at what skills they want to acquire before choosing a specific profession and before getting trapped in the Rat Race.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Education is more valuable than money in the long run.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The reason so many talented people are poor is that they focus on building a better hamburger and know little to nothing about business systems.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">The main management skills needed for success are:</span></p>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Management of cash flow</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Management of systems</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Management of people</span></li>\r\n</ol>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The most important specialized skills are sales and marketing.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;To be truly rich, we need to be able to give as well as to receive.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Giving money is the secret to most great wealthy families.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The primary difference between a rich person and a poor person is how they manage fear.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">There are five main reasons why financially literate people may still not develop abundant asset columns that could produce a large cash flow. The five reasons are:</span></p>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Fear</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Cynicism</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Laziness</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Bad habits</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Arrogance</span></li>\r\n</ol>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;For most people, the reason they don&rsquo;t win financially is that the pain of losing money is far greater than the joy of being rich.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Failure inspires winners. Failure defeats losers.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Real estate is a powerful investment tool for anyone seeking financial independence or freedom.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;A great property manager is key to success in real estate.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">The most common form of laziness is staying busy.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Rich dad believed that the words &lsquo;I can&rsquo;t afford it&rsquo; shut down your brain. &lsquo;How can I afford it?&rsquo; opens up possibilities, excitement, and dreams.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Whenever you find yourself avoiding something you know you should be doing, then the only thing to ask yourself is, &lsquo;What&rsquo;s in it for me?&rsquo; Be a little greedy. It&rsquo;s the best cure for laziness.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Richard has found that many people use arrogance to try to hide their own ignorance.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;There is gold everywhere. Most people are not trained to see it.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;To find million-dollar &lsquo;deals of a lifetime&rsquo; requires us to call on our financial genius.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">A reason or a purpose is a combination of &lsquo;wants&rsquo; and &lsquo;don&rsquo;t wants.&rsquo;&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;Most people simply buy investments rather than first investing in learning about investing.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">Richard believes one of the hardest things about wealth-building is to be true to yourself and to be willing not to go along with the crowd.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The rich know that savings are only used to create more money, not to pay bills.&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">&ldquo;The sophisticated investor&rsquo;s first question is: &lsquo;How fast do I get my money back?&rsquo;&rdquo;</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">If Richard could leave one single idea with you, it is that idea. Whenever you feel short or need something, give what you want first, and it will come back in buckets.</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 30px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\"><span style=\"box-sizing: border-box;\">In the world of accounting, there are three different types of income: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></p>\r\n<ol style=\"box-sizing: border-box; margin: 0px 0px 30px 40px; padding: 0px; font-family: \'Cormorant Garamond\', ui-serif, Georgia, Cambria, \'Times New Roman\', Times, serif; font-size: 22px; background-color: #ffffff;\">\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Ordinary earned</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Portfolio</span></li>\r\n<li style=\"box-sizing: border-box; list-style-type: decimal;\"><span style=\"box-sizing: border-box;\">Passive</span></li>\r\n</ol>', 'Rich dad poor dad audio book', NULL, 'https://www.youtube.com/watch?v=wp7Lz1svVro', NULL, '2023-07-17 13:03:59', '2023-12-04 14:21:13', 794, 1, 4.0),
(19, 'Journey Through the Lens A Leonardo DiCaprio Documentary', '21', '1', '1', 'WooEnglish', '6918', '1', '70', '2', '1', '2', 'active', '2', 'all_users', 'upload/book/9675671690293802.jpg', '<p style=\"text-align: center;\">&nbsp;From the fiery rebellion of the Revolutionary War to the transformative dawn of industry, join Ethan\'s gripping journey through a tumultuous American history, where courage, sacrifice, and the pursuit of freedom ignite a thrilling adventure.&nbsp;</p>', 'Journey Through the Lens A Leonardo DiCaprio Documentary', NULL, 'https://youtu.be/bwK1F0wdSpI', NULL, '2023-07-25 14:03:22', '2023-11-30 12:53:49', 124, 1, 2.8),
(20, 'Steve Jobs', '24', '2', '2', 'Walter Isaacson', '654', '1', '10', '3', '1', '3', 'active', '4', 'all_users', 'upload/book/5744551690439047.jpg', '<p><span style=\"color: #1e1915; font-family: \'Proxima Nova\', Montserrat, Arial, sans-serif; font-size: 16px; background-color: #ffffff;\">Walter Isaacson, a professor of history at Tulane, has been CEO of the Aspen Institute, chair of CNN, and editor of Time. He is the author of \'Leonardo da Vinci; The Innovators; Steve Jobs; Einstein: His Life and Universe; Benjamin Franklin: An American Life; and Kissinger: A Biography, and the coauthor of The Wise Men: Six Friends and the World They Made. Visit him at Isaacson.Tulane.edu and on Twitter at @WalterIsaacson</span></p>', NULL, NULL, NULL, NULL, '2023-07-27 06:24:07', '2023-11-29 11:19:34', 62, 0, 5.0),
(22, 'one indian girl', '21', '1', '3', 'Chetan bhagat', '50000', '2', '8000', '2', '1', '3', 'active', '2', 'all_users', 'upload/book/7120081690894707.jpeg', '<p><em>One Indian Girl</em> is a novel by the Indian author Chetan Bhagat. ... The book is about a girl named Radhika Mehta, who is a worker at the Distressed Debt group</p>', NULL, NULL, NULL, NULL, '2023-08-01 12:58:27', '2023-11-30 10:14:42', 55, 0, 4.5),
(24, 'Thumbelina', '25', '1', '1', 'WooEnglish', '22200', '1', '29', '2', '1', '1', 'active', '2', 'all_users', 'upload/book/3587331693257070.jpg', '<p><span style=\"font-family: \'helvetica neue\', Helvetica, Arial, sans-serif; font-size: 14px; text-align: justify;\">One woman wanted a child. She decided to go to the old woman who knew magic. The old woman gave her a flower. She said to plant this flower in a small box and wait. The woman planted the flower. The next day another big flower appeared in the box. It was very beautiful. The woman kissed it. Suddenly the flower opened. There was a lovely little girl inside. But she was very small. The girl was not more than an inch tall. The woman decided to call her Thumbelina. Thumbelina continued to live in her flower on the woman\'s table. But one night something happened. A big toad came into the house. The toad saw Thumbelina. She wanted the little girl to marry her son. She took the flower with Thumbelina and ran away.</span></p>', NULL, NULL, NULL, NULL, '2023-08-28 20:11:10', '2023-12-04 12:36:28', 217, 0, 4.5);

-- --------------------------------------------------------

--
-- Table structure for table `bookmark`
--

CREATE TABLE `bookmark` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `chapter_id` text DEFAULT NULL,
  `chapter_name` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookmark`
--

INSERT INTO `bookmark` (`id`, `book_id`, `chapter_id`, `chapter_name`, `user_id`, `created_at`, `updated_at`) VALUES
(56, '19', '33', 'Rising Through the Ranks', '64d623bf0cf19', '2023-08-11 21:14:22', '2023-08-11 21:14:22'),
(58, '19', '33', 'Rising Through the Ranks', '64d6287920de6', '2023-08-26 08:48:52', '2023-08-26 08:48:52'),
(60, '18', '30', 'Chapter 1', '64edee169990f', '2023-09-22 05:51:01', '2023-09-22 05:51:01'),
(63, '18', '29', 'Introduction', '64d4df0960935', '2023-10-02 09:16:32', '2023-10-02 09:16:32'),
(65, '18', '31', 'chapter 2', '65118cec186b0', '2023-10-03 04:04:58', '2023-10-03 04:04:58'),
(67, '18', '29', 'Introduction', '651d1a3e89fdb', '2023-10-13 08:28:09', '2023-10-13 08:28:09'),
(71, '18', '29', 'Introduction', '651eb34c00eb1', '2023-11-24 06:43:28', '2023-11-24 06:43:28');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `status`, `created_at`, `updated_at`) VALUES
(20, 'Action', 'active', '2023-06-22 17:11:54', '2023-06-22 17:11:54'),
(21, 'Novel', 'active', '2023-06-22 17:18:20', '2023-06-22 17:18:20'),
(23, 'test', 'active', '2023-07-07 15:28:35', '2023-07-07 15:28:35'),
(24, 'Biography', 'active', '2023-07-27 06:19:15', '2023-07-27 06:19:15'),
(25, 'test2', 'active', '2023-08-02 08:23:17', '2023-08-02 08:23:17');

-- --------------------------------------------------------

--
-- Table structure for table `chapters`
--

CREATE TABLE `chapters` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `chapter_no` text DEFAULT NULL,
  `chapter_name` text DEFAULT NULL,
  `chapter_description` longtext DEFAULT NULL,
  `audio_title` text DEFAULT NULL,
  `audio` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chapters`
--

INSERT INTO `chapters` (`id`, `book_id`, `chapter_no`, `chapter_name`, `chapter_description`, `audio_title`, `audio`, `created_at`, `updated_at`) VALUES
(1, '3', '1', 'Chapter 1', '<div>\r\n<h2>What is Lorem Ipsum?</h2>\r\n<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n</div>\r\n<div>\r\n<h2>Why do we use it?</h2>\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n</div>\r\n<p>&nbsp;</p>', 'audio 1', 'upload/book/audio/698581689226937.mp3', '2023-06-15 03:51:38', '2023-07-13 05:42:19'),
(4, '6', '1', 'Index page', '<div>\r\n<h2>Where does it come from?</h2>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n<p>&nbsp;</p>\r\n<div>\r\n<h2>Where does it come from?</h2>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 <strong> translation </strong>by H. Rackham.</p>\r\n</div>\r\n<p>&nbsp;</p>\r\n</div>\r\n<p>&nbsp;</p>', NULL, NULL, '2023-06-15 08:23:31', '2023-06-15 08:23:31'),
(5, '7', '1', 'test', '<p>test</p>', NULL, NULL, '2023-06-16 06:03:44', '2023-06-16 06:03:44'),
(16, '13', '01', 'A Noble Family', '<div class=\"page1\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">One evening, on his way home from Shaston to the village of Marlott, Jack Durbeyfield met Parson Tringham. \'Good evening, parson,\' said Jack.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Good evening, Sir John.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Jack looked at the parson in surprise. \'Why do you call me \"Sir John\"?\' he asked. \'You know that I am plain Jack Durbeyfield, the haggler.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The parson hesitated for a moment, then replied, \'While I was researching the history of this county, I discovered that your ancestors are the d\'Urbervilles, an ancient noble family. Your ancestor Sir Pagan d\'Urberville was a famous knight who came from Normandy with William the Conqueror.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I have never heard it before!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Yes. Yours is one of the best families in England.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'How amazing!\' cried Jack. \'All these years I thought I was just a common fellow! Tell me, sir, where do we d\'Urbervilles live?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You don\'t live anywhere. You are extinct as a county family.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'That\'s bad. But where are we buried?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'At Kingsbere. Many d\'Urbervilles are buried there in marble tombs.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'And where are our fine houses and our lands?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You don\'t have any, though you once had. Goodnight, Durbeyfield.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Well!\' thought Jack. \'I\'ll go to The Pure Drop Pub and have a drink to celebrate this! Then I\'ll ride home in a carriage!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">That evening the women of the village were walking in a procession. It was an old custom. Every year, in the month of May, the women dressed in white and walked together through the village then danced in the field. As they passed by The Pure Drop Pub, one girl called out to another, \'Look, Tess Durbeyfield! There\'s your father riding home in a carriage!\'</p>\r\n</div>\r\n<div class=\"page2\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess turned to look. She was very pretty, with a soft mouth and large innocent eyes. She wore a white muslin dress and a red ribbon in her hair. None of the other girls had a red ribbon.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Tess!\' called her father from the carriage, \'I am descended from a noble family! I have a family vault at Kingsbere!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess blushed to see her father make such a fool of himself. \'He\'s just tired,\' she said.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No!\' said the other girl. \'He\'s drunk!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I won\'t walk with you if you make fun of my father!\' cried Tess.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As the carriage drove away, the procession of women entered the field and began to dance.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Three young gentlemen were passing at that moment. They stopped to watch the women dancing. The youngest entered the field.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'What are you doing, Angel?\' asked his eldest brother.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'m going to dance with them. Why don\'t we all dance?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Don\'t be foolish. We can\'t dance with simple country girls. Somebody might see us. Besides, we must get to Stourcastle before dark.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Well, you go on. I\'ll join you in five minutes.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The two elder brothers - Felix and Cuthbert - walked on.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Who will dance with me?\' Angel asked the women.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You\'ll have to choose a partner, sir,\' said one of the girls.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Angel looked around and chose the girl nearest to him. He did not choose Tess, even though she was descended from a noble family.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">After the dance, Angel noticed Tess. She was standing apart from the others, looking at him sadly. He felt sorry that he had not asked her to dance, but it was too late now. Angel turned and ran down the road after his brothers.</p>\r\n</div>\r\n<div class=\"page3\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">When Tess returned home that evening, she was still thinking about the young man who had not asked her to dance. But as soon as she entered the cottage, her father told her what the parson had said. \'I went back to The Pure Drop and told everyone there. One man said there is a lady called Mrs Stoke-d\'Urberville living in a fine house near Trantridge. She must be my cousin.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Mrs Durbeyfield smiled. Her face still had some of the freshness and prettiness of her youth. Tess\'s good looks came from her mother, not from the noble d\'Urbervilles. \'I think you should go and visit her, Tess!\' said she. \'I looked in my fortune-telling book and it said you should go!\' Tess\'s mother was a simple country woman who spoke in dialect, sang folk songs, and had many superstitious beliefs. Tess had been educated at the National School and she spoke two languages: dialect at home, and English outside.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Mr and Mrs Durbeyfield had brought nine children into the world. Tess, the eldest, was seventeen. The two after Tess had died in infancy. Then came Liza-Lu, Abraham, two more sisters, a three-year-old boy, and the baby.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Mr Durbeyfield\'s face was red from drinking. \'I\'m tired, Joan,\' he said to his wife.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Father,\' said Tess, \'you have to drive the goods to town so we can sell them at the market tomorrow! How will you wake up in time?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'ll wake up, don\'t you worry!\' said Jack.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">But at two in the morning Joan came to Tess\'s room. \'I\'ve been trying to wake him, but I can\'t,\' she said. \'If he doesn\'t leave now, he\'ll be late for the market!\'</p>\r\n</div>\r\n<div class=\"page4\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Abraham and I will go,\' Tess replied.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess loaded the goods onto the cart, which was drawn by Prince, their only horse. Then she and Abraham climbed on and waved goodbye to their mother.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The night sky was full of stars as Tess and Abraham rode along.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'What do you think the stars are?\' asked Abraham.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'They are worlds like this one.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Really? Are they exactly like our world?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No. I think they are like the apples on the tree. Some of them are splendid and healthy but others are rotten.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'And which are we on - a splendid one or a rotten one?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'A rotten one.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">They stopped talking, and Tess began to feel sleepy. She tried to stay awake, but in the end she fell asleep. She was woken up by the terrifying sound of an animal in pain. The cart had stopped.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess jumped down and saw to her horror that they had crashed into the morning mail-cart in the dark. The pointed wooden shaft of the mail-cart had penetrated Prince\'s chest like a sword. Tess put her hand on the wound. Prince\'s blood splashed over her face and dress. The poor horse fell down dead.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I must go on with the mail,\' said the mail-man. \'I\'ll send someone to help you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As Tess and Abraham waited on the road, the sun rose. Then Tess saw the huge pool of blood. \'It\'s all my fault!\' she cried.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'How will mother and father get their goods to market without a horse?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Is it because we live on a rotten star?\' asked Abraham, with tears running down his cheeks. Tess did not reply. Her cheeks were pale and dry, as though she thought herself a murderess.</p>\r\n</div>\r\n<div class=\"page5\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">After Prince\'s death, life was very difficult for the Durbeyfields. Tess felt responsible for her family\'s distress and wondered what she could do to help them. One day her mother said, \'Tess, you must go to our cousin Mrs Stoke-d\'Urberville and ask for her help. She is very rich.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess took a cart to Trantridge Cross and walked the rest of the way. She passed through The Chase, an ancient forest that had been there for thousands of years. Finally she came to Mrs d\'Urberville\'s house, a fine new mansion known as The Slopes.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess was startled and intimidated by the grandeur of The Slopes. The great red-brick house, the green lawn with an ornamental tent on it, the stables: everything about the house and gardens looked like money. \'I thought we were an old family!\' thought Tess, \'but this is all new!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">In fact the Stoke-d\'Urbervilles were not really d\'Urbervilles at all. Mr Simon Stoke had made a fortune as a merchant in the North of England. When he retired, he moved to the South and decided to change his name to something more aristocratic. He looked through a history of the county and found the name d\'Urberville. So he changed his name to Stoke-d\'Urberville. Tess and her family knew nothing about this work of the imagination.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As Tess stood looking at the house, a young man walked out of the ornamental tent, smoking a cigar. He had dark skin, a full mouth, and a black moustache. \'Well, my beauty, what can I do for you?\' he asked, looking at Tess coldly. \'I am Mr Alexander d\'Urberville. Have you come to see me or my mother?\'</p>\r\n</div>\r\n<div class=\"page6\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess was even more surprised by Mr d\'Urberville than she was by the house. She had expected her cousins to have fine aristocratic faces, but this man looked almost barbaric.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'ve come to see your mother, sir,\' she said.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You can\'t see my mother: she is an invalid. Can I help you? What did you wish to discuss with her?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess felt suddenly embarrassed. \'It\'s so foolish,\' she said, smiling shyly. \'I\'m afraid to tell you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I like foolish things.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I came to tell you that we\'re of the same family as you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Poor relations?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Yes.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Stokes?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No, d\'Urbervilles.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Oh, yes. I mean d\'Urbervilles.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Our name is now Durbeyfield, but we have proof that we are d\'Urbervilles. We have an old seal, marked with a lion rampant. And we have an old silver spoon with a castle on it, but it is so worn that mother uses it to stir the soup.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'A castle argent is certainly my crest,\' said he. \'And my arms a lion rampant. And so, you have come on a friendly visit to us, as relations?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Yes,\' said Tess, looking up again. \'I will go home by the same cart that brought me.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'The cart won\'t come for a long time yet. Why not walk with me around the grounds, my pretty cousin?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess wished she could leave immediately, but the young man insisted, so she walked around the grounds with him. He showed her gardens, fruit trees, and greenhouses. In one of the greenhouses, he asked Tess if she liked strawberries.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Yes,\' she replied, \'when they are in season.\'</p>\r\n</div>\r\n<div class=\"page7\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'They are in season here already,\' said Alec. He picked a ripe red strawberry and held it to her lips.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No - no!\' she said quickly, putting her fingers between his hand and her lips. \'Please let me take it in my own hand.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Nonsense!\' he insisted. A little distressed, she parted her lips and took it in.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Alec asked her many questions about herself and her family. She told him about the death of Prince. \'It was all my fault!\' she said. \'And now we are even poorer than we were before.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Maybe I can do something to help,\' said Alec. \'My mother could find work for you here. But if you come to live here, Tess, you mustn\'t talk nonsense about being a d\'Urberville. Your name is Durbeyfield - a completely different name.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I wish for no better name, sir,\' said Tess with dignity.</p>\r\n</div>', '01', 'upload/book/audio/1328651687454697.mp3', '2023-06-22 17:24:58', '2023-06-22 17:24:58'),
(17, '13', '02', 'Maiden', '<div class=\"page8\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Then Tess got home the next day, her mother said, \'A letter has come, Tess! Mrs d\'Urberville wants you to work on her chicken farm. She says you will have a comfortable room and good wages!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess read the letter, then said, \'I want to stay here with you and father.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Why?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I don\'t want to tell you why. I don\'t really know why.\' For the next few weeks, Tess searched for work close to home, but she found none. One day, when she came home, her mother said, \'Mr d\'Urberville came by on his horse and asked if you had decided to work at his mother\'s chicken farm. Oh, what a handsome man he is!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I don\'t think so,\' said Tess coldly.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'And he was wearing a diamond ring!\' said Abraham. \'I saw it. The diamond glittered every time he put his hand up to his moustache. Why did our rich relation put his hand up to his moustache so often?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Perhaps to show his diamond ring,\' said Jack.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Are you going to accept the offer, Tess?\' asked her mother.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Perhaps,\' said Tess.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Well, he likes her,\' said Joan to her husband, \'and she should go.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I don\'t like my children going away from home,\' said Jack.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Let her go,\' said his poor stupid wife. \'He likes her, and he called her \"cousin\"! Maybe he\'ll marry her, and then we will have a new horse and plenty of money!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I will go,\' said Tess. \'But don\'t talk about me marrying him. I am going to earn some money so that we can buy a horse.\'</p>\r\n</div>\r\n<div class=\"page9\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess wrote to Mrs d\'Urberville, accepting her offer. Mrs d\'Urberville replied, saying she was glad. Mrs d\'Urberville\'s handwriting seemed rather masculine.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Two days later, the entire family accompanied Tess to meet the cart. As they climbed the hill, the cart appeared on the summit. Tess kissed everyone goodbye and ran up the hill. But then a gig came out from behind the trees.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess\'s face was full of surprise and apprehension as d\'Urberville asked her to mount his gig and drive with him to The Slopes. She wanted to ride in the cart. But, when she looked down the hill at her family, she thought about Prince and how she was responsible for his death. Then she climbed onto the gig with Alec d\'Urberville.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As they drove along, Alec paid many compliments to Tess. Joan had insisted that Tess dress in her best clothes. Sitting on the gig in her white muslin dress with a pink ribbon in her hair, Tess wished she had worn her ordinary working clothes. She had a full figure that made her look more of a woman and less of a child than she really was, and the white muslin dress emphasised this. Tess looked out at the green valley of her birth and the grey unfamiliar countryside beyond.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Will you go slow, sir, when we go downhill?\' asked Tess.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No, Tess,\' said d\'Urberville, holding his cigar between his strong white teeth and smiling at her. \'I enjoy going down the hills at full gallop!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As they descended the hill, the gig went faster and faster. The wind blew through Tess\'s white muslin and chilled her skin. She did not want him to see that she was frightened, but she was afraid of falling off the gig, so she held his arm.</p>\r\n</div>\r\n<div class=\"page10\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Don\'t hold my arm,\' said he. \'Hold on around my waist.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">She held his waist, and so they reached the bottom.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Safe, thank God, in spite of your fooling!\' cried Tess.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Don\'t be angry, Tess, and don\'t let go of me now that you are out of danger.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess blushed. She had held onto his waist without thinking.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Here\'s another hill! Hang on!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As the gig sped down the hill, Alec turned to Tess and said,</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Now put your arms around my waist as you did before!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Never!\' cried Tess independently.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'If you let me kiss you, I\'ll slow down.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess moved as far away from him as she could. \'Will nothing else make you slow down?\' she cried.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Nothing, dear Tess.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Oh! All right!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">He slowed the gig down and leaned over to kiss her, but Tess turned her face away.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You little witch!\' cried Alec. \'I\'ll drive so fast that we will both be killed, if you don\'t keep your promise.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'All right!\' said Tess, \'but you should be kind to me, since you are my cousin.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Nonsense! Come here!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I don\'t want anyone to kiss me, sir!\' cried Tess. A big tear rolled down her cheek, and her lips trembled. \'I wish I had stayed at home!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">When d\'Urberville kissed her, she blushed with shame. At that moment, Tess\'s hat blew off in the wind. \'Oh, sir! Let me get my hat!\' she said. He stopped the gig. Tess jumped down, ran back along the road, and picked up her hat.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Come on! Get back on the gig,\' said d\'Urberville.</p>\r\n</div>\r\n<div class=\"page11\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No, sir,\' Tess replied. \'I shall walk.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You let your hat blow off deliberately!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess did not deny it. D\'Urberville began to swear at her. He drove the gig towards her, forcing her to climb into the hedge.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You should be ashamed of yourself for using such wicked words!\' cried Tess. \'I don\'t like you at all! I hate you! I\'ll go back to my mother!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Alec\'s anger disappeared at the sight of Tess\'s. He laughed heartily. \'Well, I like you even more now! Come here, and let there be peace. I won\'t do it any more against your will, I promise!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I won\'t get back on the gig, sir!\' said Tess. She walked along, with the gig moving slowly beside her. In this way they came to The Slopes.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess\'s life at The Slopes was quite pleasant. Her duties were not difficult, and the other workers were friendly. On the first day, Tess was surprised to learn that Mrs d\'Urberville was blind. Even so, the old lady was very interested in her chickens and treated them more like pets than farm animals. Every morning Tess brought the chickens to Mrs d\'Urberville. The old lady took the chickens in her arms one by one. She recognised each one and called it by its name. Although she was kind and polite to Tess, clearly she had no idea that they were cousins.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess often met Alec in the house or the garden. Sometimes it seemed that he was following her, watching her secretly from behind walls and curtains. She was reserved towards him, but he treated her as if they were old friends. He often called her \'cousin\', though sometimes his tone was ironic.</p>\r\n</div>\r\n<div class=\"page12\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">On Saturday nights, the villagers went to a nearby market town called Chaseborough to dance, drink beer, and enjoy themselves. At first, Tess refused to go with them, but the others asked her again, and finally she agreed. She enjoyed herself the first time, so she began to go regularly.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">One Saturday in September, Tess worked late at the chicken farm, then walked to Chaseborough alone, because her friends had all gone earlier in the evening. By the time she got there, the sun had already set. At first she could not find her friends, then someone told her that they had gone dancing in the barn of a local farmer. As Tess walked along the road to the barn, she saw Alec standing on the corner.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Why are you out so late, my beauty?\' he said.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">She told him she was looking for her friends, so that she could walk home with them.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'ll see you again,\' he called to her as she walked on.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The barn was full of yellow light. Tess\'s friends were dancing with their arms around each other, like satyrs and nymphs. A young man asked her to dance, but she refused. The dancing seemed so mad and passionate, it made Tess uncomfortable.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Are any of you walking home soon?\' she asked anxiously. She was afraid to walk home alone.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Oh yes,\' replied a man. \'This will be the last dance.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">But when that dance was over, the dancers asked the musicians to play once more. Tess waited and waited.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Suddenly, one of the couples in the dance fell down, and other couples fell on top of them. Tess heard a loud laugh behind her. She looked around and saw the red end of a burning cigar in the shadows. Alec was standing there alone.</p>\r\n</div>\r\n<div class=\"page13\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Hello, my beauty. What are you doing here?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess explained that she was waiting for her friends to walk home.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'m on horseback this evening, but I could rent a gig from the hotel and drive you home,\' he said.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'No, thank you,\' she said.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">When the dance was finally over, Tess and the others walked back towards Trantridge in the moonlight. Many of the men and some of the women were drunk. Two of the women walked unsteadily: a dark beauty named Car Darch, who was known as the Queen of Spades, and her sister, who was known as the Queen of Diamonds. Until recently, the Queen of Spades had been Alec d\'Urberville\'s favourite.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Car Darch fell in the mud on the road. The others laughed at her, and Tess joined in the laughter. Suddenly Car Darch stood up and said to Tess, \'How dare you laugh at me!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Everyone was laughing,\' Tess replied.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You think you are better than the rest of us, just because he likes you best now!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The Queen of Spades closed her hands and held them up towards Tess, ready to fight.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I shall not fight you,\' said Tess, \'I did not know that you were whores! I wish I had not waited to walk home with you!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">This general comment made the others angry too. The Queen of Diamonds, who had also been one of Alec\'s favourites in the past, united with her sister against the common enemy. Several other women also insulted Tess. Their husbands and lovers tried to make peace by defending her, but this only made the situation worse.</p>\r\n</div>\r\n<div class=\"page14\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess was no longer afraid to walk home alone, she just wanted to get away from these people. Suddenly Alec appeared on horseback out of the shadows. He rode up to Tess, who was standing a little apart from the others.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'What the devil are you people doing?\' he cried. \'Jump up on my horse,\' he whispered to Tess, \'and we\'ll be far away from them in a moment.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">She wanted to refuse his help, as she had refused it before. But now she was afraid of these angry drunken companions. She wanted to mount the horse and ride away, triumphing over her enemies. She gave in to the impulse and got on the horse.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">As Alec and Tess rode away, Car Darch and her sister began to laugh.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'What are you laughing at?\' asked a young man.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Car\'s mother, who was also laughing, said, \'Out of the frying-pan into the fire!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Alec and Tess rode along in silence. Tess was glad of her triumph, but she was nervous about her present situation. She held on to Alec\'s waist as he rode, because she was afraid of falling off. She asked him to ride slowly, and he did so.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Are you glad to have escaped from them, dear Tess?\' asked Alec.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Yes. I should be grateful to you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'And are you?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">She did not reply.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Tess, why do you not like me to kiss you?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Because I don\'t love you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Are you sure?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I am angry with you sometimes!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Ah, I thought so,\' said Alec sadly, but he was not really saddened by what she had said. He knew that any other feeling she had for him was better than indifference.</p>\r\n</div>\r\n<div class=\"page15\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">They fell silent, and the horse walked on. There was a faint luminous fog around them. They had passed the road to Trantridge a long time ago, but Tess had not noticed. She was tired. This morning, as usual, she had risen at five and worked all day. It was now nearly one o\'clock. Fatigue overcame her, and her head sank gently against his back.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">D\'Urberville stopped the horse, turned around, and put his arm around her waist, but the movement woke Tess, and she pushed him away.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Good God! You nearly pushed me off the horse!\' cried Alec.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'m sorry, sir,\' said Tess humbly.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'For nearly three months you have treated me this way, Tess, and I won\'t tolerate it! You know that I love you and think you are the prettiest girl in the world, and yet you treat me badly. Will you not let me act as your lover?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I don\'t know - I wish - how can I say yes or no when...\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Then Tess noticed that the road was unfamiliar. \'Where are we?\' she asked.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'We are in The Chase - the oldest forest in England. It\'s a lovely night, and I thought we could ride for a little longer.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'How could you be so treacherous! Let me down. I want to walk home.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'You cannot walk home, darling. We are miles from Trantridge.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Never mind. Let me down, sir!\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'All right,\' said Alec. \'But I don\'t know where we are. Promise to wait by the horse while I walk through the woods in search of a road or a house. When I know where we are, I will give you directions and let you walk home alone, or you may ride, if you wish.\'</p>\r\n</div>\r\n<div class=\"page16\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess agreed to this plan.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Alec tied the horse to a tree and made a pile of dried leaves on the ground nearby. \'Sit there,\' he said. \'I\'ll be back soon. By the way, Tess, somebody gave your father a new horse today.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'How very kind of you!\' she cried, but she felt embarrassed having to thank him at that moment. \'I almost wish that you had not.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Why, dear?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'It makes things difficult for me.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Tessy - don\'t you love me a little now?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'I\'m grateful,\' she reluctantly admitted. \'But I don\'t love you.\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The knowledge that his passion for her had caused him to be so kind to her family made Tess feel sad, and she began to cry.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Don\'t cry, dear! Sit down here and wait for me. Are you cold?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess was wearing only her thin muslin dress. Alec took off his coat and put it over her shoulders, then he walked off into the fog.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">He went up the hill so that he could see the surrounding countryside and discover where they were. From the hilltop he saw a familiar road, so he turned back. The moon had now set, and The Chase was dark. At first he could not find the spot where he had left the horse. But, after walking around in the darkness for some time, he heard the sound of the horse moving.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">\'Tess?\'</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">There was no answer. It was so dark that he could see nothing but the pale cloud of her dress on the ground at his feet. He stooped and heard her gentle regular breathing. He knelt beside her and bent lower till her breath warmed his face and his cheek rested on hers. She was asleep, and there were tears on her eyelashes.</p>\r\n</div>\r\n<div class=\"page17\" style=\"box-sizing: border-box; color: #010101; font-family: Arial; font-size: 20px; text-indent: 40px; background-color: #fefefe;\">\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">The ancient trees of The Chase rose high above them in darkness and silence. But where was Tess\'s guardian angel? This coarse young man was about to claim a fine, sensitive, pure girl for his own. Why does this happen so often? Perhaps in this case Nemesis was involved. No doubt some of Tess\'s noble ancestors had treated the peasant girls of their time in the same way.</p>\r\n<p style=\"box-sizing: border-box; margin: 0px; padding: 0px 0px 10px;\">Tess\'s own people, who believe in Fate, often say, \'It was to be.\' That was the pity of it.</p>\r\n</div>', NULL, NULL, '2023-06-22 17:26:17', '2023-06-22 17:26:17'),
(21, '15', '1', 'test', '<p>test</p>', 'test', 'upload/book/audio/4756421688649407.mp3', '2023-07-06 13:16:48', '2023-07-06 13:16:48'),
(22, '15', '1', 'test', '<p>test</p>', 'tst', NULL, '2023-07-12 10:16:47', '2023-07-12 10:16:47'),
(26, '3', '2', 'Chapter 2', '<div>\r\n<h2>Where does it come from?</h2>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.</p>\r\n</div>\r\n<h2>Where can I get some?</h2>\r\n<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embar</p>\r\n<p>&nbsp;</p>', 'audio 2', 'upload/book/audio/1999411689227111.mp3', '2023-07-13 05:45:12', '2023-07-13 05:45:12'),
(27, '3', '3', 'Chapter 3', '<h2>here does it come from?</h2>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero a</p>\r\n<p>&nbsp;</p>', 'audio 3', 'upload/book/audio/4638421689227180.mp3', '2023-07-13 05:46:22', '2023-07-13 05:46:22');
INSERT INTO `chapters` (`id`, `book_id`, `chapter_no`, `chapter_name`, `chapter_description`, `audio_title`, `audio`, `created_at`, `updated_at`) VALUES
(28, '3', '4', 'Chapter 4', '<h2>here does it come from?</h2>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of \"de Finibus Bonorum et Malorum\" (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, \"Lorem ipsum dolor sit amet..\", comes from a line in section 1.10.32.</p>\r\n<p>The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from \"de Finibus Bonorum et Malorum\" by Cicero a</p>\r\n<p>&nbsp;</p>', 'audio 4', 'upload/book/audio/1567051689227211.mp3', '2023-07-13 05:46:51', '2023-07-13 05:46:51'),
(29, '18', '1', 'Introduction', '<p>introduction Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', 'Introduction', 'upload/book/audio/151571689599294.mp3', '2023-07-17 13:08:14', '2023-07-17 13:08:14'),
(30, '18', '2', 'Chapter 1', '<p>Chapter 1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>', 'Chapter 1', 'upload/book/audio/9244421689599348.mp3', '2023-07-17 13:09:08', '2023-07-17 13:10:13'),
(31, '18', '3', 'chapter 2', '<p>test</p>', 'test', 'upload/book/audio/1477481690204887.mp3', '2023-07-24 13:21:28', '2023-07-24 13:21:28'),
(32, '19', '1', 'Childhood Dreams', '<p>Leonardo DiCaprio was born on November 11, 1974, in a bustling, colorful part of Los Angeles, California, known as Hollywood. His parents, George DiCaprio and Irmelin Indenbirken, both held a deep love for art and creativity, and this was a huge part of Leonardo\'s childhood.</p>\r\n<p>&nbsp;</p>\r\n<p>George was an underground comic artist and distributor, and his keen interest in storytelling and visual expression had a profound influence on Leonardo. Irmelin, Leonardo\'s mother, was a legal secretary, but she also had an appreciation for art and culture. She was a constant source of support and encouragement for Leonardo.</p>\r\n<p>&nbsp;</p>\r\n<p>Even as a little boy, Leonardo found himself immersed in a world full of artistic expressions and eclectic characters. His neighborhood was a melting pot of cultures, filled with street performers, musicians, and artists. This unique blend of experiences often led to exciting, and sometimes challenging, adventures for young Leonardo.</p>\r\n<p>&nbsp;</p>\r\n<p>Living in the vibrant heart of Los Angeles, the allure of the silver screen was never far away. From a young age, Leonardo was fascinated by movies. He would often visit the local movie theater, eyes wide with excitement, getting lost in the magical world of cinema. The power of storytelling through film captivated his young mind. He imagined himself as the heroic figures he saw on the big screen, battling dragons, exploring alien worlds, or solving complex mysteries.</p>\r\n<p>&nbsp;</p>\r\n<p>His parents, noticing his passion for performing, encouraged him. They took him to auditions, waiting patiently with him for hours, hoping for an opportunity that would let their son shine. Leonardo, on his part, was determined to impress. He would memorize lines diligently, practice expressions in the mirror, and even create little skits at home. It was clear to everyone who knew him; Leonardo was born to be a star.</p>\r\n<p>&nbsp;</p>\r\n<p>However, his journey to stardom was not as straightforward as one might imagine. Leonardo faced numerous rejections and obstacles that threatened to overshadow his dreams. But every time he fell, he would pick himself up, dust off the disappointment, and step back into the world of auditions with renewed determination. Leonardo\'s spirit was unbreakable, a trait that would, in time, become a cornerstone of his success.</p>\r\n<p>&nbsp;</p>\r\n<p>The city of Los Angeles, with its glittering promise of fame, its vibrant art scene, and the steadfast support of his parents, set the stage for Leonardo\'s dreams of stardom. Little did he know then how brightly his star would one day shine in the Hollywood sky.</p>\r\n<p>&nbsp;</p>\r\n<p>This was the beginning of Leonardo DiCaprio\'s journey, a journey that started in the heart of Hollywood and would take him to unimaginable heights. As we explore his early life, we get a glimpse of the star Leonardo was destined to become.</p>\r\n<p>&nbsp;</p>\r\n<p>Leonardo DiCaprio&rsquo;s journey to fame was not a straight path. Despite his passion for acting and a supportive family, he faced many challenges early in his career. These initial obstacles would test his dedication and shape him into the resilient performer he is today.</p>\r\n<p>&nbsp;</p>\r\n<p>As a young boy in Hollywood, Leonardo was no stranger to auditions. He would accompany his parents to various studios, clutching scripts in his small hands, his heart filled with hopes and dreams. These auditions were often exhausting and demoralizing. He would stand in long lines, wait for hours, and often walk away without a callback.</p>\r\n<p>&nbsp;</p>\r\n<p>But Leonardo, ever determined, never let rejection slow him down. Each \'no\' he heard was a push to try harder, a challenge to prove himself. He was just a young boy, but he had the spirit of a true artist, a spirit that refused to back down. The countless auditions were not just a test of his talent, but also of his perseverance and passion for acting.</p>\r\n<p>&nbsp;</p>\r\n<p>However, not all auditions ended in rejection. Sometimes, he would land a small role, an extra in a commercial, or a line or two in a television show. These small parts, though not major breakthroughs, were still victories for young Leonardo. They were stepping stones, learning experiences that taught him about the world of acting.</p>\r\n<p>&nbsp;</p>\r\n<p>There were also instances where Leonardo was cast for roles that never made it to the screen. This was another challenging aspect of the acting industry. Not all projects were successful, and sometimes work that an actor had poured their heart and soul into would never be seen by an audience.</p>\r\n<p>&nbsp;</p>\r\n<p>One such incident in Leonardo\'s early career was when he was cast in a television series that was cancelled before it could even premiere. For Leonardo, who had worked diligently on his role, this was a significant setback. However, instead of letting it discourage him, he used the experience as a lesson in resilience.</p>\r\n<p>&nbsp;</p>\r\n<p>These early struggles shaped Leonardo&rsquo;s approach to acting and fame. They taught him that success was not guaranteed, that the path to stardom was fraught with challenges. But they also taught him the importance of perseverance, determination, and resilience.</p>\r\n<p>&nbsp;</p>\r\n<p>Leonardo\'s early experiences in the acting industry, from the countless auditions to the roles that never saw the light of day, were not failures, but foundations. They were crucial chapters in his journey that honed his skills, strengthened his resolve, and prepared him for the incredible success that was to come.</p>\r\n<p>This part of Leonardo\'s life reminds us that the road to achieving our dreams may not always be smooth, but the struggles we face along the way are the stepping stones to our ultimate success. Leonardo DiCaprio\'s early struggles are a testament to his unwavering determination and passion for acting. And as we will see, this would eventually lead him to the pinnacle of Hollywood stardom.</p>\r\n<p>After many auditions, small roles, and disappointments, a golden opportunity finally came Leonardo DiCaprio\'s way. His breakthrough role in television opened the doors of Hollywood for him, setting the stage for a star in the making.</p>\r\n<p>&nbsp;</p>\r\n<p>In the early 1990s, Leonardo bagged a recurring role in a popular television show titled \"Growing Pains\". This family sitcom revolved around the everyday life of the Seaver family, and Leonardo played a homeless boy named Luke Brower, who the Seavers take in.</p>\r\n<p>&nbsp;</p>\r\n<p>Getting a part in this well-loved show was a significant achievement for young Leonardo. It was his first steady acting job and provided him the opportunity to showcase his talent on a bigger stage. The character of Luke Brower, though troubled, was sympathetic and endearing, giving Leonardo a chance to explore a depth of emotion in his acting that he hadn\'t previously had.</p>\r\n<p>&nbsp;</p>\r\n<p>The cast and crew of \"Growing Pains\" were experienced and supportive. Working with them helped Leonardo learn the ropes of television production, from understanding script nuances to mastering the timing of comedy. He watched, he learned, and he grew, both as an actor and as a person. His performances were well-received, and his charming presence on the small screen quickly won the hearts of many viewers.</p>\r\n<p>&nbsp;</p>\r\n<p>Being part of \"Growing Pains\" was not just about learning to act, though. It was also about dealing with the fame that came with being on a popular show. Leonardo started getting recognized on the streets, and he had to adapt to this new reality. However, he managed to handle his growing fame with grace and humility, never allowing it to distract him from his passion for acting.</p>\r\n<p>&nbsp;</p>\r\n<p>Though \"Growing Pains\" ended after a couple of years, Leonardo\'s journey had just begun. The recognition he received from the show caught the attention of Hollywood casting directors. Offers for film roles started coming in, and Leonardo found himself at the doorstep of a promising movie career.</p>\r\n<p>&nbsp;</p>\r\n<p>His time on \"Growing Pains\" had equipped him with valuable skills and exposure. It served as a stepping stone, paving the way for his transition from television to film. The show may have ended, but for Leonardo DiCaprio, it was just the beginning. It was his first taste of stardom, a peek into the limelight that was about to shine brightly on him.</p>\r\n<p>&nbsp;</p>\r\n<p>This chapter in Leonardo\'s life was a critical turning point, marking his shift from a young boy with dreams to an up-and-coming actor on the brink of Hollywood fame. As we delve further into his journey, we will see how Leonardo used this early success as a springboard, diving headfirst into the world of cinema, eventually emerging as one of the most recognized faces in Hollywood.</p>', 'Childhood Dreams', 'upload/book/audio/8032591690294113.mp3', '2023-07-25 14:08:33', '2023-07-25 14:08:33'),
(33, '19', '2', 'Rising Through the Ranks', '<p>Chapter 2: \"Rising Through the Ranks\"</p>\r\n<p>In \"Breaking Through Barriers\", we delve into the journey of Leonardo DiCaprio as he navigated his way through the complexities of Hollywood. We get to see the young actor\'s dedication and his relentless pursuit of success, even when faced with rejection and hardship.</p>\r\n<p>&nbsp;</p>\r\n<p>Leonardo was born and raised in Los Angeles, the city of dreams, and from a young age, he was drawn to the magic of the silver screen. He found himself participating in several commercials and TV series, each experience adding a little more to his budding passion for acting.</p>\r\n<p>&nbsp;</p>\r\n<p>Despite his raw talent and dedication, Leonardo\'s journey to stardom wasn\'t an easy one. Hollywood was a tough place, especially for a newcomer without any industry connections. Leonardo found himself facing one rejection after another. However, he didn\'t let these setbacks discourage him. He took each \'no\' in stride, using it as a learning experience and fuel to work harder.</p>\r\n<p>&nbsp;</p>\r\n<p>One of Leonardo\'s early notable roles was in the television series \"Growing Pains,\" where he played a homeless teenager. His performance was praised by critics, and he became a familiar face to television audiences. While it wasn\'t a blockbuster movie, it was a significant milestone that propelled him closer to his Hollywood dreams.</p>\r\n<p>&nbsp;</p>\r\n<p>At a very young age, Leonardo learned one of the most critical lessons in life &ndash; persistence pays off. His steadfast commitment to his dream was commendable, and it eventually led him to his breakout role in the movie \"This Boy\'s Life\", where he starred alongside Robert De Niro. This film opened the door to bigger opportunities and set the foundation for the stellar career that lay ahead.</p>\r\n<p>&nbsp;</p>\r\n<p>\"Breaking Through Barriers\" showcases Leonardo\'s humble beginnings, his struggle, and his breakthrough. It serves as an inspiring testament to his tenacity and the sheer will that has shaped his journey from a dreamy-eyed boy to an international superstar. This part of his life provides an essential understanding of the grit and determination that\'s central to his character, both on-screen and off-screen. As we move forward, we will explore how Leonardo built upon this early success and how he started to carve a niche for himself in Hollywood.</p>\r\n<p>&nbsp;</p>\r\n<p>\"A Taste of Recognition\" follows Leonardo DiCaprio\'s extraordinary performance in the 1993 film, \"What\'s Eating Gilbert Grape\". It was this film that offered Leonardo his first taste of recognition on an international stage, landing him his first Oscar nomination.</p>\r\n<p>&nbsp;</p>\r\n<p>In \"What\'s Eating Gilbert Grape\", Leonardo played the role of Arnie Grape, a young boy with a developmental disability. It was a challenging part to play, demanding not just a physical transformation, but a mental one as well. Leonardo, however, dived into the character with commitment and grace.</p>\r\n<p>&nbsp;</p>\r\n<p>He prepared for the role with meticulous detail, researching extensively to ensure that his portrayal was accurate and sensitive. He spent time at homes for children with similar disabilities, observing their behavior and interacting with them. He learned their mannerisms, their challenges, and their joys, incorporating these insights into his portrayal of Arnie Grape.</p>\r\n<p>&nbsp;</p>\r\n<p>The making of \"What\'s Eating Gilbert Grape\" was an intense process for Leonardo. The film had a somber tone and dealt with complex themes of family dynamics, responsibility, and the struggle of living with a disability. Despite the heavy subject matter, Leonardo carried the role with an air of authenticity, delicacy, and even humor that was deeply moving.</p>\r\n<p>&nbsp;</p>\r\n<p>Working alongside experienced actors like Johnny Depp, who played his older brother Gilbert Grape, provided another opportunity for Leonardo to learn and grow. He observed their performances, absorbing everything he could from their expertise.</p>\r\n<p>&nbsp;</p>\r\n<p>The film was a critical success, and Leonardo\'s performance was highly praised. Critics lauded his detailed, sensitive, and convincing portrayal of Arnie. At just nineteen years old, he received his first Academy Award nomination for Best Supporting Actor, a remarkable achievement that signaled his arrival as a serious talent in Hollywood.</p>\r\n<p>&nbsp;</p>\r\n<p>This Oscar nomination was a milestone in Leonardo\'s career. It provided a taste of recognition from the most prestigious award-giving body in the film industry. Yet, true to his nature, Leonardo didn\'t let this early success inflate his ego. Instead, it fueled his desire to improve, to explore more complex roles and to become an even better actor.</p>\r\n<p>&nbsp;</p>\r\n<p>\"A Taste of Recognition\" reveals a pivotal time in Leonardo DiCaprio\'s career. His role in \"What\'s Eating Gilbert Grape\" offered him the chance to showcase his dedication to his craft and his ability to immerse himself completely in a character. His first Oscar nomination was a testament to his talent, setting the stage for his continued rise in Hollywood. As we continue exploring his journey, we will see how this recognition laid the groundwork for the iconic roles and incredible success still to come.</p>', 'Rising Through the Ranks', 'upload/book/audio/8179681690294252.mp3', '2023-07-25 14:10:53', '2023-07-25 14:10:53'),
(36, '24', '1', 'Chapter 1', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>', NULL, NULL, '2023-09-12 10:43:55', '2023-09-12 10:43:55'),
(37, '24', '2', 'chapter 2', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>', NULL, NULL, '2023-09-12 10:44:04', '2023-09-12 10:44:04'),
(38, '24', '3', 'Chapter 3', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum<strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum</p>', NULL, NULL, '2023-09-12 10:44:14', '2023-09-12 10:44:14');

-- --------------------------------------------------------

--
-- Table structure for table `english_accent`
--

CREATE TABLE `english_accent` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `english_accent`
--

INSERT INTO `english_accent` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'British', '2023-06-14 07:05:11', NULL),
(2, 'American', '2023-06-14 07:05:24', NULL),
(3, 'Any', '2023-06-14 07:05:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `english_fluency`
--

CREATE TABLE `english_fluency` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `english_fluency`
--

INSERT INTO `english_fluency` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Beginner', '2023-06-14 07:05:11', NULL),
(2, 'Intermediate', '2023-06-14 07:05:11', NULL),
(3, 'Advanced', '2023-06-14 07:05:24', NULL),
(4, 'Fluent', '2023-06-14 07:05:24', NULL),
(5, 'Native Speaker', '2023-06-14 07:05:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`id`, `book_id`, `user_id`, `created_at`, `updated_at`) VALUES
(90, '18', '64d4cfb1156fe', '2023-08-10 10:58:34', '2023-08-10 10:58:34'),
(91, '18', '64d4df0960935', '2023-08-11 05:47:57', '2023-08-11 05:47:57'),
(92, '18', '64d6287920de6', '2023-08-11 13:45:35', '2023-08-11 13:45:35'),
(94, '19', '64d623bf0cf19', '2023-08-12 19:11:42', '2023-08-12 19:11:42'),
(95, '20', '64edee169990f', '2023-09-12 10:24:54', '2023-09-12 10:24:54'),
(96, '18', '64edee169990f', '2023-09-14 04:19:33', '2023-09-14 04:19:33'),
(97, '19', '64d4df0960935', '2023-09-15 03:13:29', '2023-09-15 03:13:29'),
(103, '19', '64d6287920de6', '2023-09-29 08:50:39', '2023-09-29 08:50:39'),
(105, '18', '651eb34c00eb1', '2023-10-09 05:21:32', '2023-10-09 05:21:32'),
(106, '18', '654f9968c9882', '2023-11-11 15:13:05', '2023-11-11 15:13:05'),
(107, '15', '651d1a3e89fdb', '2023-11-24 08:52:14', '2023-11-24 08:52:14'),
(108, '18', '651d1a3e89fdb', '2023-11-24 08:52:42', '2023-11-24 08:52:42'),
(109, '24', '651d51f46f693', '2023-11-28 07:58:53', '2023-11-28 07:58:53'),
(110, '20', '651d51f46f693', '2023-11-28 08:01:30', '2023-11-28 08:01:30'),
(111, '18', '651d1e263dc08', '2023-12-04 12:39:58', '2023-12-04 12:39:58');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(11) NOT NULL,
  `user_id` text DEFAULT NULL,
  `msg` longtext DEFAULT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `user_id`, `msg`, `name`, `email`, `created_at`, `updated_at`) VALUES
(20, '64d623bf0cf19', 'help 12', 'Oubaha Abderrahmane', 'web.oubaha@gmail.com', '2023-08-11 21:14:04', '2023-08-11 21:14:04'),
(21, '64edee169990f', 'v6v6v6g6v6vybbub7b7b7\nbubu\nbub\nub\nubu\nbubu ubub', 'manish', 'test@gmail.com', '2023-09-22 06:01:04', '2023-09-22 06:01:04');

-- --------------------------------------------------------

--
-- Table structure for table `follow`
--

CREATE TABLE `follow` (
  `id` int(11) NOT NULL,
  `user_id` text DEFAULT NULL,
  `author_id` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `follow`
--

INSERT INTO `follow` (`id`, `user_id`, `author_id`, `created_at`, `updated_at`) VALUES
(49, '64d623bf0cf19', '16', '2023-08-11 11:05:15', '2023-08-11 11:05:15'),
(50, '64d4df0960935', '16', '2023-08-19 06:25:03', '2023-08-19 06:25:03'),
(52, '64d6287920de6', '16', '2023-08-26 18:48:16', '2023-08-26 18:48:16'),
(54, '651aab829086a', '16', '2023-10-03 04:38:20', '2023-10-03 04:38:20');

-- --------------------------------------------------------

--
-- Table structure for table `genre`
--

CREATE TABLE `genre` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `genre`
--

INSERT INTO `genre` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Fantasy', '2023-06-14 07:05:11', NULL),
(2, 'Science Fiction', '2023-06-14 07:05:11', NULL),
(3, 'Mystery', '2023-06-14 07:05:24', NULL),
(4, 'Romance', '2023-06-14 07:05:24', NULL),
(6, 'Any', '2023-09-15 12:16:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `home_category`
--

CREATE TABLE `home_category` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `home_category`
--

INSERT INTO `home_category` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Last update', '2023-06-20 12:23:21', NULL),
(2, 'Popular', '2023-06-20 12:23:21', NULL),
(3, 'Recommended', '2023-06-27 06:56:34', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `info_pages`
--

CREATE TABLE `info_pages` (
  `id` int(11) NOT NULL,
  `page_name` text DEFAULT NULL,
  `page_description` longtext DEFAULT NULL,
  `image` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `info_pages`
--

INSERT INTO `info_pages` (`id`, `page_name`, `page_description`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Welcome to read time', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,</p>', 'upload/infopage/9752871691751856.png', '2023-08-09 07:31:01', '2023-08-11 10:04:16'),
(2, 'Choose your book', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,</p>', 'upload/infopage/876901691751868.png', '2023-08-09 07:31:38', '2023-08-11 10:04:28'),
(3, 'Read your book anytime', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,</p>', 'upload/infopage/6256721691751876.png', '2023-08-09 07:32:10', '2023-08-11 10:04:36');

-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE `language` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Br', '2023-08-01 12:49:55', NULL),
(2, 'Ame', '2023-08-01 12:49:55', NULL),
(3, 'Any', '2023-09-15 12:19:22', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `length`
--

CREATE TABLE `length` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `length`
--

INSERT INTO `length` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Short', '2023-08-01 12:48:50', NULL),
(2, 'Medium', '2023-08-01 12:48:50', NULL),
(3, 'Long', '2023-08-01 12:48:58', NULL),
(4, 'Any', '2023-09-15 12:18:53', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `level`
--

CREATE TABLE `level` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `level`
--

INSERT INTO `level` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Beginner', '2023-06-14 07:05:11', NULL),
(2, 'Intermediate', '2023-06-14 07:05:11', NULL),
(3, 'Advanced', '2023-06-14 07:05:24', NULL),
(5, 'Any', '2023-09-15 12:17:11', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `id` int(11) NOT NULL,
  `notification_name` text DEFAULT NULL,
  `notification_description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`id`, `notification_name`, `notification_description`, `created_at`, `updated_at`) VALUES
(42, 'title test by oubaha', 'test by oubaha description', '2023-09-29 09:29:20', '2023-09-29 09:29:20');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(11) NOT NULL,
  `page_name` text DEFAULT NULL,
  `page_description` longtext DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `page_name`, `page_description`, `created_at`, `updated_at`) VALUES
(2, 'Privacy Policy', '<p>Here are a few examples:</p>\n<ol>\n<li>An <strong>Intellectual Property</strong> clause will inform users that the contents, logo and other visual media you created is your property and is protected by copyright laws.</li>\n<li>A <strong>Termination</strong> clause will inform users that any accounts on your website and mobile app, or users\' access to your website and app, can be terminated in case of abuses or at your sole discretion.</li>\n<li>A <strong>Governing Law</strong> clause will inform users which laws govern the agreement. These laws should come from the country in which your company is headquartered or the country from which you operate your website and mobile app.</li>\n<li>A <strong>Links to Other Websites</strong> clause will inform users that you are not responsible for any third party websites that you link to. This kind of clause will generally inform users that they are responsible for reading and agreeing (or disagreeing) with the Terms and Conditions or Privacy Policies of these third parties.</li>\n<li>\n<p>If your website or mobile app allows users to create content and make that content public to other users, a <strong>Content</strong> clause will inform users that they own the rights to the content they have created. This clause usually mentions that users must give you (the website or mobile app developer/owner) a license so that you can share this content on your website/mobile app and to make it available to other users.</p>\n<p>Because the content created by users is public to other users, a <a href=\"https://termsfeed.com/blog/dmca-terms-and-conditions/\">DMCA notice clause</a> (or Copyright Infringement ) section is helpful to inform users and copyright authors that, if any content is found to be a copyright infringement, you will respond to any DMCA takedown notices received and you will take down the content.</p>\n</li>\n<li>\n<p>A <strong>Limit What Users Can Do</strong> clause can inform users that <strong>by agreeing to use your service, they\'re also agreeing to not do certain things</strong>. This can be part of a very long and thorough list in your Terms and Conditions agreement so as to encompass the most amount of negative uses.</p>\n<p>Here\'s how <a href=\"https://500px.com/terms\">500px</a> lists its prohibited activities:</p>\n<p><img class=\"alignnone size-full wp-image-988\" src=\"https://www.termsfeed.com/public/uploads/2018/09/500px-terms-use-conduct-prohibited-activities-clause-excerpt.jpg\" alt=\"500px Terms of Use: Excerpt of User Conduct clause - Prohibited activities\" width=\"672\" height=\"482\" /></p>\n</li>\n</ol>\n<p><br /><br /></p>\n<p>&nbsp;</p>', '2023-06-20 05:51:18', '2023-07-12 06:22:32'),
(9, 'Terms and Condition', '<p><strong>Lorem Ipsum</strong> is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was populari</p>', '2023-08-10 11:01:57', '2023-08-10 11:01:57');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 107, 'API TOKEN', '510bedcc0e39b728fc39116c5bfecff7881a216baa7f736355d82e7a5a070a5d', '[\"*\"]', '2023-09-26 11:16:37', '2023-08-10 10:46:56', '2023-09-26 11:16:37'),
(3, 'App\\Models\\User', 109, 'API TOKEN', '32bb77585f916a0b11de7c733b917bf624fd73c6e6fb204d9ce3cbd4cf611f86', '[\"*\"]', NULL, '2023-08-10 11:28:18', '2023-08-10 11:28:18'),
(4, 'App\\Models\\User', 110, 'API TOKEN', '9ef38dbed180f15bb159ed0f2255b5438683b4c50739cce85324f67785282a40', '[\"*\"]', NULL, '2023-08-10 11:30:12', '2023-08-10 11:30:12'),
(5, 'App\\Models\\User', 109, 'API TOKEN', '0a16e4db974c95967f71cd71e0ddc045e13ec9a6b28efab5d9cb8e452e855118', '[\"*\"]', NULL, '2023-08-10 11:30:15', '2023-08-10 11:30:15'),
(6, 'App\\Models\\User', 109, 'API TOKEN', 'cf16679b494bcc7e28201b87f98fc37babf058381bd742a26a1272be8d854588', '[\"*\"]', NULL, '2023-08-10 11:30:47', '2023-08-10 11:30:47'),
(7, 'App\\Models\\User', 111, 'API TOKEN', '40b86b26d5482ae869abfce506f78844da56a2074461b981e05439b1ef8ed18a', '[\"*\"]', NULL, '2023-08-10 11:31:25', '2023-08-10 11:31:25'),
(8, 'App\\Models\\User', 111, 'API TOKEN', '2cf50a01fc493ae7dac8ef036fcc0b9570067916eff6615370a429187ae5ebc5', '[\"*\"]', NULL, '2023-08-10 11:31:53', '2023-08-10 11:31:53'),
(9, 'App\\Models\\User', 108, 'API TOKEN', '9ea3e42dfcb7e93f7cff9b57f2fe093166a7eea14dbbd1102954d855cc7c4baf', '[\"*\"]', '2023-08-10 11:41:10', '2023-08-10 11:40:59', '2023-08-10 11:41:10'),
(10, 'App\\Models\\User', 112, 'API TOKEN', 'ea21f6550d0734f63ba4138c6531f8aaa519d36c6bcba482e99952f6bfeb0cd2', '[\"*\"]', '2023-08-10 11:58:56', '2023-08-10 11:58:49', '2023-08-10 11:58:56'),
(15, 'App\\Models\\User', 112, 'API TOKEN', '1f2a4c30d76337b9313d14dd4ebad95384650be0a1398faa0d42153ac5853b9f', '[\"*\"]', '2023-08-11 05:37:23', '2023-08-11 05:19:37', '2023-08-11 05:37:23'),
(16, 'App\\Models\\User', 112, 'API TOKEN', '2fb357f832db735993deedd789c37ca4a28f7dfe821ee7662d0d1f0f383bdba4', '[\"*\"]', '2023-08-29 12:07:38', '2023-08-11 05:42:21', '2023-08-29 12:07:38'),
(18, 'App\\Models\\User', 117, 'API TOKEN', 'd38ee4091b6e9f24caa8a08ba0bfafb916c2bcf2f301c5342d6f9895cad51245', '[\"*\"]', '2023-08-11 10:02:12', '2023-08-11 10:02:03', '2023-08-11 10:02:12'),
(19, 'App\\Models\\User', 118, 'API TOKEN', '2082cf724068f16d002efdc61fb2713be39c25ae616391e51909c001afb37906', '[\"*\"]', '2023-08-11 11:11:35', '2023-08-11 11:04:15', '2023-08-11 11:11:35'),
(20, 'App\\Models\\User', 118, 'API TOKEN', '1c0ea3693b468a3286407db19b911a0530750b74746881a5991aa2d5a3ab5339', '[\"*\"]', '2023-08-11 21:06:50', '2023-08-11 13:38:48', '2023-08-11 21:06:50'),
(21, 'App\\Models\\User', 119, 'API TOKEN', '6b1a0295b47c3dd3fbfc3888db3e872b9355d4b63f7108fcaf84a21aba2f4b83', '[\"*\"]', '2023-09-22 22:15:39', '2023-08-11 13:42:46', '2023-09-22 22:15:39'),
(22, 'App\\Models\\User', 118, 'API TOKEN', 'b92f7c9d84b1eeafeae65e005b84ca8796487eaa451f75ab08f1f683912f82e2', '[\"*\"]', '2023-09-20 20:35:37', '2023-08-11 21:09:49', '2023-09-20 20:35:37'),
(24, 'App\\Models\\User', 122, 'API TOKEN', '23c5aae35c6a48692c00cb4ee4abaaf70994970f08b5aecffa449bd703bbb8d0', '[\"*\"]', '2023-08-18 06:56:42', '2023-08-18 06:56:33', '2023-08-18 06:56:42'),
(25, 'App\\Models\\User', 122, 'API TOKEN', '3e072dae6399f9fdc81c9fad760e77ded8f1e9f3554d641df07dc072a6a23104', '[\"*\"]', '2023-08-18 06:59:39', '2023-08-18 06:59:31', '2023-08-18 06:59:39'),
(26, 'App\\Models\\User', 123, 'API TOKEN', '1c841bcdff1edabe8df79f5eabefc0263b15237acc978af9e81eed82363bc29c', '[\"*\"]', '2023-08-29 12:11:21', '2023-08-29 12:10:27', '2023-08-29 12:11:21'),
(27, 'App\\Models\\User', 117, 'API TOKEN', 'af68b4e48e916561a949d0f1b84c4dab320277c34b6bf5f23c529ae69f5543e6', '[\"*\"]', '2023-09-20 07:18:31', '2023-09-07 06:15:43', '2023-09-20 07:18:31'),
(29, 'App\\Models\\User', 112, 'API TOKEN', '80e0b6f46998ae63f8fe38decc89bdbe28e6d0a1f8c673a5439c7653c5e38d51', '[\"*\"]', '2023-09-14 07:49:24', '2023-09-14 06:27:12', '2023-09-14 07:49:24'),
(33, 'App\\Models\\User', 117, 'API TOKEN', '67e75b2903990d99e7e675a0f22606f03a2d646d97821cd5c0e127fe54b1907f', '[\"*\"]', '2023-09-18 06:47:07', '2023-09-18 06:45:52', '2023-09-18 06:47:07'),
(34, 'App\\Models\\User', 124, 'API TOKEN', '9bbb8330513826f1d7c33bdcde3d81222763c42dd91c45e5708bb133ad33afd8', '[\"*\"]', '2023-09-21 10:46:31', '2023-09-18 08:31:56', '2023-09-21 10:46:31'),
(35, 'App\\Models\\User', 125, 'API TOKEN', 'b35e91f5fd0b645d81400ea29e9a0e86cae8eb4cc01dbe4ac3b2ae0e841ec14c', '[\"*\"]', '2023-09-25 09:18:26', '2023-09-18 08:34:59', '2023-09-25 09:18:26'),
(36, 'App\\Models\\User', 126, 'API TOKEN', '4443716a8776bf37f941d6e55e58a97241766af39e8be595e6b983dd76ce109f', '[\"*\"]', '2023-09-18 08:44:32', '2023-09-18 08:42:49', '2023-09-18 08:44:32'),
(38, 'App\\Models\\User', 123, 'API TOKEN', '66a89d8db0bb12f6bcf3305b0633054ff9ce5a9e8de119edcb9e426564b87f0e', '[\"*\"]', '2023-09-22 09:05:55', '2023-09-21 08:40:02', '2023-09-22 09:05:55'),
(39, 'App\\Models\\User', 112, 'API TOKEN', '3fcb76110dad8fa5b61f295e585ec39497e605c9f3233115f8c04bc1209065ba', '[\"*\"]', '2023-09-22 10:41:46', '2023-09-22 10:39:47', '2023-09-22 10:41:46'),
(41, 'App\\Models\\User', 119, 'API TOKEN', 'f0c4386515fbc97f4d48d898c01a125b70b4a2871c7a738512d63a72294fe96d', '[\"*\"]', '2023-09-25 17:49:50', '2023-09-22 22:20:03', '2023-09-25 17:49:50'),
(42, 'App\\Models\\User', 123, 'API TOKEN', 'ff7817d2547a57468bd86189a9ff77a8733a27900722f7e95a51e0d50e3ccf8d', '[\"*\"]', '2023-09-25 06:45:22', '2023-09-25 04:30:57', '2023-09-25 06:45:22'),
(43, 'App\\Models\\User', 112, 'API TOKEN', '0978e2e56bc0a24abb4cc837e1a85314997e1cd356cecac660f7d66c3ea5f796', '[\"*\"]', '2023-09-25 08:11:08', '2023-09-25 07:17:56', '2023-09-25 08:11:08'),
(44, 'App\\Models\\User', 112, 'API TOKEN', 'ac0fe224e020b1fc5446f3217bb5d8e1d15cbd0904f5cceea638a2e0b1075349', '[\"*\"]', '2023-09-27 05:58:49', '2023-09-25 07:25:03', '2023-09-27 05:58:49'),
(45, 'App\\Models\\User', 112, 'API TOKEN', 'bed3afc6ee289c87a990139c38feac516951b0bce8f44639e7817381643a6aa6', '[\"*\"]', '2023-09-26 11:08:26', '2023-09-25 08:15:23', '2023-09-26 11:08:26'),
(46, 'App\\Models\\User', 128, 'API TOKEN', 'eecb7036139c56210db0a70cfd996abab263d9c23c47f9fabae486fc9e116260', '[\"*\"]', '2023-09-26 03:56:38', '2023-09-25 08:33:20', '2023-09-26 03:56:38'),
(48, 'App\\Models\\User', 129, 'API TOKEN', '1b38140f08b5f6c72044600d86b4c9f4a05648e51e0b902571bbdeec59fe7491', '[\"*\"]', '2023-10-01 06:11:35', '2023-09-26 06:15:07', '2023-10-01 06:11:35'),
(49, 'App\\Models\\User', 130, 'API TOKEN', '6917eab586cd76a4f88b191970fdd0ad5830b1f536cce91144592fc2e8f9b17f', '[\"*\"]', '2023-09-26 11:27:13', '2023-09-26 11:22:12', '2023-09-26 11:27:13'),
(50, 'App\\Models\\User', 131, 'API TOKEN', '5270f01ae4a9ab4d8f085ebc32972ea48a5c11a710124837f749036d79d99e2a', '[\"*\"]', '2023-09-26 22:45:32', '2023-09-26 22:41:51', '2023-09-26 22:45:32'),
(51, 'App\\Models\\User', 123, 'API TOKEN', 'd17318c06aada5c51c82fed0997c9ae3d31fc1e9ee751c98e4dab277b9fcea76', '[\"*\"]', '2023-09-27 06:06:19', '2023-09-27 06:03:07', '2023-09-27 06:06:19'),
(52, 'App\\Models\\User', 112, 'API TOKEN', '9b6e205a6df7d50f8a4f1c0d5958c4769c5b0b899628497ae810ad6114b00a78', '[\"*\"]', '2023-09-27 11:32:23', '2023-09-27 06:10:34', '2023-09-27 11:32:23'),
(53, 'App\\Models\\User', 132, 'API TOKEN', '1f0a1d40dd994207fbb1598e157d1bef7552ba2bf7241bebb26f2808b21d131b', '[\"*\"]', '2023-09-27 13:06:03', '2023-09-27 12:58:06', '2023-09-27 13:06:03'),
(54, 'App\\Models\\User', 119, 'API TOKEN', '630df5ec121cd8d804d523979d13c21e22070155815a68a7bf7d8be27c32093d', '[\"*\"]', '2023-09-29 08:52:21', '2023-09-27 14:41:27', '2023-09-29 08:52:21'),
(55, 'App\\Models\\User', 131, 'API TOKEN', '013b639eaf8f2bd3a6680804373c567d6320fee22c70a592f2ffbbffb2725b3a', '[\"*\"]', '2023-09-29 09:32:16', '2023-09-27 14:58:59', '2023-09-29 09:32:16'),
(57, 'App\\Models\\User', 127, 'API TOKEN', '9344cb7e3632f1f65502691072992c9569329c9eae28e031fa27ad01bcfaa8d2', '[\"*\"]', '2023-09-29 09:09:10', '2023-09-29 09:09:02', '2023-09-29 09:09:10'),
(60, 'App\\Models\\User', 134, 'API TOKEN', 'fd151f0013fb5f5ae58c403323d495b3dfb2493382b4120c858205cb6ac63c61', '[\"*\"]', '2023-10-02 05:05:22', '2023-10-02 05:04:26', '2023-10-02 05:05:22'),
(63, 'App\\Models\\User', 135, 'API TOKEN', '12f0f324c3c7583c40e35af67d4b8c81ecce63e78acb3f58264039936ee6058c', '[\"*\"]', '2023-10-03 03:26:00', '2023-10-03 03:25:21', '2023-10-03 03:26:00'),
(64, 'App\\Models\\User', 129, 'API TOKEN', '711e6eb5649408f6ffb5892790aec96fbdf1a4e2de169c0715099c79f41b5d92', '[\"*\"]', '2023-10-03 04:04:58', '2023-10-03 03:53:56', '2023-10-03 04:04:58'),
(66, 'App\\Models\\User', 135, 'API TOKEN', 'eaed19e4e131df392c551336085c64a457e044abbc916ece0cae22e790b41059', '[\"*\"]', '2023-10-03 12:13:04', '2023-10-03 04:35:48', '2023-10-03 12:13:04'),
(67, 'App\\Models\\User', 133, 'API TOKEN', '146ecdd06dd44c7ff8402b0d0889226847669adc485b817ecc9bfe8ca4a85e4a', '[\"*\"]', '2023-10-04 05:08:25', '2023-10-03 11:24:56', '2023-10-04 05:08:25'),
(70, 'App\\Models\\User', 142, 'API TOKEN', 'f9b36762e3c23f0b68d977e4fe8845213a2dfb96f041c4a581437ff725ff1ebf', '[\"*\"]', '2023-10-04 06:30:41', '2023-10-04 06:30:34', '2023-10-04 06:30:41'),
(74, 'App\\Models\\User', 148, 'API TOKEN', '5e94d9dd885c047c23e19958e45396b7ebe1c2d93b343e9ca400a89892b14c4c', '[\"*\"]', '2023-10-04 07:11:25', '2023-10-04 07:11:18', '2023-10-04 07:11:25'),
(76, 'App\\Models\\User', 147, 'API TOKEN', 'e2f6bc675acdc9f36e9599f7b9a74a7cd434871be888d26dbf10e3cf2c97842f', '[\"*\"]', '2023-10-04 07:30:14', '2023-10-04 07:29:51', '2023-10-04 07:30:14'),
(77, 'App\\Models\\User', 146, 'API TOKEN', 'cf6aaedd182d443e35853656725d33e6ae03694ea3132882097b0399cf94584f', '[\"*\"]', '2023-10-04 08:37:24', '2023-10-04 08:34:11', '2023-10-04 08:37:24'),
(81, 'App\\Models\\User', 147, 'API TOKEN', '23b5fab6d46e152ec61ec3c46a1860c7f4508eafb9ec960527404d06fdd1d519', '[\"*\"]', '2023-10-05 06:25:20', '2023-10-05 06:23:55', '2023-10-05 06:25:20'),
(84, 'App\\Models\\User', 147, 'API TOKEN', '32b8961f0940ec7cef69d22d09bcff6f96ff6205024a8f5affd601aee7da572d', '[\"*\"]', '2023-10-05 09:40:16', '2023-10-05 09:37:51', '2023-10-05 09:40:16'),
(85, 'App\\Models\\User', 147, 'API TOKEN', 'fb6a967377c018ed16a80da640f67a6a72bd122673c719b0c2bf6e6c637e1e58', '[\"*\"]', '2023-10-05 10:04:13', '2023-10-05 10:02:02', '2023-10-05 10:04:13'),
(86, 'App\\Models\\User', 151, 'API TOKEN', '607907c92e363c9cb9c5cce37f655e258b30730f3f59ba1e383a41ac17ed7d27', '[\"*\"]', '2023-10-05 10:23:07', '2023-10-05 10:17:49', '2023-10-05 10:23:07'),
(87, 'App\\Models\\User', 156, 'API TOKEN', '29c80b18e6cd081ead1dbc9e182ba5565b3f427ee97819dd6eebc03b74dcb841', '[\"*\"]', '2023-10-05 10:23:07', '2023-10-05 10:18:03', '2023-10-05 10:23:07'),
(89, 'App\\Models\\User', 147, 'API TOKEN', '1b54f612c3794e1ed2fdee0eb5ac5089362d401fd3c90de273e1529db00ba280', '[\"*\"]', '2023-10-05 11:21:09', '2023-10-05 11:18:02', '2023-10-05 11:21:09'),
(90, 'App\\Models\\User', 145, 'API TOKEN', '4d4e0c977f62f324b90e723dfedbc19b08f10a5e67acf768051bcc4237133e4b', '[\"*\"]', '2023-10-05 11:36:53', '2023-10-05 11:36:17', '2023-10-05 11:36:53'),
(91, 'App\\Models\\User', 144, 'API TOKEN', 'a4edd1c7ea0562394deb3d35cce1f8011761466a74ddb3c531ccad4cf2bd31de', '[\"*\"]', '2023-10-05 11:47:13', '2023-10-05 11:47:07', '2023-10-05 11:47:13'),
(92, 'App\\Models\\User', 146, 'API TOKEN', '4eb37fba0d2bda465137da75e462214d48a88aa4bbee74961e7ad9b808b2d8ff', '[\"*\"]', '2023-10-05 11:52:48', '2023-10-05 11:51:48', '2023-10-05 11:52:48'),
(93, 'App\\Models\\User', 158, 'API TOKEN', 'f31559c9a2e33d73413be59932dc713ad46d9009790ee28496dcee655ee4f710', '[\"*\"]', '2023-10-05 12:00:48', '2023-10-05 11:59:56', '2023-10-05 12:00:48'),
(94, 'App\\Models\\User', 158, 'API TOKEN', '29461ca98cd78b6877c0ccb8239ea3b3b236c9398249322f487418d3394e5ab6', '[\"*\"]', '2023-10-31 16:08:14', '2023-10-05 12:04:05', '2023-10-31 16:08:14'),
(95, 'App\\Models\\User', 147, 'API TOKEN', 'c45fff458a4acba4a5f2ec1408a31a89c80e12efd5361a61432937c2bf34d93e', '[\"*\"]', '2023-10-06 10:13:19', '2023-10-06 10:11:16', '2023-10-06 10:13:19'),
(96, 'App\\Models\\User', 151, 'API TOKEN', '8bcf73a5336dfc38e8e615b1d6084b2983322436d93fc4b6a0ace2eeb0a9952f', '[\"*\"]', '2023-10-06 11:32:04', '2023-10-06 11:31:42', '2023-10-06 11:32:04'),
(97, 'App\\Models\\User', 160, 'API TOKEN', '7f5fe44c4ebb898e811601ed9fab28db31b97a4e21e0f530fbf75944f4bd71e0', '[\"*\"]', '2023-10-06 11:45:45', '2023-10-06 11:45:00', '2023-10-06 11:45:45'),
(98, 'App\\Models\\User', 144, 'API TOKEN', 'c9edc5f55d5357427c910e4e201f52661a357b466440a86d1cf1fbd1f13219f2', '[\"*\"]', '2023-10-09 07:25:06', '2023-10-09 07:24:57', '2023-10-09 07:25:06'),
(99, 'App\\Models\\User', 151, 'API TOKEN', '5758d0ee6f1201513228d3443416d98704af47948006660d0a733b28752205a5', '[\"*\"]', NULL, '2023-10-09 10:16:58', '2023-10-09 10:16:58'),
(100, 'App\\Models\\User', 140, 'API TOKEN', 'b3ce496023a4fa68cb86da309c52a297aa231601a7345b460cc565e15f80b704', '[\"*\"]', NULL, '2023-10-09 10:40:26', '2023-10-09 10:40:26'),
(101, 'App\\Models\\User', 144, 'API TOKEN', '4967e0dd02883ee79f5b149889996a6b69224912f5402a421a426afccc9aa6f8', '[\"*\"]', '2023-10-30 07:45:27', '2023-10-10 07:04:30', '2023-10-30 07:45:27'),
(103, 'App\\Models\\User', 140, 'API TOKEN', '4e5c4639c13932ca13f9686e93106d7512e6f0d5d732961c7a0975975ac0969f', '[\"*\"]', '2023-10-10 09:14:37', '2023-10-10 09:14:30', '2023-10-10 09:14:37'),
(104, 'App\\Models\\User', 146, 'API TOKEN', 'e0df0d7a6f00213618010220c855b4dab5f8badbbdefbb999e1fbce5536ef5d6', '[\"*\"]', '2023-10-10 11:07:41', '2023-10-10 11:01:01', '2023-10-10 11:07:41'),
(105, 'App\\Models\\User', 163, 'API TOKEN', '7e428bc1111f4e9c5b65e454a94defc58cb9d5c029e12262f04277b608f185bd', '[\"*\"]', '2023-11-27 10:46:31', '2023-10-10 17:46:15', '2023-11-27 10:46:31'),
(106, 'App\\Models\\User', 163, 'API TOKEN', 'b84365b868b4e806eae608a3248187d24c2c068cbb6e681f11fa379045ff4c18', '[\"*\"]', '2023-10-18 21:37:01', '2023-10-18 21:14:40', '2023-10-18 21:37:01'),
(107, 'App\\Models\\User', 165, 'API TOKEN', '1e8dbc23d0d2ace28c6f09e62dd022cbd865f6a6983c49c769b45eb53f574b65', '[\"*\"]', '2023-11-11 15:21:11', '2023-11-11 15:11:07', '2023-11-11 15:21:11'),
(108, 'App\\Models\\User', 140, 'API TOKEN', '7a51a747f6df2eeadcb95849f2c70d476324f44edd3b1cb77cabe88d8e92b4da', '[\"*\"]', '2023-11-15 17:27:22', '2023-11-15 17:27:08', '2023-11-15 17:27:22'),
(109, 'App\\Models\\User', 158, 'API TOKEN', 'a5a44a430592ce886a9a32ea02f27a93235cfdcd50d1aed84de2d770ca1223a8', '[\"*\"]', '2023-11-18 11:55:53', '2023-11-18 11:52:06', '2023-11-18 11:55:53'),
(110, 'App\\Models\\User', 166, 'API TOKEN', '9ce3ba8a7842be2d633712c87d4e5ce195cb81007e6bf5f2f05fe98f2486c9ed', '[\"*\"]', '2023-11-21 06:46:12', '2023-11-21 05:19:48', '2023-11-21 06:46:12'),
(111, 'App\\Models\\User', 158, 'API TOKEN', '4bd5bed435b65c259db4210e17ef06fae867abacde3bc2960f852ce3632036c9', '[\"*\"]', '2023-11-21 09:13:35', '2023-11-21 06:52:38', '2023-11-21 09:13:35'),
(112, 'App\\Models\\User', 166, 'API TOKEN', '14d1d1730ed2c4bcfb6f1ea56d91881b882a5886063c06f6e3df8d69814df79c', '[\"*\"]', '2023-11-22 06:53:49', '2023-11-21 09:34:03', '2023-11-22 06:53:49'),
(113, 'App\\Models\\User', 165, 'API TOKEN', 'b7510183c90340474a586807a6b9bd489948331ad0f48056d0b385a58ff72d0e', '[\"*\"]', '2023-11-21 10:26:16', '2023-11-21 10:24:31', '2023-11-21 10:26:16'),
(114, 'App\\Models\\User', 166, 'API TOKEN', '50cef0b0aad4e87843f2a84113c24780194efab6d9f6801476836d5147a50881', '[\"*\"]', '2023-11-23 07:11:20', '2023-11-22 07:02:52', '2023-11-23 07:11:20'),
(115, 'App\\Models\\User', 165, 'API TOKEN', '9772a1bc880d6e1d4cc04c331f885c894dd4c459a179ee7dcabea6f53c8b98f5', '[\"*\"]', '2023-12-03 14:02:54', '2023-11-22 18:08:25', '2023-12-03 14:02:54'),
(116, 'App\\Models\\User', 144, 'API TOKEN', 'e793fe09933311a9c9b85ea94639d735e6445dc6f68a8b5777d2430c3bcdaa35', '[\"*\"]', '2023-11-30 09:56:04', '2023-11-23 04:20:20', '2023-11-30 09:56:04'),
(117, 'App\\Models\\User', 158, 'API TOKEN', 'dc400e395dd1bdbf510f224c03c7cb5e329e05e23f186d1baefcc773345ec1c7', '[\"*\"]', '2023-11-23 07:58:37', '2023-11-23 07:58:24', '2023-11-23 07:58:37'),
(118, 'App\\Models\\User', 158, 'API TOKEN', '38849df3ee1842b7ca58f20912b26054ba2881393cb3466a8c97fc7efa2c246a', '[\"*\"]', '2023-11-24 09:33:55', '2023-11-23 08:03:25', '2023-11-24 09:33:55'),
(119, 'App\\Models\\User', 151, 'API TOKEN', '71b9fcca1aa45e12b2a564434be9f04649e539f2845546e4f99a61b853451b38', '[\"*\"]', '2023-11-24 06:30:02', '2023-11-24 06:14:51', '2023-11-24 06:30:02'),
(120, 'App\\Models\\User', 166, 'API TOKEN', 'b474447890e9c151e41994400ceee346ddda9fa3921c99b424346ef490769bca', '[\"*\"]', '2023-11-24 11:12:01', '2023-11-24 10:00:28', '2023-11-24 11:12:01'),
(121, 'App\\Models\\User', 166, 'API TOKEN', '8543dff5f31b211d2eeccf5853f1c9787b35eb260d1931481ef1a192cf14e897', '[\"*\"]', '2023-11-24 11:33:45', '2023-11-24 11:21:11', '2023-11-24 11:33:45'),
(124, 'App\\Models\\User', 166, 'API TOKEN', '6b896126bc8c3aaaf0a4a16a8b95ff4a7d566523ddce047133c7dffc93c2b61e', '[\"*\"]', '2023-12-04 13:50:38', '2023-11-24 12:58:20', '2023-12-04 13:50:38'),
(125, 'App\\Models\\User', 169, 'API TOKEN', '2d87c682d6f6aae3d53e356a22a3849aac735b4d256f9b18dc38c02b2070ddf6', '[\"*\"]', '2023-11-25 04:12:16', '2023-11-25 04:11:33', '2023-11-25 04:12:16'),
(126, 'App\\Models\\User', 170, 'API TOKEN', 'd89a92c2fce3cde6607552af46acd7b4a2395bd920afd771aa0d884c906249b3', '[\"*\"]', '2023-11-27 07:15:12', '2023-11-25 11:11:13', '2023-11-27 07:15:12'),
(127, 'App\\Models\\User', 171, 'API TOKEN', '52002e09a1a0c56285f0ea460aea25f35943b318b40fe16746e5db8ff905eb4c', '[\"*\"]', '2023-11-25 17:22:21', '2023-11-25 17:21:48', '2023-11-25 17:22:21'),
(128, 'App\\Models\\User', 151, 'API TOKEN', 'a6a6e25bcd073cabc4443c079cc98d8caf9a766ac94bab983c2e565dd09047f9', '[\"*\"]', '2023-11-28 13:44:11', '2023-11-27 06:16:39', '2023-11-28 13:44:11'),
(130, 'App\\Models\\User', 146, 'API TOKEN', '57c07aa39f22208f2d2a19855c58c8df1ded569306083f8f091a9a283a129754', '[\"*\"]', '2023-11-27 14:03:55', '2023-11-27 11:19:25', '2023-11-27 14:03:55'),
(131, 'App\\Models\\User', 173, 'API TOKEN', '0516367e238dab862202ea92e9687c5516a7bc964f239f6e5811ba7507cef99f', '[\"*\"]', '2023-11-27 12:55:36', '2023-11-27 12:21:34', '2023-11-27 12:55:36'),
(132, 'App\\Models\\User', 174, 'API TOKEN', 'c11b6657670e69478b15c659cefa85d43701fa0b405c1c569b3a52186ca37012', '[\"*\"]', '2023-11-27 14:09:13', '2023-11-27 14:00:13', '2023-11-27 14:09:13'),
(133, 'App\\Models\\User', 151, 'API TOKEN', 'f8dd6a855635defa5441b7831913b1b0c4b0cce2f4755bacd78f376dd8edc0fc', '[\"*\"]', '2023-11-28 08:15:35', '2023-11-28 07:31:28', '2023-11-28 08:15:35'),
(135, 'App\\Models\\User', 166, 'API TOKEN', '7f8c6771b4dfa84a2fa45fbcd5f5229506cda37fe42e4e35ab99144090eb7858', '[\"*\"]', '2023-11-29 11:05:16', '2023-11-28 11:41:17', '2023-11-29 11:05:16'),
(136, 'App\\Models\\User', 174, 'API TOKEN', 'b471cded87f16d81d7350fadde17594729b7356eb06b256db2137c311bc03ba9', '[\"*\"]', '2023-11-28 15:27:15', '2023-11-28 15:25:22', '2023-11-28 15:27:15'),
(140, 'App\\Models\\User', 166, 'API TOKEN', '5084425d7d4894871ef94893549c74a263d8fdf2bd056f45cd856c88c2fe1ec8', '[\"*\"]', '2023-12-01 06:37:50', '2023-11-30 08:14:18', '2023-12-01 06:37:50'),
(141, 'App\\Models\\User', 166, 'API TOKEN', '9afad1d3fc15b9088a37118065848fef2f8e49d81e39c5cd35c8e588b6b1c54e', '[\"*\"]', '2023-11-30 12:43:35', '2023-11-30 12:35:51', '2023-11-30 12:43:35'),
(142, 'App\\Models\\User', 166, 'API TOKEN', 'b79f31d58d93abe45408e454ed9c7b9a7e25b8356c7bbcb8c8067a696b5a0103', '[\"*\"]', '2023-12-04 05:16:20', '2023-11-30 12:48:52', '2023-12-04 05:16:20'),
(143, 'App\\Models\\User', 173, 'API TOKEN', '110d081b3bee0436e5ae4579bbde88a1bcdc2fcfa469cf7de1b39d965776f8db', '[\"*\"]', '2023-11-30 13:33:23', '2023-11-30 12:50:49', '2023-11-30 13:33:23'),
(144, 'App\\Models\\User', 166, 'API TOKEN', 'e49705ef8c18d905aca1572e9aa770d4334327ff59539695656c26e9b38970df', '[\"*\"]', '2023-12-04 05:57:48', '2023-12-04 05:52:43', '2023-12-04 05:57:48'),
(145, 'App\\Models\\User', 166, 'API TOKEN', 'bb77640e4ed4e9b43df919ae237a63774aaed6613864cd50fd8864f79dc98551', '[\"*\"]', '2023-12-04 08:26:47', '2023-12-04 06:10:42', '2023-12-04 08:26:47'),
(146, 'App\\Models\\User', 166, 'API TOKEN', '99f0898ba20c6953a8c58c49463cdaa48878fdb4e5a8414f825a3823d7b80acd', '[\"*\"]', '2023-12-04 09:42:08', '2023-12-04 09:33:52', '2023-12-04 09:42:08'),
(147, 'App\\Models\\User', 166, 'API TOKEN', 'c4606d41367c90acfb6a0cfa4e40d6c2ad5fae43dacbbac09b9b2c2f47face3a', '[\"*\"]', '2023-12-04 09:54:35', '2023-12-04 09:54:05', '2023-12-04 09:54:35'),
(148, 'App\\Models\\User', 166, 'API TOKEN', 'cc9ac95fd2e53a56d9cc4394df44e1fa78571846ae877404f9655e54d9e0dd32', '[\"*\"]', '2023-12-04 12:48:59', '2023-12-04 10:16:17', '2023-12-04 12:48:59'),
(150, 'App\\Models\\User', 175, 'API TOKEN', '9571f43681c1e60d120e8616dc1dcf850a53c13c3504a7a324faa752b74a254b', '[\"*\"]', '2023-12-04 14:21:28', '2023-12-04 13:17:01', '2023-12-04 14:21:28'),
(151, 'App\\Models\\User', 166, 'API TOKEN', 'aaa6d7d45f76d5f872ae7a74aabf247538f7d279c4fd4baaa0fffaf7042992eb', '[\"*\"]', '2023-12-04 14:17:58', '2023-12-04 13:37:58', '2023-12-04 14:17:58');

-- --------------------------------------------------------

--
-- Table structure for table `plan_period`
--

CREATE TABLE `plan_period` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plan_period`
--

INSERT INTO `plan_period` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'days', '2023-06-16 09:59:01', NULL),
(2, 'months', '2023-06-16 09:59:01', NULL),
(3, 'years', '2023-06-16 09:59:15', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `quiz`
--

CREATE TABLE `quiz` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `question` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz`
--

INSERT INTO `quiz` (`id`, `book_id`, `question`, `created_at`, `updated_at`) VALUES
(4, '3', 'Why did you select this book? loriyum ipsumfd', '2023-06-15 02:27:32', '2023-06-15 02:27:32'),
(6, '6', 'Testing data goes here', '2023-06-15 08:26:56', '2023-06-15 08:26:56'),
(7, '7', 'dd', '2023-06-16 06:25:13', '2023-06-16 06:25:13'),
(11, '13', 'TEST 1', '2023-06-22 17:28:00', '2023-06-22 17:28:00'),
(12, '13', 'test 2', '2023-06-22 17:28:05', '2023-06-22 17:28:05'),
(13, '13', 'test 3', '2023-06-22 17:28:10', '2023-06-22 17:28:10'),
(14, '3', 'Where does it come from?', '2023-07-13 05:49:05', '2023-07-13 05:49:05'),
(15, '3', 'Where can I get some?', '2023-07-13 05:49:13', '2023-07-13 05:49:13'),
(16, '3', 'What is Lorem Ipsum?', '2023-07-13 05:49:19', '2023-07-13 05:49:19'),
(17, '3', 'Why do we use it?', '2023-07-13 05:49:38', '2023-07-13 05:49:38'),
(18, '18', 'Who is author of this book', '2023-07-17 13:11:28', '2023-07-17 13:11:28'),
(19, '18', 'Explain me first chapter', '2023-07-17 13:11:38', '2023-07-17 13:11:38'),
(20, '18', 'Which chapter audio book do you like', '2023-07-17 13:11:48', '2023-07-17 13:11:48'),
(21, '15', 'bfbb fvb', '2023-07-27 08:05:19', '2023-07-27 08:05:19'),
(22, '23', 'quiz 1', '2023-08-28 19:57:50', '2023-08-28 19:57:50'),
(23, '23', 'quiz 2', '2023-08-28 19:58:00', '2023-08-28 19:58:00'),
(24, '23', 'quiz 3', '2023-08-28 19:58:07', '2023-08-28 19:58:07'),
(25, '23', 'quiz 4', '2023-08-28 19:58:14', '2023-08-28 19:58:14'),
(26, '23', 'quiz 5', '2023-08-28 19:58:21', '2023-08-28 19:58:21');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_response`
--

CREATE TABLE `quiz_response` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `name` text DEFAULT NULL,
  `admin_reply` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_response`
--

INSERT INTO `quiz_response` (`id`, `book_id`, `user_id`, `name`, `admin_reply`, `created_at`, `updated_at`) VALUES
(63, '18', '64d4df0960935', 'manish sharma', NULL, '2023-08-11 05:55:44', '2023-08-11 05:55:44'),
(64, '15', '64d6287920de6', 'oub aabdou', NULL, '2023-08-11 19:15:57', '2023-08-11 19:15:57'),
(65, '18', '64d6287920de6', 'oub aabdou', 'q1 howa hada akhouna jma3 rassek chwiya rah lwa9t ou zman hada\r\n\r\nq2 neta nadddi a3miii nadi nit\r\n\r\nq3 jim m3ak', '2023-08-28 20:16:31', '2023-08-28 20:20:04'),
(66, '18', '64edee169990f', 'manish', NULL, '2023-09-12 10:28:15', '2023-09-12 10:28:15'),
(67, '18', '65118cec186b0', 'Aman', 'test', '2023-10-01 06:09:53', '2023-11-27 10:20:51'),
(68, '18', '6564a09f43e21', 'Nabil BOUMRACH', 'testtt', '2023-11-27 14:06:59', '2023-11-27 14:07:38'),
(69, '18', '6564a09f43e21', 'Nabil BOUMRACH', NULL, '2023-11-28 15:26:56', '2023-11-28 15:26:56'),
(70, '18', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-11-30 10:16:26', '2023-11-30 10:16:26'),
(71, '18', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-11-30 10:16:32', '2023-11-30 10:16:32'),
(72, '{{book_id}}', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-11-30 10:24:28', '2023-11-30 10:24:28'),
(73, '{{book_id}}', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-11-30 10:26:45', '2023-11-30 10:26:45'),
(74, '{{book_id}}', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-11-30 10:27:32', '2023-11-30 10:27:32'),
(75, '18', '656481506d451', 'ily yo', NULL, '2023-11-30 13:28:17', '2023-11-30 13:28:17'),
(76, '18', '655c3df4104c8', 'Preeti Vishwakarma', NULL, '2023-12-04 04:50:42', '2023-12-04 04:50:42');

-- --------------------------------------------------------

--
-- Table structure for table `quiz_useranswer`
--

CREATE TABLE `quiz_useranswer` (
  `id` int(11) NOT NULL,
  `question` text DEFAULT NULL,
  `answer` text DEFAULT NULL,
  `quiz_res_id` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `quiz_useranswer`
--

INSERT INTO `quiz_useranswer` (`id`, `question`, `answer`, `quiz_res_id`, `created_at`, `updated_at`) VALUES
(164, '\"Who is author of this book', '\"hehdehj', '63', '2023-08-11 05:55:44', '2023-08-11 05:55:44'),
(165, ' Explain me first chapter', ' hdhejdh', '63', '2023-08-11 05:55:44', '2023-08-11 05:55:44'),
(166, ' Which chapter audio book do you like\"', ' jehehhe\"', '63', '2023-08-11 05:55:44', '2023-08-11 05:55:44'),
(167, '\"bfbb fvb\"', '\"reply 1\"', '64', '2023-08-11 19:15:57', '2023-08-11 19:15:57'),
(168, '\"Who is author of this book', '\"chkon liaref', '65', '2023-08-28 20:16:31', '2023-08-28 20:16:31'),
(169, ' Explain me first chapter', ' howa hadak lmohim', '65', '2023-08-28 20:16:31', '2023-08-28 20:16:31'),
(170, ' Which chapter audio book do you like\"', ' kolchoom ajbini\"', '65', '2023-08-28 20:16:31', '2023-08-28 20:16:31'),
(171, '\"Who is author of this book', '\"fff', '66', '2023-09-12 10:28:15', '2023-09-12 10:28:15'),
(172, ' Explain me first chapter', ' ff', '66', '2023-09-12 10:28:15', '2023-09-12 10:28:15'),
(173, ' Which chapter audio book do you like\"', ' ff\"', '66', '2023-09-12 10:28:15', '2023-09-12 10:28:15'),
(174, '\"Who is author of this book', '\"', '67', '2023-10-01 06:09:53', '2023-10-01 06:09:53'),
(175, ' Explain me first chapter', ' ', '67', '2023-10-01 06:09:54', '2023-10-01 06:09:54'),
(176, ' Which chapter audio book do you like\"', ' \"', '67', '2023-10-01 06:09:54', '2023-10-01 06:09:54'),
(177, '\"Who is author of this book', '\"test', '68', '2023-11-27 14:06:59', '2023-11-27 14:06:59'),
(178, ' Explain me first chapter', ' ', '68', '2023-11-27 14:06:59', '2023-11-27 14:06:59'),
(179, ' Which chapter audio book do you like\"', ' \"', '68', '2023-11-27 14:06:59', '2023-11-27 14:06:59'),
(180, '\"Who is author of this book', '\"', '69', '2023-11-28 15:26:56', '2023-11-28 15:26:56'),
(181, ' Explain me first chapter', ' teeest', '69', '2023-11-28 15:26:56', '2023-11-28 15:26:56'),
(182, ' Which chapter audio book do you like\"', ' \"', '69', '2023-11-28 15:26:56', '2023-11-28 15:26:56'),
(183, '\"Who is author of this book', '\"', '70', '2023-11-30 10:16:26', '2023-11-30 10:16:26'),
(184, ' Explain me first chapter', ' ', '70', '2023-11-30 10:16:26', '2023-11-30 10:16:26'),
(185, ' Which chapter audio book do you like\"', ' \"', '70', '2023-11-30 10:16:26', '2023-11-30 10:16:26'),
(186, '\"Who is author of this book', '\"', '71', '2023-11-30 10:16:32', '2023-11-30 10:16:32'),
(187, ' Explain me first chapter', ' ', '71', '2023-11-30 10:16:32', '2023-11-30 10:16:32'),
(188, ' Which chapter audio book do you like\"', ' \"', '71', '2023-11-30 10:16:32', '2023-11-30 10:16:32'),
(189, '\"q1', '\"a1', '72', '2023-11-30 10:24:28', '2023-11-30 10:24:28'),
(190, ' q2', ' a2', '72', '2023-11-30 10:24:28', '2023-11-30 10:24:28'),
(191, ' q3\"', ' a3\"', '72', '2023-11-30 10:24:28', '2023-11-30 10:24:28'),
(192, '\"q1', '\"a1', '73', '2023-11-30 10:26:45', '2023-11-30 10:26:45'),
(193, ' q2', ' a2', '73', '2023-11-30 10:26:45', '2023-11-30 10:26:45'),
(194, ' q3\"', '\"', '73', '2023-11-30 10:26:45', '2023-11-30 10:26:45'),
(195, '\"q1', '\"a1', '74', '2023-11-30 10:27:32', '2023-11-30 10:27:32'),
(196, ' q2', ' a2', '74', '2023-11-30 10:27:32', '2023-11-30 10:27:32'),
(197, ' q3\"', ' a3\"', '74', '2023-11-30 10:27:32', '2023-11-30 10:27:32'),
(198, '\"Who is author of this book', '\"test', '75', '2023-11-30 13:28:17', '2023-11-30 13:28:17'),
(199, ' Explain me first chapter', ' test', '75', '2023-11-30 13:28:17', '2023-11-30 13:28:17'),
(200, ' Which chapter audio book do you like\"', ' test\"', '75', '2023-11-30 13:28:17', '2023-11-30 13:28:17'),
(201, '\"Who is author of this book', '\"yes', '76', '2023-12-04 04:50:42', '2023-12-04 04:50:42'),
(202, ' Explain me first chapter', ' no', '76', '2023-12-04 04:50:42', '2023-12-04 04:50:42'),
(203, ' Which chapter audio book do you like\"', ' 8no\"', '76', '2023-12-04 04:50:42', '2023-12-04 04:50:42');

-- --------------------------------------------------------

--
-- Table structure for table `read_books`
--

CREATE TABLE `read_books` (
  `id` int(11) NOT NULL,
  `book_id` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `chapter` text DEFAULT NULL,
  `status` enum('inprogress','finish') NOT NULL DEFAULT 'inprogress',
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `review` text DEFAULT NULL,
  `rating` float(10,1) DEFAULT NULL,
  `book_id` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `reply` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `name`, `review`, `rating`, `book_id`, `user_id`, `reply`, `created_at`, `updated_at`) VALUES
(66, 'manish sharma', 'dhdwhh', 1.0, '18', '64d4df0960935', NULL, '2023-08-11 05:48:24', '2023-08-11 05:48:24'),
(68, 'manish sharma', 'fd', 5.0, '18', '64d4df0960935', NULL, '2023-08-11 05:49:35', '2023-08-11 05:49:35'),
(72, 'manish sharma', NULL, 4.5, '18', '64d4df0960935', NULL, '2023-08-11 05:53:27', '2023-08-11 05:53:27'),
(73, 'manish sharma', 'hello', 3.0, '18', '64d4df0960935', NULL, '2023-08-11 05:53:40', '2023-08-11 05:53:40'),
(74, 'Oubaha Abderrahmane', 'thank you', 1.0, '19', '64d623bf0cf19', NULL, '2023-08-11 11:05:59', '2023-08-11 11:05:59'),
(75, 'manish sharma', 'fydu', 4.5, '18', '64d4df0960935', NULL, '2023-08-22 10:34:56', '2023-08-22 10:34:56'),
(76, 'oub aabdou', NULL, 5.0, '23', '64d6287920de6', NULL, '2023-08-28 20:34:47', '2023-08-28 20:34:47'),
(77, 'manish', 'dhdy', 5.0, '18', '64edee169990f', NULL, '2023-09-12 10:26:32', '2023-09-12 10:26:32'),
(78, 'Aman', NULL, 4.5, '24', '65118cec186b0', NULL, '2023-09-25 15:24:46', '2023-09-25 15:24:46'),
(79, 'mahendra panwar', NULL, 4.5, '3', '651153e0c9918', NULL, '2023-09-26 03:53:06', '2023-09-26 03:53:06'),
(80, 'mahendra panwar', NULL, 1.0, '3', '651153e0c9918', NULL, '2023-09-26 03:53:14', '2023-09-26 03:53:14'),
(81, 'Aman', NULL, 4.5, '22', '65118cec186b0', NULL, '2023-09-26 06:16:52', '2023-09-26 06:16:52'),
(82, 'Aman', NULL, 4.5, '22', '65118cec186b0', NULL, '2023-09-26 06:16:58', '2023-09-26 06:16:58'),
(83, 'rr', NULL, 4.5, '3', '651d51f46f693', NULL, '2023-10-05 10:22:08', '2023-10-05 10:22:08'),
(84, 'akshit', 'hii', 4.5, '18', '654f9968c9882', NULL, '2023-11-11 15:17:04', '2023-11-11 15:17:04'),
(85, 'oubambo', 'thank you', 4.5, '18', '65215b53909e6', NULL, '2023-11-12 06:44:08', '2023-11-12 06:44:08'),
(86, 'Preeti vishwakarma', 'ghhh', 4.5, '18', '651eb34c00eb1', NULL, '2023-11-23 13:28:12', '2023-11-23 13:28:12'),
(87, 'rr', NULL, 4.5, '3', '651d51f46f693', NULL, '2023-11-24 06:18:25', '2023-11-24 06:18:25'),
(88, 'Preeti vishwakarma', 'gghbbh', 3.0, '18', '651eb34c00eb1', NULL, '2023-11-24 09:23:17', '2023-11-24 09:23:17'),
(89, 'ily yo', 'thank you', 4.5, '19', '656481506d451', NULL, '2023-11-27 12:52:23', '2023-11-27 12:52:23');

-- --------------------------------------------------------

--
-- Table structure for table `subscription`
--

CREATE TABLE `subscription` (
  `id` int(11) NOT NULL,
  `plan_name` text DEFAULT NULL,
  `plan_duration` text DEFAULT NULL,
  `plan_period` text DEFAULT NULL,
  `plan_price` text DEFAULT NULL,
  `status` enum('active','inactive') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `subscription`
--

INSERT INTO `subscription` (`id`, `plan_name`, `plan_duration`, `plan_period`, `plan_price`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Silver', '28', 'days', '100', 'active', '2023-06-16 04:41:09', '2023-06-21 06:50:09'),
(5, 'Gold', '6', 'months', '200', 'active', '2023-06-16 05:07:51', '2023-06-16 05:07:51'),
(9, 'platinum ', '1', 'Years', '500', 'active', '2023-06-22 17:13:23', '2023-06-22 17:13:23');

-- --------------------------------------------------------

--
-- Table structure for table `support`
--

CREATE TABLE `support` (
  `id` int(11) NOT NULL,
  `user_id` text DEFAULT NULL,
  `msg` longtext DEFAULT NULL,
  `name` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `support`
--

INSERT INTO `support` (`id`, `user_id`, `msg`, `name`, `email`, `created_at`, `updated_at`) VALUES
(13, '64d4ce1905a9d', 'test', 'Pragyakushwah', 'pragyakushwah@gmail.com', '2023-08-10 10:48:44', '2023-08-10 10:48:44'),
(14, '650817bd37404', 'dydf\nhyyy', 'Nikki', NULL, '2023-09-19 09:18:18', '2023-09-19 09:18:18');

-- --------------------------------------------------------

--
-- Table structure for table `thirdparty_data`
--

CREATE TABLE `thirdparty_data` (
  `id` int(11) NOT NULL,
  `facebook_url` text DEFAULT NULL,
  `youtube_url` text DEFAULT NULL,
  `mob_id` text DEFAULT NULL,
  `paypal_id` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thirdparty_data`
--

INSERT INTO `thirdparty_data` (`id`, `facebook_url`, `youtube_url`, `mob_id`, `paypal_id`, `created_at`, `updated_at`) VALUES
(2, 'https://facebook/c/.com', 'https://youtube/c/.com', '555444333', '555444333', '2023-06-15 08:05:54', '2023-06-21 06:44:25');

-- --------------------------------------------------------

--
-- Table structure for table `transcation_history`
--

CREATE TABLE `transcation_history` (
  `id` int(11) NOT NULL,
  `plan_id` text DEFAULT NULL,
  `user_id` text DEFAULT NULL,
  `amount` text DEFAULT NULL,
  `currency` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `transaction_id` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `transcation_history`
--

INSERT INTO `transcation_history` (`id`, `plan_id`, `user_id`, `amount`, `currency`, `status`, `transaction_id`, `created_at`, `updated_at`) VALUES
(1, '1', '651d51f46f693', '40', '$', 'success', '5aff56565dggf', '2023-11-27 07:08:02', '2023-11-27 07:08:02'),
(2, '1', '651d51f46f693', '100', '$', 'success', '5aff56565dggf', '2023-11-27 07:49:39', '2023-11-27 07:49:39'),
(3, '1', '655c3df4104c8', '100', '$', 'success', 'sdj67asd565', '2023-11-27 09:51:08', '2023-11-27 09:51:08'),
(4, '1', '655c3df4104c8', '100', '$', 'success', 'sdj67asd565', '2023-11-27 09:56:50', '2023-11-27 09:56:50'),
(5, '1', '655c3df4104c8', '100', '$', 'success', 'sdj67asd565', '2023-11-29 12:01:05', '2023-11-29 12:01:05'),
(6, '9', '655c3df4104c8', '500', '$', 'success', 'sdj67asd565', '2023-11-29 12:58:13', '2023-11-29 12:58:13'),
(7, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHnNQL0eU4RO2jC0eC6BAvf', '2023-11-29 13:00:48', '2023-11-29 13:00:48'),
(8, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHnVQL0eU4RO2jC0WATz9Do', '2023-11-29 13:08:59', '2023-11-29 13:08:59'),
(9, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHnbpL0eU4RO2jC19UC6Jl4', '2023-11-29 13:15:41', '2023-11-29 13:15:41'),
(10, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHnuFL0eU4RO2jC0AXcNPWx', '2023-11-29 13:34:41', '2023-11-29 13:34:41'),
(11, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHnx3L0eU4RO2jC1jwH6IaX', '2023-11-29 13:37:35', '2023-11-29 13:37:35'),
(12, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHo07L0eU4RO2jC0uc1Mvqs', '2023-11-29 13:40:45', '2023-11-29 13:40:45'),
(13, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHo2BL0eU4RO2jC0e85wphH', '2023-11-29 13:42:57', '2023-11-29 13:42:57'),
(14, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OHo6TL0eU4RO2jC1mFB8cHX', '2023-11-29 13:47:20', '2023-11-29 13:47:20'),
(15, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI5brL0eU4RO2jC06esqUM2', '2023-11-30 08:29:12', '2023-11-30 08:29:12'),
(16, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI5dEL0eU4RO2jC1JUcYrQb', '2023-11-30 08:30:15', '2023-11-30 08:30:15'),
(17, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI6WiL0eU4RO2jC0SAnUL2x', '2023-11-30 09:27:45', '2023-11-30 09:27:45'),
(18, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI6mSL0eU4RO2jC1n7DGNIH', '2023-11-30 09:43:56', '2023-11-30 09:43:56'),
(19, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI6pGL0eU4RO2jC1ebt5wS1', '2023-11-30 09:46:59', '2023-11-30 09:46:59'),
(20, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI9ZFL0eU4RO2jC1lH62FK9', '2023-11-30 12:42:31', '2023-11-30 12:42:31'),
(21, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OI9krL0eU4RO2jC0d785oIq', '2023-11-30 12:54:32', '2023-11-30 12:54:32'),
(22, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OJV8SL0eU4RO2jC0vDshPFy', '2023-12-04 05:56:36', '2023-12-04 05:56:36'),
(23, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OJbVBL0eU4RO2jC0eV4TFV2', '2023-12-04 12:44:49', '2023-12-04 12:44:49'),
(24, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OJcXBL0eU4RO2jC00EsHMIv', '2023-12-04 13:50:29', '2023-12-04 13:50:29'),
(25, '1', '655c3df4104c8', '100', 'usd', 'status', 'pi_3OJcXLL0eU4RO2jC1hfcvmwb', '2023-12-04 13:50:38', '2023-12-04 13:50:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` text DEFAULT NULL,
  `user_image` text DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `user_role` enum('user','admin') NOT NULL DEFAULT 'user',
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `user_id` text DEFAULT NULL,
  `membership_plan` text DEFAULT NULL,
  `membership_date` text DEFAULT NULL,
  `membership_expire_date` text DEFAULT NULL,
  `ip` text DEFAULT NULL,
  `device_type` text DEFAULT NULL,
  `notification_on_off` enum('1','0') NOT NULL DEFAULT '1',
  `app_update_on_off` enum('1','0') NOT NULL DEFAULT '1',
  `mode` enum('1','0') DEFAULT '0',
  `fcmid` text DEFAULT NULL,
  `provider` text DEFAULT NULL,
  `country_code` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `mobile`, `user_image`, `email_verified_at`, `password`, `remember_token`, `user_role`, `status`, `user_id`, `membership_plan`, `membership_date`, `membership_expire_date`, `ip`, `device_type`, `notification_on_off`, `app_update_on_off`, `mode`, `fcmid`, `provider`, `country_code`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin@gmail.com', '9768658588', NULL, NULL, '$2y$10$bIsUQtdnXYl0A96wpW/RIufNzRmeRn8h2zpH3aY/zOJO5XE4qMhTO', NULL, 'admin', 'active', NULL, '2', NULL, NULL, NULL, NULL, '1', '1', '0', NULL, NULL, NULL, '2023-06-12 03:54:32', '2023-06-15 05:03:13'),
(140, 'pk', 'preeti123@gmail.com', '9131167313', NULL, NULL, '$2y$10$pEgByPyGfqrAKeT6YwYmL.eAJnl1Vx6.96IA4DxEMfBr3.nXhpRHq', NULL, 'user', 'inactive', '651d106f692a0', NULL, NULL, NULL, '49.35.194.124', 'Android', '1', '1', '0', 'eaiOgZFBRWK8PR1AdkZJIC:APA91bFC4OUlxAnWs1ONmeZb61lNO9VR8l0yLQrN0SP7Y2iIkObezfpMsmlf2sHzGOCDNunad-hVjkR9sDXFzeOTR6AqJtZgZ20ZPo4x-y-XW3dWovzBMXNbNVaGdmQgrIZPqM2WAkNW', NULL, '91', '2023-10-04 06:12:47', '2023-11-15 17:27:21'),
(141, 'DBtech access', 'dbtechaccess@gmail.com', NULL, NULL, NULL, '$2y$10$C.TCw.hEITnk5yiDkToaFuEhg/te5c.8VLPGEzUcNp0B84QqT9PfK', NULL, 'user', 'inactive', '651d13f7c5eba', NULL, NULL, NULL, '152.58.26.230', 'Android', '1', '1', '0', 'dmJhwTlURlyvS03spAq3mj:APA91bG1NmQ1-Vaj6hWIww7iXysQ81VmtUKB4R6-FauP2ABNw2BvOT6-4WUrIrGVWgTLOo5dD3lcU7M9k28UR4wzZlq08R1XQpGwz4LbfHNhfDg07FCkgpQE_0rtw-z6nd7MvRzp33Kt', 'google', NULL, '2023-10-04 06:27:51', '2023-10-04 06:35:34'),
(142, 'cycyyv', 'preeti@gmail.com', '8640075389', NULL, NULL, '$2y$10$MyYio2Ga3plZJdODCS/Q7Ot9JAwD9bopKd6aSLcccE5A.rp4V5VWW', NULL, 'user', 'inactive', '651d14752cf51', NULL, NULL, NULL, '27.5.45.34', 'Android', '1', '1', '0', 'edsgEBeoTOSD6ydd6FDmd-:APA91bFO5aRD8GQbX_Y2F1puKfZ1E5nLQMaZQ1eMRJpCxjNOj9BX2SXWJHGSHZWTTc7HEI2hrb1bCMH5xNyGdkdxFlNaTzvuCR9LInUkeXNbM6iyUG-NF2LrZNQ92y4YxxEFgjhT5YN0', NULL, '+91', '2023-10-04 06:29:57', '2023-10-04 06:30:41'),
(143, 'Preeti Vishwakarma', NULL, '9131167314', NULL, NULL, '$2y$10$weALJ7IbOVJ38jF7gxrIHOGyYaxvPtHVG/t/s2t3mnH8MijaAtnpG', NULL, 'user', 'inactive', '651d171dcf1e8', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-04 06:41:17', '2023-10-04 06:41:17'),
(144, 'test', NULL, '6263624487', NULL, NULL, '$2y$10$acvKBC1Qj3wqgXIscZd.iOCFefUkfyPc/Q5U2A.oOEVAGrnr3SbnG', NULL, 'user', 'inactive', '651d1a3e89fdb', NULL, NULL, NULL, '47.247.219.160', 'Android', '1', '1', '0', 'cLCtSK8QQpWrCZJWeCWmoC:APA91bHEnCuMr9i4_xtfck-k1IhMUdRwdhTECgzFJtbQRnz5HFqAVAO7DotreO_p2Cj3Bmw1y0Z2AF9O1v_OtxwgcQlbSazLv8z2obghB8flohZoqVuH-tRKXuLasGZzpHW0_VUVF5qG', NULL, '+91', '2023-10-04 06:54:38', '2023-11-29 05:57:53'),
(145, 'Manish Sharma', 'manishsharma84848@gmail.com', NULL, NULL, NULL, '$2y$10$wPd.vKJJ8gKZo/tgs3r0AO8lW1koEog.P1LBnRrwxabYqXmINt3YK', NULL, 'user', 'inactive', '651d1a7047e33', NULL, NULL, NULL, '182.70.241.61', 'Android', '1', '1', '0', 'f2V45q8qQ2OoTAUxOXUYQn:APA91bFxAr1pyt3flcecv388tkHQ26UO6tl9b7hpMQ_2ZU1o0KMvJS--ImEflvRjVF2Kspaw8ggiupUJVFer9F9bw1LhMnPa0c14Gh4GpqUTWY8Q88dZg12LC3DV5Gmz3t0Sig05dMzM', 'google', NULL, '2023-10-04 06:55:28', '2023-10-05 11:36:48'),
(146, 'Ajeet Choubey', 'ajeet.developerbajar@gmail.com', NULL, NULL, NULL, '$2y$10$WbA7.1f29kpGnuUfinO4IOZ4FwKuGeIkq3DIoc3jpXxbdvdN9BqYK', NULL, 'user', 'inactive', '651d1dcfb7785', NULL, NULL, NULL, '116.75.215.29', 'Android', '1', '1', '0', 'eIbxYaxnQ36xAh_z7fu4oi:APA91bGzBHSi8-IuXlLU4_BKTCTXFnH4IIGy7eMyS5uAsPpQRrBO8y6-mPi5j0CtCdb8gCGaH8MLmHVzG5R1rbIelBVYP4fj5vg0qppvm4HsNiMhMfI7Us86nrznVlMaRyfKysBKTloz', 'google', NULL, '2023-10-04 07:09:51', '2023-11-27 14:03:55'),
(147, 'manish sharma', 'dollopmanish@gmail.com', NULL, NULL, NULL, '$2y$10$wh72AvZ6xYMCu4gho.jTZuW572oxETZiJMYoQ4em6BgVjl67s5WIe', NULL, 'user', 'inactive', '651d1ddc10230', NULL, NULL, NULL, '182.70.241.61', 'Android', '1', '1', '0', 'fIuPlAJ_TNOwk1wQ6G58nQ:APA91bEKcSHA9zb5p5nu2kcqevAELs_p_Pi6_FziFxYcx-UsFQcGTzBeMxMuRuBvKhenrhznP7SLZ-Tf5k7C7xlE2CqFEGALmyoUIN3m9qUZhduHhSEU2Ps7R00tOCnjbqo3VNa5LNTp', 'google', '+91', '2023-10-04 07:10:04', '2023-10-06 10:13:19'),
(148, 'Ajeet Choubey', 'jeetschoubey90@gmail.com', NULL, 'upload/user/2555101701693951.jpg', NULL, '$2y$10$uPUiEnUY0VUYAN2GEjJWbOn3/gkPyTWaLRaB.AbX7ZPGm2chHsL9a', NULL, 'user', 'inactive', '651d1e263dc08', NULL, NULL, NULL, '116.74.32.163', 'Android', '1', '1', '0', 'cIwTZfXMT-m5mUzoks5dDQ:APA91bFhCHsfRJ23NtrCj_IFOmDq5v_A3iDffWP8LmtB9BP7KbHVllXtlVE46V7-H548PwUYBTKyPlzmVJ0Oip-OzpLeFaW5Mp9D3RI7ZohUaiRs3FAKu_Jj3tq9QIhkUaGB7XDxbrLB', 'google', '+91', '2023-10-04 07:11:18', '2023-12-04 13:14:27'),
(149, 'Aman', NULL, '6265683442', NULL, NULL, '$2y$10$9gqEOfgW8dM/s29boR8B.e.4r1jUXHo5lKeQc0FYGXy7DtYDrcKom', NULL, 'user', 'inactive', '651d1f3e87c26', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-04 07:15:58', '2023-10-04 07:15:58'),
(151, 'Ajeet Choubey', NULL, '8982027891', NULL, NULL, '$2y$10$DyEWRL.EvWrYlBdr5cPVaebeHfFVhbXn0gWx7gUYWnNXyRIX0WnHa', NULL, 'user', 'inactive', '651d51f46f693', '1', '27-11-2023', '25-12-2023', '116.73.52.247', 'Android', '1', '1', '0', 'et4XzzJLRGav_NP2L6emWN:APA91bHzEk_GyqO8alSIJSymmer03cpD0581fTRqTpIA0tAZoVe2ypHbg0wzvIX5Bp919mx5g2jxdROHXgNJsr-UzXFSFeXGwe40LBpiKp29BBsQi7-0YeNOTsyBqWrsn56pK7-lMRpG', NULL, '+91', '2023-10-04 10:52:20', '2023-11-28 08:11:34'),
(152, 'aj', NULL, '7067709951', NULL, NULL, '$2y$10$lJlpbfwbb4h3CGSpbcWL4uP8fyky3klLZji6NhiYfZT3/dvNUqf0W', NULL, 'user', 'inactive', '651e4f71de6e2', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-05 04:53:53', '2023-10-05 04:53:53'),
(153, 'alok', NULL, '7974095872', NULL, NULL, '$2y$10$3WTTOGPAvtR7wLDH9TOIoOdVmWtWQZ5XUqCzxb1VodvHvuIobkIUu', NULL, 'user', 'inactive', '651e51e40246c', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-05 05:04:20', '2023-10-05 05:04:20'),
(154, 'alok', NULL, '7610683788', NULL, NULL, '$2y$10$yS4C3c7.oDzqFZmkudvymujcdvjeE3NG7iiVs9bymwEasoNH5LtTe', NULL, 'user', 'inactive', '651e525ec38ff', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-05 05:06:22', '2023-10-05 05:06:22'),
(155, 'manish', NULL, '9090909090', NULL, NULL, '$2y$10$Y4MfcBBup6XQSmLFgSHaBO2tLbHL6GiNgnFg1k4fbgxBkEvJRj/qa', NULL, 'user', 'inactive', '651e638475a66', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-05 06:19:32', '2023-10-05 06:19:32'),
(156, 'mahi', NULL, '9098977418', NULL, NULL, '$2y$10$XX74JVHX73ho2mwPR/BHN.byRcIXESBypGEq3p47sigrhG1sKSeom', NULL, 'user', 'inactive', '651e7980d3fdd', NULL, NULL, NULL, '182.70.241.61', 'Android', '1', '1', '0', 'eibGNx3STdWB60Px21aV6I:APA91bHnaUzwgtBU3I7_TCF8b3LRotS_lYhqmLmg4gbwGRCk7AvDal_RAlxobnHzKSAnxhBkzfjfglaA6YuVojBAgIpP_CA7y4UB_v0AmqTd46lgPEuVAmTHbEBpsmqf5v8-SV-qMo8h', NULL, '+91', '2023-10-05 07:53:20', '2023-10-05 10:23:07'),
(157, 'mahi', NULL, '9165723746', NULL, NULL, '$2y$10$muF/sw3abRdsOa2GzDaxuudgs2QU3pkR840PCIofA1owTI.UsntDW', NULL, 'user', 'inactive', '651e79ceae352', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-10-05 07:54:38', '2023-10-05 07:54:38'),
(158, 'Preeti vishwakarma', 'preetivishwakarma154@gmail.com', NULL, NULL, NULL, '$2y$10$cZrB5nsRsIWcen5fwhBnOuTxy/qqWr5g5FJjjaaaNtUIu0LpIgUh.', NULL, 'user', 'inactive', '651eb34c00eb1', NULL, NULL, NULL, '49.35.164.142', 'Android', '1', '1', '0', 'ce43iJ5IQDKcXjzYbOFYF3:APA91bHTDjHyeuhHEesf4MtIFNGpR0sn_3ScH55yEOVr877JZTZ70ZjX8_x_EN_ZSTFGX00QnMdlSEozbfyy4fZSXBzE7Xl-az6wNPiZZE_Bwg0vHlA-Gc30ECIGbtzQq1CUYZbVZBoc', 'google', NULL, '2023-10-05 11:59:56', '2023-11-30 07:56:42'),
(159, 'Pragyakushwah', NULL, '8108103030', NULL, NULL, '$2y$10$7JYmDWjiB6fP0kjlbuh0U.9Eo1wdtZO8N8HWn2Rhwm2O7VOawPwsS', NULL, 'user', 'inactive', '651fff5f44272', NULL, NULL, NULL, NULL, 'android', '1', '1', '0', NULL, NULL, '91', '2023-10-06 11:36:47', '2023-10-06 11:36:47'),
(160, 'Pragyakushwah', 'pragyakushwah1@gmail.com', '8108103000', NULL, NULL, '$2y$10$66sslsQt7Fw9Ct//1/A4SuCa3OvdclNYd3p/3YA/PqinqqSyyjhNy', NULL, 'user', 'inactive', '652000ebe9162', NULL, NULL, NULL, '49.43.1.154', 'android', '1', '1', '0', NULL, NULL, '91', '2023-10-06 11:43:24', '2023-10-06 11:45:00'),
(161, 'ouba', NULL, '634869843', NULL, NULL, '$2y$10$ClWBtT.5IMRUrpx5VWi9BevyxcnJ7Npg9V4rvuPQEyxS1BQH.EVVy', NULL, 'user', 'inactive', '652081eeb9f55', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+34', '2023-10-06 20:53:50', '2023-10-06 20:53:50'),
(162, 'ouba', NULL, '0634869843', NULL, NULL, '$2y$10$kTczewXJuZBVlMQEey3xo.WigaqxBVeRjRRimxVbu1qLzf3DFZBFW', NULL, 'user', 'inactive', '652082360bb65', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+34', '2023-10-06 20:55:02', '2023-10-06 20:55:02'),
(163, 'oubambo', NULL, '0674635458', 'upload/user/7676591699758736.jpg', NULL, '$2y$10$CRU9.hWEcf/j/7hkEv47H.22y7hA3j.k0cNP8zntcGiFCJ3/U/Ba2', NULL, 'user', 'active', '65215b53909e6', '5', '2023-10-18', NULL, '31.4.243.189', 'Android', '1', '1', '0', 'fOCBpw7KRQqdYjJwju2thi:APA91bECuPKjTih-c5jEwpGNJTAdOF_LzC6rcMYE3d-LnuuJr7cdFtvHbkclQrHmf3TjUwVPKNR5REgzjHveo6NV0e_qT1SQH3MV9K-QTOwZe6zgHhlOuI22nEj82OSi8zTclMnpyv6y', NULL, '+212', '2023-10-07 12:21:23', '2023-11-27 10:46:31'),
(164, 'oubambo', NULL, '674635458', NULL, NULL, '$2y$10$gAn/I8uCSfu9G2uG636LFu2fLjnr5.hRssPgox7nYXNkw3a66SlJG', NULL, 'user', 'active', '65215ba096467', '5', '2023-10-18', NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+212', '2023-10-07 12:22:40', '2023-10-18 21:35:43'),
(165, 'akshit', 'test@gmail.com', '9770880339', NULL, NULL, '$2y$10$lETQpcUe6oWVgDCDz1shducfVMJWq2Vzh/sybOiyi812oPWK7YL8u', NULL, 'user', 'inactive', '654f9968c9882', NULL, NULL, NULL, '152.58.26.228', 'Android', '1', '1', '0', 'cLA5iyEbSjqOxHcGT33tSh:APA91bGAKiSus3iWE30gGxwaphxr4MX7Q3I4dSO0TLi0ZdPqwkGGhp_O4Jnj8UHsTFkSfNvQiWnHoiDEqsMqSNMPnHxwGVIFi7uQaS_coDNTVjdZA97CvkabjMDp1SwvEExyseD0YTKz', NULL, '+91', '2023-11-11 15:10:32', '2023-12-03 14:02:36'),
(166, 'Preeti Vishwakarma', 'dbpreeti15@gmail.com', NULL, 'upload/user/7381711701344598.jpg', NULL, '$2y$10$cjgXHJPJtyayTkYVdqtmZe2HajnLTTWQaTNOPwJtgok8A/c9FVfNW', NULL, 'user', 'inactive', '655c3df4104c8', '1', '04-12-2023', '01-01-2024', '49.35.210.229', 'Android', '1', '1', '1', 'eJbcb_lDRo2v48j746urKZ:APA91bFf5qZ5aKks-mV_4APfPjeoOK_6lgSGmsyuy8lZ7mPEEYRUKDlvjpxiCWm7wGw8EIpfjMbfN0DKXYzjASb4kLENwImlQBCnoAWvRozPoQmSEjMmIH7spyeAltRRrkfntPPezCAa', 'google', '+91', '2023-11-21 05:19:48', '2023-12-04 14:17:49'),
(167, 'jaya', NULL, '8207483448', NULL, NULL, '$2y$10$wypGTU7KTVYdpITVA66KquM4iH/Qu60k7cPGSD2dwkwmflCFAnm16', NULL, 'user', 'inactive', '655e3f97c7b5a', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-11-22 17:51:19', '2023-11-22 17:51:19'),
(168, 'Jayshree Giri', NULL, '8207403448', NULL, NULL, '$2y$10$zNjDY5n78b7zfAQOKGAL0.bD1biyeyslpOf6GH64/CB2oIgo9dNZK', NULL, 'user', 'inactive', '655e43d16ba22', NULL, NULL, NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+91', '2023-11-22 18:09:21', '2023-11-22 18:09:21'),
(169, 'Ashish', 'ashishkumawat151@gmail.com', '9174178300', NULL, NULL, '$2y$10$BmsHq/L.BNnTc2/j942V8.XfyCjiR6w2CGihd6xgk4ChZNgjdzVb6', NULL, 'user', 'inactive', '656173b0ec927', NULL, NULL, NULL, '157.34.150.43', 'Android', '1', '1', '0', 'cpTPy0bLRrCbKptyHnm1dn:APA91bEAp_eo5DBsn4S2cP1x8hch-j3ZTMoK3TFXTdAdkSzCz2RajA4WqF_ISVHBa1TzK6QVOu16GOo5K6NbD0SJhFeid-QhwHlUjOMi5Y-4NL-7woBedgktSMpVVDqvMwi12-8MdWwD', NULL, '+91', '2023-11-25 04:10:25', '2023-11-25 04:12:16'),
(170, 'Jayshree Giri', 'girijayshree29@gmail.com', NULL, NULL, NULL, '$2y$10$K3XPn2P9zd8O.Gf/.dKkg.UeKsbgIBeDAWN27Ye4pNoHw9nZgqw/u', NULL, 'user', 'inactive', '6561d651d80dc', NULL, NULL, NULL, '106.67.64.139', 'Android', '1', '1', '0', 'e40Gtni4QF-YNmKx9vAuix:APA91bGVvdIxHf5zkm5tJjGcoRFmp8fiPDrOL6xNZxzVvH77qLpH7tgYqor8sgcr2f_vNhn1n-SUIWPYRFEltzE5MXff5bqRlhpp_HZGg_yVxzUzai5sU0r4EHSTLj8_VQmTTuUDIcJb', 'google', NULL, '2023-11-25 11:11:13', '2023-11-27 07:15:12'),
(171, 'Aniket', 'aniketmakwana854@gmail.com', '9926260273', NULL, NULL, '$2y$10$AKrHcEQ8A9IIN82FTqLxZe2ILJF3aMOg9B.vtiTCvgvMU8vRvU5Yu', NULL, 'user', 'inactive', '65622d0062041', NULL, NULL, NULL, '157.34.210.207', 'Android', '1', '1', '0', 'eSAzA_drRS6rCTwtsEpS86:APA91bG9-_S42cW-8rPpvaIG8wzeESqVuHRzQJijYtowaUx4u54FZ-KgSaGzOOxk0mT7Ia0qd2KJj5_Xb8dSexjS3w8ygXoWUwA9fwQtjPdfzIfsVmPJwvpFscHBFvLAXOXergkv3aet', NULL, '+91', '2023-11-25 17:21:04', '2023-11-25 17:22:16'),
(172, 'por ouba', NULL, '191052048', NULL, NULL, '$2y$10$NlV.KI3LdfmkEL7S0G0pWep/8BcXVsNTGiHT1/0I48xFkhYSCmS8W', NULL, 'user', 'active', '6564807fb3754', '9', '2023-11-27', NULL, NULL, 'Android', '1', '1', '0', NULL, NULL, '+351', '2023-11-27 11:41:51', '2023-11-27 11:43:02'),
(173, 'ily yo', NULL, '910520485', NULL, NULL, '$2y$10$Qsvgd6O5LsCdcr0B57UrVuySJlVgDtOCwqDobNBlexaRj96Tn3u2.', NULL, 'user', 'active', '656481506d451', '5', '2023-11-27', NULL, '188.37.208.1', 'Android', '1', '1', '0', 'f7aZdz2XTVupGd_5VuNvT5:APA91bHrWlKcmS5tjvY0zlsqEELSjpIlJ9cyPaqhdP6-78z-1lHwFvk98L1HJTHHLbWVaQaowVBeEgkaPuBX0BgqsOyaJZaN7d0lQ4JU0Eg8fYPP0L4DNrNuxM00vrHmbVLbb2iFDxAz', NULL, '+351', '2023-11-27 11:45:20', '2023-11-30 13:25:16'),
(174, 'Nabil BOUMRACH', 'nabilboumrach@outlook.com', '664777950', NULL, NULL, '$2y$10$kscO19Vqf0EOs9T5KQL.ROvCzY9v8kXSyJ/v5pHJHGYiiWVqfn9iO', NULL, 'user', 'active', '6564a09f43e21', '9', '2023-11-27', NULL, '196.92.1.21', 'Android', '1', '1', '0', 'c7AnL3PiQe6nLUxWCbPpIE:APA91bGDcmhqIOYED6wJ9IKT4qHLV-LNg1iid2kOQ5wq5rbxbjqKNS-umQec8lmByJL9C_xYRaJGRNXNWKiSx67w2M1nwDHNLYbjVOIQuA9vv4VbQAQTS5nq7Solqv2rN2CJb0tCGRxe', NULL, '+212', '2023-11-27 13:58:55', '2023-11-28 15:26:16'),
(175, 'Project Management', 'project@developerbazaar.com', NULL, NULL, NULL, '$2y$10$1VBgFl.Dd.Y62H7TdqKn0OwSqseSczpEmG1GYxjnk2TBckxZx2QSW', NULL, 'user', 'inactive', '656dd14d783f1', NULL, NULL, NULL, '116.74.32.163', 'Android', '1', '1', '0', 'cIwTZfXMT-m5mUzoks5dDQ:APA91bFhCHsfRJ23NtrCj_IFOmDq5v_A3iDffWP8LmtB9BP7KbHVllXtlVE46V7-H548PwUYBTKyPlzmVJ0Oip-OzpLeFaW5Mp9D3RI7ZohUaiRs3FAKu_Jj3tq9QIhkUaGB7XDxbrLB', 'google', NULL, '2023-12-04 13:17:01', '2023-12-04 14:21:28');

-- --------------------------------------------------------

--
-- Table structure for table `user_otps`
--

CREATE TABLE `user_otps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` text DEFAULT NULL,
  `otp` varchar(255) NOT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_otps`
--

INSERT INTO `user_otps` (`id`, `user_id`, `otp`, `expire_at`, `created_at`, `updated_at`) VALUES
(238, '64d4ce1905a9d', '1264', '2023-08-10 10:46:56', '2023-08-10 10:46:33', '2023-08-10 10:46:56'),
(239, '64d4d7c207f31', '6704', '2023-08-10 11:28:18', '2023-08-10 11:27:46', '2023-08-10 11:28:18'),
(240, '64d4d7c207f31', '7816', '2023-08-10 11:30:15', '2023-08-10 11:28:39', '2023-08-10 11:30:15'),
(241, '64d4d83ea35a0', '3903', '2023-08-10 11:30:12', '2023-08-10 11:29:50', '2023-08-10 11:30:12'),
(242, '64d4d7c207f31', '3871', '2023-08-10 11:30:47', '2023-08-10 11:30:28', '2023-08-10 11:30:47'),
(243, '64d4d7c207f31', '5753', '2023-08-10 11:42:08', '2023-08-10 11:32:08', '2023-08-10 11:32:08'),
(244, '64d4d7c207f31', '1263', '2023-08-10 12:07:52', '2023-08-10 11:57:52', '2023-08-10 11:57:52'),
(245, '64d4d83ea35a0', '5041', '2023-08-10 12:00:17', '2023-08-10 11:59:55', '2023-08-10 12:00:17'),
(246, '64d4d83ea35a0', '4925', '2023-08-10 12:03:25', '2023-08-10 12:03:03', '2023-08-10 12:03:25'),
(247, '64d4e174a128d', '6762', '2023-08-10 12:19:08', '2023-08-10 12:09:08', '2023-08-10 12:09:08'),
(248, '64d4e1e657bab', '7676', '2023-08-10 12:21:02', '2023-08-10 12:11:02', '2023-08-10 12:11:02'),
(249, '64d4e2271788c', '7004', '2023-08-10 12:22:07', '2023-08-10 12:12:07', '2023-08-10 12:12:07'),
(250, '64d614e6d9920', '5533', '2023-08-11 10:01:23', '2023-08-11 10:00:54', '2023-08-11 10:01:23'),
(251, '64d614e6d9920', '9525', '2023-08-11 10:02:03', '2023-08-11 10:01:42', '2023-08-11 10:02:03'),
(252, '64d6287920de6', '7715', '2023-08-11 11:34:25', '2023-08-11 11:24:25', '2023-08-11 11:24:25'),
(253, '64d62aaa7610b', '1396', '2023-08-11 11:43:46', '2023-08-11 11:33:46', '2023-08-11 11:33:46'),
(254, '64d6287920de6', '9938', '2023-08-11 13:42:46', '2023-08-11 13:37:36', '2023-08-11 13:42:46'),
(255, '64df23d065255', '2662', '2023-08-18 06:56:33', '2023-08-18 06:54:56', '2023-08-18 06:56:33'),
(256, '64df23d065255', '5108', '2023-08-18 06:59:31', '2023-08-18 06:58:53', '2023-08-18 06:59:31'),
(257, '64edee169990f', '5348', '2023-08-29 12:10:27', '2023-08-29 12:09:42', '2023-08-29 12:10:27'),
(258, '64d614e6d9920', '9423', '2023-09-07 06:15:43', '2023-09-07 06:15:09', '2023-09-07 06:15:43'),
(259, '64edee169990f', '9194', '2023-09-12 10:22:07', '2023-09-12 10:21:23', '2023-09-12 10:22:07'),
(260, '64d614e6d9920', '6970', '2023-09-18 06:45:52', '2023-09-18 06:45:20', '2023-09-18 06:45:52'),
(261, '64edee169990f', '1396', '2023-09-18 08:35:13', '2023-09-18 08:25:13', '2023-09-18 08:25:13'),
(262, '650817bd37404', '8592', '2023-09-18 08:31:56', '2023-09-18 08:26:21', '2023-09-18 08:31:56'),
(263, '650817bd37404', '4000', '2023-09-18 08:42:00', '2023-09-18 08:32:00', '2023-09-18 08:32:00'),
(264, '64edee169990f', '8580', '2023-09-21 04:08:34', '2023-09-21 04:07:34', '2023-09-21 04:08:34'),
(265, '64edee169990f', '6933', '2023-09-21 04:48:01', '2023-09-21 04:38:01', '2023-09-21 04:38:01'),
(266, '64edee169990f', '6642', '2023-09-21 08:40:02', '2023-09-21 08:39:34', '2023-09-21 08:40:02'),
(267, '64d6287920de6', '8174', '2023-09-22 22:20:03', '2023-09-22 22:19:33', '2023-09-22 22:20:03'),
(268, '64edee169990f', '6253', '2023-09-25 04:30:57', '2023-09-25 04:23:59', '2023-09-25 04:30:57'),
(269, '64edee169990f', '8905', '2023-09-25 07:33:51', '2023-09-25 07:23:51', '2023-09-25 07:23:51'),
(270, '64edee169990f', '4876', '2023-09-25 12:46:09', '2023-09-25 12:36:09', '2023-09-25 12:36:09'),
(271, '65118cec186b0', '3429', '2023-09-25 12:37:20', '2023-09-25 12:36:44', '2023-09-25 12:37:20'),
(272, '65118cec186b0', '7275', '2023-09-26 06:15:07', '2023-09-26 06:12:17', '2023-09-26 06:15:07'),
(273, '65136bb6ad009', '4517', '2023-09-26 22:41:51', '2023-09-26 22:39:34', '2023-09-26 22:41:51'),
(274, '64edee169990f', '1399', '2023-09-27 06:03:07', '2023-09-27 06:02:29', '2023-09-27 06:03:07'),
(275, '651434d5b941b', '6994', '2023-09-27 12:58:06', '2023-09-27 12:57:41', '2023-09-27 12:58:06'),
(276, '64d6287920de6', '8576', '2023-09-27 14:41:27', '2023-09-27 14:40:33', '2023-09-27 14:41:27'),
(277, '65136bb6ad009', '7842', '2023-09-27 14:58:59', '2023-09-27 14:58:12', '2023-09-27 14:58:59'),
(278, '64d614e6d9920', '5874', '2023-09-28 09:54:01', '2023-09-28 09:53:34', '2023-09-28 09:54:01'),
(279, '6516a2fc0bf90', '9807', '2023-09-29 09:12:39', '2023-09-29 09:12:12', '2023-09-29 09:12:39'),
(280, '6516a2fc0bf90', '1700', '2023-09-29 09:24:49', '2023-09-29 09:14:49', '2023-09-29 09:14:49'),
(281, '64edee169990f', '5651', '2023-10-02 03:53:54', '2023-10-02 03:43:54', '2023-10-02 03:43:54'),
(282, '64edee169990f', '1732', '2023-10-03 04:30:24', '2023-10-03 04:29:46', '2023-10-03 04:30:24'),
(283, '651d0f546b9c9', '7065', '2023-10-04 06:18:04', '2023-10-04 06:08:04', '2023-10-04 06:08:04'),
(284, '651d0f6b9f73f', '2194', '2023-10-04 06:18:27', '2023-10-04 06:08:27', '2023-10-04 06:08:27'),
(285, '651d0f8fd0c53', '8184', '2023-10-04 06:19:03', '2023-10-04 06:09:03', '2023-10-04 06:09:03'),
(286, '651d0fda7b087', '8586', '2023-10-04 06:10:51', '2023-10-04 06:10:18', '2023-10-04 06:10:51'),
(287, '651d106f692a0', '5412', '2023-10-04 06:22:47', '2023-10-04 06:12:47', '2023-10-04 06:12:47'),
(288, '651d0fda7b087', '4932', '2023-10-04 06:25:39', '2023-10-04 06:15:39', '2023-10-04 06:15:39'),
(289, '651d106f692a0', '1683', '2023-10-04 06:35:38', '2023-10-04 06:25:38', '2023-10-04 06:25:38'),
(290, '651d14752cf51', '5372', '2023-10-04 06:30:34', '2023-10-04 06:29:57', '2023-10-04 06:30:34'),
(291, '651d14752cf51', '1799', '2023-10-04 06:44:29', '2023-10-04 06:34:29', '2023-10-04 06:34:29'),
(292, '651d0fda7b087', '6222', '2023-10-04 06:47:33', '2023-10-04 06:37:33', '2023-10-04 06:37:33'),
(293, '651d171dcf1e8', '7779', '2023-10-04 06:51:17', '2023-10-04 06:41:17', '2023-10-04 06:41:17'),
(294, '651d1a3e89fdb', '2737', '2023-10-04 07:04:38', '2023-10-04 06:54:38', '2023-10-04 06:54:38'),
(295, '651d1a3e89fdb', '5167', '2023-10-04 07:20:55', '2023-10-04 07:10:55', '2023-10-04 07:10:55'),
(296, '651d0fda7b087', '7290', '2023-10-04 07:22:42', '2023-10-04 07:12:42', '2023-10-04 07:12:42'),
(297, '651d106f692a0', '5375', '2023-10-04 07:22:44', '2023-10-04 07:12:44', '2023-10-04 07:12:44'),
(298, '651d1f3e87c26', '2130', '2023-10-04 07:25:58', '2023-10-04 07:15:58', '2023-10-04 07:15:58'),
(299, '651d1a3e89fdb', '1732', '2023-10-04 07:34:12', '2023-10-04 07:24:12', '2023-10-04 07:24:12'),
(300, '651d106f692a0', '6796', '2023-10-04 08:31:16', '2023-10-04 08:21:16', '2023-10-04 08:21:16'),
(301, '651d0fda7b087', '1641', '2023-10-04 08:32:14', '2023-10-04 08:22:14', '2023-10-04 08:22:14'),
(302, '651d0fda7b087', '8406', '2023-10-04 09:11:29', '2023-10-04 09:01:29', '2023-10-04 09:01:29'),
(303, '651d106f692a0', '9672', '2023-10-04 10:05:44', '2023-10-04 09:55:44', '2023-10-04 09:55:44'),
(304, '651d0fda7b087', '4077', '2023-10-04 10:09:29', '2023-10-04 09:59:29', '2023-10-04 09:59:29'),
(305, '651d106f692a0', '5754', '2023-10-04 10:54:08', '2023-10-04 10:44:08', '2023-10-04 10:44:08'),
(306, '651d516219690', '2005', '2023-10-04 10:59:54', '2023-10-04 10:49:54', '2023-10-04 10:49:54'),
(307, '651d51f46f693', '7594', '2023-10-04 11:02:20', '2023-10-04 10:52:20', '2023-10-04 10:52:20'),
(308, '651e4f71de6e2', '6095', '2023-10-05 05:03:54', '2023-10-05 04:53:54', '2023-10-05 04:53:54'),
(309, '651e51e40246c', '9967', '2023-10-05 05:14:20', '2023-10-05 05:04:20', '2023-10-05 05:04:20'),
(310, '651e525ec38ff', '8502', '2023-10-05 05:16:22', '2023-10-05 05:06:22', '2023-10-05 05:06:22'),
(311, '651d1a3e89fdb', '9360', '2023-10-05 05:55:23', '2023-10-05 05:45:23', '2023-10-05 05:45:23'),
(312, '651d1a3e89fdb', '7654', '2023-10-05 06:06:15', '2023-10-05 05:56:15', '2023-10-05 05:56:15'),
(313, '651d1f3e87c26', '6138', '2023-10-05 06:17:05', '2023-10-05 06:07:05', '2023-10-05 06:07:05'),
(314, '651e638475a66', '9400', '2023-10-05 06:29:32', '2023-10-05 06:19:32', '2023-10-05 06:19:32'),
(315, '651d1a3e89fdb', '8504', '2023-10-05 06:32:49', '2023-10-05 06:22:49', '2023-10-05 06:22:49'),
(316, '651d1a3e89fdb', '6642', '2023-10-05 06:47:11', '2023-10-05 06:37:11', '2023-10-05 06:37:11'),
(317, '651d1a3e89fdb', '1402', '2023-10-05 07:33:47', '2023-10-05 07:23:47', '2023-10-05 07:23:47'),
(318, '651d1a3e89fdb', '7137', '2023-10-05 07:43:59', '2023-10-05 07:33:59', '2023-10-05 07:33:59'),
(319, '651d1a3e89fdb', '6305', '2023-10-05 08:00:21', '2023-10-05 07:50:21', '2023-10-05 07:50:21'),
(320, '651e7980d3fdd', '4569', '2023-10-05 08:03:20', '2023-10-05 07:53:20', '2023-10-05 07:53:20'),
(321, '651e79ceae352', '4395', '2023-10-05 08:04:38', '2023-10-05 07:54:38', '2023-10-05 07:54:38'),
(322, '651e7980d3fdd', '6038', '2023-10-05 08:14:24', '2023-10-05 08:04:24', '2023-10-05 08:04:24'),
(323, '651d1a3e89fdb', '8781', '2023-10-05 08:38:12', '2023-10-05 08:37:37', '2023-10-05 08:38:12'),
(324, '651e7980d3fdd', '8050', '2023-10-05 09:20:17', '2023-10-05 09:10:17', '2023-10-05 09:10:17'),
(325, '651d1a3e89fdb', '7960', '2023-10-05 09:36:32', '2023-10-05 09:35:11', '2023-10-05 09:36:32'),
(326, '651d51f46f693', '8851', '2023-10-05 10:17:49', '2023-10-05 10:17:20', '2023-10-05 10:17:49'),
(327, '651e7980d3fdd', '3241', '2023-10-05 10:18:03', '2023-10-05 10:17:20', '2023-10-05 10:18:03'),
(328, '651d1a3e89fdb', '3702', '2023-10-05 11:17:08', '2023-10-05 11:16:28', '2023-10-05 11:17:08'),
(329, '651d1a3e89fdb', '2571', '2023-10-05 11:47:07', '2023-10-05 11:46:05', '2023-10-05 11:47:07'),
(330, '651e51e40246c', '6816', '2023-10-06 01:55:23', '2023-10-06 01:45:23', '2023-10-06 01:45:23'),
(331, '651d51f46f693', '9126', '2023-10-06 11:31:42', '2023-10-06 11:31:11', '2023-10-06 11:31:42'),
(332, '651fff5f44272', '3467', '2023-10-06 11:46:47', '2023-10-06 11:36:47', '2023-10-06 11:36:47'),
(333, '652000ebe9162', '5308', '2023-10-06 11:45:00', '2023-10-06 11:43:24', '2023-10-06 11:45:00'),
(334, '652081eeb9f55', '2265', '2023-10-06 21:03:50', '2023-10-06 20:53:50', '2023-10-06 20:53:50'),
(335, '652082360bb65', '9153', '2023-10-06 21:05:02', '2023-10-06 20:55:02', '2023-10-06 20:55:02'),
(336, '65215b53909e6', '7684', '2023-10-07 12:31:23', '2023-10-07 12:21:23', '2023-10-07 12:21:23'),
(337, '65215ba096467', '6186', '2023-10-07 12:32:40', '2023-10-07 12:22:40', '2023-10-07 12:22:40'),
(338, '652081eeb9f55', '5495', '2023-10-07 12:36:43', '2023-10-07 12:26:43', '2023-10-07 12:26:43'),
(339, '652082360bb65', '2384', '2023-10-07 12:37:08', '2023-10-07 12:27:08', '2023-10-07 12:27:08'),
(340, '651d51f46f693', '7370', '2023-10-07 13:49:03', '2023-10-07 13:39:03', '2023-10-07 13:39:03'),
(341, '651e525ec38ff', '8815', '2023-10-07 15:07:00', '2023-10-07 14:57:00', '2023-10-07 14:57:00'),
(342, '651e51e40246c', '4121', '2023-10-07 15:09:22', '2023-10-07 14:59:22', '2023-10-07 14:59:22'),
(343, '651d51f46f693', '5829', '2023-10-07 17:42:25', '2023-10-07 17:32:25', '2023-10-07 17:32:25'),
(344, '651e51e40246c', '1719', '2023-10-08 08:01:30', '2023-10-08 07:51:30', '2023-10-08 07:51:30'),
(345, '651d51f46f693', '4634', '2023-10-09 05:29:54', '2023-10-09 05:19:54', '2023-10-09 05:19:54'),
(346, '651d1a3e89fdb', '7331', '2023-10-09 07:24:57', '2023-10-09 07:24:18', '2023-10-09 07:24:57'),
(347, '651d51f46f693', '8438', '2023-10-09 10:16:58', '2023-10-09 10:09:44', '2023-10-09 10:16:58'),
(348, '651d51f46f693', '2967', '2023-10-09 10:43:16', '2023-10-09 10:33:16', '2023-10-09 10:33:16'),
(349, '651d106f692a0', '6797', '2023-10-09 10:40:26', '2023-10-09 10:35:32', '2023-10-09 10:40:26'),
(350, '651d106f692a0', '5530', '2023-10-09 11:10:36', '2023-10-09 11:00:36', '2023-10-09 11:00:36'),
(351, '651d106f692a0', '7549', '2023-10-09 11:51:58', '2023-10-09 11:41:58', '2023-10-09 11:41:58'),
(352, '651d106f692a0', '6371', '2023-10-09 12:14:32', '2023-10-09 12:04:32', '2023-10-09 12:04:32'),
(353, '651d106f692a0', '5779', '2023-10-09 13:07:22', '2023-10-09 12:57:22', '2023-10-09 12:57:22'),
(354, '651e51e40246c', '6107', '2023-10-09 15:10:25', '2023-10-09 15:00:25', '2023-10-09 15:00:25'),
(355, '651d1a3e89fdb', '6668', '2023-10-10 07:04:30', '2023-10-10 07:03:17', '2023-10-10 07:04:30'),
(356, '651d106f692a0', '1775', '2023-10-10 09:14:30', '2023-10-10 09:13:50', '2023-10-10 09:14:30'),
(357, '65215ba096467', '8317', '2023-10-10 17:54:20', '2023-10-10 17:44:20', '2023-10-10 17:44:20'),
(358, '65215b53909e6', '5494', '2023-10-10 17:46:15', '2023-10-10 17:45:39', '2023-10-10 17:46:15'),
(359, '65215ba096467', '9964', '2023-10-18 21:09:56', '2023-10-18 20:59:56', '2023-10-18 20:59:56'),
(360, '65215b53909e6', '7347', '2023-10-18 21:12:14', '2023-10-18 21:02:14', '2023-10-18 21:02:14'),
(361, '65215b53909e6', '9114', '2023-10-18 21:14:40', '2023-10-18 21:13:44', '2023-10-18 21:14:40'),
(362, '651d1a3e89fdb', '9729', '2023-11-07 05:56:12', '2023-11-07 05:46:12', '2023-11-07 05:46:12'),
(363, '651d106f692a0', '8681', '2023-11-08 07:55:58', '2023-11-08 07:45:58', '2023-11-08 07:45:58'),
(364, '654f9968c9882', '9096', '2023-11-11 15:11:07', '2023-11-11 15:10:32', '2023-11-11 15:11:07'),
(365, '651d106f692a0', '5667', '2023-11-15 17:27:08', '2023-11-15 17:26:21', '2023-11-15 17:27:08'),
(366, '654f9968c9882', '9319', '2023-11-21 10:24:31', '2023-11-21 10:23:50', '2023-11-21 10:24:31'),
(367, '655e3f97c7b5a', '6240', '2023-11-22 18:01:19', '2023-11-22 17:51:19', '2023-11-22 17:51:19'),
(368, '654f9968c9882', '1387', '2023-11-22 18:08:25', '2023-11-22 18:07:45', '2023-11-22 18:08:25'),
(369, '655e43d16ba22', '5738', '2023-11-22 18:19:21', '2023-11-22 18:09:21', '2023-11-22 18:09:21'),
(370, '651d1a3e89fdb', '7384', '2023-11-23 04:20:20', '2023-11-23 04:19:45', '2023-11-23 04:20:20'),
(371, '655e43d16ba22', '3465', '2023-11-23 10:10:17', '2023-11-23 10:00:17', '2023-11-23 10:00:17'),
(372, '651d51f46f693', '5730', '2023-11-24 06:14:51', '2023-11-24 06:14:22', '2023-11-24 06:14:51'),
(373, '656173b0ec927', '8129', '2023-11-25 04:11:33', '2023-11-25 04:10:25', '2023-11-25 04:11:33'),
(374, '655e43d16ba22', '6144', '2023-11-25 11:19:18', '2023-11-25 11:09:18', '2023-11-25 11:09:18'),
(375, '65622d0062041', '4958', '2023-11-25 17:21:48', '2023-11-25 17:21:04', '2023-11-25 17:21:48'),
(376, '651d51f46f693', '9310', '2023-11-27 06:16:39', '2023-11-27 06:16:02', '2023-11-27 06:16:39'),
(377, '6564807fb3754', '1920', '2023-11-27 11:51:51', '2023-11-27 11:41:51', '2023-11-27 11:41:51'),
(378, '656481506d451', '6619', '2023-11-27 11:55:20', '2023-11-27 11:45:20', '2023-11-27 11:45:20'),
(379, '656481506d451', '3094', '2023-11-27 12:21:34', '2023-11-27 12:20:38', '2023-11-27 12:21:34'),
(380, '6564a09f43e21', '8030', '2023-11-27 14:00:13', '2023-11-27 13:58:55', '2023-11-27 14:00:13'),
(381, '651d51f46f693', '7568', '2023-11-28 07:31:28', '2023-11-28 07:30:56', '2023-11-28 07:31:28'),
(382, '6564a09f43e21', '5697', '2023-11-28 15:25:22', '2023-11-28 15:24:31', '2023-11-28 15:25:22'),
(383, '656481506d451', '7149', '2023-11-30 12:50:49', '2023-11-30 12:50:05', '2023-11-30 12:50:49');

-- --------------------------------------------------------

--
-- Table structure for table `view_books`
--

CREATE TABLE `view_books` (
  `id` int(11) NOT NULL,
  `user_id` text DEFAULT NULL,
  `book_id` text DEFAULT NULL,
  `chapter` text DEFAULT NULL,
  `video` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  `read_type` text DEFAULT NULL,
  `percentage` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `view_books`
--

INSERT INTO `view_books` (`id`, `user_id`, `book_id`, `chapter`, `video`, `status`, `read_type`, `percentage`, `created_at`, `updated_at`) VALUES
(62, '64d4cfb1156fe', '18', '3', NULL, 'finish', 'reading', '100', '2023-08-10 11:15:23', '2023-08-10 11:15:35'),
(63, '64d4df0960935', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'reading', 'reading', '66.666666666667', '2023-08-11 05:47:07', '2023-10-03 03:23:54'),
(64, '64d623bf0cf19', '19', '1', 'https://youtu.be/bwK1F0wdSpI', 'watching', 'watching', '100', '2023-08-11 11:06:15', '2023-08-26 20:41:07'),
(65, '64d6287920de6', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'finish', 'reading', '100', '2023-08-11 13:43:31', '2023-09-27 14:48:49'),
(66, '64d6287920de6', '15', '1', NULL, 'finish', 'reading', '50', '2023-08-11 13:47:31', '2023-08-28 20:33:40'),
(67, '64d6287920de6', '19', '1', 'https://youtu.be/bwK1F0wdSpI', 'watching', 'reading', '100', '2023-08-11 19:17:33', '2023-09-29 08:50:44'),
(68, '64d623bf0cf19', '11', NULL, 'https://www.youtube.com/watch?v=cYoXlkiw67U', 'watching', 'watching', NULL, '2023-08-11 23:01:30', '2023-08-11 23:01:30'),
(69, '64d623bf0cf19', '18', '3', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'finish', 'reading', '100', '2023-08-11 23:12:09', '2023-08-26 19:34:04'),
(70, '64d623bf0cf19', '13', '2', NULL, 'finish', 'reading', '100', '2023-08-28 07:32:48', '2023-08-28 07:33:31'),
(71, '64d6287920de6', '23', NULL, 'https://youtu.be/n3EAatemHdY', 'watching', 'watching', NULL, '2023-08-28 20:00:28', '2023-08-28 20:00:28'),
(72, '64d614e6d9920', '18', '1', NULL, 'finish', 'reading', '100', '2023-09-07 06:20:48', '2023-09-14 11:27:43'),
(73, '64edee169990f', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'finish', 'reading', '100', '2023-09-12 10:27:23', '2023-10-03 04:30:40'),
(74, '64d614e6d9920', '24', '3', NULL, 'finish', 'reading', '100', '2023-09-12 10:41:11', '2023-09-12 10:44:57'),
(75, '64d614e6d9920', '6', '1', NULL, 'reading', 'reading', '100', '2023-09-12 10:44:22', '2023-09-12 10:44:25'),
(76, '650819c3d32b5', '18', NULL, 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', NULL, '2023-09-18 08:40:06', '2023-09-18 08:40:06'),
(77, '650819c3d32b5', '6', NULL, 'https://www.youtube.com/watch?v=GXWfue9VhTY', 'watching', 'watching', NULL, '2023-09-18 10:00:55', '2023-09-18 10:01:02'),
(78, '650817bd37404', '18', '1', NULL, 'finish', 'reading', '100', '2023-09-19 09:19:20', '2023-09-19 09:20:38'),
(79, '64d623bf0cf19', '24', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-09-20 20:34:26', '2023-09-20 20:34:26'),
(80, '64edee169990f', '19', '1', NULL, 'reading', 'reading', '50', '2023-09-22 04:24:28', '2023-09-22 04:24:28'),
(81, '650d8ee41cfd7', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'reading', '33.333333333333', '2023-09-22 12:49:38', '2023-09-28 09:44:42'),
(82, '64d4df0960935', '15', '1', NULL, 'reading', 'reading', '50', '2023-09-25 09:47:52', '2023-09-25 09:47:52'),
(83, '651153e0c9918', '18', NULL, 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', NULL, '2023-09-26 03:55:14', '2023-09-26 03:55:14'),
(84, '6512ccf472102', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-09-26 11:22:29', '2023-09-26 11:27:00'),
(85, '65136bb6ad009', '18', '2', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', '100', '2023-09-26 22:43:10', '2023-09-26 22:44:46'),
(86, '65136bb6ad009', '19', '1', NULL, 'reading', 'reading', '50', '2023-09-26 22:45:32', '2023-09-26 22:45:32'),
(87, '65118cec186b0', '18', '3', NULL, 'finish', 'reading', '100', '2023-09-27 11:09:48', '2023-10-03 04:03:20'),
(88, '651aab829086a', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-10-02 10:37:59', '2023-10-03 12:09:15'),
(89, '6516a2fc0bf90', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', '33.333333333333', '2023-10-03 11:25:24', '2023-10-03 11:26:34'),
(90, '651d51f46f693', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', '100', '2023-10-05 10:18:21', '2023-11-28 08:15:20'),
(91, '651d51f46f693', '3', '1', NULL, 'reading', 'reading', '25', '2023-10-05 10:21:36', '2023-11-28 07:43:33'),
(92, '651d1ddc10230', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-10-05 11:19:51', '2023-10-05 11:21:09'),
(93, '651d1a7047e33', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-10-05 11:36:34', '2023-10-05 11:36:34'),
(94, '651eb34c00eb1', '24', '3', NULL, 'finish', 'reading', '100', '2023-10-06 05:50:52', '2023-11-24 09:28:18'),
(95, '651eb34c00eb1', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'finish', 'reading', '100', '2023-10-06 05:51:50', '2023-11-24 09:26:42'),
(96, '651d1dcfb7785', '18', '1', NULL, 'finish', 'reading', '100', '2023-10-10 11:03:41', '2023-11-27 12:11:56'),
(97, '65215b53909e6', '13', '2', NULL, 'finish', 'reading', '100', '2023-10-10 17:50:28', '2023-10-10 17:54:52'),
(98, '65215b53909e6', '18', '2', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'reading', 'reading', '66.666666666667', '2023-10-10 17:57:21', '2023-11-23 13:36:35'),
(99, '65215b53909e6', '24', '2', NULL, 'reading', 'reading', '66.666666666667', '2023-10-10 17:59:44', '2023-11-23 13:37:12'),
(100, '65215b53909e6', '19', '1', NULL, 'finish', 'reading', '100', '2023-10-10 18:03:41', '2023-11-23 13:39:16'),
(101, '651d1a3e89fdb', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'watching', '33.333333333333', '2023-10-13 05:53:54', '2023-10-27 10:28:55'),
(102, '65215b53909e6', '6', '1', NULL, 'reading', 'reading', '100', '2023-11-07 02:29:45', '2023-11-07 02:36:30'),
(103, '654f9968c9882', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'watching', 'reading', '100', '2023-11-11 15:13:28', '2023-12-03 14:02:31'),
(104, '655c3df4104c8', '24', '1', NULL, 'finish', 'reading', '100', '2023-11-21 10:08:18', '2023-11-30 10:40:24'),
(105, '651eb34c00eb1', '19', '1', NULL, 'finish', 'reading', '100', '2023-11-24 09:29:11', '2023-11-30 07:37:04'),
(106, '656173b0ec927', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-11-25 04:11:49', '2023-11-25 04:11:49'),
(107, '6561d651d80dc', '24', '1', NULL, 'reading', 'reading', '66.666666666667', '2023-11-25 11:15:14', '2023-11-25 11:16:49'),
(108, '656481506d451', '19', '2', NULL, 'finish', 'reading', '100', '2023-11-27 12:26:46', '2023-11-27 12:54:16'),
(109, '656481506d451', '18', '2', NULL, 'finish', 'reading', '66.666666666667', '2023-11-27 12:55:36', '2023-11-30 13:28:17'),
(110, '6564a09f43e21', '18', '2', NULL, 'finish', 'reading', '100', '2023-11-27 14:01:25', '2023-11-28 15:27:16'),
(111, '651d51f46f693', '24', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-11-28 08:00:32', '2023-11-28 08:00:32'),
(112, '655c3df4104c8', '18', '1', 'https://www.youtube.com/watch?v=wp7Lz1svVro', 'finish', 'reading', '33.333333333333', '2023-11-28 12:16:36', '2023-12-04 14:17:58'),
(113, '655c3df4104c8', '3', '1', NULL, 'reading', 'reading', '25', '2023-11-30 10:39:50', '2023-11-30 10:39:50'),
(114, '655c3df4104c8', '19', NULL, 'https://youtu.be/bwK1F0wdSpI', 'watching', 'watching', NULL, '2023-11-30 10:40:41', '2023-11-30 10:40:41'),
(115, '651d1e263dc08', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-12-04 12:36:36', '2023-12-04 12:56:35'),
(116, '656dd14d783f1', '18', '1', NULL, 'reading', 'reading', '33.333333333333', '2023-12-04 13:43:13', '2023-12-04 13:48:02');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bookmark`
--
ALTER TABLE `bookmark`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chapters`
--
ALTER TABLE `chapters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `english_accent`
--
ALTER TABLE `english_accent`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `english_fluency`
--
ALTER TABLE `english_fluency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `follow`
--
ALTER TABLE `follow`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `genre`
--
ALTER TABLE `genre`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `home_category`
--
ALTER TABLE `home_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `info_pages`
--
ALTER TABLE `info_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `language`
--
ALTER TABLE `language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `length`
--
ALTER TABLE `length`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `level`
--
ALTER TABLE `level`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `plan_period`
--
ALTER TABLE `plan_period`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz`
--
ALTER TABLE `quiz`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_response`
--
ALTER TABLE `quiz_response`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `quiz_useranswer`
--
ALTER TABLE `quiz_useranswer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `read_books`
--
ALTER TABLE `read_books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscription`
--
ALTER TABLE `subscription`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support`
--
ALTER TABLE `support`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `thirdparty_data`
--
ALTER TABLE `thirdparty_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transcation_history`
--
ALTER TABLE `transcation_history`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_otps`
--
ALTER TABLE `user_otps`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `view_books`
--
ALTER TABLE `view_books`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcement`
--
ALTER TABLE `announcement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `book`
--
ALTER TABLE `book`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `bookmark`
--
ALTER TABLE `bookmark`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `chapters`
--
ALTER TABLE `chapters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `english_accent`
--
ALTER TABLE `english_accent`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `english_fluency`
--
ALTER TABLE `english_fluency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `favorite`
--
ALTER TABLE `favorite`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `follow`
--
ALTER TABLE `follow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `genre`
--
ALTER TABLE `genre`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `home_category`
--
ALTER TABLE `home_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `info_pages`
--
ALTER TABLE `info_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `language`
--
ALTER TABLE `language`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `length`
--
ALTER TABLE `length`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `level`
--
ALTER TABLE `level`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=152;

--
-- AUTO_INCREMENT for table `plan_period`
--
ALTER TABLE `plan_period`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `quiz`
--
ALTER TABLE `quiz`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `quiz_response`
--
ALTER TABLE `quiz_response`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `quiz_useranswer`
--
ALTER TABLE `quiz_useranswer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT for table `read_books`
--
ALTER TABLE `read_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `subscription`
--
ALTER TABLE `subscription`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `support`
--
ALTER TABLE `support`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `thirdparty_data`
--
ALTER TABLE `thirdparty_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transcation_history`
--
ALTER TABLE `transcation_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=176;

--
-- AUTO_INCREMENT for table `user_otps`
--
ALTER TABLE `user_otps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=384;

--
-- AUTO_INCREMENT for table `view_books`
--
ALTER TABLE `view_books`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
