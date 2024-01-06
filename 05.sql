select customers.name, customers.citystatezip, customers.phone, count()
from file('./testdata/noahs-customers.csv') customers
join file('./testdata/noahs-orders.csv') orders ON orders.customerid = customers.customerid
join file('./testdata/noahs-orders_items.csv') order_items ON orders.orderid = order_items.orderid
join file('./testdata/noahs-products.csv') products ON order_items.sku = products.sku
where (products.desc like '%Senior Cat%')
group by all
order by count() desc
limit 1
format Vertical
