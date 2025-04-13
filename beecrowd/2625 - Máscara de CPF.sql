select concat(substring(np.cpf from 1 for 3), '.', substring(np.cpf from 4 for 3), '.', substring(np.cpf from 7 for 3), '-', substring(np.cpf from 10 for 2))
from customers c
inner join
natural_person np
on c.id = np.id_customers;