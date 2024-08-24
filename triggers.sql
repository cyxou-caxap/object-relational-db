-- Удаление триггера enforce_place_id_belongs_to_place
DROP TRIGGER IF EXISTS enforce_place_id_belongs_to_place ON car_parking;

-- Удаление триггера delete_cascade_from_child_tables_trigger
DROP TRIGGER IF EXISTS delete_cascade_from_child_tables_trigger ON place;

-- Удаление триггера update_place_id_in_car_parking_trigger
DROP TRIGGER IF EXISTS update_place_id_in_car_parking_trigger ON place;
-------------------------------------------------------------------------------------

---триггер на вставку и обновление car_parking, чтобы нельзя было вставить ключи, не
---принадлежащие place или её дочерним таблицам
CREATE OR REPLACE FUNCTION validate_place_id()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM place WHERE place_id = NEW.place_id) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'place_id должен принадлежать одной из таблиц place, place_freight, place_trailer или place_passenger';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER enforce_place_id_belongs_to_place
BEFORE INSERT OR UPDATE ON car_parking
FOR EACH ROW
EXECUTE FUNCTION validate_place_id();

-------------------------------------------------------------------------------------
---триггер на удаление данных из родительской таблицы
CREATE OR REPLACE FUNCTION delete_cascade_from_child_tables()
RETURNS TRIGGER AS $$
BEGIN
	-- Зануление place_id в car_parking
	UPDATE car_parking SET place_id = NULL WHERE place_id = OLD.place_id;
	
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_cascade_from_child_tables_trigger
BEFORE DELETE ON place
FOR EACH ROW
EXECUTE FUNCTION delete_cascade_from_child_tables();

-------------------------------------------------------------------------------------
--триггер на обновление ключа в родительской таблице
CREATE OR REPLACE FUNCTION update_place_id_in_car_parking()
RETURNS TRIGGER AS $$
BEGIN
    -- Обновление place_id в car_parking при обновлении place_id в place
    UPDATE car_parking SET place_id = NEW.place_id WHERE place_id = OLD.place_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_place_id_in_car_parking_trigger
BEFORE UPDATE OF place_id ON place
FOR EACH ROW
WHEN (OLD.place_id <> NEW.place_id)
EXECUTE FUNCTION update_place_id_in_car_parking();
