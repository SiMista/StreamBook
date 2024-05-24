-- Table des informations de base des utilisateurs
CREATE TABLE users_core (
    user_id NUMBER PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) NOT NULL
);

-- Table des informations supplémentaires des utilisateurs
CREATE TABLE users_profile (
    user_id NUMBER PRIMARY KEY,
    address VARCHAR2(200),
    preferences VARCHAR2(200),
    FOREIGN KEY (user_id) REFERENCES users_core(user_id)
);

-- Table des informations de base sur les livres
CREATE TABLE books (
    book_id NUMBER PRIMARY KEY,
    title VARCHAR2(200) NOT NULL,
    author VARCHAR2(100) NOT NULL,
    genre VARCHAR2(50)
);

-- Table des évaluations des livres
CREATE TABLE book_ratings (
    rating_id NUMBER PRIMARY KEY,
    user_id NUMBER,
    book_id NUMBER,
    rating NUMBER CHECK (rating BETWEEN 1 AND 5),
    review VARCHAR2(4000),
    FOREIGN KEY (user_id) REFERENCES users_core(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Table des recommandations de livres pour les utilisateurs
CREATE TABLE recommendations (
    recommendation_id NUMBER PRIMARY KEY,
    user_id NUMBER,
    book_id NUMBER,
    reason VARCHAR2(4000),
    FOREIGN KEY (user_id) REFERENCES users_core(user_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
