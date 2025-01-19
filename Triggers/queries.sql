 id |    name    |  price   |         updated_at
----+------------+----------+----------------------------
  1 | Laptop     | 59999.99 | 2025-01-19 11:01:42.784639
  2 | Smartphone | 19999.99 | 2025-01-19 11:01:42.784639
  3 | Headphones |  1999.99 | 2025-01-19 11:01:42.784639
  4 | Smartwatch |  7999.99 | 2025-01-19 11:01:42.784639
  5 | Tablet     | 24999.99 | 2025-01-19 11:01:42.784639
(5 rows)

Q1 
create or replace function update_timestamp()
returns trigger as $$
begin
NEW.updated_at = CURRENT_TIMESTAMP;
return NEW;
end;
$$language plpgsql;
CREATE FUNCTION

create trigger updated_at_trigger
before update on products
for each row
execute function update_timestamp();
CREATE TRIGGER
update products set price = 80000 where id = 1;
UPDATE 1

 id |    name    |  price   |         updated_at
----+------------+----------+----------------------------
  2 | Smartphone | 19999.99 | 2025-01-19 11:01:42.784639
  3 | Headphones |  1999.99 | 2025-01-19 11:01:42.784639
  4 | Smartwatch |  7999.99 | 2025-01-19 11:01:42.784639
  5 | Tablet     | 24999.99 | 2025-01-19 11:01:42.784639
  1 | Laptop     | 80000.00 | 2025-01-19 11:10:20.322302
(5 rows)


Q2 
create or replace function prevent_order_deletion_if_shipments_exist()
returns trigger as $$
begin
    if exists (select 1 from shipments where order_id = old.order_id) then
        raise exception 'cannot delete order %: shipments exist', old.order_id;
    end if;
    return old; 
end;
$$ language plpgsql;
CREATE FUNCTION

create trigger prevent_order_deletion
before delete on orders
for each row
execute function prevent_order_deletion_if_shipments_exist();
CREATE TRIGGER
delete from orders where order_id = 1;
ERROR:  Cannot delete order 1: shipments exist
CONTEXT:  PL/pgSQL function prevent_order_deletion_if_shipments_exist() line 4 at RAISE


