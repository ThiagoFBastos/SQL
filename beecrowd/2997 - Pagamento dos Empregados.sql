with salario_bruto as (
    select  emp.matr,
            emp.nome,
            emp.lotacao_div,
            emp.lotacao,
            sum(coalesce(ven.valor, 0)) as "bruto"
           
    from    empregado emp
            left join emp_venc ev on ev.matr = emp.matr
            left join vencimento ven on ev.cod_venc = ven.cod_venc

    group by emp.matr, emp.nome, emp.lotacao_div, emp.lotacao
), salario_desconto as (
     select emp.matr,
            emp.nome,
            emp.lotacao_div,
            emp.lotacao,
            sum(coalesce(des.valor, 0)) as "desconto"
           
    from    empregado emp
            left join emp_desc ed on ed.matr = emp.matr
            left join desconto des on ed.cod_desc = des.cod_desc

    group by emp.matr, emp.nome, emp.lotacao_div, emp.lotacao
), salario_liquido as (
    select  br.matr,
            br.nome,
            br.lotacao_div,
            br.lotacao,
            br.bruto,
            des.desconto,
            br.bruto - des.desconto as "liquido"
    from salario_bruto br
    inner join salario_desconto des on br.matr = des.matr
)

select  dep.nome,
        emp.nome,
        case when emp.bruto = 0 then 0 else round(emp.bruto, 2) end,
        case when emp.desconto = 0 then 0 else round(emp.desconto, 2) end,
        case when emp.liquido = 0 then 0 else round(emp.liquido, 2) end

from salario_liquido emp
inner join departamento dep on emp.lotacao = dep.cod_dep
order by emp.liquido desc, emp.nome desc;