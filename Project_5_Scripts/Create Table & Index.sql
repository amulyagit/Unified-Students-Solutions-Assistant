----------------------------------------------------- CREATE TABLE SCRIPT - DDL ----------------------------------------------------



--------------------------------- ALL_USERS Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_all_users is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE ALL_USERS 
                    (
                        USER_ID NUMBER(10) NOT NULL, 
                        USER_NAME VARCHAR2(100) NOT NULL, 
                        GENDER VARCHAR2(10) NOT NULL, 
                        CONTACT_NUMBER NUMBER(10) NOT NULL, 
                        EMAIL_ADDRESS VARCHAR2(100) NOT NULL, 
                        CITY VARCHAR2(50) NOT NULL,
                        STATE VARCHAR2(50) NOT NULL,
                        ZIPCODE NUMBER(5) NOT NULL, 

                        CONSTRAINT ALL_USERS_PK PRIMARY KEY
                        (
                            USER_ID 
                        )
                        ENABLE 
                    )';

    EXECUTE IMMEDIATE table_name;
END p_all_users;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'ALL_USERS';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ALL_USERS ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_all_users;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE ALL_USERS CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE ALL_USERS CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_all_users;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());

    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- CURRENT_STUDENTS Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_current_students is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE CURRENT_STUDENTS 
                (
                    USER_ID NUMBER(10) NOT NULL,
                    NUID NUMBER(7) NOT NULL, 
                    EXPECTED_GRADUATION_DATE DATE NOT NULL,

                    CONSTRAINT CURRENT_STUDENTS_PK PRIMARY KEY
                    (
                        NUID
                    ),
                    FOREIGN KEY
                    (
                        USER_ID 
                    )
                    REFERENCES ALL_USERS
                    (
                        USER_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_current_students;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'CURRENT_STUDENTS';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE CURRENT_STUDENTS ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_current_students;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE CURRENT_STUDENTS CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE CURRENT_STUDENTS CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_current_students;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- DEGREE Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_degree is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE DEGREE 
                (
                    DEGREE_ID NUMBER(1) NOT NULL,
                    DEGREE_NAME VARCHAR2(100) NOT NULL, 
                    DEGREE_DEPARTMENT VARCHAR2(100) NOT NULL,

                    CONSTRAINT DEGREE_PK PRIMARY KEY
                    (
                        DEGREE_ID 
                    )
                    ENABLE 
                )';

    EXECUTE IMMEDIATE table_name;
END p_degree;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'DEGREE';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE DEGREE ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_degree;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE DEGREE CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE DEGREE CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_degree;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- ALUMNI Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_alumni is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE ALUMNI 
                (
                    ALUMNI_ID NUMBER(10) NOT NULL,
                    USER_ID NUMBER(10) NOT NULL,
                    DEGREE_ID NUMBER(1) NOT NULL,
                    GPA FLOAT NOT NULL,
                    GRADUATION_DATE DATE NOT NULL, 
                    LINKEDIN VARCHAR2(100), 
                    COMPANY_NAME VARCHAR2(100) NOT NULL, 
                    COMPANY_CITY VARCHAR2(50) NOT NULL, 
                    COMPANY_STATE VARCHAR2(50) NOT NULL, 
                    COMPANY_ZIPCODE NUMBER(5) NOT NULL, 
                    JOB_TITLE VARCHAR2(500) NOT NULL, 
                    SALARY_RANGE VARCHAR2(100) NOT NULL, 

                    CONSTRAINT ALUMNI_PK PRIMARY KEY
                    (
                        ALUMNI_ID
                    ),
                    FOREIGN KEY
                    (
                        USER_ID 
                    )
                    REFERENCES ALL_USERS
                    (
                        USER_ID 
                    ),
                    FOREIGN KEY
                    (
                        DEGREE_ID 
                    )
                    REFERENCES DEGREE
                    (
                        DEGREE_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_alumni;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'ALUMNI';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_alumni;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_alumni;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- COURSE_CATALOG Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_course_catalog is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE COURSE_CATALOG 
                (
                    COURSE_ID NUMBER(4) NOT NULL,
                    COURSE_NAME VARCHAR2(500) NOT NULL, 

                    CONSTRAINT COURSE_CATALOG_PK PRIMARY KEY
                    (
                        COURSE_ID 
                    )
                    ENABLE 
                )';

    EXECUTE IMMEDIATE table_name;
END p_course_catalog;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'COURSE_CATALOG';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE COURSE_CATALOG ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_course_catalog;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE COURSE_CATALOG CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE COURSE_CATALOG CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_course_catalog;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- PROFESSOR Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_professor is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE PROFESSOR 
                (
                    PROFESSOR_ID NUMBER(3) NOT NULL,
                    COURSE_ID NUMBER(4) NOT NULL, 
                    PROFESSOR_NAME VARCHAR2(100) NOT NULL,
                    CONTACT_NUMBER NUMBER(10) NOT NULL,

                    CONSTRAINT PROFESSOR_PK PRIMARY KEY
                    (
                        PROFESSOR_ID
                    ),
                    FOREIGN KEY
                    (
                        COURSE_ID 
                    )
                    REFERENCES COURSE_CATALOG
                    (
                        COURSE_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_professor;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'PROFESSOR';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE PROFESSOR ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_professor;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE PROFESSOR CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PROFESSOR CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_professor;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- ALUMNI_COURSE Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_alumni_course is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE ALUMNI_COURSE 
                (
                    ALUMNI_ID NUMBER(10) NOT NULL,
                    COURSE_ID NUMBER(4) NOT NULL, 
                    COURSE_NAME VARCHAR2(500) NOT NULL,

                    CONSTRAINT ALUMNI_COURSE_PK PRIMARY KEY
                    (
                        ALUMNI_ID,
                        COURSE_ID
                    ),
                    FOREIGN KEY
                    (
                        ALUMNI_ID 
                    )
                    REFERENCES ALUMNI
                    (
                        ALUMNI_ID 
                    ),
                    FOREIGN KEY
                    (
                        COURSE_ID 
                    )
                    REFERENCES COURSE_CATALOG
                    (
                        COURSE_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_alumni_course;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'ALUMNI_COURSE';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI_COURSE ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_alumni_course;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI_COURSE CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE ALUMNI_COURSE CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_alumni_course;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- SHOP Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_shop is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE SHOP 
                (
                    SHOP_ID NUMBER(5) NOT NULL,
                    SHOP_NAME VARCHAR2(50) NOT NULL, 
                    SHOP_LOCATION VARCHAR2(50) NOT NULL,

                    CONSTRAINT SHOP_PK PRIMARY KEY
                    (
                        SHOP_ID 
                    )
                    ENABLE 
                )';

    EXECUTE IMMEDIATE table_name;
END p_shop;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'SHOP';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE SHOP ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_shop;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE SHOP CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE SHOP CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_shop;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- PRODUCT Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_product is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE PRODUCT 
                (
                    PRODUCT_ID NUMBER(5) NOT NULL,
                    PRODUCT_NAME VARCHAR2(50) NOT NULL, 

                    CONSTRAINT PRODUCT_PK PRIMARY KEY
                    (
                        PRODUCT_ID 
                    )
                    ENABLE 
                )';

    EXECUTE IMMEDIATE table_name;
END p_product;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'PRODUCT';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE PRODUCT ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_product;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE PRODUCT CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PRODUCT CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_product;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- PRICE Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_price is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE PRICE 
                (
                    PRODUCT_ID NUMBER(5) NOT NULL,
                    SHOP_ID NUMBER(5) NOT NULL, 
                    PRODUCT_PRICE FLOAT NOT NULL,
                    PRODUCT_STATUS VARCHAR2(20) NOT NULL,

                    CONSTRAINT PRICE_PK PRIMARY KEY
                    (
                        PRODUCT_ID,
                        SHOP_ID
                    ),
                    FOREIGN KEY
                    (
                        PRODUCT_ID 
                    )
                    REFERENCES PRODUCT
                    (
                        PRODUCT_ID 
                    ),
                    FOREIGN KEY
                    (
                        SHOP_ID 
                    )
                    REFERENCES SHOP
                    (
                        SHOP_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_price;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'PRICE';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE PRICE ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_price;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE PRICE CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PRICE CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_price;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- MARKETPLACE_PRODUCTS Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_marketplace_products is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE MARKETPLACE_PRODUCTS 
                (
                    MP_PROD_ID NUMBER(7) NOT NULL,
                    MP_PROD_NAME VARCHAR2(100) NOT NULL, 
                    MP_PROD_PRICE FLOAT NOT NULL,
                    MP_PROD_STATUS VARCHAR2(20) NOT NULL,
                    MP_PROD_DATE DATE NOT NULL,
                    SELLER_NUID NUMBER(7) NOT NULL,
                    BUYER_NUID NUMBER(7),

                    CONSTRAINT MARKETPLACE_PRODUCTS_PK PRIMARY KEY
                    (
                        MP_PROD_ID 
                    )
                    ENABLE 
                )';

    EXECUTE IMMEDIATE table_name;
END p_marketplace_products;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'MARKETPLACE_PRODUCTS';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE MARKETPLACE_PRODUCTS ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_marketplace_products;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE MARKETPLACE_PRODUCTS CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE MARKETPLACE_PRODUCTS CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_marketplace_products;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


--------------------------------- PICKUP Table --------------------------------

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE p_pickup is table_name varchar2(4000);
BEGIN
--- Create Table Query
    table_name := 'CREATE TABLE PICKUP 
                (
                    PICKUP_ID NUMBER(10) NOT NULL,
                    MP_PROD_ID NUMBER(7) NOT NULL, 
                    PICKUP_DATE DATE,
                    PICKUP_LOCATION VARCHAR2(50),
                    PICKUP_STATUS VARCHAR2(20),

                    CONSTRAINT PICKUP_PK PRIMARY KEY
                    (
                        PICKUP_ID,
                        MP_PROD_ID
                    ),
                    FOREIGN KEY
                    (
                        MP_PROD_ID 
                    )
                    REFERENCES MARKETPLACE_PRODUCTS
                    (
                        MP_PROD_ID 
                    )
                )';

    EXECUTE IMMEDIATE table_name;
END p_pickup;
/

DECLARE
    t_name varchar(50);
    cnt NUMBER;
BEGIN
    t_name := 'PICKUP';
    SELECT COUNT(*) INTO cnt FROM user_tables where table_name = t_name;
    IF(cnt>0) THEN
        DBMS_OUTPUT.PUT_LINE('TABLE PICKUP ALREADY EXISTS!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    ELSE
        BEGIN
            p_pickup;
        END;
        DBMS_OUTPUT.PUT_LINE('TABLE PICKUP CREATED SUCCESSFULLY!');
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN no_data_found THEN
    DBMS_OUTPUT.PUT_LINE('TABLE PICKUP CREATED SUCCESSFULLY!');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
    BEGIN
        p_pickup;
    END;
    WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END;
/
--COMMIT;


----------------------------------------------------- CREATE TABLE SCRIPT - END ----------------------------------------------------



----------------------------------------------------- CREATE ALUMNI_ID - INDEX ----------------------------------------------------

SET SERVEROUTPUT ON;

DECLARE
already_exists EXCEPTION;
PRAGMA exception_init ( already_exists, -955);
BEGIN
EXECUTE IMMEDIATE 'CREATE INDEX alumni_id_idx on alumni_course(alumni_id)';
dbms_output.put_line('INDEX ALUMNI_ID CREATED SUCCESSFULLY!');
EXCEPTION
WHEN already_exists THEN
dbms_output.put_line('INDEX ALUMNI_ID ALREADY EXISTS!');
WHEN others THEN
    DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG!');
    DBMS_OUTPUT.PUT_LINE('Format Error Stack : '||dbms_utility.Format_error_stack());
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
NULL;
END;
/

COMMIT;
