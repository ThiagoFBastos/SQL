select C.name
from customers C inner join legal_person LP on C.id = LP.id_customers;