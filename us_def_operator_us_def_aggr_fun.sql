--Пользовательский оператор осуществляет поиск владельца, у которого есть грузовой автомобиль, 
--но нет легкового, путем выполнения запроса на разность. 
--На вход подаются две метки, в этом случае “грузовая” и “легковая”.
DROP FUNCTION find_owner_diff(type_car_place,type_car_place) cascade;

CREATE OR REPLACE FUNCTION find_owner_diff(fir type_car_place, sec type_car_place)
RETURNS TABLE(owner_surname varchar(40), owner_name varchar(40), owner_patronymic varchar(40)) AS $$
BEGIN
    RETURN QUERY
    SELECT o.owner_name, o.owner_surname, o.owner_patronymic
    FROM owner o
    JOIN car c ON o.owner_id = c.owner_id
    WHERE c.car_type = fir
    EXCEPT
    SELECT o.owner_name, o.owner_surname, o.owner_patronymic
    FROM owner o
    JOIN car c2 ON o.owner_id = c2.owner_id
    WHERE c2.car_type = sec;
END;
$$ LANGUAGE plpgsql;
---
CREATE OPERATOR -@ (
    LEFTARG = type_car_place,
    RIGHTARG = type_car_place,
    PROCEDURE = find_owner_diff
);

SELECT 'грузовая'::type_car_place -@ 'легковая'::type_car_place AS owners;

--------------------------------------------------------------------------
--Пользовательская агрегатная функция находит максимальное время выезда автомобиля с парковки.
DROP FUNCTION max_departure_time_fun(parking_time, parking_time) cascade;

CREATE OR REPLACE FUNCTION max_departure_time_fun(state parking_time, value parking_time)
RETURNS parking_time AS $$
BEGIN
    IF value.departure IS NULL THEN
        RETURN state;
    ELSE 
        IF state.departure IS NULL OR value.departure > state.departure THEN
            RETURN value;
        END IF;
        RETURN state;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE AGGREGATE max_departure_time (parking_time) (
    sfunc = max_departure_time_fun,
    stype = parking_time
);

SELECT max_departure_time(information)
FROM car_parking;
