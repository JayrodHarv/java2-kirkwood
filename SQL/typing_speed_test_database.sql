/*
	FILE: 	typing_speed_test_database.sql
    DATE:	2023-04-21
    AUTHOR:	Jared Harvey
    DESCRIPTION:
		Builds a database made for the final project that stores typing speed test data.
*/

/*****************************************************************************
							DATABASE CREATION
*****************************************************************************/

DROP DATABASE IF EXISTS typing_speed_test;
CREATE DATABASE typing_speed_test;
USE typing_speed_test;

/*****************************************************************************
							TABLE CREATION
*****************************************************************************/

DROP TABLE IF EXISTS Typist;
CREATE TABLE Typist(
	typist_id	INT	NOT NULL AUTO_INCREMENT	COMMENT "Unique identifier for a typist."
	, typist_name	VARCHAR(50)	NOT NULL UNIQUE COMMENT "A typist's username."
	, typist_password	VARCHAR(50)	NOT NULL COMMENT "A typist's password."
    , number_of_tests INT NOT NULL DEFAULT 0 COMMENT "Number of tests the typist has completed."
	, average_WPM	INT	NULL COMMENT "The average typing speed of the typist."
	, fastest_WPM	INT	NULL COMMENT "The fastest typing speed of the typist."
	, slowest_WPM	INT	NULL COMMENT "The slowest typing speed of the typist."
    , PRIMARY KEY(typist_id)
) COMMENT "Table that stores typists."
;

DROP TABLE IF EXISTS TypingSession;
CREATE TABLE TypingSession(
	session_id	INT	NOT NULL AUTO_INCREMENT	COMMENT "Unique identifier for a session."
	, typist_id	INT	NOT NULL COMMENT "Unique identifier for a typist."
	, number_of_tests INT NOT NULL DEFAULT 0 COMMENT "Number of tests completed in a session."
	, average_WPM INT NULL COMMENT "Average words per minute of a session."
	, fastest_WPM INT NULL COMMENT "Fastest words per minute in a session."
	, slowest_WPM INT NULL COMMENT "Slowest words per minute in a session."
	, session_date DATE NOT NULL COMMENT "TypingSession date."
    , PRIMARY KEY(session_id)
    , CONSTRAINT fk_typingsession_typistid
		FOREIGN KEY(typist_id)
        REFERENCES Typist(typist_id)
) COMMENT "Table that stores sessions."
;

DROP TABLE IF EXISTS Quote;
CREATE TABLE Quote(
	quote_id INT NOT NULL AUTO_INCREMENT COMMENT "A unique identifier for a quote."
	, quote_text TEXT NOT NULL COMMENT "The string containing the text of the quote."
	, author_name VARCHAR(100) NOT NULL COMMENT "The quote's author name."
	, number_of_words INT NOT NULL COMMENT "The number of words contained in the quote."
    , PRIMARY KEY(quote_id)
) COMMENT "Table that stores quotes."
;

DROP TABLE IF EXISTS Test;
CREATE TABLE Test(
	test_id	INT	NOT NULL AUTO_INCREMENT	COMMENT "Unique identifier for a test."
	, session_id INT NOT NULL COMMENT "Unique identifier for a session."
	, quote_id INT NOT NULL COMMENT "A unique identifier for a quote."
	, time_elapsed INT NOT NULL COMMENT "The time it took a typist to type the quote."
	, words_per_minute INT NULL COMMENT "The words per minute of a given test."
    , PRIMARY KEY(test_id)
    , CONSTRAINT fk_test_sessionid
		FOREIGN KEY(session_id)
        REFERENCES TypingSession(session_id)
	, CONSTRAINT fk_test_quoteid
		FOREIGN KEY(quote_id)
        REFERENCES Quote(quote_id)
) COMMENT "Table that stores tests."
;

DROP TABLE IF EXISTS QuoteStats;
CREATE TABLE QuoteStats(
	quote_id INT NOT NULL COMMENT "A unique identifier for a quote."
	, number_of_tests INT NOT NULL DEFAULT 0 COMMENT "The number of times a quote has been typed."
	, average_WPM INT NULL COMMENT "The average speed a quote is typed."
	, fastest_WPM INT NULL COMMENT "The fastest speed a quote was typed."
    , PRIMARY KEY(quote_id)
    , CONSTRAINT fk_quotestats_quoteid
		FOREIGN KEY(quote_id)
        REFERENCES Quote(quote_id)
) COMMENT "Table that holds statistics of a given quote."
;

DROP TABLE IF EXISTS TypistAudit;
CREATE TABLE TypistAudit(
	typist_id INT NOT NULL COMMENT "Unique identifier for a typist."
	, typist_name VARCHAR(50) NOT NULL COMMENT "A typist's username."
	, typist_password VARCHAR(50) NOT NULL COMMENT "A typist's password."
    , number_of_tests INT NOT NULL COMMENT "Number of tests the typist has completed."
	, average_WPM INT NULL COMMENT "The average typing speed of the typist."
	, fastest_WPM INT NULL COMMENT "The fastest typing speed of the typist."
	, slowest_WPM INT NULL COMMENT "The slowest typing speed of the typist."
	, action_type VARCHAR(50) NOT NULL COMMENT "Type of action committed."
	, action_date DATETIME NOT NULL COMMENT "Date and time action took place."
	, action_user VARCHAR(50) NOT NULL COMMENT "Who done it?"
) COMMENT "An audit table for typists."
;

/*****************************************************************************
								TRIGGERS
*****************************************************************************/

/*---------------------------------------------------------------------------
							Typist Triggers
----------------------------------------------------------------------------*/

/* Typist After Insert Trigger */
DELIMITER $$
DROP TRIGGER IF EXISTS tr_typist_after_insert$$
CREATE TRIGGER tr_typist_after_insert
	AFTER INSERT ON Typist
    FOR EACH ROW
BEGIN
	INSERT INTO TypistAudit(
		typist_id
        , typist_name
        , typist_password
        , number_of_tests
        , average_WPM
        , fastest_WPM
        , slowest_WPM
        , action_type
        , action_date
        , action_user
    ) VALUES (
		NEW.typist_id
        , NEW.typist_name
        , NEW.typist_password
        , NEW.number_of_tests
        , NEW.average_WPM
        , NEW.fastest_WPM
        , NEW.slowest_WPM
        , 'INSERTED' -- action_type
        , NOW() -- action_date
        , CURRENT_USER() -- action_user
    )
    ;
END$$
DELIMITER ;

/* Typist After Update Trigger */
DELIMITER $$
DROP TRIGGER IF EXISTS tr_typist_after_update$$
CREATE TRIGGER tr_typist_after_update
	AFTER UPDATE ON Typist
    FOR EACH ROW
BEGIN
	INSERT INTO TypistAudit(
		typist_id
        , typist_name
        , typist_password
        , number_of_tests
        , average_WPM
        , fastest_WPM
        , slowest_WPM
        , action_type
        , action_date
        , action_user
    ) VALUES (
		NEW.typist_id
        , NEW.typist_name
        , NEW.typist_password
        , NEW.number_of_tests
        , NEW.average_WPM
        , NEW.fastest_WPM
        , NEW.slowest_WPM
        , 'UPDATED' -- action_type
        , NOW() -- action_date
        , CURRENT_USER() -- action_user
    )
    ;
END$$
DELIMITER ;

/* Typist After Delete Trigger */
DELIMITER $$
DROP TRIGGER IF EXISTS tr_typist_after_delete$$
CREATE TRIGGER tr_typist_after_delete
	AFTER DELETE ON Typist
    FOR EACH ROW
BEGIN
	INSERT INTO TypistAudit(
		typist_id
        , typist_name
        , typist_password
        , number_of_tests
        , average_WPM
        , fastest_WPM
        , slowest_WPM
        , action_type
        , action_date
        , action_user
    ) VALUES (
		OLD.typist_id
        , OLD.typist_name
        , OLD.typist_password
        , OLD.number_of_tests
        , OLD.average_WPM
        , OLD.fastest_WPM
        , OLD.slowest_WPM
        , 'DELETED' -- action_type
        , NOW() -- action_date
        , CURRENT_USER() -- action_user
    )
    ;
END$$
DELIMITER ;

/*---------------------------------------------------------------------------
								Test Triggers
----------------------------------------------------------------------------*/

/* Test After INSERT Trigger */
DELIMITER $$
DROP TRIGGER IF EXISTS tr_test_after_insert$$
CREATE TRIGGER tr_test_after_insert
	AFTER INSERT ON Test
    FOR EACH ROW
BEGIN
	-- DECLARE VARIABLES
	DECLARE var_session_test_count INT;
    DECLARE var_session_average_wpm INT;
    DECLARE var_session_fastest_wpm INT;
    DECLARE var_session_slowest_wpm INT;
    
    DECLARE var_typist_test_count INT;
    DECLARE var_typist_average_wpm INT;
    DECLARE var_typist_fastest_wpm INT;
    DECLARE var_typist_slowest_wpm INT;
    DECLARE var_typist_id INT;
    
    -- Session SELECT Query
    SELECT 
		COUNT(Test.test_id)
		, CEILING(AVG(Test.words_per_minute))
        , MAX(Test.words_per_minute)
        , MIN(Test.words_per_minute)
    INTO 
		var_session_test_count
		, var_session_average_wpm
        , var_session_fastest_wpm
        , var_session_slowest_wpm
    FROM Test
    WHERE Test.session_id = NEW.session_id
    ;
    
    -- UPDATE TypingSession
	UPDATE TypingSession
    SET 
		TypingSession.number_of_tests = var_session_test_count
		, TypingSession.average_WPM = var_session_average_wpm
        , TypingSession.fastest_WPM = var_session_fastest_wpm
        , TypingSession.slowest_WPM = var_session_slowest_wpm
	WHERE TypingSession.session_id = NEW.session_id
    ;
    
    -- Gets Typist
    SELECT TypingSession.typist_id
    INTO var_typist_id
	FROM TypingSession
    WHERE TypingSession.session_id = NEW.session_id
    ;
    
    -- Gets Typist number_of_tests
    SELECT SUM(TypingSession.number_of_tests)
    INTO var_typist_test_count
    FROM TypingSession
    WHERE TypingSession.typist_id = var_typist_id
    ;
    
    -- Gets Typist Stats
    SELECT 
		CEILING(AVG(TypingSession.average_WPM))
        , MAX(TypingSession.fastest_WPM)
        , MIN(TypingSession.slowest_WPM)
    INTO 
		var_typist_average_wpm
        , var_typist_fastest_wpm
        , var_typist_slowest_wpm
    FROM TypingSession
    WHERE TypingSession.typist_id = var_typist_id
    ;
    
    -- UPDATE Typist
    UPDATE Typist
    SET
		Typist.number_of_tests = var_typist_test_count
		, Typist.average_WPM = var_typist_average_wpm
        , Typist.fastest_WPM = var_typist_fastest_wpm
        , Typist.slowest_WPM = var_typist_slowest_wpm
	WHERE Typist.typist_id = var_typist_id
    ;
END$$
DELIMITER ;

/*---------------------------------------------------------------------------
								Test Triggers
----------------------------------------------------------------------------*/

/* QUOTE AFTER INSERT */
DELIMITER $$
DROP TRIGGER IF EXISTS tr_quote_after_insert$$
CREATE TRIGGER tr_quote_after_insert
	AFTER INSERT ON Quote
    FOR EACH ROW
BEGIN
    DECLARE var_quote_id INT;
    
    SELECT Quote.quote_id
    INTO var_quote_id
    FROM Quote
    WHERE Quote.quote_id = NEW.quote_id
    ;
    
    INSERT INTO QuoteStats(
		quote_id
    ) VALUES (
		var_quote_id
    )
    ;
END$$
DELIMITER ;

/*****************************************************************************
					STORED PROCEDURES / CRUD FUNCTIONS
*****************************************************************************/

/* INSERT TEST */
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insert_test$$
CREATE PROCEDURE sp_insert_test(
	IN p_session_id INT
    , IN p_quote_id INT
    , IN p_time_elapsed INT
)
BEGIN
	-- DECLARE Variables
    DECLARE var_error TINYINT DEFAULT FALSE;
    DECLARE var_words_per_minute INT;
    
    DECLARE var_quote_number_of_tests INT;
    DECLARE var_quote_average_wpm INT;
    DECLARE var_quote_fastest_wpm INT;
    
    -- DECLARE Error Handlers
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET var_error = TRUE;
    
    START TRANSACTION;
    
    INSERT INTO Test(
		session_id
        , quote_id
        , time_elapsed
    ) VALUES (
		p_session_id
        , p_quote_id
        , p_time_elapsed
    )
    ;
    
    /*
		This is something that would normally be done in my app but if I didn't add this, 
        I would have had to calculate the WPM for 500 different tests.
    */
    -- Calculate words_per_minute
    SELECT CEILING((Quote.number_of_words / Test.time_elapsed) * 60)
    INTO var_words_per_minute
	FROM Test
    INNER JOIN Quote
    ON Quote.quote_id = Test.quote_id
    WHERE Test.test_id = last_insert_id()
    ;
    
    -- UPDATE Test words_per_minute
    UPDATE Test
    SET Test.words_per_minute = var_words_per_minute
    WHERE Test.test_id = last_insert_id()
    ;
    
    -- QuoteStats SELECT Query
    SELECT 
        COUNT(Test.quote_id)
        , CEILING(AVG(Test.words_per_minute))
        , MAX(Test.words_per_minute)
	INTO
		var_quote_number_of_tests
        , var_quote_average_wpm
        , var_quote_fastest_wpm
	FROM Test
    WHERE Test.quote_id = p_quote_id
    ;
    
    UPDATE QuoteStats
    SET
		QuoteStats.number_of_tests = var_quote_number_of_tests
        , QuoteStats.average_WPM = var_quote_average_wpm
        , QuoteStats.fastest_WPM = var_quote_fastest_wpm
	WHERE QuoteStats.quote_id = p_quote_id
    ;
    
    -- Having messages here makes it grind to a halt
    IF var_error = FALSE THEN
		COMMIT;
        -- SELECT 'Transaction Sucessful' AS 'message';
	ELSE
		ROLLBACK;
		-- SELECT 'Transaction Failed' AS 'message';
	END IF;
    
END$$
DELIMITER ;

/* UPDATE TEST */
-- Would never use in program
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_update_test$$
CREATE PROCEDURE sp_update_test(
	IN p_test_id INT
	, IN p_session_id INT
    , IN p_quote_id INT
    , IN p_time_elapsed INT
)
BEGIN
	-- DECLARE Variables
    DECLARE var_error TINYINT DEFAULT FALSE;
    DECLARE var_words_per_minute INT;
    
    -- DECLARE Error Handlers
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET var_error = TRUE;
    
    START TRANSACTION;
    
    UPDATE Test
    SET
		session_id = p_session_id
        , quote_id = p_quote_id
        , time_elapsed = p_time_elapsed
    WHERE Test.test_id = p_test_id
    ;
    
    -- Calculate words_per_minute
    SELECT CEILING((Quote.number_of_words / Test.time_elapsed) * 60)
    INTO var_words_per_minute
	FROM Test
    INNER JOIN Quote
    ON Quote.quote_id = Test.quote_id
    WHERE Test.test_id = p_test_id
    ;
    
    -- UPDATE Test words_per_minute
    UPDATE Test
    SET Test.words_per_minute = var_words_per_minute
    WHERE Test.test_id = p_test_id
    ;
    
    IF var_error = FALSE THEN
		COMMIT;
        SELECT 'Transaction Sucessful' AS 'message';
	ELSE
		ROLLBACK;
		SELECT 'Transaction Failed' AS 'message';
	END IF;
    
END$$
DELIMITER ;

/* DELETE TEST */
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_delete_test$$
CREATE PROCEDURE sp_delete_test(
	IN p_test_id INT
)
BEGIN
	-- DECLARE Variables
    DECLARE var_error TINYINT DEFAULT FALSE;
    
    -- DECLARE Error Handlers
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET var_error = TRUE;
    
    START TRANSACTION;
    
    DELETE FROM Test
    WHERE Test.test_id = p_test_id
    ;
    
    IF var_error = FALSE THEN
		COMMIT;
        SELECT 'Transaction Sucessful' AS 'message';
	ELSE
		ROLLBACK;
		SELECT 'Transaction Failed' AS 'message';
	END IF;
END$$
DELIMITER ;

/*****************************************************************************
							INSERT STATEMENTS
*****************************************************************************/

/* Typists (10) */
insert into Typist (typist_name, typist_password) values ('Wilfrid', 'BUwChodGNr');
insert into Typist (typist_name, typist_password) values ('Jacklyn', 'VhFpt40IF');
insert into Typist (typist_name, typist_password) values ('Sandy', 'aOi0UYXXG');
insert into Typist (typist_name, typist_password) values ('Napoleon', 'VCuGBT7yjEL');
insert into Typist (typist_name, typist_password) values ('Bobbie', 'vOFomyvipb');
insert into Typist (typist_name, typist_password) values ('Candida', 'h7H6Aq1zNPx');
insert into Typist (typist_name, typist_password) values ('Stacia', '3qjrWz5');
insert into Typist (typist_name, typist_password) values ('Georgeanna', 'PZAqBu71FHc');
insert into Typist (typist_name, typist_password) values ('Lyman', 'dryyX6');
insert into Typist (typist_name, typist_password) values ('Gerardo', 'ZTdtAqur');

/* TypingSessions (50) */
insert into TypingSession (typist_id, session_date) values (2, '2022-06-12');
insert into TypingSession (typist_id, session_date) values (5, '2023-02-21');
insert into TypingSession (typist_id, session_date) values (7, '2022-05-09');
insert into TypingSession (typist_id, session_date) values (1, '2023-04-18');
insert into TypingSession (typist_id, session_date) values (9, '2022-08-14');
insert into TypingSession (typist_id, session_date) values (4, '2022-11-22');
insert into TypingSession (typist_id, session_date) values (10, '2022-09-09');
insert into TypingSession (typist_id, session_date) values (5, '2023-04-21');
insert into TypingSession (typist_id, session_date) values (4, '2022-06-30');
insert into TypingSession (typist_id, session_date) values (5, '2023-03-14');
insert into TypingSession (typist_id, session_date) values (2, '2022-05-14');
insert into TypingSession (typist_id, session_date) values (7, '2023-03-07');
insert into TypingSession (typist_id, session_date) values (6, '2022-12-16');
insert into TypingSession (typist_id, session_date) values (4, '2023-04-05');
insert into TypingSession (typist_id, session_date) values (5, '2023-01-07');
insert into TypingSession (typist_id, session_date) values (1, '2022-10-05');
insert into TypingSession (typist_id, session_date) values (7, '2022-08-06');
insert into TypingSession (typist_id, session_date) values (4, '2022-08-29');
insert into TypingSession (typist_id, session_date) values (5, '2022-08-06');
insert into TypingSession (typist_id, session_date) values (7, '2022-06-10');
insert into TypingSession (typist_id, session_date) values (9, '2023-02-13');
insert into TypingSession (typist_id, session_date) values (10, '2022-12-30');
insert into TypingSession (typist_id, session_date) values (1, '2022-09-02');
insert into TypingSession (typist_id, session_date) values (8, '2022-12-17');
insert into TypingSession (typist_id, session_date) values (2, '2023-01-02');
insert into TypingSession (typist_id, session_date) values (2, '2023-02-09');
insert into TypingSession (typist_id, session_date) values (1, '2022-09-03');
insert into TypingSession (typist_id, session_date) values (10, '2022-11-06');
insert into TypingSession (typist_id, session_date) values (9, '2022-09-07');
insert into TypingSession (typist_id, session_date) values (8, '2022-12-22');
insert into TypingSession (typist_id, session_date) values (4, '2023-04-16');
insert into TypingSession (typist_id, session_date) values (7, '2023-04-11');
insert into TypingSession (typist_id, session_date) values (9, '2022-12-03');
insert into TypingSession (typist_id, session_date) values (10, '2022-06-20');
insert into TypingSession (typist_id, session_date) values (8, '2022-10-29');
insert into TypingSession (typist_id, session_date) values (6, '2022-10-12');
insert into TypingSession (typist_id, session_date) values (2, '2022-08-23');
insert into TypingSession (typist_id, session_date) values (8, '2023-03-10');
insert into TypingSession (typist_id, session_date) values (1, '2023-04-21');
insert into TypingSession (typist_id, session_date) values (2, '2022-09-30');
insert into TypingSession (typist_id, session_date) values (2, '2023-02-25');
insert into TypingSession (typist_id, session_date) values (8, '2023-04-08');
insert into TypingSession (typist_id, session_date) values (6, '2022-12-31');
insert into TypingSession (typist_id, session_date) values (2, '2022-11-18');
insert into TypingSession (typist_id, session_date) values (6, '2022-09-02');
insert into TypingSession (typist_id, session_date) values (4, '2022-07-20');
insert into TypingSession (typist_id, session_date) values (9, '2022-09-03');
insert into TypingSession (typist_id, session_date) values (3, '2022-08-04');
insert into TypingSession (typist_id, session_date) values (5, '2022-10-13');
insert into TypingSession (typist_id, session_date) values (9, '2022-10-22');

/* Quotes (50) */
insert into Quote (quote_text, author_name, number_of_words) values ('eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in', 'Dorey Cleal', 43);
insert into Quote (quote_text, author_name, number_of_words) values ('nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit', 'Drusilla Gosenell', 15);
insert into Quote (quote_text, author_name, number_of_words) values ('elit proin interdum mauris non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci', 'Stephani Binfield', 48);
insert into Quote (quote_text, author_name, number_of_words) values ('ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet', 'Skipper Mapledorum', 59);
insert into Quote (quote_text, author_name, number_of_words) values ('non ligula pellentesque ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget nunc donec quis orci eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo', 'Mariejeanne Balma', 68);
insert into Quote (quote_text, author_name, number_of_words) values ('pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst maecenas ut massa quis augue luctus tincidunt nulla mollis molestie', 'Clyde Roots', 32);
insert into Quote (quote_text, author_name, number_of_words) values ('vulputate elementum nullam varius nulla facilisi cras non velit nec nisi vulputate nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper', 'Skippie Haygreen', 61);
insert into Quote (quote_text, author_name, number_of_words) values ('penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel augue vestibulum rutrum rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia aenean sit amet justo morbi ut odio', 'Dorie Baskeyfied', 43);
insert into Quote (quote_text, author_name, number_of_words) values ('dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam', 'Barbie Van Dale', 55);
insert into Quote (quote_text, author_name, number_of_words) values ('interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis', 'Oswell Charley', 31);
insert into Quote (quote_text, author_name, number_of_words) values ('dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo', 'Broddie Amer', 29);
insert into Quote (quote_text, author_name, number_of_words) values ('mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit', 'Dasya Gourley', 13);
insert into Quote (quote_text, author_name, number_of_words) values ('at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia eget tincidunt eget tempus vel', 'Nevile Romke', 61);
insert into Quote (quote_text, author_name, number_of_words) values ('non mauris morbi non lectus aliquam sit amet diam in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis fusce posuere felis sed lacus morbi', 'Georgi Cleft', 35);
insert into Quote (quote_text, author_name, number_of_words) values ('dapibus augue vel accumsan tellus nisi eu orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis justo maecenas rhoncus aliquam lacus morbi quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed', 'Carma Silverton', 62);
insert into Quote (quote_text, author_name, number_of_words) values ('nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac tellus semper interdum mauris ullamcorper purus', 'Zorine Teese', 49);
insert into Quote (quote_text, author_name, number_of_words) values ('nonummy maecenas tincidunt lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra', 'Aldridge Haywood', 29);
insert into Quote (quote_text, author_name, number_of_words) values ('amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla', 'Feliks Gasking', 17);
insert into Quote (quote_text, author_name, number_of_words) values ('urna ut tellus nulla ut erat id mauris vulputate elementum', 'Dwayne Linzee', 11);
insert into Quote (quote_text, author_name, number_of_words) values ('at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel augue vestibulum ante ipsum primis in faucibus orci', 'Charil Stroband', 32);
insert into Quote (quote_text, author_name, number_of_words) values ('turpis elementum ligula vehicula consequat morbi a ipsum integer a nibh in quis', 'Lurline McAdam', 15);
insert into Quote (quote_text, author_name, number_of_words) values ('nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget', 'Odetta Terzi', 18);
insert into Quote (quote_text, author_name, number_of_words) values ('odio justo sollicitudin ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu', 'Margret Dorrity', 38);
insert into Quote (quote_text, author_name, number_of_words) values ('eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur', 'Friedrick Robey', 42);
insert into Quote (quote_text, author_name, number_of_words) values ('praesent blandit lacinia erat vestibulum sed magna at nunc commodo placerat praesent blandit nam nulla integer pede justo lacinia', 'Steffi Idel', 25);
insert into Quote (quote_text, author_name, number_of_words) values ('non mi integer ac neque duis bibendum morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat', 'Deidre Kinton', 32);
insert into Quote (quote_text, author_name, number_of_words) values ('molestie nibh in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus etiam vel', 'Charis Measor', 63);
insert into Quote (quote_text, author_name, number_of_words) values ('consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia', 'Carlota Arnopp', 18);
insert into Quote (quote_text, author_name, number_of_words) values ('faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor', 'Gweneth Schutt', 52);
insert into Quote (quote_text, author_name, number_of_words) values ('nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat', 'Kennan Giorgini', 34);
insert into Quote (quote_text, author_name, number_of_words) values ('pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus', 'Benedict Balfre', 35);
insert into Quote (quote_text, author_name, number_of_words) values ('nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat', 'Cece Botler', 24);
insert into Quote (quote_text, author_name, number_of_words) values ('dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan', 'Ula Knowlton', 47);
insert into Quote (quote_text, author_name, number_of_words) values ('nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis', 'Gavan MacArthur', 33);
insert into Quote (quote_text, author_name, number_of_words) values ('praesent lectus vestibulum quam sapien varius ut blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat', 'Gretal Crippell', 45);
insert into Quote (quote_text, author_name, number_of_words) values ('nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit amet', 'Rubia Cawse', 52);
insert into Quote (quote_text, author_name, number_of_words) values ('ut suscipit a feugiat et eros vestibulum ac est lacinia nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse', 'Pegeen Hamer', 53);
insert into Quote (quote_text, author_name, number_of_words) values ('maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam', 'Miner Ilchenko', 48);
insert into Quote (quote_text, author_name, number_of_words) values ('massa id lobortis convallis tortor risus dapibus augue vel accumsan tellus nisi eu orci mauris lacinia', 'Celine Moger', 20);
insert into Quote (quote_text, author_name, number_of_words) values ('pellentesque viverra pede ac diam cras pellentesque volutpat dui maecenas tristique est et tempus semper est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus orci', 'Modestine Hotton', 41);
insert into Quote (quote_text, author_name, number_of_words) values ('donec ut dolor morbi vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id lobortis convallis tortor risus dapibus augue vel accumsan', 'Carley Lammerts', 41);
insert into Quote (quote_text, author_name, number_of_words) values ('mi nulla ac enim in tempor turpis nec euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere nonummy', 'Marten Peek', 37);
insert into Quote (quote_text, author_name, number_of_words) values ('eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio', 'Homer Greguol', 18);
insert into Quote (quote_text, author_name, number_of_words) values ('nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla sed', 'Minerva Koche', 46);
insert into Quote (quote_text, author_name, number_of_words) values ('primis in faucibus orci luctus et ultrices posuere cubilia curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet', 'Stephani Penley', 30);
insert into Quote (quote_text, author_name, number_of_words) values ('eget orci vehicula condimentum curabitur in libero ut massa volutpat convallis morbi odio odio elementum eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac enim', 'Dorey Castro', 55);
insert into Quote (quote_text, author_name, number_of_words) values ('augue luctus tincidunt nulla mollis molestie lorem quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer', 'Annabell Ambrosoli', 42);
insert into Quote (quote_text, author_name, number_of_words) values ('volutpat sapien arcu sed augue aliquam erat volutpat in congue etiam justo etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla ut erat id mauris', 'Terry Hannis', 39);
insert into Quote (quote_text, author_name, number_of_words) values ('justo sit amet sapien dignissim vestibulum vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit', 'Clifford Turnell', 39);
insert into Quote (quote_text, author_name, number_of_words) values ('lacus at velit vivamus vel nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus phasellus in felis donec semper sapien a libero', 'Moss Hardan', 43);

/* Tests (200) */
CALL sp_insert_test(36,8,24);
CALL sp_insert_test(34,17,88);
CALL sp_insert_test(38,27,61);
CALL sp_insert_test(34,49,37);
CALL sp_insert_test(24,3,22);
CALL sp_insert_test(6,26,98);
CALL sp_insert_test(9,32,91);
CALL sp_insert_test(45,45,70);
CALL sp_insert_test(47,49,24);
CALL sp_insert_test(40,20,27);
CALL sp_insert_test(29,40,49);
CALL sp_insert_test(17,39,27);
CALL sp_insert_test(8,10,91);
CALL sp_insert_test(6,21,58);
CALL sp_insert_test(27,33,18);
CALL sp_insert_test(3,21,56);
CALL sp_insert_test(7,20,38);
CALL sp_insert_test(27,23,81);
CALL sp_insert_test(4,39,65);
CALL sp_insert_test(35,31,22);
CALL sp_insert_test(20,33,43);
CALL sp_insert_test(22,33,49);
CALL sp_insert_test(19,12,43);
CALL sp_insert_test(42,50,37);
CALL sp_insert_test(50,17,70);
CALL sp_insert_test(29,29,81);
CALL sp_insert_test(20,11,58);
CALL sp_insert_test(18,7,40);
CALL sp_insert_test(42,19,64);
CALL sp_insert_test(32,6,22);
CALL sp_insert_test(48,41,22);
CALL sp_insert_test(5,46,45);
CALL sp_insert_test(9,29,34);
CALL sp_insert_test(41,39,30);
CALL sp_insert_test(46,13,24);
CALL sp_insert_test(39,20,34);
CALL sp_insert_test(5,21,23);
CALL sp_insert_test(16,46,60);
CALL sp_insert_test(20,3,90);
CALL sp_insert_test(26,50,50);
CALL sp_insert_test(18,26,66);
CALL sp_insert_test(19,18,39);
CALL sp_insert_test(13,50,29);
CALL sp_insert_test(14,3,33);
CALL sp_insert_test(13,26,39);
CALL sp_insert_test(17,45,35);
CALL sp_insert_test(16,41,96);
CALL sp_insert_test(7,50,15);
CALL sp_insert_test(30,41,99);
CALL sp_insert_test(32,31,69);
CALL sp_insert_test(9,49,83);
CALL sp_insert_test(21,17,55);
CALL sp_insert_test(32,33,34);
CALL sp_insert_test(16,43,75);
CALL sp_insert_test(12,38,22);
CALL sp_insert_test(4,28,69);
CALL sp_insert_test(38,1,12);
CALL sp_insert_test(28,8,91);
CALL sp_insert_test(21,46,22);
CALL sp_insert_test(21,10,100);
CALL sp_insert_test(14,14,58);
CALL sp_insert_test(2,46,12);
CALL sp_insert_test(17,25,66);
CALL sp_insert_test(22,32,49);
CALL sp_insert_test(49,4,72);
CALL sp_insert_test(50,4,19);
CALL sp_insert_test(21,49,38);
CALL sp_insert_test(3,13,55);
CALL sp_insert_test(48,13,45);
CALL sp_insert_test(2,20,14);
CALL sp_insert_test(31,15,92);
CALL sp_insert_test(9,7,68);
CALL sp_insert_test(23,39,10);
CALL sp_insert_test(18,23,51);
CALL sp_insert_test(23,3,23);
CALL sp_insert_test(35,3,27);
CALL sp_insert_test(5,45,49);
CALL sp_insert_test(8,16,78);
CALL sp_insert_test(27,32,81);
CALL sp_insert_test(41,12,76);
CALL sp_insert_test(2,39,49);
CALL sp_insert_test(7,31,88);
CALL sp_insert_test(20,46,77);
CALL sp_insert_test(47,4,90);
CALL sp_insert_test(46,44,99);
CALL sp_insert_test(28,43,14);
CALL sp_insert_test(18,8,47);
CALL sp_insert_test(19,30,72);
CALL sp_insert_test(29,34,53);
CALL sp_insert_test(11,32,76);
CALL sp_insert_test(13,17,46);
CALL sp_insert_test(31,12,85);
CALL sp_insert_test(45,22,87);
CALL sp_insert_test(34,12,78);
CALL sp_insert_test(39,34,35);
CALL sp_insert_test(39,4,95);
CALL sp_insert_test(27,45,10);
CALL sp_insert_test(1,31,11);
CALL sp_insert_test(19,17,74);
CALL sp_insert_test(20,4,90);
CALL sp_insert_test(22,35,22);
/* HALFWAY POINT*/
CALL sp_insert_test(25,32,93);
CALL sp_insert_test(29,11,39);
CALL sp_insert_test(31,9,53);
CALL sp_insert_test(36,23,64);
CALL sp_insert_test(3,25,39);
CALL sp_insert_test(37,16,49);
CALL sp_insert_test(21,13,45);
CALL sp_insert_test(49,40,22);
CALL sp_insert_test(27,31,98);
CALL sp_insert_test(31,43,15);
CALL sp_insert_test(23,47,90);
CALL sp_insert_test(6,3,19);
CALL sp_insert_test(10,13,50);
CALL sp_insert_test(15,46,48);
CALL sp_insert_test(2,30,17);
CALL sp_insert_test(47,29,92);
CALL sp_insert_test(22,49,97);
CALL sp_insert_test(48,38,94);
CALL sp_insert_test(5,28,33);
CALL sp_insert_test(49,17,97);
CALL sp_insert_test(47,28,72);
CALL sp_insert_test(3,24,55);
CALL sp_insert_test(25,31,65);
CALL sp_insert_test(39,3,84);
CALL sp_insert_test(16,1,91);
CALL sp_insert_test(36,1,30);
CALL sp_insert_test(39,38,83);
CALL sp_insert_test(9,17,20);
CALL sp_insert_test(21,38,85);
CALL sp_insert_test(4,18,57);
CALL sp_insert_test(39,28,56);
CALL sp_insert_test(40,25,19);
CALL sp_insert_test(19,43,68);
CALL sp_insert_test(20,36,89);
CALL sp_insert_test(40,5,58);
CALL sp_insert_test(43,14,18);
CALL sp_insert_test(26,49,57);
CALL sp_insert_test(43,44,84);
CALL sp_insert_test(18,48,53);
CALL sp_insert_test(38,24,18);
CALL sp_insert_test(50,19,71);
CALL sp_insert_test(17,34,64);
CALL sp_insert_test(30,11,28);
CALL sp_insert_test(28,31,17);
CALL sp_insert_test(39,25,15);
CALL sp_insert_test(48,48,46);
CALL sp_insert_test(22,8,38);
CALL sp_insert_test(18,33,20);
CALL sp_insert_test(50,12,55);
CALL sp_insert_test(30,42,54);
CALL sp_insert_test(38,39,63);
CALL sp_insert_test(7,32,48);
CALL sp_insert_test(11,28,16);
CALL sp_insert_test(26,23,43);
CALL sp_insert_test(6,20,28);
CALL sp_insert_test(4,43,27);
CALL sp_insert_test(28,33,88);
CALL sp_insert_test(37,6,24);
CALL sp_insert_test(30,12,73);
CALL sp_insert_test(37,39,38);
CALL sp_insert_test(21,39,80);
CALL sp_insert_test(22,47,45);
CALL sp_insert_test(43,41,47);
CALL sp_insert_test(7,21,60);
CALL sp_insert_test(25,38,54);
CALL sp_insert_test(13,25,88);
CALL sp_insert_test(20,42,82);
CALL sp_insert_test(4,44,17);
CALL sp_insert_test(2,37,41);
CALL sp_insert_test(24,20,20);
CALL sp_insert_test(29,42,81);
CALL sp_insert_test(19,8,69);
CALL sp_insert_test(46,30,50);
CALL sp_insert_test(18,8,23);
CALL sp_insert_test(2,42,94);
CALL sp_insert_test(23,10,15);
CALL sp_insert_test(23,40,17);
CALL sp_insert_test(29,45,54);
CALL sp_insert_test(7,21,16);
CALL sp_insert_test(17,10,93);
CALL sp_insert_test(32,41,89);
CALL sp_insert_test(34,14,31);
CALL sp_insert_test(13,4,25);
CALL sp_insert_test(25,28,56);
CALL sp_insert_test(47,22,58);
CALL sp_insert_test(16,13,28);
CALL sp_insert_test(7,21,24);
CALL sp_insert_test(22,25,94);
CALL sp_insert_test(50,34,73);
CALL sp_insert_test(16,6,98);
CALL sp_insert_test(41,11,93);
CALL sp_insert_test(4,16,29);
CALL sp_insert_test(13,27,59);
CALL sp_insert_test(27,6,27);
CALL sp_insert_test(35,4,69);
CALL sp_insert_test(35,38,25);
CALL sp_insert_test(16,36,51);
CALL sp_insert_test(44,16,100);
CALL sp_insert_test(33,38,67);
CALL sp_insert_test(46,17,73);

/*****************************************************************************
									VIEWS
*****************************************************************************/

/* Top 100 Leaderboard View */
CREATE OR REPLACE VIEW typing_speed_test.vw_top_10_leaderboard AS (
	SELECT
		Test.words_per_minute
        , Typist.typist_name
        , Quote.quote_text
        , Quote.author_name
	FROM Test
    INNER JOIN TypingSession
    ON Test.session_id = TypingSession.session_id
    INNER JOIN Typist
    ON Typist.typist_id = TypingSession.typist_id
    INNER JOIN Quote
    ON Quote.quote_id = Test.quote_id
    ORDER BY Test.words_per_minute DESC
    LIMIT 10
)
;

/* Top WPM for each quote View */
CREATE OR REPLACE VIEW typing_speed_test.vw_top_wpm_for_quotes AS (
	SELECT
		Quote.quote_id
		, Quote.author_name
        , Quote.quote_text
		, QuoteStats.fastest_WPM
	FROM QuoteStats
    INNER JOIN Quote
    ON Quote.quote_id = QuoteStats.quote_id
)
;

/* Overall Average WPM View */
CREATE OR REPLACE VIEW typing_speed_test.vw_overall_average_wpm AS (
	SELECT CEILING(AVG(Test.words_per_minute)) AS "Overall Average WPM"
    FROM Test
)
;

/*****************************************************************************
								SELECT QUERIES
*****************************************************************************/

-- Views --
SELECT *
FROM vw_top_10_leaderboard
;

SELECT *
FROM vw_top_wpm_for_quotes
;

SELECT *
FROM vw_overall_average_wpm
;

-- Typist Queries --
SELECT *
FROM Typist
;

-- Test Queries --
SELECT *
FROM Test
WHERE Test.words_per_minute > 150
ORDER BY Test.words_per_minute DESC
;

-- Quote Queries -- 
SELECT *
FROM Quote
;

-- TypistAudit Query --
SELECT *
FROM TypistAudit
;

-- QuoteStats Query --
SELECT *
FROM QuoteStats
;




