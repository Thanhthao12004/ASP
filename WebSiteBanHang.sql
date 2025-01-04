-- ============================================
-- Tạo cơ sở dữ liệu nếu chưa tồn tại
-- ============================================
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'BanHang')
BEGIN
    CREATE DATABASE BanHang;
END
GO

-- Sử dụng cơ sở dữ liệu BanHang
USE BanHang;
GO

-- ============================================
-- Xóa bảng nếu đã tồn tại
-- ============================================

-- Brand
IF OBJECT_ID('Brand', 'U') IS NOT NULL
BEGIN
    DROP TABLE Brand;
END
GO

-- Category
IF OBJECT_ID('Category', 'U') IS NOT NULL
BEGIN
    DROP TABLE Category;
END
GO

-- Order
IF OBJECT_ID('Order', 'U') IS NOT NULL
BEGIN
    DROP TABLE [Order];
END
GO

-- User
IF OBJECT_ID('User', 'U') IS NOT NULL
BEGIN
    DROP TABLE User;
END
GO

-- Product
IF OBJECT_ID('Product', 'U') IS NOT NULL
BEGIN
    DROP TABLE Product;
END
GO

-- ============================================
-- Tạo bảng
-- ============================================

-- Brand
CREATE TABLE Brand (
    Id INT PRIMARY KEY IDENTITY(1,1), -- Khóa chính, tự động tăng
    Name NVARCHAR(100) NOT NULL,      -- Tên thương hiệu
    Avatar NVARCHAR(100),             -- Ảnh đại diện
    Slug VARCHAR(100),                -- Slug thân thiện với URL
    ShowOnHomePage BIT DEFAULT 0,     -- Hiển thị trên trang chủ (mặc định là 0)
    DisplayOrder INT DEFAULT 0,       -- Thứ tự hiển thị (mặc định là 0)
    CreatedOnUtc DATETIME DEFAULT GETUTCDATE(), -- Thời gian tạo (mặc định là thời gian hiện tại UTC)
    UpdatedOnUtc DATETIME NULL,       -- Thời gian cập nhật cuối
    Deleted BIT DEFAULT 0             -- Cờ xóa (mặc định là 0)
);
GO

-- Category
CREATE TABLE Category (
    Id INT PRIMARY KEY IDENTITY(1,1), -- Khóa chính, tự động tăng
    Name NVARCHAR(100) NOT NULL,      -- Tên danh mục
    Avatar NCHAR(100),                -- Ảnh đại diện
    Slug VARCHAR(100),                -- Slug thân thiện với URL
    ShowOnHomePage BIT DEFAULT 0,     -- Hiển thị trên trang chủ (mặc định là 0)
    DisplayOrder INT DEFAULT 0,       -- Thứ tự hiển thị (mặc định là 0)
    Deleted BIT DEFAULT 0,            -- Cờ xóa (mặc định là 0)
    CreatedOnUtc DATETIME DEFAULT GETUTCDATE(), -- Thời gian tạo (UTC)
    UpdatedOnUtc DATETIME NULL        -- Thời gian cập nhật cuối
);
GO

-- Order
CREATE TABLE [Order] (
    Id INT PRIMARY KEY IDENTITY(1,1), -- Khóa chính, tự động tăng
    Name NVARCHAR(100) NOT NULL,      -- Tên đơn hàng hoặc khách hàng
    ProductId INT NOT NULL,           -- Liên kết với sản phẩm
    Price FLOAT NOT NULL,             -- Giá
    Status INT DEFAULT 0,             -- Trạng thái (mặc định là 0)
    CreatedOnUtc DATETIME DEFAULT GETUTCDATE() -- Thời gian tạo (UTC)
);
GO

-- Product
CREATE TABLE Product (
    Id INT PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Avatar NCHAR(100),
    CategoryId INT NOT NULL,
    ShortDes NVARCHAR(100),
    FullDescription NVARCHAR(500),
    Price FLOAT,
    PriceDiscount FLOAT,
    TypeId INT,
    Slug VARCHAR(50),
    BrandId INT,
    Deleted BIT DEFAULT 0,
    ShowOnHomePage BIT DEFAULT 0,
    DisplayOrder INT,
    CreatedOnUtc DATETIME DEFAULT GETUTCDATE(),
    UpdatedOnUtc DATETIME
);

-- User
CREATE TABLE [User] (
    Id INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    IsAdmin BIT DEFAULT 0
);

-- ============================================
-- Thêm dữ liệu mẫu vào bảng Brand
-- ============================================

-- Brand
INSERT INTO Brand (Name, Avatar, Slug, ShowOnHomePage, DisplayOrder, CreatedOnUtc, UpdatedOnUtc, Deleted)
VALUES 
('Nike', 'nike-logo.png', 'nike', 1, 1, GETUTCDATE(), NULL, 0),
('Adidas', 'adidas-logo.png', 'adidas', 1, 2, GETUTCDATE(), NULL, 0),
('Puma', 'puma-logo.png', 'puma', 0, 3, GETUTCDATE(), NULL, 0),
('Reebok', 'reebok-logo.png', 'reebok', 1, 4, GETUTCDATE(), NULL, 0),
('New Balance', 'newbalance-logo.png', 'new-balance', 0, 5, GETUTCDATE(), NULL, 0);
GO

-- Category
INSERT INTO Category (Name, Avatar, Slug, ShowOnHomePage, DisplayOrder, Deleted, CreatedOnUtc, UpdatedOnUtc)
VALUES 
('Electronics', 'electronics.png', 'electronics', 1, 1, 0, GETUTCDATE(), NULL),
('Clothing', 'clothing.png', 'clothing', 1, 2, 0, GETUTCDATE(), NULL),
('Books', 'books.png', 'books', 0, 3, 0, GETUTCDATE(), NULL),
('Home Appliances', 'home-appliances.png', 'home-appliances', 1, 4, 0, GETUTCDATE(), NULL),
('Toys', 'toys.png', 'toys', 0, 5, 0, GETUTCDATE(), NULL);
GO

-- Product
INSERT INTO Product (Id, Name, Avatar, CategoryId, ShortDes, FullDescription, Price, PriceDiscount, TypeId, Slug, BrandId, Deleted, ShowOnHomePage, DisplayOrder, CreatedOnUtc, UpdatedOnUtc)
VALUES 
(1, N'Laptop Dell XPS 15', N'images/dell-xps-15.jpg', 1, 
    N'Máy tính xách tay cao cấp', 
    N'Laptop Dell XPS 15 với màn hình 4K cảm ứng, bộ xử lý Intel Core i7 thế hệ 12, RAM 16GB, SSD 512GB.', 
    2500.00, 2300.00, 1, 'laptop-dell-xps-15', 1, 0, 1, 1, GETUTCDATE(), NULL),

(2, N'Smartphone iPhone 15 Pro', N'images/iphone-15-pro.jpg', 2, 
    N'Điện thoại thông minh cao cấp', 
    N'iPhone 15 Pro được trang bị chip A17 Bionic mạnh mẽ, camera chính 48MP, thiết kế titan siêu nhẹ và khả năng chống nước IP68.', 
    1500.00, 1450.00, 2, 'iphone-15-pro', 2, 0, 1, 2, GETUTCDATE(), NULL),

(3, N'Tai nghe Sony WH-1000XM5', N'images/sony-wh-1000xm5.jpg', 3, 
    N'Tai nghe chống ồn tốt nhất', 
    N'Tai nghe Sony WH-1000XM5 với chất lượng âm thanh Hi-Res, hỗ trợ Bluetooth 5.2, thời lượng pin 30 giờ và chống ồn chủ động tiên tiến.', 
    400.00, 350.00, 3, 'sony-wh-1000xm5', 3, 0, 1, 3, GETUTCDATE(), NULL),

(4, N'TV LG OLED 55-inch', N'images/lg-oled-55.jpg', 4, 
    N'Tivi màn hình OLED', 
    N'Tivi LG OLED 55 inch với độ phân giải 4K sắc nét, hỗ trợ Dolby Vision, âm thanh Dolby Atmos và tích hợp hệ điều hành WebOS.', 
    1200.00, 1100.00, 4, 'lg-oled-55', 4, 0, 1, 4, GETUTCDATE(), NULL),

(5, N'Bàn phím cơ Keychron K6', N'images/keychron-k6.jpg', 5, 
    N'Bàn phím cơ không dây', 
    N'Bàn phím cơ Keychron K6 được trang bị switch Gateron, hỗ trợ kết nối Bluetooth/USB-C, đèn nền RGB và thiết kế nhỏ gọn phù hợp với mọi không gian làm việc.', 
    100.00, 90.00, 5, 'keychron-k6', 5, 0, 0, 5, GETUTCDATE(), NULL);


-- ============================================
-- Kiểm tra dữ liệu trong bảng Brand
-- ============================================
SELECT * FROM Brand;
SELECT * FROM Category;
SELECT * FROM [Order];
SELECT * FROM Product;
SELECT * FROM [User];
GO
