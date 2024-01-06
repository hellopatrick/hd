with (
    replaceRegexpAll(products.desc, '\(.+\)', '') as desc_without_color
)
select
    toStartOfMinute(orders.shipped) as time,
    desc_without_color,
    groupUniqArray(customers.phone) as buyers
from file('./testdata/noahs-customers.csv') customers
join file('./testdata/noahs-orders.csv') orders ON orders.customerid = customers.customerid
join file('./testdata/noahs-orders_items.csv') order_items ON orders.orderid = order_items.orderid
join file('./testdata/noahs-products.csv') products ON order_items.sku = products.sku
where products.desc like 'Noah%(%)'
group by all
having length(buyers) > 1 and has(buyers, '838-295-7143')
limit 10
format Vertical
