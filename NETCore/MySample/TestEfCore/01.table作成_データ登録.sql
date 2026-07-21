-- カテゴリテーブル
CREATE TABLE Categories (
    CategoryId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL
);

-- 商品テーブル
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    CategoryId INT NOT NULL,
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- 初期データ
INSERT INTO Categories (Name) VALUES ('家電'), ('書籍');
INSERT INTO Products (Name, Price, CategoryId) VALUES ('4Kモニター', 45000, 1), ('C#入門書', 3200, 2);