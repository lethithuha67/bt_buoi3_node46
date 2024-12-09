CREATE TABLE food (
    food_id INT PRIMARY KEY AUTO_INCREMENT,
    food_name VARCHAR(255),
    img VARCHAR(255),
    price FLOAT,
    description VARCHAR(255),
    type_id INT
)

CREATE TABLE sub_food (
	sub_id INT PRIMARY KEY AUTO_INCREMENT,
	sub_name VARCHAR(255),
	sub_price FLOAT,
	food_id INT
)

CREATE TABLE food_type (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
	type_name VARCHAR(255)
)

CREATE TABLE `user` (
	user_id INT PRIMARY KEY AUTO_INCREMENT,
	full_name VARCHAR(255),
	email VARCHAR(255),
	password VARCHAR(255)
)

CREATE TABLE `order` (
	orders_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	food_id INT,
	amount INT,
	code VARCHAR(255),
	arr_sub_id VARCHAR(255),
	FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (food_id) REFERENCES food(food_id)
)

CREATE TABLE `restaurant` (
	res_id INT PRIMARY KEY AUTO_INCREMENT,
	res_name VARCHAR(255),
	img VARCHAR(255),
	description VARCHAR(255)
)

CREATE TABLE `rate_res` (
	rate_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	res_id INT,
	amount INT,
	day_rate TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
)


CREATE TABLE `like_res` (
	like_id INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,
	res_id INT,
	day_like TIMESTAMP,
	FOREIGN KEY (user_id) REFERENCES user(user_id),
	FOREIGN KEY (res_id) REFERENCES restaurant(res_id)
)

INSERT INTO user(full_name, email, password) VALUES
('ha','guest@gmail.com',123),
('ha','guest2@gmail.com',456),
('ha','guest3@gmail.com',789)

INSERT INTO food ( food_name, img, price, description) VALUES
('Cơm gà','http:hinhComGa.png',25000,'Ăn rất ngon'),
('Bún gà','http:hinhBunBo.png',25000,'Ăn chạy mất dép'),
('sắn','http:hinhSuiCao.png',60000,'Ăn rất khô ')

INSERT INTO restaurant (res_name, img, description) VALUES
('hồ xuân hương', 'http:dalat.png', 'sang đà lạt'),
('hồ tràm', 'http:hotram.png', ' ở SG'),
('công viên', 'http:congvien.png', 'bán cá viên chiên');

INSERT INTO `order` (user_id, food_id) VALUES

(1,2),
(1,3),
(1,1),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3)

INSERT INTO `rate_res` (user_id, res_id) VALUES

(1,2),
(1,3),
(1,1),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3)

INSERT INTO `like_res` (user_id, res_id) VALUES

(1,2),
(1,3),
(1,1),
(2,1),
(2,2),
(2,3),
(3,1),
(3,2),
(3,3)

-- Tìm 5 người đã like nhà hàng nhiều nhất
SELECT users.user_id, users.full_name, users.email, COUNT(like_res.user_id) AS 'Quantity Like'
FROM like_res
INNER JOIN user AS users ON like_res.user_id = users.user_id
GROUP BY like_res.user_id
ORDER BY `Quantity Like` DESC
LIMIT 5;
-- Tìm 2 nhà hàng có lượt like nhiều nhất.
SELECT restaurant.res_id, restaurant.res_name, COUNT(like_res.res_id) AS 'Quantity Like'
FROM like_res
INNER JOIN restaurant ON like_res.res_id = restaurant.res_id
GROUP BY like_res.res_id
ORDER BY `Quantity Like` DESC
LIMIT 2;
-- Tìm người đã đặt hàng nhiều nhất
SELECT users.user_id, users.full_name, users.email, COUNT(`order`.user_id) AS 'Quantity Order'
FROM `order`
INNER JOIN user AS users ON `order`.user_id = users.user_id
GROUP BY `order`.user_id
ORDER BY `Quantity Order` DESC
LIMIT 1;
-- Tìm người dùng không hoạt động trong hệ thống (không đặt hàng, không like, không đánh giá nhà hàng).
SELECT users.user_id, users.full_name, users.email 
FROM user AS users
LEFT JOIN `order` ON `order`.user_id = users.user_id
LEFT JOIN like_res ON like_res.user_id = users.user_id
LEFT JOIN rate_res ON rate_res.user_id = users.user_id
WHERE `order`.user_id IS NULL AND like_res.user_id IS NULL AND rate_res.user_id IS NULL;