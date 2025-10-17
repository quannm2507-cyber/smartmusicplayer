DROP DATABASE IF EXISTS smart_music_player;

-- 1️⃣ Tạo Database
CREATE DATABASE smart_music_player CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE smart_music_player;

-- 2️⃣ Bảng USERS
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(100) NOT NULL UNIQUE,
                       password VARCHAR(255) NOT NULL,
                       fullname VARCHAR(255),
                       role ENUM('admin', 'user') DEFAULT 'user',
                       avatar VARCHAR(255)
);

-- 3️⃣ Bảng SONGS
CREATE TABLE songs (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       title VARCHAR(255) NOT NULL,
                       artist VARCHAR(255),
                       album VARCHAR(255),
                       genre VARCHAR(100),
                       file_path VARCHAR(255) NOT NULL,
                       cover_image VARCHAR(255),
                       uploaded_by INT,
                       upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (uploaded_by) REFERENCES users(id)
);

-- 4️⃣ Bảng PLAYLISTS
CREATE TABLE playlists (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           name VARCHAR(255) NOT NULL,
                           user_id INT NOT NULL,
                           FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 5️⃣ Bảng PLAYLIST_SONGS (liên kết n-n)
CREATE TABLE playlist_songs (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                playlist_id INT,
                                song_id INT,
                                FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
                                FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- 6️⃣ Bảng FEEDBACK
CREATE TABLE feedback (
                          id INT AUTO_INCREMENT PRIMARY KEY,
                          user_id INT,
                          song_id INT,
                          rating INT CHECK (rating BETWEEN 1 AND 5),
                          comment TEXT,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
                          FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- 7️⃣ Dữ liệu mẫu
INSERT INTO users (username, password, fullname, role) VALUES
                                                           ('admin', '123456', 'Administrator', 'admin'),
                                                           ('tuyen', '123456', 'Le Tuyen', 'user'),
                                                           ('an', '123456', 'Tran An', 'user');

INSERT INTO songs (title, artist, album, genre, file_path, cover_image, uploaded_by)
VALUES
    ('7 Years', 'Lukas Graham', 'Blue Album', 'Pop', '7 Years.mp3', '7years.jpg', 1),
    ('Buông Đôi Tay Nhau Ra', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Buông_Đôi_Tay_Nhau_Ra.mp3', 'buongdoi.jpg', 1),
    ('Bánh Mì Không', 'Đạt G ft Du Uyên', 'Single', 'Pop', 'Bánh Mì Không.mp3', 'banhmikhong.jpg', 1),
    ('Chúng Ta Của Hiện Tại', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Chúng_Ta_Của_Hiện_Tại.mp3', 'chungta.jpg', 1),
    ('CHẠY NGAY ĐI', 'Sơn Tùng M-TP', 'Single', 'Pop', 'CHẠY_NGAY_ĐI.mp3', 'chayngaydi.jpg', 1),
    ('Faded', 'Alan Walker', 'Different World', 'EDM', 'Faded.mp3', 'faded.jpg', 1),
    ('Hãy Trao Cho Anh', 'Sơn Tùng M-TP ft Snoop Dogg', 'Single', 'Pop', 'Hãy Trao Cho Anh.mp3', 'haytraochoanh.jpg', 1),
    ('Hãy Trao Cho Anh (Remix)', 'Sơn Tùng M-TP', 'Remix', 'EDM', 'Hãy_Trao_Cho_Anh.mp3', 'haytraochoanh_remix.jpg', 1),
    ('Làm Người Luôn Yêu Em Mất Rồi', 'Nguyễn Minh Cường', 'Single', 'Ballad', 'Lam_nguoi_luon_yeu_em.mp3', 'lamnguoiyeuem.jpg', 1),
    ('Let Her Go', 'Passenger', 'All the Little Lights', 'Folk', 'Let_Her_Go.mp3', 'lethergo.jpg', 1),
    ('Làm Người Yêu Anh Nhé Baby', 'Ba Chú Bộ Đội', 'Single', 'Pop', 'Làm Người Yêu Anh Nhé Baby.mp3', 'lamnguoiyenhe.jpg', 1),
    ('Lạc Trôi', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Lạc_Trôi.mp3', 'lactroi.jpg', 1),
    ('Lạc Trôi 1', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Lạc_Trôi1.mp3', 'lactroi1.jpg', 1),
    ('Muộn Rồi Mà Sao Còn', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Muộn_Rồi_Mà_Sao_Còn.mp3', 'muonroi.jpg', 1),
    ('Nơi Này Có Anh', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Nơi Này Có Anh.mp3', 'noinaycoanh.jpg', 1),
    ('Sau Cơn Mưa', 'Mr. Siro', 'Single', 'Ballad', 'Sau Cơn Mưa.mp3', 'sauconmua.jpg', 1),
    ('Shape Of You', 'Ed Sheeran', 'Divide', 'Pop', 'Shape_Of_You.mp3', 'shapeofyou.jpg', 1),
    ('Simple Love', 'Obito ft Seachains', 'Single', 'Pop', 'Simple Love.mp3', 'simplelove.jpg', 1),
    ('Thiên Lý Ơi (Remix)', 'Jack', 'Remix', 'EDM', 'Thiên_Lý_Ơi_(Remix).mp3', 'thienlyoi.jpg', 1),
    ('Trên Tình Bạn Dưới Tình Yêu', 'MIN', '50/50', 'Pop', 'Trên Tình Bạn Dưới Tình Yêu.mp3', 'trentinhban.jpg', 1),
    ('Âm Thầm Bên Em', 'Sơn Tùng M-TP', 'Single', 'Pop', 'Âm_Thầm_Bên_Em.mp3', 'amthambenem.jpg', 1),
    ('Địa Ngục Trần Gian', 'Hồ Quang Hiếu', 'Single', 'Ballad', 'Địa Ngục Trần Gian.mp3', 'dianguctrangian.jpg', 1);



INSERT INTO playlists (name, user_id) VALUES
                                          ('My Favorite Songs', 2),
                                          ('Chill Vibes', 3);

INSERT INTO playlist_songs (playlist_id, song_id) VALUES
                                                      (1, 1), (1, 2), (2, 3), (2, 4);

INSERT INTO feedback (user_id, song_id, rating, comment) VALUES
                                                             (2, 1, 5, 'Tuyệt vời!'),
                                                             (3, 2, 4, 'Rất hay nhưng hơi ngắn'),
                                                             (2, 3, 5, 'Yêu thích bài này.');

USE smart_music_player;



SELECT * FROM songs;

SELECT title, file_path, cover_image FROM songs WHERE title IN ('Sau Cơn Mưa', 'Shape Of You');



ALTER TABLE playlist_songs ADD COLUMN order_index INT DEFAULT 0;
-- Cập nhật order_index cho các bản ghi hiện có trong playlist_songs
UPDATE playlist_songs SET order_index = id WHERE order_index = 0;

