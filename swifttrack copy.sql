-- phpMyAdmin SQL Dump 
-- version 4.9.0.1 
-- https://www.phpmyadmin.net/ 
-- 
-- Host: localhost 
-- Generation Time: Mar 06, 2020 at 03:19 AM 
-- Server version: 10.3.16-MariaDB 
-- PHP Version: 7.3.7 
SET sql_mode
= "NO_AUTO_VALUE_ON_ZERO";
SET autocommit
= 0;START transaction;
SET time_zone
= "+00:00"; 
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */ 
; 
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */ 
; 
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */ 
; 
/*!40101 SET NAMES utf8mb4 */ 
;
-- 
-- Database: `swifttrack` 
-- 
-- -------------------------------------------------------- 
-- 
-- Table structure for table `ADMIN_INFO` 
DROP TABLE  `admin_info`;
CREATE TABLE `admin_info`
( 
                          `id`       INT NOT NULL PRIMARY KEY, 
                          `username` VARCHAR
(10) NOT NULL, 
                          `password` VARCHAR
(45) NOT NULL 
             ) 
             engine=innodb DEFAULT charset=utf8;

-- 
-- Dumping data for table `ADMIN_INFO` 
INSERT INTO `admin_info` 
            ( 
                        `
username`,
`password
` 
            ) 
            VALUES
( 
                        'admin', 
                        'admin101' 
            );

-- -------------------------------------------------------- 
-- 
-- Table structure for table `AWARD_CATEGORY` 
DROP TABLE  `award_category`;
CREATE TABLE `award_category`
( 
                          `id`                INT NOT NULL PRIMARY KEY, 
                          `award_category_id` INT
(11) NOT NULL, 
                          `description`       VARCHAR
(45) NOT NULL, 
                          `hours_required`    INT
(11) NOT NULL 
             ) 
             engine=innodb DEFAULT charset=utf8;

-- 
-- Dumping data for table `AWARD_CATEGORY` 
INSERT INTO `award_category` 
            ( 
                        `
award_category_id`,
`description
`, 
                        `hours_required` 
            ) 
            VALUES
( 
                        1, 
                        'Brower youth Award', 
                        25 
            ) 
            ,
( 
                        2, 
                        'Davidson Fellowship Award', 
                        50 
            ) 
            ,
( 
                        3, 
                        'Ford Scholars Award', 
                        75 
            ) 
            ,
( 
                        4, 
                        'Newman Civic Fellows Award', 
                        100 
            );

-- -------------------------------------------------------- 
-- 
-- Table structure for table `AWARD_TOTALS` 
DROP TABLE  `award_category`;
CREATE TABLE `award_totals`
( 
                          `id`                INT NOT NULL PRIMARY KEY, 
                          `student_id`        INT
(11) NOT NULL, 
                          `award_category_id` INT
(11) NOT NULL, 
                          `total_hours`       INT
(11) NOT NULL, 
                          `award_acheived`    CHAR
(1) NOT NULL 
             ) 
             engine=innodb DEFAULT charset=utf8;

-- 
-- Dumping data for table `AWARD_TOTALS` 

INSERT INTO `award_totals` 
            ( 
                        `
student_id`,
`award_category_id
`, 
                        `total_hours`, 
                        `award_acheived` 
            ) 
            VALUES
( 
                        1000001, 
                        1, 
                        32, 
                        'Y' 
            ) 
            ,
( 
                        1000002, 
                        2, 
                        56, 
                        'Y' 
            ) 
            ,
( 
                        1000003, 
                        3, 
                        80, 
                        'Y' 
            ) 
            ,
( 
                        1000004, 
                        4, 
                        104, 
                        'Y' 
            ) 
            ,
( 
                        1000005, 
                        2, 
                        24, 
                        'N' 
            );

-- -------------------------------------------------------- 
-- 
-- Table structure for table `STUDENT_INFO` 
DROP TABLE  `student_info`;
CREATE TABLE `student_info`
( 
                          `id`                INT NOT NULL PRIMARY KEY, 
                          `student_id`        INT
(11) NOT NULL, 
                          `firstname`         VARCHAR
(45) NOT NULL, 
                          `lastname`          VARCHAR
(45) NOT NULL, 
                          `grade`             INT
(11) NOT NULL, 
                          `award_category_id` INT
(11) NOT NULL 
             ) 
             engine=innodb DEFAULT charset=utf8;

-- 
-- Dumping data for table `STUDENT_INFO` 
INSERT INTO `student_info` 
            ( 
                        `
student_id`,
`firstname
`, 
                        `lastname`, 
                        `grade`, 
                        `award_category_id` 
            ) 
            VALUES
( 
                        1000001, 
                        'SHRUTHI', 
                        'SOLAIAPPAN', 
                        11, 
                        1 
            ) 
            ,
( 
                        1000002, 
                        'SARAH', 
                        'LEE', 
                        10, 
                        2 
            ) 
            ,
( 
                        1000003, 
                        'EVAN', 
                        'GRANT', 
                        9, 
                        3 
            ) 
            ,
( 
                        1000004, 
                        'JOHN', 
                        'DOE', 
                        10, 
                        4 
            ) 
            ,
( 
                        1000005, 
                        'JAMES', 
                        'SMITH', 
                        12, 
                        2 
            );

-- -------------------------------------------------------- 
-- 
-- Table structure for table `STUDENT_LOG` 
DROP TABLE  `student_log`;
CREATE TABLE `student_log`
( 
                          `id`         INT NOT NULL PRIMARY KEY, 
                          `student_id` INT
(11) NOT NULL, 
                          `date`       DATE NOT NULL, 
                          `hour`       INT
(11) NOT NULL 
             ) 
             engine=innodb DEFAULT charset=utf8;

-- 
-- Dumping data for table `STUDENT_LOG` 
INSERT INTO `student_log` 
            ( 
                        `
student_id`,
`date
`, 
                        `hour` 
            ) 
            VALUES
( 
                        1000001, 
                        '2020-01-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-01-05', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-20', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-03-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-01-06', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-15', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-01-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-01-05', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-20', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-03-01', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-01-06', 
                        8 
            ) 
            ,
( 
                        1000001, 
                        '2020-02-15', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-01-01', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-01-05', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-01', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-20', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-03-01', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-03-02', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-03-03', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-03-04', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-03-05', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-02', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-03', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-04', 
                        8 
            ) 
            ,
( 
                        1000002, 
                        '2020-02-05', 
                        8 
            ) 
            ,
( 
                        1000003, 
                        '2020-01-01', 
                        8 
            ) 
            ,
( 
                        1000003, 
                        '2020-01-06', 
                        8 
            ) 
            ,
( 
                        1000003, 
                        '2020-01-07', 
                        8 
            ) 
            ,
( 
                        1000003, 
                        '2020-01-08', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-15', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-16', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-17', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-18', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-19', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-20', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-21', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-22', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-23', 
                        8 
            ) 
            ,
( 
                        1000004, 
                        '2020-02-24', 
                        8 
            ) 
            ,
( 
                        1000005, 
                        '2020-01-18', 
                        8 
            ) 
            ,
( 
                        1000005, 
                        '2020-01-19', 
                        8 
            ) 
            ,
( 
                        1000005, 
                        '2020-01-20', 
                        8 
            ); 

-- 
-- Indexes for dumped tables 
-- 
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */ 
; 
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */ 
; 
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */ 
;