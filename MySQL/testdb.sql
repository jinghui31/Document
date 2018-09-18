USE testdb;

DROP TABLE IF EXISTS sensor;
CREATE TABLE sensor (
    sensor_id VARCHAR(32),
    machine_id VARCHAR(32),
    type VARCHAR(16) NOT NULL
);

DROP TABLE IF EXISTS counter_data;
CREATE TABLE counter_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id VARCHAR(32) NOT NULL,
    work_order_id VARCHAR(32) NOT NULL,
    product_id VARCHAR(32) NOT NULL,
    datetime DATETIME NOT NULL,
    value INT NOT NULL
);

DROP TABLE IF EXISTS temperature_data;
CREATE TABLE temperature_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id VARCHAR(32) NOT NULL,
    datetime DATETIME NOT NULL,
    value decimal(5,2) NOT NULL
);

DROP TABLE IF EXISTS towerlight_data;
CREATE TABLE towerlight_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id VARCHAR(32) NOT NULL,
    datetime DATETIME NOT NULL,
    value char(8) NOT NULL
);

SELECT	s1.id, s1.dt, max(s1.value)
FROM	machine1_sensor1 s1
GROUP BY MINUTE(s1.dt), SECOND(s1.dt) div 5;

SELECT	s2.id, s2.dt, avg(s2.tpt)
FROM	machine1_sensor2 s2
GROUP BY MINUTE(s2.dt), SECOND(s2.dt) div 5;