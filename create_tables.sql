-------------------------------------------------------------------------------------
-- Удаление всех таблиц
DROP TABLE IF EXISTS place_freight, place_passenger, place_trailer, place, car_parking, parking, street, car, owner, brand;

-- Удаление всех типов
DROP TYPE IF EXISTS parking_time;
DROP TYPE IF EXISTS type_car_place;
-------------------------------------------------------------------------------------

-- Создание новых типов
CREATE TYPE parking_time AS (
arrival timestamp,
departure timestamp
);

CREATE TYPE type_car_place AS ENUM (
	'легковая','грузовая', 'с прицепом'
);

-- Создание новых таблиц
CREATE TABLE brand
(
	brand_id int PRIMARY KEY,
	brand_name varchar(30) UNIQUE
);

CREATE TABLE owner
(
	owner_id int PRIMARY KEY,
	owner_name varchar(40) NULL,
	owner_surname varchar(40) NULL,
	owner_patronymic varchar(40) DEFAULT NULL
);

CREATE TABLE car
(
	car_id int PRIMARY KEY,
	regNum varchar(9) NOT NULL,
	car_type type_car_place NOT NULL,
	brand_id integer NOT NULL,
	owner_id integer NOT NULL,
	FOREIGN KEY(brand_id) REFERENCES brand(brand_id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY(owner_id) REFERENCES owner(owner_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE street
(
	street_id int PRIMARY KEY,
	name varchar(40)UNIQUE NULL
);

CREATE TABLE parking
(
	parking_id int PRIMARY KEY,
	number int NULL,
	street_id integer NOT NULL,
	FOREIGN KEY(street_id) REFERENCES street(street_id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE car_parking
(
	car_parking_id int PRIMARY KEY,
	car_id integer NOT NULL,
	information parking_time NOT NULL,
	place_id int,
	FOREIGN KEY(car_id) REFERENCES car(car_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE place 
(
	place_id serial NOT NULL PRIMARY KEY,
	place_type type_car_place NOT NULL,
	number varchar(5) NOT NULL,
	repair boolean DEFAULT FALSE,
	parking_id int NOT NULL,
	FOREIGN KEY(parking_id) REFERENCES parking(parking_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE place_freight
(
	PRIMARY KEY (place_id),
	limit_weight int NOT NULL
) INHERITS (place);

CREATE TABLE place_passenger
(
	PRIMARY KEY (place_id),
	size_car varchar(12) NOT NULL
) INHERITS (place);

CREATE TABLE place_trailer
(
	PRIMARY KEY (place_id),
	size_trailer varchar(15) NOT NULL
) INHERITS (place);
