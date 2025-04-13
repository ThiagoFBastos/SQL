select PD.name, 'Ajax SA'
from providers PR inner join products PD on PR.id = PD.id_providers
where PR.name = 'Ajax SA';