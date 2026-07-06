# rajya_purohit

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.



----
MySQL database name ---> rajya_purohit
MySQL username ---> intelligent
Password ---> intel@2026#HC
RajyaPurohit@2026

DB Name: u726843024_rajya_purohit
DB User: u726843024_intelligent
Password: intel@2026#HC


-----table Query------

-- 1. GOTRAS TABLE
CREATE TABLE IF NOT EXISTS `gotras` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`gotra_name` VARCHAR(100) NOT NULL,
`kuldevi_name` VARCHAR(100) NOT NULL,
`is_active` TINYINT(1) DEFAULT 1, -- ૧ એટલે એક્ટિવ, ૦ એટલે ઈનએક્ટિવ
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 2. VILLAGES TABLE
CREATE TABLE IF NOT EXISTS `villages` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`village_name` VARCHAR(100) NOT NULL,
`district` VARCHAR(100) NOT NULL,
`state` VARCHAR(100) NOT NULL,
`is_active` TINYINT(1) DEFAULT 1,
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 3. FAMILIES TABLE
CREATE TABLE IF NOT EXISTS `families` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`family_head_id` INT NULL,
`parent_family_id` INT NULL,
`residential_status` VARCHAR(100) DEFAULT 'Joint Family',
`address` TEXT NOT NULL,
`current_city` VARCHAR(100) NOT NULL,
`total_members` INT DEFAULT 1,
`is_active` TINYINT(1) DEFAULT 1, -- ફેમિલીને ઈનએક્ટિવ કરવા માટે
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`parent_family_id`) REFERENCES `families`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 4. USERS TABLE
CREATE TABLE IF NOT EXISTS `users` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`family_id` INT NOT NULL,
`gotra_id` INT NOT NULL,
`native_village_id` INT NOT NULL,
`surname` VARCHAR(100) NOT NULL,
`first_name` VARCHAR(100) NOT NULL,
`father_or_husband_name` VARCHAR(100) NOT NULL,
`gender` ENUM('Male', 'Female') NOT NULL,
`birth_date` DATE NOT NULL,
`phone_number` VARCHAR(15) UNIQUE NOT NULL,
`marital_status` VARCHAR(50) NOT NULL,
`education` VARCHAR(150) NOT NULL,
`occupation` VARCHAR(100) NOT NULL,
`relation_with_head` VARCHAR(100) NOT NULL,
`is_verified` TINYINT(1) DEFAULT 0,
`is_active` TINYINT(1) DEFAULT 1, -- ⚡ યુઝરને ઈનએક્ટિવ કરવા માટે (Soft Delete)
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`family_id`) REFERENCES `families`(`id`),
FOREIGN KEY (`gotra_id`) REFERENCES `gotras`(`id`),
FOREIGN KEY (`native_village_id`) REFERENCES `villages`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 5. MATERNAL DETAILS TABLE
CREATE TABLE IF NOT EXISTS `maternal_details` (
`id` INT AUTO_INCREMENT PRIMARY KEY,
`user_id` INT UNIQUE NOT NULL,
`maternal_father_name` VARCHAR(100) NOT NULL,
`maternal_mother_name` VARCHAR(100) NOT NULL,
`maternal_address` TEXT NOT NULL,
`is_active` TINYINT(1) DEFAULT 1, -- પ્રોફાઈલ ઈનએક્ટિવ થાય તો આ પણ થઈ શકે
`created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



હવે આપણે આ ડેટાબેઝને ફ્લટર (Flutter) સાથે કનેક્ટ કરવા માટે PHP API સ્ક્રિપ્ટ્સ તૈયાર કરીએ. આપણે આ આર્કિટેક્ચરને એકદમ ક્લીન રાખવા માટે હોસ્ટિંગરના ફાઈલ મેનેજરમાં એક અલગ ફોલ્ડર બનાવીને ૩ મુખ્ય ફાઈલો મુકીશું:

db_config.php (ડેટાબેઝ કનેક્શન માટે)
add_member.php (એપમાંથી નવો ડેટા સ્ટોર કરવા માટે)
get_members.php (ડેટા ફેચ કરીને એપમાં લિસ્ટ બતાવવા માટે)




------------data add---
INSERT INTO `gotras` (`id`, `gotra_name`, `kuldevi_name`) VALUES
(2, 'Bhardwaj', 'Ashapura Mataji'),
(3, 'Vashistha', 'Ambe Mataji'),
(4, 'Gautam', 'Chamunda Mataji'),
(5, 'Shandilya', 'Mahalaxmi Mataji'),
(6, 'Atri', 'Durga Mataji');