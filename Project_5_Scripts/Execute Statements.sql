SET SERVEROUTPUT ON;

EXEC project_admin.WELCOME_TO_USA;



--- VIEWS 

SELECT * FROM project_admin.VW_GPA;
SELECT * FROM project_admin.VW_ROLE;
SELECT * FROM project_admin.VW_DMDD;
SELECT * FROM project_admin.VW_COMPARE;
SELECT * FROM project_admin.VW_JOBTITLE;


--- STORED PROCEDURES 

EXEC project_admin.INSERT_MARKET_PROD(1171,'LAPTOP',500,'SOLD',1540019,1540015,to_date('12/13/2021', 'MM/DD/YYYY'), 'Boylston','SCHEDULED');
--- SELECT * FROM project_admin.MARKETPLACE_PRODUCTS;
--- SELECT * FROM project_admin.PICKUP;

EXEC project_admin.update_pickup(1251,to_date('12/19/2021', 'MM/DD/YYYY'),'Park Drive','Scheduled');
--- SELECT * FROM project_admin.MARKETPLACE_PRODUCTS;
--- SELECT * FROM project_admin.PICKUP;
--- DELETE project_admin.PICKUP where pickup_id = 1251;
--- DELETE project_admin.MARKETPLACE_PRODUCTS where MP_PROD_ID = 1171;

EXEC project_admin.Compare_Courses('Data Management for Analytics');

EXEC project_admin.Compare_Products('Tofu');



--- FUNCTIONS

--- SELECT NUID, getUserNameByNUID(NUID) FROM project_admin.CURRENT_STUDENTS; 
--- SELECT NUID, getCountOfProductsSold(NUID) FROM project_admin.CURRENT_STUDENTS; 
--- SELECT NUID, getSalesByNUID(NUID) FROM project_admin.CURRENT_STUDENTS; 
SELECT NUID, project_admin.getUserNameByNUID(NUID), project_admin.getCountOfProductsSold(NUID), project_admin.getSalesByNUID(NUID) FROM project_admin.CURRENT_STUDENTS; 

DECLARE
    cnt_sellers NUMBER := 0;
BEGIN
    cnt_sellers := project_admin.findSellers('Boston', 'Massachusetts', 22115);
    DBMS_OUTPUT.put_line('Total  No. of Sellers in Boston : ' || cnt_sellers);
END;

















