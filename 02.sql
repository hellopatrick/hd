with (
    splitByChar(' ', name) as nameparts,
    arrayMap(np -> splitByString('', np), nameparts) as exploded_nameparts,
    arrayStringConcat(arrayMap(np -> np[1], exploded_nameparts)) as initials
)
select orders.ordered, customers.*
from file('./testdata/noahs-customers.csv') customers
join file('./testdata/noahs-orders.csv') orders ON orders.customerid = customers.customerid
join file('./testdata/noahs-orders_items.csv') order_items ON orders.orderid = order_items.orderid
join file('./testdata/noahs-products.csv') products ON order_items.sku = products.sku
where products.desc = 'Rug Cleaner' and initials like '%D%S%' and year(orders.ordered) = 2017
limit 1
format Vertical
