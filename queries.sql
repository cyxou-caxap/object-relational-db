---вывести места для легковых автомобилей (номер места, ид места)
--предок и потомок
SELECT p.number, p.place_id
FROM place p
WHERE p.place_type = 'легковая';

---места для грузовых машин до 5000 кг (номер места, ид места, максимальный вес)
--потомок
SELECT pf.number, pf.place_id, pf.limit_weight
FROM place_freight pf
WHERE pf.limit_weight <= 5000;

---места для автомобилей с прицепом любых размеров (нет ограничения на кузов) (номер места, ид места)
--предок
SELECT p.number, p.place_id 
FROM ONLY place p 
WHERE place_type='с прицепом';
