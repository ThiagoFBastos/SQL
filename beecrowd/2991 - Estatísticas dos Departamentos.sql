with salario_bruto as (
    select  emp.matr,
            emp.lotacao,
            sum(coalesce(ven.valor, 0)) as "bruto"
           
    from    empregado emp
            left join emp_venc ev on ev.matr = emp.matr
            left join vencimento ven on ev.cod_venc = ven.cod_venc

    group by emp.matr, emp.lotacao
), salario_desconto as (
     select emp.matr,
            emp.lotacao,
            sum(coalesce(des.valor, 0)) as "desconto"
           
    from    empregado emp
            left join emp_desc ed on ed.matr = emp.matr
            left join desconto des on ed.cod_desc = des.cod_desc

    group by emp.matr, emp.lotacao
), salario_liquido as (
    select  br.matr,
            br.lotacao,
            br.bruto - des.desconto as "liquido"
    from salario_bruto br
    inner join salario_desconto des on br.matr = des.matr
)

select  dep.nome,
        count(*),
        case when avg(emp.liquido) = 0 then 0 else round(avg(emp.liquido), 2) end as "media",
        case when max(emp.liquido) = 0 then 0 else round(max(emp.liquido), 2) end,
        case when min(emp.liquido) = 0 then 0 else round(min(emp.liquido), 2) end

from departamento dep

inner join salario_liquido emp on dep.cod_dep = emp.lotacao

group by dep.cod_dep, dep.nome

order by "media" desc;