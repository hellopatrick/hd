with (
    multiIf(month(birthdate) = 9, day(birthdate) >= 22, month(birthdate) = 10, day(birthdate) <= 22, false) as is_libra,
    ((year(birthdate) - 1931) % 12) = 0 as is_goat,
    customers.citystatezip like '%11427' as is_area
)
select name, phone, birthdate
from file('./testdata/noahs-customers.csv') customers
where
    is_libra
    and is_goat
    and is_area;
