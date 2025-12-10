

-- 2. Создаём чистую базу заново
CREATE DATABASE TestDB;
GO

-- 3. Переключаемся на неё
USE TestDB;
GO

-- 4. Создаём таблицу Orders точно как в оригинальном Northwind
CREATE TABLE Orders
(
    OrderID         int IDENTITY(1000,1) NOT NULL PRIMARY KEY,
    CustomerID      nchar(5)             NULL,
    EmployeeID      int                  NULL,
    OrderDate       nvarchar(MAX)NULL,
    RequiredDate    nvarchar(MAX)NULL,
    ShippedDate     nvarchar(MAX)             NULL,
    ShipVia         int                  NULL,
    Freight         money                NULL CONSTRAINT DF_Orders_Freight DEFAULT (0),
    ShipName        nvarchar(40)         NULL,
    ShipAddress     nvarchar(60)         NULL,
    ShipCity        nvarchar(15)         NULL,
    ShipRegion      nvarchar(15)         NULL,
    ShipPostalCode  nvarchar(10)         NULL,
    ShipCountry     nvarchar(15)         NULL
);
GO

-- 5. Вставляем твои 11 строк (обновлённые даты + всё идеально влезает)
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry) VALUES
('VINET', 5, '2023-07-04', '2023-08-01', '2023-07-16', 3, 32.38,  N'Vins et alcools Chevalier',   N'59 rue de l''Abbaye',      N'Reims',       NULL,   N'51100',     N'France'),
('TOMSP', 6, '2023-07-05', '2023-08-16', '2023-07-10', 1, 11.61,  N'Toms Spezialit?ten',          N'Luisenstr. 48',            N'M?nster',     NULL,   N'44087',     N'Germany'),
('HANAR', 4, '2023-07-08', '2023-08-05', '2023-07-12', 2, 65.83,  N'Hanari Carnes',               N'Rua do Pa?o, 67',          N'Rio de Janeiro', N'RJ',  N'05454-876', N'Brazil'),
('VICTE', 3, '2023-08-15', '2023-09-12', NULL,         1, 41.34,  N'Victuailles en stock',        N'2, rue du Commerce',       N'Lyon',        NULL,   N'69004',     N'France'),
('SUPRD', 7, '2024-01-20', '2024-02-17', '2024-01-25', 2, 51.30,  N'Supr?mes d?lices',            N'Boulevard Tirou, 255',     N'Charleroi',   NULL,   N'B-6000',    N'Belgium'),
('MAGAA', 2, '2024-03-10', '2024-04-07', NULL,         3, 17.68,  N'Magazzini Alimentari Riuniti',N'Via Ludovico il Moro 22',  N'Bergamo',     NULL,   N'24100',     N'Italy'),
('EASTC', 1, '2024-08-10', '2024-09-07', '2024-08-15', 3, 83.93,  N'Eastern Connection',          N'35 King George',           N'London',      NULL,   N'WX3 6FW',   N'UK'),
('LAMAI', 8, '2025-01-05', '2025-02-02', '2025-01-10', 2, 78.45,  N'La maison d''Asie',           N'1 rue Alsace-Lorraine',    N'Toulouse',    NULL,   N'31000',     N'France'),
('WARTH', 4, '2025-06-15', '2025-07-13', NULL,         1, 120.00, N'Wartian Herkku',              N'Torikatu 38',              N'Oulu',        NULL,   N'90110',     N'Finland'),
('ALFKI', 9, '2025-12-01',   NULL,         NULL,         NULL, NULL,   N'Alfreds Futterkiste',         N'Obere Str. 57',            N'Berlin',      NULL,   N'12209',     N'Germany'),
('QUICK', 3, '2022-12-30', '2023-01-27', '2023-01-05', 2, 95.50,  N'QUICK-Stop',                  N'Taucherstra?e 10',         N'Cunewalde',   NULL,   N'01307',     N'Germany');
GO
