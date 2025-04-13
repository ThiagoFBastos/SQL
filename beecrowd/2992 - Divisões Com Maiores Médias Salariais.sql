select  dep.nome as "departamento",
        div.nome as "divisao",
        round(br.bruto - des.desconto, 2) as "media"

from divisao div

inner join departamento dep on dep.cod_dep = div.cod_dep

inner join

(
    select  emp.lotacao_div as "lotacao_div",
            sum(coalesce(ven.valor, 0)) / count(distinct emp.matr) as "bruto"
           
    from    empregado emp
            left join emp_venc ev on ev.matr = emp.matr
            left join vencimento ven on ev.cod_venc = ven.cod_venc

    group by "lotacao_div"

) br

on div.cod_divisao = br.lotacao_div

inner join

(
    select  emp.lotacao_div as "lotacao_div",
            sum(coalesce(des.valor, 0)) / count(distinct emp.matr) as "desconto"
           
    from    empregado emp
            left join emp_desc ed on ed.matr = emp.matr
            left join desconto des on ed.cod_desc = des.cod_desc

    group by "lotacao_div"

) des

on br.lotacao_div = des.lotacao_div

where not exists (
    select 1
    
    from
    (
        select  emp.lotacao_div as "lotacao_div",
                sum(coalesce(ven.valor, 0)) / count(distinct emp.matr) as "bruto"
               
        from    empregado emp
                left join emp_venc ev on ev.matr = emp.matr
                left join vencimento ven on ev.cod_venc = ven.cod_venc

        where emp.lotacao = div.cod_dep

        group by "lotacao_div"

    ) br2

    inner join

    (
        select  emp.lotacao_div as "lotacao_div",
                sum(coalesce(des.valor, 0)) / count(distinct emp.matr) as "desconto"
               
        from    empregado emp
                left join emp_desc ed on ed.matr = emp.matr
                left join desconto des on ed.cod_desc = des.cod_desc

        where emp.lotacao = div.cod_dep

        group by "lotacao_div"

    ) des2
  
    on br2.lotacao_div = des2.lotacao_div

    where br2.bruto - des2.desconto > br.bruto - des.desconto
)

group by dep.cod_dep, "departamento", "divisao", "media"

order by "media" desc;