select PD.name, PR.name
from products PD inner join providers PR on PD.id_providers = PR.id
where PD.id_categories = 6;