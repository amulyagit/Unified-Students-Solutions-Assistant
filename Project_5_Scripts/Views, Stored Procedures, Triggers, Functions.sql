------------------------------------------------- VIEWS, STORED PROCEDURES, TRIGGERS, FUNCTIONS --------------------------------------------------

--- VIEWS

--------------------------------------------- View 1 : BASED ON GPA WHAT IS THEIR SALARY AND COMPANY ------------------------------------------------------
CREATE OR REPLACE VIEW VW_GPA AS
SELECT A.ALUMNI_ID, D.DEGREE_NAME, A.GPA, A.JOB_TITLE, A.COMPANY_NAME, A.SALARY_RANGE FROM ALUMNI A 
LEFT OUTER JOIN DEGREE D ON A.DEGREE_ID = D.DEGREE_ID ORDER BY GPA;

---------------------------------------------- View 2 : LIST OF ALUMNI FOR A PARTICULAR ROLE AND WHAT COURSES THEY TOOK ------------------------------------
CREATE OR REPLACE VIEW VW_ROLE AS
SELECT A.ALUMNI_ID, D.USER_NAME, C.DEGREE_NAME, A.GPA, A.COMPANY_NAME, A.JOB_TITLE, A.SALARY_RANGE, B.COURSE_ID, B.COURSE_NAME 
FROM ALUMNI A, ALUMNI_COURSE B, DEGREE C, ALL_USERS D
WHERE  A.ALUMNI_ID = B.ALUMNI_ID 
AND A.DEGREE_ID = C.DEGREE_ID 
AND A.USER_ID = D.USER_ID;

---------------------------------------------- View 3 : ALUMNI WHO HAVE TAKEN DMDD AND HAVE LANDED DIFFERENT ROLES ------------------------------------------
CREATE OR REPLACE VIEW VW_DMDD AS
SELECT DISTINCT(A.ALUMNI_ID), D.USER_NAME,C.DEGREE_NAME, A.GPA, A.COMPANY_NAME, A.JOB_TITLE, A.SALARY_RANGE, B.COURSE_ID, B.COURSE_NAME 
FROM ALUMNI A, ALUMNI_COURSE B, DEGREE C, ALL_USERS D
WHERE COURSE_ID=5010
AND A.DEGREE_ID = C.DEGREE_ID
AND A.USER_ID = D.USER_ID;

----------------------------------------------- View 4 : COMPARE PRODUCT PRICES ------------------------------------------------------------------------------
CREATE OR REPLACE VIEW VW_COMPARE AS
SELECT PRODUCT.PRODUCT_ID, PRODUCT.PRODUCT_NAME, PRICE.SHOP_ID, PRICE.PRODUCT_PRICE, PRICE.PRODUCT_STATUS FROM PRICE 
LEFT OUTER JOIN PRODUCT ON PRICE.PRODUCT_ID=PRODUCT.PRODUCT_ID 
WHERE PRICE.PRODUCT_STATUS='Available';

------------------------------------------------ View 5 : STATE AND COMPANY BASED ON JOB TITLES AND DEGREE --------------------------------------------------
CREATE OR REPLACE VIEW VW_JOBTITLE AS
SELECT B.DEGREE_NAME,  A.JOB_TITLE, A.COMPANY_NAME, A.COMPANY_STATE, A.SALARY_RANGE FROM ALUMNI A, DEGREE B WHERE B.DEGREE_ID = 1 AND A.JOB_TITLE = 'Business Analyst';

---------------------------------------------------------- VIEWS END --------------------------------------------------



--- TRIGGER

------------------------------------------------- TRIGGER To Update Pickup Details -------------------------------------------------------

CREATE OR REPLACE TRIGGER pickup_details_trig 
AFTER INSERT OR UPDATE ON PICKUP
DECLARE
id1 number;
t_pickup_date pickup.pickup_date%TYPE;
t_PICKUP_LOCATION pickup.pickup_location%TYPE;
t_PICKUP_STATUS pickup.pickup_status%TYPE;
BEGIN
SELECT max(pickup_id) into id1 from pickup;
select pickup_date, pickup_location, pickup_status into t_pickup_date, t_PICKUP_LOCATION ,t_PICKUP_STATUS from pickup where pickup_id = id1;
DBMS_OUTPUT.PUT_LINE('Congratulations on buying the product! Following are your pickup idetails.');
DBMS_OUTPUT.PUT_LINE('PICKUP ID:' || id1);
DBMS_OUTPUT.PUT_LINE('PICKUP DATE:' || t_pickup_date );
DBMS_OUTPUT.PUT_LINE('PICKUP LOCATION:' || t_pickup_location);
DBMS_OUTPUT.PUT_LINE('PICKUP STATUS:' || t_PICKUP_STATUS);
DBMS_OUTPUT.PUT_LINE('You may use update_pickup to update pickup details');
END;
/

---------------------------------------------------------- TRIGGER END --------------------------------------------------



--- STORED PROCEDURES
---------------------------------------------------------- Stored Procedure 1 --------------------------------------------------
-- 1. INSERT data in MARKETPLACE_PRODCUTS
-- 2. UPDATE if exists 
-- 3. If Product Status = "SOLD" then add to Pickup table

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE INSERT_MARKET_PROD(P_MP_PROD_ID IN MARKETPLACE_PRODUCTS.MP_PROD_ID%TYPE,
                                    P_MP_NAME IN marketplace_products.mp_prod_name%TYPE,
                                    P_MP_PRICE IN marketplace_products.mp_prod_price%TYPE,
                                    P_MP_PROD_STATUS IN marketplace_products.mp_prod_status%TYPE,
                                    P_SELLER_NUID IN marketplace_products.seller_nuid%TYPE,
                                    P_BUYER_NUID IN marketplace_products.buyer_nuid%TYPE DEFAULT NULL,
                                    P_PICKUP_DATE IN pickup.pickup_date%TYPE DEFAULT NULL,
                                    P_PICKUP_LOCATION IN pickup.pickup_location%TYPE DEFAULT 'TO BE DECIDED',
                                    P_PICKUP_STATUS pickup.pickup_status%TYPE DEFAULT 'TO BE SCHEDULED')
IS
cUnique Number;
cMax NUMBER;
status VARCHAR2(10);
SOLD_ERROR EXCEPTION;

BEGIN
select count(*) into cUnique from MARKETPLACE_PRODUCTS where MP_PROD_ID = P_MP_PROD_ID;
select MAX(PICKUP_ID) into cMax from pickup;

IF (cUnique >=1)THEN
UPDATE MARKETPLACE_PRODUCTS SET MP_PROD_STATUS = P_MP_PROD_STATUS  WHERE MP_PROD_ID = P_MP_PROD_ID;
UPDATE MARKETPLACE_PRODUCTS SET mp_prod_price = P_MP_PRICE WHERE MP_PROD_ID = P_MP_PROD_ID;
UPDATE MARKETPLACE_PRODUCTS SET buyer_nuid = P_BUYER_NUID WHERE MP_PROD_ID = P_MP_PROD_ID;
ELSE
INSERT INTO MARKETPLACE_PRODUCTS (MP_PROD_ID, mp_prod_name, mp_prod_price, MP_PROD_STATUS, MP_PROD_DATE, SELLER_NUID,buyer_nuid)
VALUES(P_MP_PROD_ID, P_MP_NAME, P_MP_PRICE, P_MP_PROD_STATUS,SYSDATE, P_SELLER_NUID,P_BUYER_NUID);
END IF;

select MP_PROD_STATUS into status from MARKETPLACE_PRODUCTS where MP_PROD_ID = P_MP_PROD_ID;


IF (status = 'SOLD')THEN
INSERT INTO pickup(PICKUP_ID, MP_PROD_ID, PICKUP_STATUS, pickup_date,pickup_location)
VALUES (coalesce(cMax,0)+1,P_MP_PROD_ID,P_PICKUP_STATUS,P_PICKUP_DATE,P_PICKUP_LOCATION);
END IF;
commit;

IF p_pickup_status = 'SCHEDULED' THEN
DBMS_OUTPUT.PUT_LINE('YOU ARE ALL SET');
ELSE
RAISE SOLD_ERROR;
END IF;


EXCEPTION
WHEN SOLD_ERROR THEN
DBMS_OUTPUT.PUT_LINE('PLEASE USE SETUP A PICKUP DATE AND LOCATION');
COMMIT;
END;
/

--- EXEC INSERT_MARKET_PROD(1171,'LAPTOP',500,'SOLD',1540019,1540015,to_date('12/13/2021', 'MM/DD/YYYY'), 'Boylston','SCHEDULED');
--- SELECT * FROM MARKETPLACE_PRODUCTS;
--- SELECT * FROM PICKUP;

---------------------------------------------------------- Stored Procedure 2 --------------------------------------------------
-- To update Pickup - Date, Location, Status

CREATE OR REPLACE PROCEDURE update_pickup(p_pickup_id in pickup.pickup_id%TYPE,
                                    P_pickup_date IN pickup.pickup_date%TYPE,
                                    P_PICKUP_LOCATION IN pickup.pickup_location%TYPE,
                                    P_PICKUP_STATUS pickup.pickup_status%TYPE)
IS
id1 number;
BEGIN
id1:=0;
Select p_pickup_id into id1 from pickup where p_pickup_id = pickup_id;

IF (id1>=1) Then
UPDATE pickup SET pickup_date = P_pickup_date where p_pickup_id = pickup_id;
UPDATE pickup SET pickup_location = P_PICKUP_LOCATION where p_pickup_id = pickup_id;
UPDATE pickup SET pickup_status = P_PICKUP_STATUS where p_pickup_id = pickup_id;
Else
DBMS_OUTPUT.PUT_LINE('PICKUP ID DOES NOT EXIST');
END IF;
EXCEPTION
when others then
DBMS_OUTPUT.PUT_LINE('SOMETHING WENT WRONG');
END;
/

--- EXEC update_pickup(1251,to_date('12/19/2021', 'MM/DD/YYYY'),'Park Drive','Scheduled');
--- SELECT * FROM MARKETPLACE_PRODUCTS;
--- SELECT * FROM PICKUP;
--- DELETE PICKUP where pickup_id = 1251;
--- DELETE MARKETPLACE_PRODUCTS where MP_PROD_ID = 1171;

---------------------------------------------------------- Stored Procedure 3 --------------------------------------------------
-- To Compare Courses

CREATE or replace PROCEDURE Compare_Courses(crse_name in VW_DMDD.Course_name%type)
IS
v_job VARCHAR2(100);
v_gpa float;
sal_range VARCHAR2(100);
Begin

for al in
(select job_title, gpa, salary_range from VW_DMDD where course_name = crse_name)
LOOP
DBMS_OUTPUT.PUT_LINE('JOB TITLE: ' ||  al.job_title || '   GPA: ' || al.gpa || '   SALARY RANGE: ' || al.salary_range);
END LOOP;
Exception
when no_data_found then
DBMS_OUTPUT.PUT_LINE('No data found');
when others then
DBMS_OUTPUT.PUT_LINE('Something went wrong.');
END;
/

--- EXEC Compare_Courses('Data Management for Analytics');

---------------------------------------------------------- Stored Procedure 4 --------------------------------------------------
-- To Compare Products 

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE Compare_Products(item in VW_COMPARE.PRODUCT_NAME%TYPE)
IS
shop1 FLOAT;
shop2 FLOAT;
shop3 FLOAT;
shop4 FLOAT;
shop5 FLOAT;

BEGIN

Select product_price into shop1 from VW_COMPARE where PRODUCT_NAME = item and SHOP_ID = 701;
Select product_price into shop2 from VW_COMPARE where PRODUCT_NAME = item and SHOP_ID = 702;
Select product_price into shop3 from VW_COMPARE where PRODUCT_NAME = item and SHOP_ID = 703;
Select product_price into shop4 from VW_COMPARE where PRODUCT_NAME = item and SHOP_ID = 704;
Select product_price into shop5 from VW_COMPARE where PRODUCT_NAME = item and SHOP_ID = 700;

DBMS_OUTPUT.PUT_LINE('Walmart: ' || shop1);
DBMS_OUTPUT.PUT_LINE('Stop and Shop: ' || shop2);
DBMS_OUTPUT.PUT_LINE('Patel Brothers: ' || shop3);
DBMS_OUTPUT.PUT_LINE('Amazon: ' || shop4);
DBMS_OUTPUT.PUT_LINE('Target: ' || shop5);

IF (shop1 < shop2 and shop1<shop3 and shop1 < shop4 and shop1 < shop5)THEN
DBMS_OUTPUT.PUT_LINE('Walmart at Quincy has the cheapest ' || item);
ELSIF (shop2 < shop1 and shop2 < shop3 and shop2 < shop4 and shop2 < shop5)THEN
DBMS_OUTPUT.PUT_LINE('Stop and Shop at Mission Hill has the cheapest ' || item);
ELSIF (shop3 < shop1 and shop3 < shop2 and shop3 < shop4 and shop3 < shop5)THEN
DBMS_OUTPUT.PUT_LINE('Patel Brothers at Waltham has the cheapest ' || item);
ELSIF (shop4 < shop1 and shop4 < shop2 and shop4 < shop3 and shop4 < shop5)THEN
DBMS_OUTPUT.PUT_LINE('Amazon has the cheapest ' || item);
ELSE
DBMS_OUTPUT.PUT_LINE('Target at Boylston has the cheapest ' || item);
END IF;

EXCEPTION
when others then
DBMS_OUTPUT.PUT_LINE('All Stores Do Not Have This Product To Compare');
COMMIT;
END;
/

--- EXEC Compare_Products('Tofu');



---------------------------------------------------------- STORED PROCEDURE END --------------------------------------------------



--- FUNCTIONS

---------------------------------------------- FUNCTION 1 : Find Username of Current Students by NUID ---------------------------------------------

CREATE OR REPLACE FUNCTION getUserNameByNUID
   (nu_id NUMBER)
   RETURN VARCHAR2
IS
   u_name VARCHAR2(100);
   uid NUMBER;
   nid NUMBER;
   CURSOR c1 IS
   SELECT USER_NAME FROM ALL_USERS WHERE USER_ID in (SELECT USER_ID FROM CURRENT_STUDENTS WHERE NUID = nu_id) ;

BEGIN
   OPEN c1;
   FETCH c1 INTO u_name;

   IF c1%NOTFOUND THEN
      u_name := 'Username Not Found!';
   END IF;

   CLOSE c1;

RETURN u_name;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

--- SELECT NUID, getUserNameByNUID(NUID) FROM CURRENT_STUDENTS; 

---------------------- FUNCTION 2 : Get Total Count of Marketplace Products sold by a Seller with particular NUID --------------------------

CREATE OR REPLACE FUNCTION getCountOfProductsSold
   (nu_id NUMBER)
   RETURN NUMBER
IS
   cnumber NUMBER; 

   CURSOR c1 IS
   SELECT COUNT(MP_PROD_ID) FROM MARKETPLACE_PRODUCTS WHERE SELLER_NUID = nu_id; 

BEGIN

   OPEN c1;
   FETCH c1 INTO cnumber;

   IF c1%notfound THEN
      cnumber := 0;
   END IF;

   CLOSE c1;

RETURN cnumber;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

--- SELECT NUID, getCountOfProductsSold(NUID) FROM CURRENT_STUDENTS; 

---------------------- FUNCTION 3 : Get Total Sum of Sales of Marketplace Products done by a Seller with particular NUID --------------------------

CREATE OR REPLACE FUNCTION getSalesByNUID
   (nu_id NUMBER)
   RETURN NUMBER
IS
   cnumber NUMBER; 

   CURSOR c1 IS
   SELECT SUM(MP_PROD_PRICE) FROM MARKETPLACE_PRODUCTS WHERE SELLER_NUID = nu_id; 

BEGIN

   OPEN c1;
   FETCH c1 INTO cnumber;

   IF c1%notfound THEN
      cnumber := 0;
   END IF;

   CLOSE c1;

RETURN cnumber;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

--- SELECT NUID, getSalesByNUID(NUID) FROM CURRENT_STUDENTS; 



--- SELECT NUID, getUserNameByNUID(NUID), getCountOfProductsSold(NUID), getSalesByNUID(NUID) FROM CURRENT_STUDENTS; 



--- FUNCTION 4 : Get Marketplace Sellers in Boston by ZipCode

CREATE OR REPLACE FUNCTION findSellers
   (city_val VARCHAR2, state_val VARCHAR2, zipc NUMBER)
   RETURN NUMBER
IS
   cnumber NUMBER;

   CURSOR c1 IS
   SELECT COUNT(SELLER_NUID) FROM MARKETPLACE_PRODUCTS WHERE SELLER_NUID IN 
   (SELECT NUID FROM CURRENT_STUDENTS WHERE USER_ID IN 
   (SELECT USER_ID FROM ALL_USERS WHERE CITY=city_val AND  STATE = state_val AND ZIPCODE = zipc)) ; 

BEGIN

   OPEN c1;
   FETCH c1 INTO cnumber;
   cnumber:=0;
   FOR rec in (SELECT DISTINCT(SELLER_NUID) FROM MARKETPLACE_PRODUCTS WHERE SELLER_NUID IN 
   (SELECT NUID FROM CURRENT_STUDENTS WHERE USER_ID IN 
   (SELECT USER_ID FROM ALL_USERS WHERE CITY=city_val AND  STATE = state_val AND ZIPCODE = zipc))) LOOP
   cnumber := cnumber + 1;
   DBMS_OUTPUT.PUT_LINE(rec.SELLER_NUID);
   DBMS_OUTPUT.PUT_LINE(getUserNameByNUID(rec.SELLER_NUID));
   
   END LOOP;

   IF c1%notfound THEN
      cnumber := 0;
   END IF;

   CLOSE c1;

RETURN cnumber;

EXCEPTION
WHEN OTHERS THEN
   raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/

--- DECLARE
    --- cnt_sellers NUMBER := 0;
--- BEGIN
    --- cnt_sellers := findSellers('Boston', 'Massachusetts', 22115);
    --- DBMS_OUTPUT.put_line('Total  No. of Sellers in Boston : ' || cnt_sellers);
--- END;

-------------------------------------------------------------- FUNCTIONS END --------------------------------------------------------------












