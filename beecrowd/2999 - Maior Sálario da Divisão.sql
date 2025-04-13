with salario_bruto as (
    select  emp.matr,
            emp.nome,
            emp.lotacao_div,
            sum(coalesce(ven.valor, 0)) as "bruto"
           
    from    empregado emp
            left join emp_venc ev on ev.matr = emp.matr
            left join vencimento ven on ev.cod_venc = ven.cod_venc

    group by emp.matr, emp.nome, emp.lotacao_div
), salario_desconto as (
     select emp.matr,
            emp.nome,
            emp.lotacao_div,
            sum(coalesce(des.valor, 0)) as "desconto"
           
    from    empregado emp
            left join emp_desc ed on ed.matr = emp.matr
            left join desconto des on ed.cod_desc = des.cod_desc

    group by emp.matr, emp.nome, emp.lotacao_div
), salario_liquido as (
    select  br.matr,
            br.nome,
            br.lotacao_div,
            br.bruto - des.desconto as "salario"
    from salario_bruto br
    inner join salario_desconto des on br.matr = des.matr
), divisao_media_salarios as (
    select  div.cod_divisao,
            avg(sl.salario) as "media"
    from salario_liquido sl
    inner join divisao div on sl.lotacao_div = div.cod_divisao
    group by div.cod_divisao
)

select  emp.nome, 
        round(emp.salario, 2)

from salario_liquido emp

inner join divisao_media_salarios dms on emp.lotacao_div = dms.cod_divisao

where emp.salario > dms.media and emp.salario >= 8000

order by dms.cod_divisao, emp.nome;

