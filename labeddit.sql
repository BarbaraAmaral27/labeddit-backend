-- Active: 1679494151249@@127.0.0.1@3306
CREATE TABLE users(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    password TEXT NOT NULL,
    role TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME())
);

INSERT INTO users (id, name, email, password, role)
VALUES
        ("u001", "Aline", "aline@labenu.com", "$2a$12$CIHI6habJCFvlzVeoKpZq.k2DVqfaBYVewqlDgHcLPUROCkaRkPcq", "ADMIN"),
        ("u002", "Binho", "binho@gmail.com", "$2a$12$CIHI6habJCFvlzVeoKpZq.k2DVqfaBYVewqlDgHcLPUROCkaRkPcq", "NORMAL"),
        ("u003", "Evandro", "evandro@gmail.com", "$2a$12$CIHI6habJCFvlzVeoKpZq.k2DVqfaBYVewqlDgHcLPUROCkaRkPcq", "NORMAL"),
        ("u004", "Paula", "paula@labenu.com", "$2a$12$CIHI6habJCFvlzVeoKpZq.k2DVqfaBYVewqlDgHcLPUROCkaRkPcq", "NORMAL");

SELECT * FROM users;

CREATE TABLE posts(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    creator_id TEXT NOT NULL,
    content TEXT NOT NULL,
    likes INTEGER DEFAULT(0),
    dislikes INTEGER DEFAULT(0),
    created_at TEXT DEFAULT(DATETIME()),
    updated_at TEXT DEFAULT(DATETIME()),
    FOREIGN KEY (creator_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO posts(id, creator_id, content)
VALUES  ("p001", "u002", "Bom dia mundo!"),
        ("p002", "u003", "E aí pessoal?"),
        ("p003", "u004", "Sextoou!!!"),
        ("p004", "u001", "Bora trabalhar?");

CREATE TABLE likes_dislikes_posts (
  user_id TEXT NOT NULL,
  post_id TEXT NOT NULL,
  like INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  UNIQUE (user_id, post_id)
);

CREATE TABLE comments (
  id TEXT PRIMARY KEY UNIQUE NOT NULL,
  creator_id TEXT NOT NULL,
  post_id TEXT NOT NULL,
  content TEXT NOT NULL,
  likes INTEGER DEFAULT(0),
  dislikes INTEGER DEFAULT(0),
  created_at TEXT DEFAULT(DATETIME()),
  updated_at TEXT DEFAULT(DATETIME()),
  FOREIGN KEY (creator_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

INSERT INTO comments(id, creator_id, post_id, content)
VALUES  ("c001", "u001", "p002", "Dia lindo!!!"),
        ("c002", "u002", "p003", "Chuvaa boa!!!"),
        ("c003", "u003", "p004", "Sextoou!!!"),
        ("c004", "u004", "p001", "Bora!!!");

CREATE TABLE likes_dislikes_comments (
  user_id TEXT NOT NULL,
  comment_id TEXT NOT NULL,
  post_id TEXT NOT NULL,
  like INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (comment_id) REFERENCES comments(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (post_id) REFERENCES posts(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  UNIQUE (user_id, comment_id, post_id)
);

SELECT * FROM comments;