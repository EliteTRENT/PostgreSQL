-- Problem 1: Transfer Funds Between Accounts
-- Description: Transfer $150 from Account X to Account Y. Ensure the transfer only proceeds if Account X has sufficient funds (>= $150). 
-- If not, roll back the transaction and log the failure.
-- Query:
DO $$
BEGIN
    BEGIN
        IF (SELECT balance FROM accounts WHERE account_id = 'X001') < 150 THEN
            INSERT INTO transaction_logs (log_id, from_account, to_account, amount, status, log_time)
            VALUES (nextval('transaction_logs_log_id_seq'), 'X001', 'X002', 150.00, 'FAILED - Low Balance', CURRENT_TIMESTAMP);
            RAISE EXCEPTION 'Insufficient funds in account X001';
        END IF;
        UPDATE accounts
        SET balance = balance - 150
        WHERE account_id = 'X001';
        UPDATE accounts
        SET balance = balance + 150
        WHERE account_id = 'X002';
        INSERT INTO transaction_logs (log_id, from_account, to_account, amount, status, log_time)
        VALUES (nextval('transaction_logs_log_id_seq'), 'X001', 'X002', 150.00, 'SUCCESS', CURRENT_TIMESTAMP);
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed: %', SQLERRM;
    END;
END $$;

-- Problem 2: Process a Multi-Item Purchase
-- Description: Process a purchase for two items (Item A and Item B). Reserve Item A if in stock, but roll back Item B reservation if out of stock, keeping Item A.
-- Query:
BEGIN;
    UPDATE inventory
    SET available_qty = available_qty - 1
    WHERE item_code = 'I001' AND available_qty > 0;
    SAVEPOINT after_first;
    DO $$
    BEGIN
        IF (SELECT available_qty FROM inventory WHERE item_code = 'I002') <= 0 THEN
            RAISE EXCEPTION 'Item I002 out of stock';
        END IF;
        UPDATE inventory
        SET available_qty = available_qty - 1
        WHERE item_code = 'I002' AND available_qty > 0;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'Item I002 reservation failed';
        END IF;
    END $$;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO SAVEPOINT after_first;
        RAISE NOTICE 'Second item reservation failed: %', SQLERRM;
END;
COMMIT;

-- Problem 3: Apply a Bonus to Staff
-- Description: Apply a 5% bonus to all staff in the 'Marketing' team. Ensure no concurrent salary modifications during the process.
-- Query:
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
BEGIN;
DO $$
DECLARE
    total_salary DECIMAL(10,2);
BEGIN
    SELECT SUM(salary) INTO total_salary
    FROM staff
    WHERE team = 'Marketing';
    RAISE NOTICE 'Total Marketing salary before bonus: %', total_salary;
END $$;
UPDATE staff
SET salary = salary * 1.05
WHERE team = 'Marketing';
COMMIT;

-- Problem 4: Register a New User and Create an Order
-- Description: Add a new user and create an order. If the order amount is invalid (e.g., negative), retain the user but skip the order.
-- Query:
BEGIN;
    INSERT INTO users (username)
    VALUES ('NewUser1');
    DO $$
    DECLARE
        new_user_id INT;
    BEGIN
        new_user_id := currval('users_user_id_seq');
        BEGIN
            IF (SELECT 1 WHERE -50.00 < 0) IS NOT NULL THEN
                RAISE EXCEPTION 'Invalid order amount';
            END IF;
            INSERT INTO purchases (user_id, total)
            VALUES (new_user_id, 100.00);
        EXCEPTION
            WHEN OTHERS THEN
                RAISE NOTICE 'Order creation failed: %', SQLERRM;
        END;
    END $$;
COMMIT;

-- Problem 5: Book Limited Reservations
-- Description: Book the last available spots for two events (E001 and E002). Ensure consistent locking to avoid conflicts.
-- Query:
BEGIN;
    UPDATE events
    SET available_spots = available_spots - 1
    WHERE event_id = 'E001' AND available_spots > 0;
    DO $$
    BEGIN
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No spots available on E001';
        END IF;
        UPDATE events
        SET available_spots = available_spots - 1
        WHERE event_id = 'E002' AND available_spots > 0;
        IF NOT FOUND THEN
            RAISE EXCEPTION 'No spots available on E002';
        END IF;
    END $$;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE NOTICE 'Reservation failed: %', SQLERRM;
END;
COMMIT;

-- Problem 6: Limit Order Quantity
-- Description: Process an order for 3 units of Item A. Roll back if the quantity exceeds 2.
-- Query:
DO $$
BEGIN
    BEGIN
        INSERT INTO orders (user_id, item_code, quantity, total_price, status)
        VALUES (1, 'I001', 3, 150.00, 'pending');
        IF (SELECT quantity FROM orders WHERE order_id = currval('orders_order_id_seq')) > 2 THEN
            RAISE EXCEPTION 'Quantity exceeds limit';
        END IF;
        UPDATE orders
        SET status = 'completed'
        WHERE order_id = currval('orders_order_id_seq');
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DELETE FROM orders WHERE order_id = currval('orders_order_id_seq');
            RAISE NOTICE 'Rolled back: %', SQLERRM;
    END;
END $$;

-- Problem 7: Undo a Completed Order
-- Description: Cancel the latest order for User 1 and restore the item stock.
-- Query:
DO $$
DECLARE
    order_id_to_cancel INT;
    item_code_to_restore TEXT;
    qty_to_restore INT;
BEGIN
    BEGIN
        SELECT order_id, item_code, quantity INTO order_id_to_cancel, item_code_to_restore, qty_to_restore
        FROM orders
        WHERE user_id = 1
        ORDER BY order_id DESC
        LIMIT 1;
        IF order_id_to_cancel IS NOT NULL THEN
            UPDATE inventory
            SET available_qty = available_qty + qty_to_restore
            WHERE item_code = item_code_to_restore;
            DELETE FROM orders
            WHERE order_id = order_id_to_cancel;
        ELSE
            RAISE EXCEPTION 'No orders to cancel';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Rolled back: %', SQLERRM;
    END;
END $$;

-- Problem 8: Adjust Order Total
-- Description: Increase the total of User 2’s latest pending order by 10%.
-- Query:
DO $$
DECLARE
    order_id_to_adjust INT;
BEGIN
    BEGIN
        SELECT order_id INTO order_id_to_adjust
        FROM orders
        WHERE user_id = 2 AND status = 'pending'
        ORDER BY order_id DESC
        LIMIT 1;
        IF order_id_to_adjust IS NOT NULL THEN
            UPDATE orders
            SET total_price = total_price * 1.10
            WHERE order_id = order_id_to_adjust;
        ELSE
            RAISE EXCEPTION 'No pending orders';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Rolled back: %', SQLERRM;
    END;
END $$;

-- Problem 9: Mark Item as Out of Stock
-- Description: Set Item B (I002) stock to 0, roll back if already 0.
-- Query:
DO $$
BEGIN
    BEGIN
        IF (SELECT available_qty FROM inventory WHERE item_code = 'I002') = 0 THEN
            RAISE EXCEPTION 'Already out of stock';
        END IF;
        UPDATE inventory
        SET available_qty = 0
        WHERE item_code = 'I002';
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Rolled back: %', SQLERRM;
    END;
END $$;

-- Problem 10: Verify Order Total
-- Description: Commit User 1’s latest order if total matches item price × quantity.
-- Query:
DO $$
DECLARE
    order_id_to_verify INT;
    expected_total DECIMAL;
BEGIN
    BEGIN
        SELECT order_id, (SELECT price * quantity FROM inventory WHERE item_code = o.item_code)
        INTO order_id_to_verify, expected_total
        FROM orders o
        WHERE user_id = 1
        ORDER BY order_id DESC
        LIMIT 1;
        IF order_id_to_verify IS NOT NULL AND (SELECT total_price FROM orders WHERE order_id = order_id_to_verify) = expected_total THEN
            UPDATE orders
            SET status = 'completed'
            WHERE order_id = order_id_to_verify;
        ELSE
            RAISE EXCEPTION 'Price mismatch';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Rolled back: %', SQLERRM;
    END;
END $$;
