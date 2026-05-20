-- ============================================
-- Mall Seed Data Script
-- Password for all users: 123456
-- Admin password: admin123
-- ============================================

-- ============================================
-- 1. Users (30 records)
-- ============================================
INSERT INTO users (username, password, role, phone, status, created_at) VALUES
-- Buyers (10)
('buyer01', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000001', 1, '2026-01-10 10:00:00'),
('buyer02', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000002', 1, '2026-01-12 10:30:00'),
('buyer03', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000003', 1, '2026-01-15 14:20:00'),
('buyer04', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000004', 1, '2026-01-18 09:15:00'),
('buyer05', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000005', 1, '2026-02-01 11:00:00'),
('buyer06', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000006', 1, '2026-02-08 16:45:00'),
('buyer07', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000007', 1, '2026-02-15 08:30:00'),
('buyer08', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000008', 1, '2026-02-20 13:20:00'),
('buyer09', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000009', 1, '2026-03-01 10:10:00'),
('buyer10', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'BUYER', '13800000010', 1, '2026-03-05 15:50:00'),
-- Sellers (10)
('seller01', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000001', 1, '2026-01-05 09:00:00'),
('seller02', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000002', 1, '2026-01-08 11:30:00'),
('seller03', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000003', 1, '2026-01-14 14:00:00'),
('seller04', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000004', 1, '2026-01-20 10:45:00'),
('seller05', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000005', 1, '2026-02-01 08:15:00'),
('seller06', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000006', 1, '2026-02-06 16:30:00'),
('seller07', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000007', 1, '2026-02-12 12:00:00'),
('seller08', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000008', 1, '2026-02-18 09:30:00'),
('seller09', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000009', 1, '2026-02-25 14:20:00'),
('seller10', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'SELLER', '13900000010', 1, '2026-03-01 10:00:00');

-- Admin users (3)
INSERT INTO users (username, password, role, phone, status, created_at) VALUES
('admin', '$2b$10$ICp3rgpxWcOGvvKlvI/4f.JnDSbuHWGr9hkfgUSDnZYVn73wAy0p6', 'ADMIN', '13700000001', 1, '2025-12-01 00:00:00'),
('admin02', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'ADMIN', '13700000002', 1, '2025-12-15 09:00:00'),
('admin03', '$2b$10$xC0nAXw1WShtZ5Xid6CfkuBA7yqH9hmaQ9ZKIYA6LLtfe.X1Asdmu', 'ADMIN', '13700000003', 1, '2026-01-01 10:00:00');

-- ============================================
-- 2. User Addresses (40 records)
-- ============================================
INSERT INTO user_addresses (user_id, receiver_name, phone, province, city, district, detail, is_default, created_at) VALUES
-- buyer01 (3 addresses)
(1, '张三', '13800000001', '北京市', '北京市', '朝阳区', '建国路88号', 1, '2026-01-15 10:00:00'),
(1, '张三', '13800000001', '北京市', '北京市', '海淀区', '中关村大街1号', 0, '2026-02-01 14:00:00'),
(1, '李四', '13800000002', '上海市', '上海市', '浦东新区', '张江高科技园区', 0, '2026-02-15 09:30:00'),
-- buyer02 (3 addresses)
(2, '王五', '13800000003', '广东省', '广州市', '天河区', '天河路385号', 1, '2026-01-20 11:00:00'),
(2, '王五', '13800000003', '广东省', '深圳市', '南山区', '科技园路1号', 0, '2026-02-10 15:00:00'),
(2, '赵六', '13800000004', '广东省', '广州市', '越秀区', '中山五路100号', 0, '2026-03-01 10:00:00'),
-- buyer03 (4 addresses)
(3, '孙七', '13800000005', '浙江省', '杭州市', '西湖区', '文三路138号', 1, '2026-02-01 08:30:00'),
(3, '孙七', '13800000005', '浙江省', '杭州市', '滨江区', '江南大道100号', 0, '2026-02-20 13:00:00'),
(3, '孙七', '13800000005', '浙江省', '宁波市', '海曙区', '天一广场88号', 0, '2026-03-10 16:00:00'),
(3, '周八', '13800000006', '江苏省', '南京市', '鼓楼区', '汉中路200号', 0, '2026-03-20 10:00:00'),
-- buyer04 (3 addresses)
(4, '吴九', '13800000007', '四川省', '成都市', '武侯区', '天府大道999号', 1, '2026-02-10 09:00:00'),
(4, '吴九', '13800000007', '四川省', '成都市', '锦江区', '春熙路58号', 0, '2026-03-05 14:30:00'),
(4, '吴九', '13800000007', '重庆市', '重庆市', '渝北区', '新牌坊一路8号', 0, '2026-03-25 11:00:00'),
-- buyer05 (3 addresses)
(5, '郑十', '13800000008', '湖北省', '武汉市', '洪山区', '珞喻路1037号', 1, '2026-02-15 10:30:00'),
(5, '郑十', '13800000008', '湖北省', '武汉市', '江岸区', '建设大道700号', 0, '2026-03-08 15:00:00'),
(5, '郑十', '13800000008', '湖南省', '长沙市', '岳麓区', '麓山南路932号', 0, '2026-03-18 09:00:00'),
-- buyer06 (3 addresses)
(6, '冯十一', '13800000009', '陕西省', '西安市', '雁塔区', '长安中路65号', 1, '2026-02-20 11:00:00'),
(6, '冯十一', '13800000009', '陕西省', '西安市', '碑林区', '南大街22号', 0, '2026-03-12 14:00:00'),
(6, '冯十一', '13800000009', '甘肃省', '兰州市', '城关区', '天水南路222号', 0, '2026-03-28 10:00:00'),
-- buyer07 (2 addresses)
(7, '陈十二', '13800000010', '福建省', '福州市', '鼓楼区', '五四路158号', 1, '2026-02-25 08:30:00'),
(7, '陈十二', '13800000010', '福建省', '厦门市', '思明区', '鹭江道88号', 0, '2026-03-15 16:00:00'),
-- buyer08 (3 addresses)
(8, '褚十三', '13800000011', '安徽省', '合肥市', '蜀山区', '长江西路130号', 1, '2026-03-01 10:00:00'),
(8, '褚十三', '13800000011', '安徽省', '合肥市', '包河区', '马鞍山路150号', 0, '2026-03-20 13:00:00'),
(8, '褚十三', '13800000011', '河南省', '郑州市', '金水区', '花园路39号', 0, '2026-04-05 09:00:00'),
-- buyer09 (3 addresses)
(9, '卫十四', '13800000012', '山东省', '济南市', '历下区', '泉城路268号', 1, '2026-03-05 11:30:00'),
(9, '卫十四', '13800000012', '山东省', '青岛市', '市南区', '香港中路10号', 0, '2026-03-22 15:00:00'),
(9, '卫十四', '13800000012', '辽宁省', '大连市', '中山区', '人民路50号', 0, '2026-04-10 10:00:00'),
-- buyer10 (3 addresses)
(10, '蒋十五', '13800000013', '江西省', '南昌市', '东湖区', '八一大道357号', 1, '2026-03-10 09:00:00'),
(10, '蒋十五', '13800000013', '江西省', '南昌市', '红谷滩区', '赣江中大道688号', 0, '2026-03-25 14:00:00'),
(10, '蒋十五', '13800000013', '云南省', '昆明市', '五华区', '东风西路128号', 0, '2026-04-15 11:00:00'),
-- Extra addresses for variety (10 more)
(1, '沈十六', '13800000014', '天津市', '天津市', '和平区', '南京路188号', 0, '2026-04-01 10:00:00'),
(2, '韩十七', '13800000015', '河北省', '石家庄市', '长安区', '中山东路216号', 0, '2026-04-05 14:00:00'),
(3, '杨十八', '13800000016', '山西省', '太原市', '小店区', '长风街108号', 0, '2026-04-10 09:00:00'),
(4, '朱十九', '13800000017', '吉林省', '长春市', '朝阳区', '人民大街526号', 0, '2026-04-15 11:00:00'),
(5, '秦二十', '13800000018', '黑龙江省', '哈尔滨市', '南岗区', '果戈里大街378号', 0, '2026-04-20 15:00:00'),
(6, '尤二一', '13800000019', '贵州省', '贵阳市', '南明区', '中华南路28号', 0, '2026-04-25 10:00:00'),
(7, '许二二', '13800000020', '广西', '南宁市', '青秀区', '民族大道100号', 0, '2026-05-01 13:00:00'),
(8, '何二三', '13800000021', '海南省', '海口市', '龙华区', '海秀东路16号', 0, '2026-05-05 09:00:00');

-- ============================================
-- 3. Categories (20 records, 3-level tree)
-- ============================================
INSERT INTO categories (id, name, parent_id, sort_order, created_at) VALUES
-- Level 1
(1, '手机数码', 0, 1, '2026-01-01 00:00:00'),
(2, '电脑办公', 0, 2, '2026-01-01 00:00:00'),
(3, '服装鞋帽', 0, 3, '2026-01-01 00:00:00'),
(4, '食品生鲜', 0, 4, '2026-01-01 00:00:00'),
(5, '家居生活', 0, 5, '2026-01-01 00:00:00'),
(6, '运动户外', 0, 6, '2026-01-01 00:00:00'),
-- Level 2 under 手机数码
(7, '智能手机', 1, 1, '2026-01-01 00:00:00'),
(8, '手机配件', 1, 2, '2026-01-01 00:00:00'),
(9, '智能穿戴', 1, 3, '2026-01-01 00:00:00'),
-- Level 2 under 电脑办公
(10, '笔记本电脑', 2, 1, '2026-01-01 00:00:00'),
(11, '台式机', 2, 2, '2026-01-01 00:00:00'),
(12, '电脑外设', 2, 3, '2026-01-01 00:00:00'),
-- Level 2 under 服装鞋帽
(13, '男装', 3, 1, '2026-01-01 00:00:00'),
(14, '女装', 3, 2, '2026-01-01 00:00:00'),
(15, '鞋靴', 3, 3, '2026-01-01 00:00:00'),
-- Level 2 under 食品生鲜
(16, '休闲零食', 4, 1, '2026-01-01 00:00:00'),
(17, '生鲜水果', 4, 2, '2026-01-01 00:00:00'),
(18, '饮品冲调', 4, 3, '2026-01-01 00:00:00'),
-- Level 2 under 家居生活
(19, '家纺', 5, 1, '2026-01-01 00:00:00'),
(20, '厨房用品', 5, 2, '2026-01-01 00:00:00');

-- ============================================
-- 4. Products (60 records, ~6 per seller)
-- ============================================
INSERT INTO products (seller_id, category_id, name, description, price, stock, status, main_image, created_at) VALUES
-- seller01 - 手机数码 (6 products)
(11, 7, '华为Mate 70 Pro', '华为旗舰手机 麒麟芯片 卫星通信 512GB存储', 6999.00, 120, 'ON', 'https://placehold.co/400x400?text=Mate70', '2026-01-10 10:00:00'),
(11, 7, 'iPhone 16 Pro Max', 'Apple旗舰手机 A18芯片 钛金属边框 256GB', 9999.00, 80, 'ON', 'https://placehold.co/400x400?text=iPhone16', '2026-01-12 14:00:00'),
(11, 7, '小米15 Ultra', '徕卡影像 骁龙8Gen4 1TB存储 120W快充', 5999.00, 150, 'ON', 'https://placehold.co/400x400?text=Xiaomi15', '2026-01-18 09:00:00'),
(11, 8, '华为FreeBuds Pro 4', '主动降噪 空间音频 38小时续航', 1199.00, 200, 'ON', 'https://placehold.co/400x400?text=FreeBuds', '2026-02-01 11:00:00'),
(11, 9, 'Apple Watch Ultra 3', '钛金属表壳 全天候显示 潜水级防水', 6499.00, 60, 'ON', 'https://placehold.co/400x400?text=WatchUltra', '2026-02-15 15:00:00'),
(11, 8, 'Anker 200W氮化镓充电器', '6口快充 GaN技术 兼容笔记本和手机', 399.00, 300, 'ON', 'https://placehold.co/400x400?text=Anker200W', '2026-03-01 10:00:00'),

-- seller02 - 电脑办公 (6 products)
(12, 10, 'MacBook Pro 16 M4', 'Apple M4 Max芯片 64GB内存 2TB SSD Liquid Retina XDR', 27999.00, 40, 'ON', 'https://placehold.co/400x400?text=MacBookPro', '2026-01-15 10:00:00'),
(12, 10, 'ThinkPad X1 Carbon Gen 13', '联想商务旗舰 Ultra 9处理器 32GB 1TB', 12999.00, 55, 'ON', 'https://placehold.co/400x400?text=ThinkPadX1', '2026-01-22 14:00:00'),
(12, 10, 'ROG 枪神9 Plus', '游戏本 i9-14900HX RTX5090 32GB', 24999.00, 25, 'ON', 'https://placehold.co/400x400?text=ROG', '2026-02-05 09:00:00'),
(12, 11, '联想拯救者刃9000K', '台式游戏电脑 i7-14700KF RTX5080 32GB', 15999.00, 35, 'ON', 'https://placehold.co/400x400?text=LenovoDT', '2026-02-18 11:00:00'),
(12, 12, '罗技MX Master 4', '无线鼠标 电磁滚轮 8K DPI USB-C充电', 799.00, 180, 'ON', 'https://placehold.co/400x400?text=MXMaster4', '2026-03-05 15:00:00'),
(12, 12, 'Keychron Q3 Pro', '客制化机械键盘 Gasket结构 QMK/VIA热插拔', 899.00, 120, 'ON', 'https://placehold.co/400x400?text=Keychron', '2026-03-15 10:00:00'),

-- seller03 - 服装鞋帽 (6 products)
(13, 13, '海澜之家商务休闲西装', '羊毛混纺 修身版型 四季通勤 免烫处理', 599.00, 200, 'ON', 'https://placehold.co/400x400?text=Suit', '2026-01-20 10:00:00'),
(13, 13, '优衣库轻薄羽绒服', '90白鹅绒 日本进口面料 轻量便携 防风防水', 499.00, 300, 'ON', 'https://placehold.co/400x400?text=DownJacket', '2026-02-01 14:00:00'),
(13, 14, 'ZARA春季碎花连衣裙', '法式复古 收腰显瘦 雪纺面料 S-XXL', 359.00, 150, 'ON', 'https://placehold.co/400x400?text=Dress', '2026-02-20 09:00:00'),
(13, 14, 'COS简约通勤衬衫', '纯棉牛津纺 宽松版型 七分袖设计 多色可选', 459.00, 180, 'ON', 'https://placehold.co/400x400?text=COSShirt', '2026-03-01 11:00:00'),
(13, 15, 'NIKE Air Max 2026', '全掌气垫 飞织鞋面 React泡棉 男女同款', 999.00, 250, 'ON', 'https://placehold.co/400x400?text=AirMax', '2026-03-10 15:00:00'),
(13, 15, 'Adidas Ultraboost 26', '4D打印中底 Primeknit鞋面 Continental橡胶', 1199.00, 180, 'ON', 'https://placehold.co/400x400?text=Ultraboost', '2026-03-20 10:00:00'),

-- seller04 - 食品生鲜 (6 products)
(14, 16, '三只松鼠坚果大礼包', '每日坚果 6种混合 30袋独立包装 1850g', 128.00, 500, 'ON', 'https://placehold.co/400x400?text=Nuts', '2026-01-25 10:00:00'),
(14, 16, '良品铺子肉脯礼盒', '猪肉脯 牛肉干 卤味零食 12袋装', 89.00, 400, 'ON', 'https://placehold.co/400x400?text=Jerky', '2026-02-10 14:00:00'),
(14, 17, '智利车厘子JJJ级', '进口大樱桃 果径30mm+ 5斤原箱 顺丰冷链', 298.00, 200, 'ON', 'https://placehold.co/400x400?text=Cherry', '2026-02-28 09:00:00'),
(14, 17, '阳澄湖大闸蟹礼盒', '三两公蟹 二两母蟹 8只装 鲜活直达', 398.00, 100, 'ON', 'https://placehold.co/400x400?text=Crab', '2026-03-10 11:00:00'),
(14, 18, '星巴克咖啡豆 中度烘焙', '哥伦比亚单一产地 阿拉比卡 1kg装', 198.00, 150, 'ON', 'https://placehold.co/400x400?text=Starbucks', '2026-03-22 15:00:00'),
(14, 18, '西湖龙井明前特级', '2026新茶 狮峰山产区 250g礼盒装 送礼佳选', 888.00, 80, 'ON', 'https://placehold.co/400x400?text=Longjing', '2026-04-01 10:00:00'),

-- seller05 - 家居生活 (6 products)
(15, 19, '水星家纺 95白鹅绒被', '匈牙利进口鹅绒 1200g填充 220x240cm 保暖冬被', 1599.00, 80, 'ON', 'https://placehold.co/400x400?text=Duvet', '2026-02-01 10:00:00'),
(15, 19, '罗莱家纺四件套', '100支长绒棉 贡缎工艺 床单被套枕套 1.8m床', 899.00, 120, 'ON', 'https://placehold.co/400x400?text=Bedding', '2026-02-20 14:00:00'),
(15, 20, '双立人刀具套装', '德国进口 7件套 冰锻工艺 含刀架和磨刀棒', 1999.00, 60, 'ON', 'https://placehold.co/400x400?text=Zwilling', '2026-03-05 09:00:00'),
(15, 20, '苏泊尔IH电饭煲', '1300W IH电磁加热 4L容量 球釜内胆 24h预约', 699.00, 150, 'ON', 'https://placehold.co/400x400?text=Supor', '2026-03-18 11:00:00'),
(15, 19, 'MUJI 超声波香薰机', '静音设计 500ml大容量 4档定时 LED暖光夜灯', 299.00, 200, 'ON', 'https://placehold.co/400x400?text=MUJI', '2026-04-01 15:00:00'),
(15, 20, '象印保温杯 480ml', '日本制造 真空断热 超轻190g 保冷保热6小时', 279.00, 350, 'ON', 'https://placehold.co/400x400?text=Zojirushi', '2026-04-10 10:00:00'),

-- seller06 - 手机数码 (6 products)
(16, 7, 'OPPO Find X8 Pro', '哈苏影像 天玑9400 80W无线闪充 16GB+1TB', 4999.00, 100, 'ON', 'https://placehold.co/400x400?text=OPPO', '2026-02-12 10:00:00'),
(16, 7, 'vivo X200 Ultra', '蔡司2亿像素APO长焦 骁龙8Gen4 80W快充', 5499.00, 90, 'ON', 'https://placehold.co/400x400?text=vivoX200', '2026-02-25 14:00:00'),
(16, 9, '华为手环9 NFC版', '1.47寸AMOLED 14天续航 心率血氧监测', 329.00, 400, 'ON', 'https://placehold.co/400x400?text=Band9', '2026-03-08 09:00:00'),
(16, 8, '小米移动电源 20000mAh', '50W双向快充 USB-C*2 USB-A*1 LED数显', 199.00, 500, 'ON', 'https://placehold.co/400x400?text=PowerBank', '2026-03-20 11:00:00'),
(16, 8, 'Belkin MagSafe车载支架', '苹果认证 15W磁吸无线充 出风口/仪表台两用', 249.00, 300, 'ON', 'https://placehold.co/400x400?text=Belkin', '2026-04-05 15:00:00'),
(16, 7, '三星Galaxy S26 Ultra', '2亿像素主摄 S Pen 钛金属框架 12GB+512GB', 8999.00, 50, 'ON', 'https://placehold.co/400x400?text=GalaxyS26', '2026-04-15 10:00:00'),

-- seller07 - 电脑办公 (6 products)
(17, 10, '华为MateBook X Pro 2026', 'Ultra 9处理器 3.1K OLED触屏 980g超轻薄', 9999.00, 45, 'ON', 'https://placehold.co/400x400?text=MateBook', '2026-02-18 10:00:00'),
(17, 10, 'Dell XPS 17 2026', '13代i9 RTX5070 4K+触摸屏 32GB 可扩展', 18999.00, 30, 'ON', 'https://placehold.co/400x400?text=DellXPS', '2026-03-01 14:00:00'),
(17, 12, '罗技G Pro X 2无线耳机', 'LIGHTSPEED连接 50mm单元 20小时续航 电竞级', 1299.00, 90, 'ON', 'https://placehold.co/400x400?text=LogitechG', '2026-03-15 09:00:00'),
(17, 12, 'Dell S3222HG 32寸曲面显示器', '165Hz刷新 1ms响应 VA面板 FreeSync', 1899.00, 65, 'ON', 'https://placehold.co/400x400?text=DellMonitor', '2026-04-01 11:00:00'),
(17, 11, 'Apple Mac mini M4 Pro', '12核CPU 18核GPU 24GB统一内存 512GB SSD', 10999.00, 40, 'ON', 'https://placehold.co/400x400?text=MacMini', '2026-04-12 15:00:00'),
(17, 12, 'HHKB Professional HYBRID Type-S', '静电容键盘 蓝牙/有线双模 60键 PBT键帽', 2199.00, 55, 'ON', 'https://placehold.co/400x400?text=HHKB', '2026-04-20 10:00:00'),

-- seller08 - 运动户外 (6 products)
(18, 6, '始祖鸟Alpha SV夹克', 'N100d 3L GORE-TEX Pro 全天候防护 加/男', 8200.00, 25, 'ON', 'https://placehold.co/400x400?text=ArcTeryx', '2026-02-22 10:00:00'),
(18, 6, 'Lululemon Align瑜伽裤', 'Nulu面料 轻盈柔滑 25寸裤长 多色高腰', 550.00, 200, 'ON', 'https://placehold.co/400x400?text=Lululemon', '2026-03-05 14:00:00'),
(18, 6, '迪卡侬山地自行车XC100', '29寸轮径 Shimano Deore 12速 气叉 液压碟刹', 3999.00, 35, 'ON', 'https://placehold.co/400x400?text=Decathlon', '2026-03-18 09:00:00'),
(18, 6, '探路者户外帐篷3-4人', '一室一厅 自动速开 UPF50+ 防风防雨 露营套装', 1299.00, 70, 'ON', 'https://placehold.co/400x400?text=Tent', '2026-04-01 11:00:00'),
(18, 6, 'Keep智能跑步机C2', '静音马达 15档电动坡度 折叠收纳 支持Zwift', 2999.00, 40, 'ON', 'https://placehold.co/400x400?text=KeepTreadmill', '2026-04-10 15:00:00'),
(18, 6, 'YONEX羽毛球拍天斧100ZZ', '日本制 超细实心中杆 回转力生成系统 3U/4U', 1680.00, 60, 'ON', 'https://placehold.co/400x400?text=Yonex', '2026-04-18 10:00:00'),

-- seller09 - 食品生鲜 (6 products)
(19, 16, '稻香村京式月饼礼盒', '传统手工 8饼8味 800g双层铁盒 中秋送礼', 168.00, 300, 'ON', 'https://placehold.co/400x400?text=Mooncake', '2026-03-01 10:00:00'),
(19, 17, '进口澳洲牛排套餐', '安格斯M3西冷+眼肉 10片装 含黑胡椒酱', 258.00, 150, 'ON', 'https://placehold.co/400x400?text=Steak', '2026-03-15 14:00:00'),
(19, 17, '烟台红富士苹果12斤', '栖霞产区 果径80mm+ 脆甜多汁 坏果包赔', 59.90, 600, 'ON', 'https://placehold.co/400x400?text=Apple', '2026-03-28 09:00:00'),
(19, 18, '三顿半精品咖啡64颗', '冷萃超即溶 中深烘焙 3秒速溶 数字系列', 219.00, 180, 'ON', 'https://placehold.co/400x400?text=Saturnbird', '2026-04-05 11:00:00'),
(19, 18, '认养一头牛纯牛奶24盒', '全脂灭菌乳 250ml*24 自有牧场 3.3g乳蛋白', 69.90, 800, 'ON', 'https://placehold.co/400x400?text=Milk', '2026-04-15 15:00:00'),
(19, 16, '沃隆每日坚果混合果仁', '6种坚果果干 25g*30袋 无添加 孕妇儿童零食', 139.00, 400, 'ON', 'https://placehold.co/400x400?text=Wolong', '2026-04-25 10:00:00'),

-- seller10 - 家居生活 (6 products)
(20, 5, '戴森V16无线吸尘器', '数字马达 激光探测 60分钟续航 整机HEPA过滤', 4990.00, 55, 'ON', 'https://placehold.co/400x400?text=Dyson', '2026-03-10 10:00:00'),
(20, 5, '艾美特空气循环扇', '直流变频 32档调速 12米远送风 静音26dB', 599.00, 120, 'ON', 'https://placehold.co/400x400?text=Airmate', '2026-03-22 14:00:00'),
(20, 20, '松下蒸烤箱NU-SC300B', '30L 直喷蒸汽 烧烤一体 77道自动菜单', 3599.00, 40, 'ON', 'https://placehold.co/400x400?text=Panasonic', '2026-04-01 09:00:00'),
(20, 19, '网易严选乳胶床垫', '泰国进口天然乳胶 5cm厚度 7区独立支撑 1.8m', 1299.00, 90, 'ON', 'https://placehold.co/400x400?text=Mattress', '2026-04-10 11:00:00'),
(20, 20, '康宁餐具18件套', '耐热玻璃 可微波烤箱 不易残留气味 4人份', 499.00, 160, 'ON', 'https://placehold.co/400x400?text=Corning', '2026-04-20 15:00:00'),
(20, 5, '小米米家智能门锁2 Pro', '3D人脸识别 指纹密码 远程开锁 全自动锁体', 1699.00, 70, 'ON', 'https://placehold.co/400x400?text=MiLock', '2026-05-01 10:00:00');

-- ============================================
-- 5. Product Images (120 records, 1-3 per product)
-- ============================================
INSERT INTO product_images (product_id, image_url, sort_order) VALUES
-- Product 1 images
(1, 'https://placehold.co/800x800?text=Mate70-1', 1),
(1, 'https://placehold.co/800x800?text=Mate70-2', 2),
(1, 'https://placehold.co/800x800?text=Mate70-3', 3),
-- Product 2
(2, 'https://placehold.co/800x800?text=iPhone16-1', 1),
(2, 'https://placehold.co/800x800?text=iPhone16-2', 2),
-- Product 3
(3, 'https://placehold.co/800x800?text=Xiaomi15-1', 1),
(3, 'https://placehold.co/800x800?text=Xiaomi15-2', 2),
(3, 'https://placehold.co/800x800?text=Xiaomi15-3', 3),
-- Product 4
(4, 'https://placehold.co/800x800?text=FreeBuds-1', 1),
(4, 'https://placehold.co/800x800?text=FreeBuds-2', 2),
-- Product 5
(5, 'https://placehold.co/800x800?text=WatchUltra-1', 1),
(5, 'https://placehold.co/800x800?text=WatchUltra-2', 2),
-- Product 6
(6, 'https://placehold.co/800x800?text=Anker-1', 1),
-- Product 7
(7, 'https://placehold.co/800x800?text=MacBook-1', 1),
(7, 'https://placehold.co/800x800?text=MacBook-2', 2),
(7, 'https://placehold.co/800x800?text=MacBook-3', 3),
-- Product 8
(8, 'https://placehold.co/800x800?text=ThinkPad-1', 1),
(8, 'https://placehold.co/800x800?text=ThinkPad-2', 2),
-- Product 9
(9, 'https://placehold.co/800x800?text=ROG-1', 1),
(9, 'https://placehold.co/800x800?text=ROG-2', 2),
-- Product 10
(10, 'https://placehold.co/800x800?text=LenovoDT-1', 1),
-- Product 11
(11, 'https://placehold.co/800x800?text=MXMaster-1', 1),
(11, 'https://placehold.co/800x800?text=MXMaster-2', 2),
-- Product 12
(12, 'https://placehold.co/800x800?text=Keychron-1', 1),
(12, 'https://placehold.co/800x800?text=Keychron-2', 2),
-- Product 13
(13, 'https://placehold.co/800x800?text=Suit-1', 1),
(13, 'https://placehold.co/800x800?text=Suit-2', 2),
-- Product 14
(14, 'https://placehold.co/800x800?text=DownJacket-1', 1),
-- Product 15
(15, 'https://placehold.co/800x800?text=Dress-1', 1),
(15, 'https://placehold.co/800x800?text=Dress-2', 2),
(15, 'https://placehold.co/800x800?text=Dress-3', 3),
-- Product 16
(16, 'https://placehold.co/800x800?text=COSShirt-1', 1),
-- Product 17
(17, 'https://placehold.co/800x800?text=AirMax-1', 1),
(17, 'https://placehold.co/800x800?text=AirMax-2', 2),
-- Product 18
(18, 'https://placehold.co/800x800?text=Ultraboost-1', 1),
(18, 'https://placehold.co/800x800?text=Ultraboost-2', 2),
-- Continue for remaining products
(19, 'https://placehold.co/800x800?text=Nuts-1', 1),
(20, 'https://placehold.co/800x800?text=Jerky-1', 1),
(20, 'https://placehold.co/800x800?text=Jerky-2', 2),
(21, 'https://placehold.co/800x800?text=Cherry-1', 1),
(22, 'https://placehold.co/800x800?text=Crab-1', 1),
(23, 'https://placehold.co/800x800?text=Starbucks-1', 1),
(24, 'https://placehold.co/800x800?text=Longjing-1', 1),
(24, 'https://placehold.co/800x800?text=Longjing-2', 2),
(25, 'https://placehold.co/800x800?text=Duvet-1', 1),
(26, 'https://placehold.co/800x800?text=Bedding-1', 1),
(26, 'https://placehold.co/800x800?text=Bedding-2', 2),
(27, 'https://placehold.co/800x800?text=Zwilling-1', 1),
(28, 'https://placehold.co/800x800?text=Supor-1', 1),
(29, 'https://placehold.co/800x800?text=MUJI-1', 1),
(30, 'https://placehold.co/800x800?text=Zojirushi-1', 1),
(31, 'https://placehold.co/800x800?text=OPPO-1', 1),
(31, 'https://placehold.co/800x800?text=OPPO-2', 2),
(32, 'https://placehold.co/800x800?text=vivoX200-1', 1),
(33, 'https://placehold.co/800x800?text=Band9-1', 1),
(34, 'https://placehold.co/800x800?text=PowerBank-1', 1),
(35, 'https://placehold.co/800x800?text=Belkin-1', 1),
(36, 'https://placehold.co/800x800?text=GalaxyS26-1', 1),
(36, 'https://placehold.co/800x800?text=GalaxyS26-2', 2),
(37, 'https://placehold.co/800x800?text=MateBook-1', 1),
(37, 'https://placehold.co/800x800?text=MateBook-2', 2),
(38, 'https://placehold.co/800x800?text=DellXPS-1', 1),
(39, 'https://placehold.co/800x800?text=LogitechG-1', 1),
(40, 'https://placehold.co/800x800?text=DellMonitor-1', 1),
(41, 'https://placehold.co/800x800?text=MacMini-1', 1),
(42, 'https://placehold.co/800x800?text=HHKB-1', 1),
(42, 'https://placehold.co/800x800?text=HHKB-2', 2),
(43, 'https://placehold.co/800x800?text=ArcTeryx-1', 1),
(43, 'https://placehold.co/800x800?text=ArcTeryx-2', 2),
(44, 'https://placehold.co/800x800?text=Lululemon-1', 1),
(44, 'https://placehold.co/800x800?text=Lululemon-2', 2),
(45, 'https://placehold.co/800x800?text=Decathlon-1', 1),
(46, 'https://placehold.co/800x800?text=Tent-1', 1),
(47, 'https://placehold.co/800x800?text=KeepTreadmill-1', 1),
(48, 'https://placehold.co/800x800?text=Yonex-1', 1),
(49, 'https://placehold.co/800x800?text=Mooncake-1', 1),
(50, 'https://placehold.co/800x800?text=Steak-1', 1),
(51, 'https://placehold.co/800x800?text=Apple-1', 1),
(52, 'https://placehold.co/800x800?text=Saturnbird-1', 1),
(53, 'https://placehold.co/800x800?text=Milk-1', 1),
(54, 'https://placehold.co/800x800?text=Wolong-1', 1),
(55, 'https://placehold.co/800x800?text=Dyson-1', 1),
(55, 'https://placehold.co/800x800?text=Dyson-2', 2),
(56, 'https://placehold.co/800x800?text=Airmate-1', 1),
(57, 'https://placehold.co/800x800?text=Panasonic-1', 1),
(58, 'https://placehold.co/800x800?text=Mattress-1', 1),
(59, 'https://placehold.co/800x800?text=Corning-1', 1),
(60, 'https://placehold.co/800x800?text=MiLock-1', 1),
(60, 'https://placehold.co/800x800?text=MiLock-2', 2);

-- ============================================
-- 6. Orders (50 records, mixed statuses)
-- ============================================
INSERT INTO orders (order_no, buyer_id, seller_id, total_amount, status, address_snapshot, created_at) VALUES
-- buyer01 orders
('20260110120001a1b2c3', 1, 11, 6999.00, 'RECEIVED', '{"receiverName":"张三","phone":"13800000001","address":"北京市朝阳区建国路88号"}', '2026-01-10 12:00:00'),
('20260115150002d4e5f6', 1, 11, 5999.00, 'RECEIVED', '{"receiverName":"张三","phone":"13800000001","address":"北京市海淀区中关村大街1号"}', '2026-01-15 15:00:00'),
('20260220100003g7h8i9', 1, 12, 27999.00, 'SHIPPED', '{"receiverName":"李四","phone":"13800000002","address":"上海市浦东新区张江高科技园区"}', '2026-02-20 10:00:00'),
('20260301140004j0k1l2', 1, 14, 128.00, 'PAID', '{"receiverName":"张三","phone":"13800000001","address":"北京市朝阳区建国路88号"}', '2026-03-01 14:00:00'),
('20260410090005m3n4o5', 1, 15, 1599.00, 'PENDING', '{"receiverName":"沈十六","phone":"13800000014","address":"天津市和平区南京路188号"}', '2026-04-10 09:00:00'),

-- buyer02 orders
('20260120110006p6q7r8', 2, 11, 9999.00, 'RECEIVED', '{"receiverName":"王五","phone":"13800000003","address":"广东省广州市天河区天河路385号"}', '2026-01-20 11:00:00'),
('20260210080007s9t0u1', 2, 13, 599.00, 'RECEIVED', '{"receiverName":"赵六","phone":"13800000004","address":"广东省广州市越秀区中山五路100号"}', '2026-02-10 08:00:00'),
('20260308160008v2w3x4', 2, 16, 4999.00, 'SHIPPED', '{"receiverName":"王五","phone":"13800000003","address":"广东省深圳市南山区科技园路1号"}', '2026-03-08 16:00:00'),
('20260420090009y5z6a7', 2, 19, 168.00, 'PAID', '{"receiverName":"王五","phone":"13800000003","address":"广东省广州市天河区天河路385号"}', '2026-04-20 09:00:00'),
('20260501150010b8c9d0', 2, 20, 4990.00, 'PENDING', '{"receiverName":"韩十七","phone":"13800000015","address":"河北省石家庄市长安区中山东路216号"}', '2026-05-01 15:00:00'),

-- buyer03 orders
('20260201110011e1f2g3', 3, 12, 12999.00, 'RECEIVED', '{"receiverName":"孙七","phone":"13800000005","address":"浙江省杭州市西湖区文三路138号"}', '2026-02-01 11:00:00'),
('20260220100012h4i5j6', 3, 14, 298.00, 'RECEIVED', '{"receiverName":"孙七","phone":"13800000005","address":"浙江省杭州市滨江区江南大道100号"}', '2026-02-20 10:00:00'),
('20260315140013k7l8m9', 3, 17, 2199.00, 'RECEIVED', '{"receiverName":"周八","phone":"13800000006","address":"江苏省南京市鼓楼区汉中路200号"}', '2026-03-15 14:00:00'),
('20260401090014n0o1p2', 3, 19, 59.90, 'SHIPPED', '{"receiverName":"孙七","phone":"13800000005","address":"浙江省宁波市海曙区天一广场88号"}', '2026-04-01 09:00:00'),
('20260505110015q3r4s5', 3, 11, 1199.00, 'PAID', '{"receiverName":"孙七","phone":"13800000005","address":"浙江省杭州市西湖区文三路138号"}', '2026-05-05 11:00:00'),

-- buyer04 orders
('20260210120016t6u7v8', 4, 13, 499.00, 'RECEIVED', '{"receiverName":"吴九","phone":"13800000007","address":"四川省成都市武侯区天府大道999号"}', '2026-02-10 12:00:00'),
('20260308100017w9x0y1', 4, 15, 899.00, 'RECEIVED', '{"receiverName":"吴九","phone":"13800000007","address":"四川省成都市锦江区春熙路58号"}', '2026-03-08 10:00:00'),
('20260328150018z2a3b4', 4, 18, 8200.00, 'SHIPPED', '{"receiverName":"吴九","phone":"13800000007","address":"重庆市渝北区新牌坊一路8号"}', '2026-03-28 15:00:00'),
('20260418090019c5d6e7', 4, 20, 1299.00, 'PAID', '{"receiverName":"朱十九","phone":"13800000017","address":"吉林省长春市朝阳区人民大街526号"}', '2026-04-18 09:00:00'),
('20260503160020f8g9h0', 4, 16, 5499.00, 'PENDING', '{"receiverName":"吴九","phone":"13800000007","address":"四川省成都市武侯区天府大道999号"}', '2026-05-03 16:00:00'),

-- buyer05 orders
('20260215080021i1j2k3', 5, 12, 24999.00, 'RECEIVED', '{"receiverName":"郑十","phone":"13800000008","address":"湖北省武汉市洪山区珞喻路1037号"}', '2026-02-15 08:00:00'),
('20260312150022l4m5n6', 5, 14, 398.00, 'CANCELLED', '{"receiverName":"郑十","phone":"13800000008","address":"湖北省武汉市江岸区建设大道700号"}', '2026-03-12 15:00:00'),
('20260405110023o7p8q9', 5, 17, 9999.00, 'RECEIVED', '{"receiverName":"秦二十","phone":"13800000018","address":"黑龙江省哈尔滨市南岗区果戈里大街378号"}', '2026-04-05 11:00:00'),
('20260425140024r0s1t2', 5, 18, 550.00, 'SHIPPED', '{"receiverName":"郑十","phone":"13800000008","address":"湖南省长沙市岳麓区麓山南路932号"}', '2026-04-25 14:00:00'),
('20260502100025u3v4w5', 5, 19, 258.00, 'PENDING', '{"receiverName":"郑十","phone":"13800000008","address":"湖北省武汉市洪山区珞喻路1037号"}', '2026-05-02 10:00:00'),

-- buyer06 orders
('20260301150026x6y7z8', 6, 11, 399.00, 'RECEIVED', '{"receiverName":"冯十一","phone":"13800000009","address":"陕西省西安市雁塔区长安中路65号"}', '2026-03-01 15:00:00'),
('20260320100027a9b0c1', 6, 13, 359.00, 'SHIPPED', '{"receiverName":"冯十一","phone":"13800000009","address":"陕西省西安市碑林区南大街22号"}', '2026-03-20 10:00:00'),
('20260408140028d2e3f4', 6, 16, 329.00, 'RECEIVED', '{"receiverName":"冯十一","phone":"13800000009","address":"甘肃省兰州市城关区天水南路222号"}', '2026-04-08 14:00:00'),
('20260430090029g5h6i7', 6, 20, 1699.00, 'PAID', '{"receiverName":"尤二一","phone":"13800000019","address":"贵州省贵阳市南明区中华南路28号"}', '2026-04-30 09:00:00'),

-- buyer07 orders
('20260310110030j8k9l0', 7, 12, 15999.00, 'RECEIVED', '{"receiverName":"陈十二","phone":"13800000010","address":"福建省福州市鼓楼区五四路158号"}', '2026-03-10 11:00:00'),
('20260328160031m1n2o3', 7, 15, 299.00, 'PAID', '{"receiverName":"陈十二","phone":"13800000010","address":"福建省厦门市思明区鹭江道88号"}', '2026-03-28 16:00:00'),
('20260410100032p4q5r6', 7, 17, 1299.00, 'RECEIVED', '{"receiverName":"许二二","phone":"13800000020","address":"广西南宁市青秀区民族大道100号"}', '2026-04-10 10:00:00'),
('20260428080033s7t8u9', 7, 19, 219.00, 'SHIPPED', '{"receiverName":"陈十二","phone":"13800000010","address":"福建省福州市鼓楼区五四路158号"}', '2026-04-28 08:00:00'),

-- buyer08 orders
('20260315090034v0w1x2', 8, 13, 999.00, 'RECEIVED', '{"receiverName":"褚十三","phone":"13800000011","address":"安徽省合肥市蜀山区长江西路130号"}', '2026-03-15 09:00:00'),
('20260330110035y3z4a5', 8, 14, 89.00, 'CANCELLED', '{"receiverName":"褚十三","phone":"13800000011","address":"安徽省合肥市包河区马鞍山路150号"}', '2026-03-30 11:00:00'),
('20260415150036b6c7d8', 8, 18, 3999.00, 'RECEIVED', '{"receiverName":"何二三","phone":"13800000021","address":"海南省海口市龙华区海秀东路16号"}', '2026-04-15 15:00:00'),
('20260504140037e9f0g1', 8, 20, 599.00, 'PAID', '{"receiverName":"褚十三","phone":"13800000011","address":"河南省郑州市金水区花园路39号"}', '2026-05-04 14:00:00'),

-- buyer09 orders
('20260320140038h2i3j4', 9, 11, 6499.00, 'RECEIVED', '{"receiverName":"卫十四","phone":"13800000012","address":"山东省济南市历下区泉城路268号"}', '2026-03-20 14:00:00'),
('20260405090039k5l6m7', 9, 16, 199.00, 'SHIPPED', '{"receiverName":"卫十四","phone":"13800000012","address":"山东省青岛市市南区香港中路10号"}', '2026-04-05 09:00:00'),
('20260420160040n8o9p0', 9, 17, 1899.00, 'RECEIVED', '{"receiverName":"卫十四","phone":"13800000012","address":"辽宁省大连市中山区人民路50号"}', '2026-04-20 16:00:00'),
('20260505100041q1r2s3', 9, 19, 69.90, 'PENDING', '{"receiverName":"卫十四","phone":"13800000012","address":"山东省济南市历下区泉城路268号"}', '2026-05-05 10:00:00'),

-- buyer10 orders
('20260325150042t4u5v6', 10, 15, 1999.00, 'RECEIVED', '{"receiverName":"蒋十五","phone":"13800000013","address":"江西省南昌市东湖区八一大道357号"}', '2026-03-25 15:00:00'),
('20260412080043w7x8y9', 10, 16, 5499.00, 'PAID', '{"receiverName":"蒋十五","phone":"13800000013","address":"江西省南昌市红谷滩区赣江中大道688号"}', '2026-04-12 08:00:00'),
('20260426140044z0a1b2', 10, 18, 1299.00, 'RECEIVED', '{"receiverName":"蒋十五","phone":"13800000013","address":"云南省昆明市五华区东风西路128号"}', '2026-04-26 14:00:00'),
('20260503100045c3d4e5', 10, 20, 499.00, 'SHIPPED', '{"receiverName":"蒋十五","phone":"13800000013","address":"江西省南昌市东湖区八一大道357号"}', '2026-05-03 10:00:00'),
-- Extra orders for more data
('20260506160046f6g7h8', 1, 17, 10999.00, 'PENDING', '{"receiverName":"张三","phone":"13800000001","address":"北京市朝阳区建国路88号"}', '2026-05-06 16:00:00'),
('20260507090047i9j0k1', 3, 18, 1680.00, 'PENDING', '{"receiverName":"孙七","phone":"13800000005","address":"浙江省杭州市西湖区文三路138号"}', '2026-05-07 09:00:00'),
('20260508110048l2m3n4', 5, 13, 459.00, 'PENDING', '{"receiverName":"郑十","phone":"13800000008","address":"湖北省武汉市洪山区珞喻路1037号"}', '2026-05-08 11:00:00'),
('20260509140049o5p6q7', 7, 14, 198.00, 'PENDING', '{"receiverName":"陈十二","phone":"13800000010","address":"福建省福州市鼓楼区五四路158号"}', '2026-05-09 14:00:00'),
('20260510150050r8s9t0', 9, 12, 799.00, 'PENDING', '{"receiverName":"卫十四","phone":"13800000012","address":"山东省济南市历下区泉城路268号"}', '2026-05-10 15:00:00');

-- ============================================
-- 7. Order Items (80 records)
-- ============================================
INSERT INTO order_items (order_id, product_id, product_name_snapshot, price_snapshot, quantity) VALUES
-- Order 1: buyer01 buys Huawei Mate70 Pro
(1, 1, '华为Mate 70 Pro', 6999.00, 1),
-- Order 2: buyer01 buys Xiaomi 15 Ultra
(2, 3, '小米15 Ultra', 5999.00, 1),
-- Order 3: buyer01 buys MacBook Pro
(3, 7, 'MacBook Pro 16 M4', 27999.00, 1),
-- Order 4: buyer01 buys 三只松鼠 + 良品铺子
(4, 19, '三只松鼠坚果大礼包', 128.00, 2),
(4, 20, '良品铺子肉脯礼盒', 89.00, 1),
-- Order 5: buyer01 buys 水星家纺
(5, 25, '水星家纺 95白鹅绒被', 1599.00, 1),
-- Order 6: buyer02 buys iPhone
(6, 2, 'iPhone 16 Pro Max', 9999.00, 1),
-- Order 7: buyer02 buys 海澜之家西装
(7, 13, '海澜之家商务休闲西装', 599.00, 1),
-- Order 8: buyer02 buys OPPO Find X8 Pro
(8, 31, 'OPPO Find X8 Pro', 4999.00, 1),
-- Order 9: buyer02 buys 稻香村月饼 + 三顿半咖啡
(9, 49, '稻香村京式月饼礼盒', 168.00, 2),
(9, 52, '三顿半精品咖啡64颗', 219.00, 1),
-- Order 10: buyer02 buys Dyson吸尘器
(10, 55, '戴森V16无线吸尘器', 4990.00, 1),
-- Order 11: buyer03 buys ThinkPad
(11, 8, 'ThinkPad X1 Carbon Gen 13', 12999.00, 1),
-- Order 12: buyer03 buys 车厘子
(12, 21, '智利车厘子JJJ级', 298.00, 1),
-- Order 13: buyer03 buys HHKB键盘
(13, 42, 'HHKB Professional HYBRID Type-S', 2199.00, 1),
-- Order 14: buyer03 buys 烟台苹果
(14, 51, '烟台红富士苹果12斤', 59.90, 2),
-- Order 15: buyer03 buys 华为FreeBuds
(15, 4, '华为FreeBuds Pro 4', 1199.00, 1),
-- Order 16: buyer04 buys 优衣库羽绒服
(16, 14, '优衣库轻薄羽绒服', 499.00, 1),
-- Order 17: buyer04 buys 罗莱家纺四件套
(17, 26, '罗莱家纺四件套', 899.00, 1),
-- Order 18: buyer04 buys 始祖鸟夹克
(18, 43, '始祖鸟Alpha SV夹克', 8200.00, 1),
-- Order 19: buyer04 buys 网易乳胶床垫
(19, 58, '网易严选乳胶床垫', 1299.00, 1),
-- Order 20: buyer04 buys vivo X200
(20, 32, 'vivo X200 Ultra', 5499.00, 1),
-- Order 21: buyer05 buys ROG游戏本
(21, 9, 'ROG 枪神9 Plus', 24999.00, 1),
-- Order 22: buyer05 buys 大闸蟹 (CANCELLED)
(22, 22, '阳澄湖大闸蟹礼盒', 398.00, 1),
-- Order 23: buyer05 buys MateBook
(23, 37, '华为MateBook X Pro 2026', 9999.00, 1),
-- Order 24: buyer05 buys Lululemon瑜伽裤
(24, 44, 'Lululemon Align瑜伽裤', 550.00, 1),
-- Order 25: buyer05 buys 澳洲牛排
(25, 50, '进口澳洲牛排套餐', 258.00, 2),
-- Order 26: buyer06 buys Anker充电器
(26, 6, 'Anker 200W氮化镓充电器', 399.00, 1),
-- Order 27: buyer06 buys ZARA连衣裙
(27, 15, 'ZARA春季碎花连衣裙', 359.00, 1),
-- Order 28: buyer06 buys 华为手环9
(28, 33, '华为手环9 NFC版', 329.00, 1),
-- Order 29: buyer06 buys 小米智能门锁
(29, 60, '小米米家智能门锁2 Pro', 1699.00, 1),
-- Order 30: buyer07 buys 联想拯救者台式机
(30, 10, '联想拯救者刃9000K', 15999.00, 1),
-- Order 31: buyer07 buys MUJI香薰机
(31, 29, 'MUJI 超声波香薰机', 299.00, 1),
-- Order 32: buyer07 buys 罗技G Pro X2耳机
(32, 39, '罗技G Pro X 2无线耳机', 1299.00, 1),
-- Order 33: buyer07 buys 三顿半咖啡
(33, 52, '三顿半精品咖啡64颗', 219.00, 1),
-- Order 34: buyer08 buys NIKE Air Max
(34, 17, 'NIKE Air Max 2026', 999.00, 1),
-- Order 35: buyer08 buys 良品铺子 (CANCELLED)
(35, 20, '良品铺子肉脯礼盒', 89.00, 2),
-- Order 36: buyer08 buys 迪卡侬山地车
(36, 45, '迪卡侬山地自行车XC100', 3999.00, 1),
-- Order 37: buyer08 buys 艾美特循环扇
(37, 56, '艾美特空气循环扇', 599.00, 1),
-- Order 38: buyer09 buys Apple Watch
(38, 5, 'Apple Watch Ultra 3', 6499.00, 1),
-- Order 39: buyer09 buys 小米移动电源
(39, 34, '小米移动电源 20000mAh', 199.00, 1),
-- Order 40: buyer09 buys Dell显示器
(40, 40, 'Dell S3222HG 32寸曲面显示器', 1899.00, 1),
-- Order 41: buyer09 buys 认养一头牛
(41, 53, '认养一头牛纯牛奶24盒', 69.90, 2),
-- Order 42: buyer10 buys 双立人刀具
(42, 27, '双立人刀具套装', 1999.00, 1),
-- Order 43: buyer10 buys vivo X200
(43, 32, 'vivo X200 Ultra', 5499.00, 1),
-- Order 44: buyer10 buys 探路者帐篷
(44, 46, '探路者户外帐篷3-4人', 1299.00, 1),
-- Order 45: buyer10 buys 康宁餐具
(45, 59, '康宁餐具18件套', 499.00, 1),
-- Orders 46-50 items
(46, 41, 'Apple Mac mini M4 Pro', 10999.00, 1),
(47, 48, 'YONEX羽毛球拍天斧100ZZ', 1680.00, 1),
(48, 16, 'COS简约通勤衬衫', 459.00, 1),
(49, 23, '星巴克咖啡豆 中度烘焙', 198.00, 2),
(50, 11, '罗技MX Master 4', 799.00, 1);

-- ============================================
-- 8. After-Sales (15 records)
-- ============================================
INSERT INTO after_sales (order_id, buyer_id, type, reason, status, amount, created_at) VALUES
(1, 1, 'REFUND', '收到商品有轻微划痕，申请补偿', 'RESOLVED', 6999.00, '2026-01-12 10:00:00'),
(2, 1, 'RETURN', '颜色不符合预期，七天无理由退货', 'APPROVED', 5999.00, '2026-01-17 14:00:00'),
(6, 2, 'REFUND', '物流延迟三天，要求退还运费', 'PENDING', 9999.00, '2026-01-22 09:00:00'),
(11, 3, 'RETURN', '电脑屏幕有一个坏点，申请换货', 'REJECTED', 12999.00, '2026-02-05 11:00:00'),
(16, 4, 'REFUND', '羽绒服有轻微跑绒现象', 'RESOLVED', 499.00, '2026-02-15 15:00:00'),
(21, 5, 'REFUND', '游戏本风扇噪音大，要求退款', 'PENDING', 24999.00, '2026-02-20 10:00:00'),
(30, 7, 'RETURN', '台式机运输途中机箱变形', 'APPROVED', 15999.00, '2026-03-15 14:00:00'),
(38, 9, 'REFUND', '手表续航不达标，用了两天就没电了', 'REJECTED', 6499.00, '2026-03-25 09:00:00'),
(8, 2, 'REFUND', '手机充电口接触不良', 'PENDING', 4999.00, '2026-03-12 11:00:00'),
(12, 3, 'RETURN', '车厘子有部分坏果', 'RESOLVED', 298.00, '2026-02-25 16:00:00'),
(24, 5, 'REFUND', '瑜伽裤尺寸不合适，退换货', 'PENDING', 550.00, '2026-05-01 10:00:00'),
(36, 8, 'REFUND', '自行车变速器不准，调试多次不行', 'PENDING', 3999.00, '2026-04-20 14:00:00'),
(42, 10, 'RETURN', '刀具有一个缺口', 'APPROVED', 1999.00, '2026-04-01 09:00:00'),
(43, 10, 'REFUND', '手机拍照效果不如宣传所说', 'PENDING', 5499.00, '2026-04-18 11:00:00'),
(16, 4, 'REFUND', '羽绒服拉链不好拉补申请', 'RESOLVED', 499.00, '2026-03-01 10:00:00');

-- ============================================
-- 9. Conversations (15 records)
-- ============================================
INSERT INTO conversations (buyer_id, seller_id, last_message, last_message_time) VALUES
(1, 11, '好的，明天发货', '2026-01-11 15:30:00'),
(1, 12, '请问这款笔记本可以加内存吗', '2026-03-01 10:20:00'),
(2, 11, '能优惠一点吗？', '2026-01-22 16:45:00'),
(2, 13, '西装什么材质？', '2026-02-11 09:10:00'),
(3, 12, '已下单，请尽快发货', '2026-02-02 11:30:00'),
(3, 14, '车厘子是什么时候采摘的？', '2026-02-21 14:00:00'),
(4, 13, '羽绒服165的还有货吗？', '2026-02-12 10:00:00'),
(5, 15, '被子是冬天用的还是四季通用的？', '2026-02-22 08:30:00'),
(6, 11, '充电器兼容苹果设备吗？', '2026-03-02 12:00:00'),
(7, 12, '台式机可以自己加硬盘吗？', '2026-03-11 16:20:00'),
(8, 13, 'Air Max偏码吗？平时穿42', '2026-03-16 11:00:00'),
(9, 16, '手机有现货吗？发什么快递？', '2026-04-06 15:30:00'),
(10, 15, '刀具可以刻字吗？', '2026-03-26 09:50:00'),
(4, 18, '帐篷能抗几级风？', '2026-04-02 14:20:00'),
(6, 20, '智能锁支持HomeKit吗？', '2026-05-01 13:00:00');

-- ============================================
-- 10. Messages (75 records)
-- ============================================
INSERT INTO messages (conversation_id, sender_id, content, type, is_read, created_at) VALUES
-- Conversation 1 (buyer01, seller01)
(1, 1, '你好，请问华为Mate 70 Pro现在有货吗？', 'TEXT', 1, '2026-01-11 10:00:00'),
(1, 11, '有的，512GB版本现货，下单当天发顺丰', 'TEXT', 1, '2026-01-11 10:15:00'),
(1, 1, '好，我马上下单。能送个手机壳吗？', 'TEXT', 1, '2026-01-11 10:20:00'),
(1, 11, '可以的，下单备注一下，送你一个原装保护壳', 'TEXT', 1, '2026-01-11 10:30:00'),
(1, 1, '已下单，谢谢！付款了', 'TEXT', 1, '2026-01-11 11:00:00'),
(1, 11, '好的，明天发货', 'TEXT', 1, '2026-01-11 15:30:00'),

-- Conversation 2 (buyer01, seller02)
(2, 1, '请问这款笔记本可以加内存吗', 'TEXT', 1, '2026-03-01 10:20:00'),
(2, 12, '可以的，X1 Carbon有额外的内存插槽，支持扩展到64GB', 'TEXT', 0, '2026-03-01 10:45:00'),

-- Conversation 3 (buyer02, seller01)
(3, 2, 'iPhone 16 Pro Max能优惠一点吗？', 'TEXT', 1, '2026-01-22 16:45:00'),
(3, 11, '不好意思，苹果产品价格比较透明，不过可以送你一个官方保护壳', 'TEXT', 1, '2026-01-22 17:00:00'),
(3, 2, '好，那这个价格我接受了', 'TEXT', 1, '2026-01-22 17:05:00'),

-- Conversation 4 (buyer02, seller03)
(4, 2, '西装什么材质？', 'TEXT', 1, '2026-02-11 09:10:00'),
(4, 13, '70羊毛+30聚酯纤维，免烫面料，穿着舒适有型', 'TEXT', 1, '2026-02-11 09:30:00'),
(4, 2, '好的，我看看尺寸表', 'TEXT', 0, '2026-02-11 09:35:00'),

-- Conversation 5 (buyer03, seller02)
(5, 3, '已下单，请尽快发货', 'TEXT', 1, '2026-02-02 11:30:00'),
(5, 12, '收到，今天下午发出，预计3天到杭州', 'TEXT', 1, '2026-02-02 11:35:00'),
(5, 3, '好的谢谢', 'TEXT', 1, '2026-02-02 11:40:00'),

-- Conversation 6 (buyer03, seller04)
(6, 3, '车厘子是什么时候采摘的？', 'TEXT', 1, '2026-02-21 14:00:00'),
(6, 14, '本周采摘的，空运过来的，非常新鲜', 'TEXT', 1, '2026-02-21 14:20:00'),
(6, 3, '好的，下单了一份5斤的', 'TEXT', 1, '2026-02-21 14:30:00'),

-- Conversation 7 (buyer04, seller03)
(7, 4, '羽绒服165的还有货吗？', 'TEXT', 1, '2026-02-12 10:00:00'),
(7, 13, '有的，M码就是165的，黑色和藏青色都有', 'TEXT', 1, '2026-02-12 10:10:00'),
(7, 4, '我要黑色M码', 'TEXT', 0, '2026-02-12 10:15:00'),

-- Conversation 8 (buyer05, seller05)
(8, 5, '被子是冬天用的还是四季通用的？', 'TEXT', 1, '2026-02-22 08:30:00'),
(8, 15, '这是冬季款，1200g充绒量，适合0-10度使用。我们有四季款的夏被', 'TEXT', 1, '2026-02-22 09:00:00'),
(8, 5, '那我买冬季款', 'TEXT', 1, '2026-02-22 09:10:00'),

-- Conversation 9 (buyer06, seller01)
(9, 6, '充电器兼容苹果设备吗？', 'TEXT', 1, '2026-03-02 12:00:00'),
(9, 11, '兼容的，支持PD协议，iPhone/MacBook都能快充', 'TEXT', 1, '2026-03-02 12:30:00'),

-- Conversation 10 (buyer07, seller02)
(10, 7, '台式机可以自己加硬盘吗？', 'TEXT', 1, '2026-03-11 16:20:00'),
(10, 12, '可以的，还有2个SATA接口和一个M.2接口可以扩展', 'TEXT', 1, '2026-03-11 16:40:00'),
(10, 7, '太好了，那我下单了', 'TEXT', 0, '2026-03-11 16:45:00'),

-- Conversation 11 (buyer08, seller03)
(11, 8, 'Air Max偏码吗？平时穿42', 'TEXT', 1, '2026-03-16 11:00:00'),
(11, 13, '不偏码，42码就是标准42。不过建议买大半码，运动鞋穿宽松点舒服', 'TEXT', 1, '2026-03-16 11:20:00'),
(11, 8, '好的，那我买42.5', 'TEXT', 1, '2026-03-16 11:25:00'),

-- Conversation 12 (buyer09, seller06)
(12, 9, '手机有现货吗？发什么快递？', 'TEXT', 1, '2026-04-06 15:30:00'),
(12, 16, '有现货的，发顺丰快递，一般2-3天到', 'TEXT', 1, '2026-04-06 15:50:00'),
(12, 9, '那我要一台，已经下单了', 'TEXT', 0, '2026-04-06 16:00:00'),

-- Conversation 13 (buyer10, seller05)
(13, 10, '刀具可以刻字吗？', 'TEXT', 1, '2026-03-26 09:50:00'),
(13, 15, '抱歉，我们目前不支持刻字服务。不过刀具本身就很有质感', 'TEXT', 1, '2026-03-26 10:10:00'),

-- Conversation 14 (buyer04, seller08)
(14, 4, '帐篷能抗几级风？', 'TEXT', 1, '2026-04-02 14:20:00'),
(14, 18, '经过测试可以抗6-7级风，带有防风绳和地钉', 'TEXT', 1, '2026-04-02 14:40:00'),
(14, 4, '好的了解了，我再看看', 'TEXT', 0, '2026-04-02 15:00:00'),

-- Conversation 15 (buyer06, seller10)
(15, 6, '智能锁支持HomeKit吗？', 'TEXT', 1, '2026-05-01 13:00:00'),
(15, 20, '支持Apple HomeKit，也支持米家App和小爱同学', 'TEXT', 0, '2026-05-01 13:30:00'),

-- Extra messages for conversations with few messages
(1, 1, '收到货了，手机很满意！', 'TEXT', 1, '2026-01-13 09:00:00'),
(1, 11, '感谢好评！有问题随时联系我', 'TEXT', 1, '2026-01-13 09:20:00'),
(3, 11, '手机已发出，顺丰单号SF1234567890', 'TEXT', 1, '2026-01-23 10:00:00'),
(3, 2, '收到，谢谢', 'TEXT', 1, '2026-01-23 10:10:00'),
(5, 12, '快递到哪里了？', 'TEXT', 1, '2026-02-04 10:00:00'),
(5, 12, '查了一下，今天下午就能到', 'TEXT', 1, '2026-02-04 10:15:00'),
(2, 12, '好的，我再了解一下，谢谢', 'TEXT', 0, '2026-03-01 11:00:00'),
(7, 13, '好的，马上下单', 'TEXT', 0, '2026-02-12 10:20:00'),
(9, 6, '下单了2个，谢谢推荐', 'TEXT', 0, '2026-03-02 13:00:00'),
(12, 16, '手机发货了吗？', 'TEXT', 0, '2026-04-08 10:00:00');
