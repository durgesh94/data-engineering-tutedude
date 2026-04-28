/*
===============================================================================
Assignment 1 - Stored Procedures
Question covered: 29
===============================================================================
*/

USE shophub_analytics;

DELIMITER $$

DROP PROCEDURE IF EXISTS sp_calculate_dynamic_discount $$

CREATE PROCEDURE sp_calculate_dynamic_discount(
    IN p_customer_unique_id CHAR(32),
    IN p_order_id CHAR(32),
    OUT p_discount_pct DECIMAL(5, 2),
    OUT p_discount_reason VARCHAR(100),
    OUT p_discount_amount DECIMAL(10, 2),
    OUT p_final_order_value DECIMAL(10, 2)
)
BEGIN
    DECLARE v_order_value DECIMAL(10, 2) DEFAULT 0;
    DECLARE v_previous_orders INT DEFAULT 0;

    SELECT ROUND(SUM(oi.price + oi.freight_value), 2)
    INTO v_order_value
    FROM order_items oi
    WHERE oi.order_id = p_order_id;

    SELECT COUNT(DISTINCT o.order_id)
    INTO v_previous_orders
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    WHERE c.customer_unique_id = p_customer_unique_id
      AND o.order_purchase_timestamp < (
          SELECT order_purchase_timestamp
          FROM orders
          WHERE order_id = p_order_id
      );

    IF v_previous_orders = 0 THEN
        SET p_discount_pct = 15.00;
        SET p_discount_reason = 'New customer first order';
    ELSEIF v_order_value > 500 THEN
        SET p_discount_pct = 10.00;
        SET p_discount_reason = 'High value order';
    ELSEIF v_previous_orders >= 5 THEN
        SET p_discount_pct = 5.00;
        SET p_discount_reason = 'Loyal customer';
    ELSE
        SET p_discount_pct = 0.00;
        SET p_discount_reason = 'No discount applicable';
    END IF;

    SET p_discount_amount = ROUND(v_order_value * p_discount_pct / 100, 2);
    SET p_final_order_value = ROUND(v_order_value - p_discount_amount, 2);
END $$

DELIMITER ;

-- Example usage
CALL sp_calculate_dynamic_discount(
    'customer_unique_id_here',
    'order_id_here',
    @discount_pct,
    @discount_reason,
    @discount_amount,
    @final_order_value
);
SELECT @discount_pct, @discount_reason, @discount_amount, @final_order_value;
