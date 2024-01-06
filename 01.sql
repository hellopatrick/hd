with (
    splitByChar(' ', name) as nameparts,
    arrayLast(np -> length(np) > 3, nameparts) as lastname,
    arrayMap(c -> multiIf(
        c BETWEEN 'A' and 'C', '2',
        c BETWEEN 'D' and 'F', '3',
        c BETWEEN 'G' and 'I', '4',
        c BETWEEN 'J' and 'L', '5',
        c BETWEEN 'M' and 'O', '6',
        c BETWEEN 'P' and 'S', '7',
        c BETWEEN 'T' and 'V', '8',
        '9'), splitByString('', upper(lastname))) as nums,
    arrayStringConcat(nums) as lastname_phone,
    replaceAll(phone, '-', '') as clean_phone
)
select
    name, phone
from
    file('./testdata/noahs-customers.csv')
where
    lastname_phone = clean_phone
limit 10;
