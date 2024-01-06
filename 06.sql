select name, phone, sum(profit) as total_profit
from
    (select
        any(customers.name) as name,
        any(customers.phone) as phone,
        sum(order_items.qty * order_items.unit_price) as gross,
        sum(order_items.qty * products.wholesale_cost) as wholesale,
        gross - wholesale as profit
    from file('./testdata/noahs-customers.csv') customers
    join file('./testdata/noahs-orders.csv') orders ON orders.customerid = customers.customerid
    join file('./testdata/noahs-orders_items.csv') order_items ON orders.orderid = order_items.orderid
    join file('./testdata/noahs-products.csv') products ON order_items.sku = products.sku
    group by orders.orderid)
group by all
having total_profit < 0
order by total_profit asc
limit 1
