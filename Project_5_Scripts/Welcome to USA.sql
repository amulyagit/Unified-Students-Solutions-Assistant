------------------------------------------------------ Welcome to USA (Unified Solutions Assistant) ----------------------------------------------------

CREATE OR REPLACE PROCEDURE WELCOME_TO_USA
IS
BEGIN
        dbms_output.put_line('HELLO! WELCOME TO Unified Solutions Assistant (USA)!');
        
        dbms_output.put_line('AVAILABLE ACTIONS :');
        
        dbms_output.put_line('--- ACCESS VIEWS! ---');
        dbms_output.put_line('1. VIEW ALUMNI INFORMATION BASED ON GPA');
        dbms_output.put_line('2. VIEW LIST OF ALUMNI FOR A PARTICULAR ROLE AND WHAT COURSES THEY TOOK');
        dbms_output.put_line('3. VIEW ALUMNI WHO HAVE TAKEN DMDD AND HAVE LANDED DIFFERENT ROLES');
        dbms_output.put_line('4. VIEW COMPARISON OF PRODUCT PRICES');
        dbms_output.put_line('5. VIEW ALUMNI STATE AND COMPANY BASED ON JOB TITLES AND DEGREE');
        dbms_output.put_line('');
    
        dbms_output.put_line('--- ACCESS STORED PROCEDURES! ---');
        dbms_output.put_line('1. INSERTING DATA IN MARKETPLACE PRODUCTS USING INSERT_MARKET_PROD');
        dbms_output.put_line('2. PICKUP TABLE - DATE, LOCATION AND STATUS USING update_pickup');
        dbms_output.put_line('3. COMPARE COURSES USING Compare_Courses');
        dbms_output.put_line('4. COMPARE PRODUCTS USING Compare_Products');
        
        dbms_output.put_line('--- ACCESS FUNCTIONS! ---');
        dbms_output.put_line('1. Find Username of Current Students by NUID USING getUserNameByNUID');
        dbms_output.put_line('2. Get Total Count of Marketplace Products sold by a Seller with particular NUID USING getCountOfProductsSold');
        dbms_output.put_line('3. Get Total Sum of Sales of Marketplace Products done by a Seller with particular NUID USING getSalesByNUID');
        dbms_output.put_line('4. Get Marketplace Sellers in Boston by ZipCode USING findSellers');
        
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
        dbms_output.put_line(dbms_utility.format_error_backtrace);
        ROLLBACK;
END WELCOME_TO_USA;
/

--- EXEC WELCOME_TO_USA;