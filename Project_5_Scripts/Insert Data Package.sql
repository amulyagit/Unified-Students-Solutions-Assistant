-------------------------------------------------- INSERT DATA (PACKAGE) SCRIPT - DML -----------------------------------------------



CREATE OR REPLACE PACKAGE INSERT_DATA
AS
PROCEDURE INSERT_ALL_USERS(USER_ID in NUMBER, 
                            USER_NAME in VARCHAR2, 
                            GENDER in VARCHAR2, 
                            CONTACT_NUMBER in NUMBER, 
                            EMAIL_ADDRESS in VARCHAR2, 
                            CITY in VARCHAR2, 
                            STATE in VARCHAR2, 
                            ZIPCODE in VARCHAR2
                        );

PROCEDURE INSERT_CURRENT_STUDENTS( 
                            USER_ID in NUMBER, 
                            NUID in NUMBER, 
                            EXPECTED_GRADUATION_DATE in DATE
                        );

PROCEDURE INSERT_DEGREE( 
                        DEGREE_ID in NUMBER, 
                        DEGREE_NAME in VARCHAR2, 
                        DEGREE_DEPARTMENT in VARCHAR2
                    );

PROCEDURE INSERT_ALUMNI( 
                        ALUMNI_ID in NUMBER, 
                        USER_ID in NUMBER, 
                        DEGREE_ID in NUMBER,
                        GPA in FLOAT,
                        GRADUATION_DATE in DATE,
                        LINKEDIN in VARCHAR2,
                        COMPANY_NAME in VARCHAR2,
                        COMPANY_CITY in VARCHAR2,
                        COMPANY_STATE in VARCHAR2,
                        COMPANY_ZIPCODE in NUMBER,
                        JOB_TITLE in VARCHAR2,
                        SALARY_RANGE in VARCHAR2 
                    );

PROCEDURE INSERT_COURSE_CATALOG( 
                        COURSE_ID in NUMBER, 
                        COURSE_NAME in VARCHAR2
                    );

PROCEDURE INSERT_PROFESSOR( 
                            PROFESSOR_ID in NUMBER, 
                            COURSE_ID in NUMBER,
                            PROFESSOR_NAME in VARCHAR2,
                            CONTACT_NUMBER in NUMBER 
                        );   

PROCEDURE INSERT_ALUMNI_COURSE( 
                            ALUMNI_ID in NUMBER, 
                            COURSE_ID in NUMBER,
                            COURSE_NAME in VARCHAR2
                        );                         

PROCEDURE INSERT_SHOP( 
                        SHOP_ID in NUMBER, 
                        SHOP_NAME in VARCHAR2,
                        SHOP_LOCATION in VARCHAR2
                    );      

PROCEDURE INSERT_PRODUCT( 
                        PRODUCT_ID in NUMBER, 
                        PRODUCT_NAME in VARCHAR2
                    ); 

PROCEDURE INSERT_PRICE( 
                        PRODUCT_ID in NUMBER, 
                        SHOP_ID in NUMBER,
                        PRODUCT_PRICE in FLOAT,
                        PRODUCT_STATUS VARCHAR2
                    ); 

PROCEDURE INSERT_MARKETPLACE_PRODUCTS( 
                        MP_PROD_ID in NUMBER, 
                        MP_PROD_NAME in VARCHAR2,
                        MP_PROD_PRICE in FLOAT,
                        MP_PROD_STATUS in VARCHAR2,
                        MP_PROD_DATE in DATE,
                        SELLER_NUID in NUMBER,
                        BUYER_NUID in NUMBER
                    );                    

PROCEDURE INSERT_PICKUP( 
                        PICKUP_ID in NUMBER, 
                        MP_PROD_ID in NUMBER,
                        PICKUP_DATE in DATE,
                        PICKUP_LOCATION in VARCHAR2,
                        PICKUP_STATUS in VARCHAR2
                    );       

END;
/

COMMIT;

--------------------------------- Insert ALL_USERS --------------------------------
CREATE OR REPLACE PACKAGE BODY INSERT_DATA
AS
PROCEDURE INSERT_ALL_USERS(USER_ID in NUMBER, 
                            USER_NAME in VARCHAR2, 
                            GENDER in VARCHAR2, 
                            CONTACT_NUMBER in NUMBER, 
                            EMAIL_ADDRESS in VARCHAR2, 
                            CITY in VARCHAR2, 
                            STATE in VARCHAR2, 
                            ZIPCODE in VARCHAR2
                        )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO ALL_USERS (USER_ID, USER_NAME, GENDER, CONTACT_NUMBER, EMAIL_ADDRESS, CITY, STATE, ZIPCODE) 
VALUES (USER_ID, USER_NAME, GENDER, CONTACT_NUMBER, EMAIL_ADDRESS, CITY, STATE, ZIPCODE);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN ALL_USERS TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN ALL_USERS TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_ALL_USERS;



--------------------------------- Insert CURRENT_STUDENTS --------------------------------
PROCEDURE INSERT_CURRENT_STUDENTS( 
                            USER_ID in NUMBER, 
                            NUID in NUMBER, 
                            EXPECTED_GRADUATION_DATE in DATE
                        )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO CURRENT_STUDENTS (USER_ID, NUID, EXPECTED_GRADUATION_DATE) 
VALUES (USER_ID, NUID, EXPECTED_GRADUATION_DATE);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN CURRENT_STUDENTS TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN CURRENT_STUDENTS TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_CURRENT_STUDENTS;



--------------------------------- Insert DEGREE --------------------------------
PROCEDURE INSERT_DEGREE( 
                        DEGREE_ID in NUMBER, 
                        DEGREE_NAME in VARCHAR2, 
                        DEGREE_DEPARTMENT in VARCHAR2
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO DEGREE (DEGREE_ID, DEGREE_NAME, DEGREE_DEPARTMENT) 
VALUES (DEGREE_ID, DEGREE_NAME, DEGREE_DEPARTMENT);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN DEGREE TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN DEGREE TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_DEGREE;



--------------------------------- Insert ALUMNI --------------------------------
PROCEDURE INSERT_ALUMNI( 
                        ALUMNI_ID in NUMBER, 
                        USER_ID in NUMBER, 
                        DEGREE_ID in NUMBER,
                        GPA in FLOAT,
                        GRADUATION_DATE in DATE,
                        LINKEDIN in VARCHAR2,
                        COMPANY_NAME in VARCHAR2,
                        COMPANY_CITY in VARCHAR2,
                        COMPANY_STATE in VARCHAR2,
                        COMPANY_ZIPCODE in NUMBER,
                        JOB_TITLE in VARCHAR2,
                        SALARY_RANGE in VARCHAR2 
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO ALUMNI (ALUMNI_ID, USER_ID, DEGREE_ID, GPA, GRADUATION_DATE, LINKEDIN, COMPANY_NAME, COMPANY_CITY, COMPANY_STATE, COMPANY_ZIPCODE, JOB_TITLE, SALARY_RANGE) 
VALUES (ALUMNI_ID, USER_ID, DEGREE_ID, GPA, GRADUATION_DATE, LINKEDIN, COMPANY_NAME, COMPANY_CITY, COMPANY_STATE, COMPANY_ZIPCODE, JOB_TITLE, SALARY_RANGE);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN ALUMNI TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN ALUMNI TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_ALUMNI;



--------------------------------- Insert COURSE_CATALOG --------------------------------
PROCEDURE INSERT_COURSE_CATALOG( 
                            COURSE_ID in NUMBER, 
                            COURSE_NAME in VARCHAR2
                        )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO COURSE_CATALOG (COURSE_ID, COURSE_NAME)
VALUES (COURSE_ID, COURSE_NAME);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN COURSE_CATALOG TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN COURSE_CATALOG TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_COURSE_CATALOG;



--------------------------------- Insert PROFESSOR --------------------------------
PROCEDURE INSERT_PROFESSOR( 
                            PROFESSOR_ID in NUMBER, 
                            COURSE_ID in NUMBER,
                            PROFESSOR_NAME in VARCHAR2,
                            CONTACT_NUMBER in NUMBER 
                        )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO PROFESSOR (PROFESSOR_ID, COURSE_ID, PROFESSOR_NAME, CONTACT_NUMBER)
VALUES (PROFESSOR_ID, COURSE_ID, PROFESSOR_NAME, CONTACT_NUMBER);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN PROFESSOR TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN PROFESSOR TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_PROFESSOR;



--------------------------------- Insert ALUMNI_COURSE --------------------------------
PROCEDURE INSERT_ALUMNI_COURSE( 
                            ALUMNI_ID in NUMBER, 
                            COURSE_ID in NUMBER,
                            COURSE_NAME in VARCHAR2
                        )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO ALUMNI_COURSE (ALUMNI_ID, COURSE_ID, COURSE_NAME)
VALUES (ALUMNI_ID, COURSE_ID, COURSE_NAME);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN ALUMNI_COURSE TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN ALUMNI_COURSE TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_ALUMNI_COURSE;



--------------------------------- Insert SHOP --------------------------------
PROCEDURE INSERT_SHOP( 
                        SHOP_ID in NUMBER, 
                        SHOP_NAME in VARCHAR2,
                        SHOP_LOCATION in VARCHAR2
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO SHOP (SHOP_ID, SHOP_NAME, SHOP_LOCATION)
VALUES (SHOP_ID, SHOP_NAME, SHOP_LOCATION);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN SHOP TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN SHOP TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_SHOP;



--------------------------------- Insert PRODUCT --------------------------------
PROCEDURE INSERT_PRODUCT( 
                        PRODUCT_ID in NUMBER, 
                        PRODUCT_NAME in VARCHAR2
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO PRODUCT (PRODUCT_ID, PRODUCT_NAME)
VALUES (PRODUCT_ID, PRODUCT_NAME);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN PRODUCT TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN PRODUCT TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_PRODUCT;



--------------------------------- Insert PRICE --------------------------------
PROCEDURE INSERT_PRICE( 
                        PRODUCT_ID in NUMBER, 
                        SHOP_ID in NUMBER,
                        PRODUCT_PRICE in FLOAT,
                        PRODUCT_STATUS VARCHAR2
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO PRICE (PRODUCT_ID, SHOP_ID, PRODUCT_PRICE, PRODUCT_STATUS)
VALUES (PRODUCT_ID, SHOP_ID, PRODUCT_PRICE, PRODUCT_STATUS);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN PRICE TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN PRICE TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_PRICE;



--------------------------------- Insert MARKETPLACE_PRODUCTS --------------------------------
PROCEDURE INSERT_MARKETPLACE_PRODUCTS( 
                        MP_PROD_ID in NUMBER, 
                        MP_PROD_NAME in VARCHAR2,
                        MP_PROD_PRICE in FLOAT,
                        MP_PROD_STATUS in VARCHAR2,
                        MP_PROD_DATE in DATE,
                        SELLER_NUID in NUMBER,
                        BUYER_NUID in NUMBER
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO MARKETPLACE_PRODUCTS (MP_PROD_ID, MP_PROD_NAME, MP_PROD_PRICE, MP_PROD_STATUS, MP_PROD_DATE, SELLER_NUID, BUYER_NUID)
VALUES (MP_PROD_ID, MP_PROD_NAME, MP_PROD_PRICE, MP_PROD_STATUS, MP_PROD_DATE, SELLER_NUID, BUYER_NUID);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN MARKETPLACE_PRODUCTS TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN MARKETPLACE_PRODUCTS TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_MARKETPLACE_PRODUCTS;



--------------------------------- Insert PICKUP --------------------------------
PROCEDURE INSERT_PICKUP( 
                        PICKUP_ID in NUMBER, 
                        MP_PROD_ID in NUMBER,
                        PICKUP_DATE in DATE,
                        PICKUP_LOCATION in VARCHAR2,
                        PICKUP_STATUS in VARCHAR2
                    )
AS 
BEGIN 
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
INSERT INTO PICKUP (PICKUP_ID, MP_PROD_ID, PICKUP_DATE, PICKUP_LOCATION, PICKUP_STATUS)
VALUES (PICKUP_ID, MP_PROD_ID, PICKUP_DATE, PICKUP_LOCATION, PICKUP_STATUS);
DBMS_OUTPUT.PUT_LINE('ROW SUCCESSFULLY INSERTED IN PICKUP TABLE!');
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
COMMIT;
EXCEPTION
WHEN dup_val_on_index THEN
DBMS_OUTPUT.PUT_LINE('DUPLICATE VALUE FOUND, PLEASE INSERT A DIFFERENT VALUE!');
WHEN others THEN 
DBMS_OUTPUT.PUT_LINE('ERROR OCCURED WHILE INSERTING DATA IN PICKUP TABLE!');
ROLLBACK;
DBMS_OUTPUT.PUT_LINE('ERROR ENCOUNTERED IS : ');
DBMS_OUTPUT.PUT_LINE(dbms_utility.format_error_stack);
DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------');
END INSERT_PICKUP;

END;
/

COMMIT;

-------------------------------------------------- INSERT DATA (PACKAGE) SCRIPT - END -----------------------------------------------