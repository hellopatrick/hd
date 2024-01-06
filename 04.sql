select customers.phone
from file('./testdata/noahs-customers.csv') customers
join file('./testdata/noahs-orders.csv') orders ON orders.customerid = customers.customerid
join file('./testdata/noahs-orders_items.csv') order_items ON orders.orderid = order_items.orderid
join file('./testdata/noahs-products.csv') products ON order_items.sku = products.sku
where products.desc like '%Bagel' and hour(orders.shipped) = 4 and hour(orders.ordered) = 4
limit 100
format Vertical
