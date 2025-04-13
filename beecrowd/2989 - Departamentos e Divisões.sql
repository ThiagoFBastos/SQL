select  dep.nome as "departamento",
        div.nome as "divisao",
        case
            when avg(emp.salario) = 0 then 0
            else round(avg(emp.salario), 2)
        end as "media",
        case
            when max(emp.salario) = 0 then 0
            else round(max(emp.salario), 2)
        end as "maior"

from

(
    select  coalesce(emp1.lotacao_div, emp2.lotacao_div) as "div",
            coalesce(emp1.matr, emp2.matr) as "matricula",
            coalesce(emp1.lotacao, emp2.lotacao) as "depto",  
            sum(coalesce(ven.valor, 0) - coalesce(des.valor, 0)) as "salario"
            from 
            (
                empregado emp1 left join emp_venc ev on emp1.matr = ev.matr
                left join vencimento ven on ev.cod_venc = ven.cod_venc
            )      
            full outer join
            (
                empregado emp2 left join emp_desc ed on emp2.matr = ed.matr
                left join desconto des on ed.cod_desc = des.cod_desc
            )  
            on 0 = 1
            group by "div", "matricula", "depto"
) emp

inner join divisao div on emp.div = div.cod_divisao
inner join departamento dep on emp.depto = dep.cod_dep

group by dep.cod_dep, div.cod_divisao, "departamento", "divisao"

order by "media" desc;