INSERT INTO brand (brand_id, brand_name) VALUES
(1, 'Lada'),
(2, 'Toyota'),
(3, 'BMW'),
(4, 'Mercedes'),
(5, 'Ford'),
(6, 'Porsche');

INSERT INTO owner (owner_id, owner_name, owner_surname, owner_patronymic) VALUES
(1, 'Иван', 'Иванов', 'Иванович'),
(2, 'Петр', 'Петров', 'Петрович'),
(3, 'Анна', 'Сидорова', NULL),
(4, 'Елена', 'Козлова', 'Алексеевна'),
(5, 'Александр', 'Смирнов', NULL),
(6, 'Полина', 'Великая', 'Евгеньевна');

INSERT INTO car (car_id, regNum, car_type, brand_id, owner_id) VALUES
(1, 'а123вс', 'легковая', 1, 1),
(2, 'в456де', 'легковая', 2, 2),
(3, 'с789фг', 'грузовая', 3, 3),
(4, 'д012хи', 'грузовая', 4, 4),
(5, 'е459ва', 'с прицепом', 5, 5),
(6, 'к100кк', 'с прицепом', 6, 6),
(7, 'е459ва', 'с прицепом', 5, 3),
(8, 'к100кк', 'легковая', 6, 4);

INSERT INTO street (street_id, name) VALUES
(1, 'Профсоюзная улица'),
(2, 'Ленинский проспект'),
(3, 'Невский проспект');

INSERT INTO parking (parking_id, number, street_id) VALUES
(1, 101, 1),
(2, 202, 2),
(3, 303, 3);

-- Добавление данных в таблицу place
INSERT INTO place (place_type, number, repair, parking_id) VALUES
('легковая', '101A', FALSE, 1),
('грузовая', '303C', TRUE, 3),
('с прицепом', '606F', FALSE, 3);

-- Добавление данных в таблицу place_freight
INSERT INTO place_freight (place_type, number, repair, parking_id, limit_weight) VALUES
('грузовая', '207G', FALSE, 3, 5000),
('грузовая', '808H', TRUE, 3, 7000);

-- Добавление данных в таблицу place_passenger
INSERT INTO place_passenger (place_type, number, repair, parking_id, size_car) VALUES
('легковая', '909I', FALSE, 2, 'стандартная'),
('легковая', '101J', TRUE, 1, 'компактная');

-- Добавление данных в таблицу place_trailer
INSERT INTO place_trailer (place_type, number, repair, parking_id, size_trailer) VALUES
('с прицепом', '202K', TRUE, 1, 'стандартный'),
('с прицепом', '303L', FALSE, 2, 'большой');

-- Добавление данных в таблицу car_parking
INSERT INTO car_parking (car_parking_id, car_id, information, place_id) VALUES
(1, 1, ('2024-03-27 08:00', '2024-03-27 12:00'), 1),
(2, 3, ('2024-03-27 10:30', '2024-03-27 14:45'), 2),
(3, 5, ('2024-03-27 09:15', '2024-03-27 11:30'), 3),
(4, 4, ('2024-03-27 11:00', '2024-03-27 16:00'), 4),
(5, 3, ('2024-03-28 13:45', '2024-03-28 17:30'), 5),
(6, 2, ('2024-03-27 18:30', '2024-03-27 23:30'), 6),
(7, 1, ('2024-03-28 11:00', '2024-03-28 16:00'), 7),
(8, 6, ('2024-03-27 13:45', '2024-03-27 17:30'), 8),
(9, 5, ('2024-03-28 18:30', '2024-03-28 23:30'), 9);
