select E.cpf, E.enome, D.dnome
from empregados E
inner join departamentos D on E.dnumero = D.dnumero
where E.cpf not in (
    select T.cpf_emp
    from trabalha T
    where T.cpf_emp = E.cpf
)
order by E.cpf;