CREATE DEFINER=`root`@`localhost` PROCEDURE `myPhar`(my_login varchar(255), date_1 DATE, IN date_2 DATE)
    DETERMINISTIC
BEGIN
	if date_1 < date_2 then
    begin
		create table if not exists pharInfo(first_name varchar(255), last_name varchar(255), pharmacy varchar(255), cost int);
        TRUNCATE pharInfo;
        INSERT INTO pharInfo SELECT customer.first_name AS first_name, 
		customer.last_name AS last_name,
        pharmacy.pharmacy_name AS pharmacy,
        order_item.quantity*medicine.price as order_id
        FROM (((customer INNER JOIN `order`) INNER JOIN order_item) INNER JOIN medicine) INNER JOIN pharmacy
		ON customer.login = my_login 
		AND customer.customer_id = `order`.customer_id 
		AND `order`.order_id = order_item.order_id
        AND medicine.medicine_id = order_item.medicine_id
        AND pharmacy.pharmacy_id = `order`.pharmacy_id
		WHERE `order`.order_date BETWEEN date_1 AND date_2;
	end;
    end if;
END