--CALCULA IDADE
select nr_emp_iddtnascimento, extract(year FROM age(current_date, to_date(nr_emp_iddtnascimento::text, 'YYYYMMDD'))) as idade
from dw_sgp.wd_sgp_empregado dim_empregado limit 10







--gera uma série de datas utilizando um intervalo de 12 meses a partir de uma data
SELECT 
concat(extract('year' from data_gerada),lpad( extract('month' from data_gerada)::text,2,'0')) as referencia
,extract('year' from data_gerada) as ano
,extract('month' from data_gerada) as mes
FROM generate_series(DATE'2012-12-01' - interval '12 month', DATE'2012-12-01',INTERVAL'1 month') as data_gerada

order by referencia




--primeiro e ultimo dia do mês
SELECT min(dias), max(dias) 
FROM generate_series(date_trunc('month',current_date),date_trunc('month',current_date) + INTERVAL'1 month' - INTERVAL'1 day',INTERVAL'1 day') AS dias;






--GERA ANOS
select extract(YEAR FROM generate_series(DATE'2011-01-01', now(), INTERVAL'1 Year'))as ano order by ano desc;






--GERA MESES COM BASE NO ANO
select mes,
case
when mes = 1  then 'Janeiro'
when mes = 2  then 'Fevereiro'
when mes = 3  then 'Março'
when mes = 4  then 'Abril'
when mes = 5  then 'Maio'
when mes = 6  then 'Junho'
when mes = 7  then 'Julho'
when mes = 8  then 'Agosto'
when mes = 9  then 'Setembro'
when mes = 10 then 'Outubro'
when mes = 11 then 'Novembro'
when mes = 12 then 'Dezembro'
end as mes_desc

from ( 

select
case 
   when ${param_ano} = extract (year from now())::text 
    then extract(MONTH FROM generate_series((${param_ano}||'-01-01')::date, now(), INTERVAL'1 MONTH')) 
	else
	extract(MONTH FROM generate_series((${param_ano}||'-01-01')::date, (${param_ano}||'-12-01')::date, INTERVAL'1 MONTH'))

	end as mes order by mes desc

) as T
