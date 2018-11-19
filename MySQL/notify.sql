CREATE SCHEMA notify;
USE notify;

DROP TABLE IF EXISTS alert_normal;
DROP TABLE IF EXISTS alert_unusual;
DROP TABLE IF EXISTS condition_data;
DROP TABLE IF EXISTS twl_alert_data;

TRUNCATE alert_normal;
TRUNCATE alert_unusual;
TRUNCATE condition_data;

CREATE TABLE IF NOT EXISTS alert_normal (
  id    BIT(1)     NOT NULL,
  power BIT(1)     NOT NULL,
  beg   TINYINT(3) UNSIGNED NOT NULL,
  end   TINYINT(3) UNSIGNED NOT NULL,
  hour  TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
);

SELECT ord(id) id, ord(power) power, beg, end, hour FROM alert_normal;
UPDATE alert_normal SET beg = 18, end = 8 WHERE id = 0;
INSERT INTO alert_normal (id, power, beg, end, hour) VALUES (0, 1, 20, 8, 1);

CREATE TABLE IF NOT EXISTS alert_unusual (
  id    BIT(1)     NOT NULL,
  power BIT(1)     NOT NULL,
  beg   TINYINT(3) UNSIGNED NOT NULL,
  end   TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (id)
);

SELECT ord(id) id, ord(power) power, beg, end FROM alert_unusual;
UPDATE alert_unusual SET beg = 18, end = 8 WHERE id = 0;
INSERT INTO alert_unusual (id, power, beg, end) VALUES (0, 1, 20, 8);

CREATE TABLE IF NOT EXISTS condition_data (
  machineID VARCHAR(32) NOT NULL,
  machine   VARCHAR(32) NOT NULL,
  status    VARCHAR(9)  NOT NULL,
  hour      TINYINT(3)  UNSIGNED NOT NULL,
  content   VARCHAR(64) NOT NULL,
  grade     VARCHAR(6)	NOT NULL,
  enable    BIT(1)      NOT NULL,
  PRIMARY KEY (machineID, status)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT * FROM condition_data ;

INSERT INTO condition_data (machineID, machine, status, hour, content, grade, enable) VALUES
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "powerOff", 1, "請開機", "fatal", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "mqc", 1, "看不懂", "info", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "run", 1, "正常運作", "fatal", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "test", 1, "測試中", "info", 0),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "down", 1, "請相關人員協助加快處理", "warn", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "PM", 1, "請跟Pome簽專案", "info", 1),
("392ab930b7f211e882c191998dbe26ac", "_Machine_0", "off", 1, "停機中", "fatal", 1),
("3930d3b0b7f211e8b85491998dbe26ac", "_Machine_1", "powerOff", 1, "請開機", "fatal", 1),
("3930d3b0b7f211e8b85491998dbe26ac", "_Machine_1", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("3930d3b0b7f211e8b85491998dbe26ac", "_Machine_1", "run", 1, "正常運作", "error", 1),
("3930d3b0b7f211e8b85491998dbe26ac", "_Machine_1", "down", 1, "請相關人員協助加快處理", "warn", 1),
("39367900b7f211e88aaf91998dbe26ac", "_Machine_2", "powerOff", 1, "請開機", "fatal", 1),
("39367900b7f211e88aaf91998dbe26ac", "_Machine_2", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("39367900b7f211e88aaf91998dbe26ac", "_Machine_2", "run", 1, "正常運作", "warn", 1),
("39367900b7f211e88aaf91998dbe26ac", "_Machine_2", "down", 1, "請相關人員協助加快處理", "warn", 1),
("393bf740b7f211e8a00891998dbe26ac", "_Machine_3", "powerOff", 1, "請開機", "fatal", 1),
("393bf740b7f211e8a00891998dbe26ac", "_Machine_3", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("393bf740b7f211e8a00891998dbe26ac", "_Machine_3", "run", 1, "正常運作", "fatal", 1),
("393bf740b7f211e8a00891998dbe26ac", "_Machine_3", "down", 1, "請相關人員協助加快處理", "warn", 1),
("39410050b7f211e89a0091998dbe26ac", "_Machine_4", "powerOff", 1, "請開機", "fatal", 1),
("39410050b7f211e89a0091998dbe26ac", "_Machine_4", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("39410050b7f211e89a0091998dbe26ac", "_Machine_4", "run", 1, "正常運作", "error", 1),
("39410050b7f211e89a0091998dbe26ac", "_Machine_4", "down", 1, "請相關人員協助加快處理", "warn", 1),
("39467e90b7f211e886a191998dbe26ac", "_Machine_5", "powerOff", 1, "請開機", "fatal", 1),
("39467e90b7f211e886a191998dbe26ac", "_Machine_5", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("39467e90b7f211e886a191998dbe26ac", "_Machine_5", "run", 1, "正常運作", "warn", 1),
("39467e90b7f211e886a191998dbe26ac", "_Machine_5", "down", 1, "請相關人員協助加快處理", "warn", 1),
("394c23deb7f211e88da491998dbe26ac", "_Machine_6", "powerOff", 1, "請開機", "fatal", 1),
("394c23deb7f211e88da491998dbe26ac", "_Machine_6", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("394c23deb7f211e88da491998dbe26ac", "_Machine_6", "run", 1, "正常運作", "error", 1),
("394c23deb7f211e88da491998dbe26ac", "_Machine_6", "down", 1, "請相關人員協助加快處理", "warn", 1),
("3950b7c0b7f211e88dc191998dbe26ac", "_Machine_7", "powerOff", 1, "請開機", "fatal", 1),
("3950b7c0b7f211e88dc191998dbe26ac", "_Machine_7", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("3950b7c0b7f211e88dc191998dbe26ac", "_Machine_7", "run", 1, "正常運作", "error", 1),
("3950b7c0b7f211e88dc191998dbe26ac", "_Machine_7", "down", 1, "請相關人員協助加快處理", "warn", 1),
("39552490b7f211e8989891998dbe26ac", "_Machine_8", "powerOff", 1, "請開機", "fatal", 1),
("39552490b7f211e8989891998dbe26ac", "_Machine_8", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("39552490b7f211e8989891998dbe26ac", "_Machine_8", "run", 1, "正常運作", "error", 1),
("39552490b7f211e8989891998dbe26ac", "_Machine_8", "down", 1, "請相關人員協助加快處理", "warn", 1),
("39599162b7f211e8b87391998dbe26ac", "_Machine_9", "powerOff", 1, "請開機", "fatal", 1),
("39599162b7f211e8b87391998dbe26ac", "_Machine_9", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("39599162b7f211e8b87391998dbe26ac", "_Machine_9", "run", 1, "正常運作", "error", 1),
("39599162b7f211e8b87391998dbe26ac", "_Machine_9", "down", 1, "請相關人員協助加快處理", "warn", 1),
("395e4c50b7f211e8965f91998dbe26ac", "_Machine_10", "powerOff", 1, "請開機", "fatal", 1),
("395e4c50b7f211e8965f91998dbe26ac", "_Machine_10", "loss", 1, "產線主管某某某, 請加快補料生產", "error", 1),
("395e4c50b7f211e8965f91998dbe26ac", "_Machine_10", "run", 1, "正常運作", "error", 1),
("395e4c50b7f211e8965f91998dbe26ac", "_Machine_10", "down", 1, "請相關人員協助加快處理", "warn", 1);

CREATE TABLE IF NOT EXISTS twl_alert_data (
  machineID VARCHAR(32) NOT NULL,
  machine   VARCHAR(32) NOT NULL,
  time      CHAR(19)    NOT NULL,
  status    VARCHAR(9)  NOT NULL,
  PRIMARY KEY (machineID)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

INSERT INTO twl_alert_data (machineID, machine, time, status) VALUES
("a76aba7e6a1511e8ade20090fb5b34b3", "Machine_0",  "2018-08-10 09:51:38", "run"),
("a76aba846a1511e8ade20090fb5b34b3", "Machine_1",  "2018-08-10 10:01:05", "run"),
("a76aba8a6a1511e8ade20090fb5b34b3", "Machine_2",  "2018-08-10 10:01:05", "run"),
("a76aba906a1511e8ade20090fb5b34b3", "Machine_3",  "2018-08-10 10:00:02", "loss"),
("a76aba966a1511e8ade20090fb5b34b3", "Machine_4",  "2018-08-10 10:01:05", "loss"),
("a76aba9c6a1511e8ade20090fb5b34b3", "Machine_5",  "2018-08-10 10:01:05", "run"),
("a76abaa26a1511e8ade20090fb5b34b3", "Machine_6",  "2018-08-10 10:01:05", "powerOff"),
("a76abaa86a1511e8ade20090fb5b34b3", "Machine_7",  "2018-08-10 09:58:59", "run"),
("a76abaae6a1511e8ade20090fb5b34b3", "Machine_8",  "2018-08-10 10:00:02", "run"),
("a76abab46a1511e8ade20090fb5b34b3", "Machine_9",  "2018-08-10 10:01:05", "loss"),
("a76ababa6a1511e8ade20090fb5b34b3", "Machine_10", "2018-08-10 09:55:50", "run"),
("a76abac06a1511e8ade20090fb5b34b3", "Machine_11", "2018-08-10 10:01:05", "run"),
("a76abac66a1511e8ade20090fb5b34b3", "Machine_12", "2018-08-10 09:52:40", "run"),
("a76abacc6a1511e8ade20090fb5b34b3", "Machine_13", "2018-08-10 09:51:38", "run"),
("a76abad26a1511e8ade20090fb5b34b3", "Machine_14", "2018-08-10 09:58:59", "run"),
("a76abad86a1511e8ade20090fb5b34b3", "Machine_15", "2018-08-10 10:01:05", "powerOff"),
("a76abade6a1511e8ade20090fb5b34b3", "Machine_16", "2018-08-10 10:01:05", "down"),
("a76abae46a1511e8ade20090fb5b34b3", "Machine_17", "2018-08-10 09:57:55", "run"),
("a76abaea6a1511e8ade20090fb5b34b3", "Machine_18", "2018-08-10 09:57:55", "run"),
("a76abaf06a1511e8ade20090fb5b34b3", "Machine_19", "2018-08-10 10:00:02", "run"),
("a76abaf66a1511e8ade20090fb5b34b3", "Machine_20", "2018-08-10 09:56:53", "run");

CREATE TABLE IF NOT EXISTS twl_alert_grade (
  grade     VARCHAR(6)  NOT NULL,
  grade_nm  CHAR(4)     NOT NULL,
  color     CHAR(6)     NOT NULL,
  PRIMARY KEY (grade)
) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

SELECT * FROM twl_alert_grade;

INSERT IGNORE twl_alert_grade (grade, grade_nm, color) VALUES
("fatal", "嚴重異常",  "EDD4FF"),
("error", "中等錯誤",  "FFD4D4"),
("warn", "輕微警告",  "FFF0D4"),
("info", "系統訊息",  "E8E8E8"),
("period", "定時資訊",  "E8E8E8");