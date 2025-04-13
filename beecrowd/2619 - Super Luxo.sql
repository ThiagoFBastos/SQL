select prod.name, prov.name, prod.price
from products prod
inner join providers prov on prod.id_providers = prov.id
inner join categories cat on prod.id_categories = cat.id
where prod.price > 1000 and cat.name = 'Super Luxury';