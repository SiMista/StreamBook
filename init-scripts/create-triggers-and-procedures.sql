-- Trigger to check unique email before insert in users_core
CREATE OR REPLACE TRIGGER trg_check_unique_email
BEFORE INSERT ON users_core
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM users_core WHERE email = :NEW.email;
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Email already exists.');
    END IF;
END;
/

-- Procedure to add a new user
CREATE OR REPLACE PROCEDURE add_user (
    p_username IN VARCHAR2,
    p_email IN VARCHAR2,
    p_address IN VARCHAR2,
    p_preferences IN VARCHAR2
) AS
    v_user_id NUMBER;
BEGIN
    SELECT users_core_seq.NEXTVAL INTO v_user_id FROM dual;
    INSERT INTO users_core (user_id, username, email)
    VALUES (v_user_id, p_username, p_email);
    INSERT INTO users_profile (user_id, address, preferences)
    VALUES (v_user_id, p_address, p_preferences);
END add_user;
/

-- Procedure to add a book rating
CREATE OR REPLACE PROCEDURE add_book_rating (
    p_user_id IN NUMBER,
    p_book_id IN NUMBER,
    p_rating IN NUMBER,
    p_review IN VARCHAR2
) AS
BEGIN
    INSERT INTO book_ratings (rating_id, user_id, book_id, rating, review)
    VALUES (book_ratings_seq.NEXTVAL, p_user_id, p_book_id, p_rating, p_review);
END add_book_rating;
/

-- Procedure to recommend a book to a user
CREATE OR REPLACE PROCEDURE recommend_book (
    p_user_id IN NUMBER,
    p_book_id IN NUMBER,
    p_reason IN VARCHAR2
) AS
BEGIN
    INSERT INTO recommendations (recommendation_id, user_id, book_id, reason)
    VALUES (recommendations_seq.NEXTVAL, p_user_id, p_book_id, p_reason);
END recommend_book;
/

-- Trigger to ensure rating is between 1 and 5 before insert in book_ratings
CREATE OR REPLACE TRIGGER trg_check_rating
BEFORE INSERT ON book_ratings
FOR EACH ROW
BEGIN
    IF :NEW.rating < 1 OR :NEW.rating > 5 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Rating must be between 1 and 5.');
    END IF;
END;
/
