-- =========================
-- RESET
-- =========================
DROP TABLE IF EXISTS favorites CASCADE;
DROP TABLE IF EXISTS track_genres CASCADE;
DROP TABLE IF EXISTS track_artists CASCADE;
DROP TABLE IF EXISTS genres CASCADE;
DROP TABLE IF EXISTS tracks CASCADE;
DROP TABLE IF EXISTS artists CASCADE;
DROP TABLE IF EXISTS users CASCADE;

-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    name TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);
-- =========================
-- ARTISTS
-- =========================
CREATE TABLE artists (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT
);

-- =========================
-- TRACKS
-- =========================
CREATE TABLE tracks (
    id SERIAL PRIMARY KEY,
    title TEXT NOT NULL,
    duration INT NOT NULL,
    file_url TEXT,
    cover_url TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- GENRES
-- =========================
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

-- =========================
-- RELATIONS
-- =========================
CREATE TABLE track_artists (
    track_id INT NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    artist_id INT NOT NULL REFERENCES artists(id) ON DELETE CASCADE,
    PRIMARY KEY (track_id, artist_id)
);

CREATE TABLE track_genres (
    track_id INT NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    genre_id INT NOT NULL REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (track_id, genre_id)
);

CREATE TABLE favorites (
    user_id INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    track_id INT NOT NULL REFERENCES tracks(id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, track_id)
);

-- =========================
-- INDEXES
-- =========================
CREATE INDEX idx_tracks_title ON tracks(title);
CREATE INDEX idx_artists_name ON artists(name);
CREATE INDEX idx_genres_name ON genres(name);

-- =========================
-- DATA: GENRES
-- =========================
INSERT INTO genres (name) VALUES
('instrumental'),
('rock'),
('electronic'),
('pop'),
('hip-hop'),
('jazz'),
('classical'),
('ambient'),
('acoustic'),
('punk'),
('piano');

-- =========================
-- DATA: ARTISTS
-- =========================
INSERT INTO artists (name, country) VALUES
('Rafael Archangel', 'USA'),
('HoliznaCC0', 'USA'),
('Amarent', 'France'),
('Tea K Pea', 'USA'),
('TV Girl', 'USA'),
('Coolzey', 'USA'),
('BenJamin Banger', 'USA'),
('Dee Yan-Key', 'USA'),
('Taylor & Lopker', 'USA'),
('<1', 'Unknown'),
('António Bizarro', 'Portugal'),
('Kosta T', 'Russia'),
('Генри Бэсхэ', 'Russia');

-- =========================
-- DATA: TRACKS
-- =========================
INSERT INTO tracks (title, duration, file_url, cover_url) VALUES
('Sakura', 164, 'http://localhost:9000/tracks/sakura.mp3', 'http://localhost:9000/tracks/cover.png'),
('Sleep Time', 108, 'http://localhost:9000/tracks/sleep_time.mp3', 'http://localhost:9000/tracks/cover.png'),
('Fires Uptown', 191, 'http://localhost:9000/tracks/fires_uptown.mp3', 'http://localhost:9000/tracks/cover.png'),
('D2', 192, 'http://localhost:9000/tracks/d2.mp3', 'http://localhost:9000/tracks/cover.png'),
('mewmew', 216, 'http://localhost:9000/tracks/mewmew.mp3', 'http://localhost:9000/tracks/cover.png'),
('Daughter of a Cop', 153, 'http://localhost:9000/tracks/daughter_of_a_cop.mp3', 'http://localhost:9000/tracks/cover.png'),
('Keef (Clean)', 233, 'http://localhost:9000/tracks/keef_clean.mp3', 'http://localhost:9000/tracks/cover.png'),
('Baby Remix', 144, 'http://localhost:9000/tracks/baby_remix.mp3', 'http://localhost:9000/tracks/cover.png'),
('First Attempt to Fly', 169, 'http://localhost:9000/tracks/first_attempt_to_fly.mp3', 'http://localhost:9000/tracks/cover.png'),
('30 Only Classical MX', 1555, 'http://localhost:9000/tracks/only_classical_mx_30.mp3', 'http://localhost:9000/tracks/cover.png'),
('Decay Anxiety IV', 1604, 'http://localhost:9000/tracks/decay_anxiety_iv.mp3', 'http://localhost:9000/tracks/cover.png'),
('Marina', 174, 'http://localhost:9000/tracks/marina.mp3', 'http://localhost:9000/tracks/cover.png'),
('Русская рулетка', 302, 'http://localhost:9000/tracks/русская_рулетка.mp3', 'http://localhost:9000/tracks/cover.png'),
('Время жить', 193, 'http://localhost:9000/tracks/время_жить.mp3', 'http://localhost:9000/tracks/cover.png');

-- =========================
-- RELATIONS: TRACK_ARTISTS
-- =========================
INSERT INTO track_artists VALUES
(1,1),(2,1),
(3,2),
(4,3),
(5,4),
(6,5),
(7,6),
(8,7),
(9,8),
(10,9),
(11,10),
(12,11),
(13,12),
(14,13);

-- =========================
-- RELATIONS: TRACK_GENRES
-- =========================
INSERT INTO track_genres VALUES
(1,1),
(2,1),
(3,2),(3,1),
(4,3),
(5,3),
(6,4),(6,5),
(7,4),(7,5),
(8,4),(8,5),
(9,6),(9,7),(9,1),
(10,6),(10,7),(10,1),
(11,8),
(12,8),
(13,1),(13,9),
(14,10),(14,11);
