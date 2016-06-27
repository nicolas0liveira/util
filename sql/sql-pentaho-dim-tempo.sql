select 

1 AS version
,'1900-01-01 00:00:00'::timestamp without time zone AS date_from
,'2199-12-31 23:59:59'::timestamp without time zone AS date_to

, date_trunc('day', data)::timestamp without time zone as data


,to_char(data,'YYYY')::BigInt as ano

,(to_char(data, 'mm')::integer) as mes

,(((to_char(data, 'mm')::integer)/7))+1 as semestre
,(((to_char(data, 'mm')::integer)/7))+1 || '° Semestre' as semestre_desc
,(((to_char(data, 'mm')::integer)/7))+1 || '° Sem' as semestre_abrev
, to_char(data,'Q')::BigInt as trimestre_ano 
, to_char(data,'Q')::BigInt || '° Trimestre' as trimestre_desc	
, to_char(data,'Q')::BigInt || '° Trim' as trimestre_abrev

,CASE when ((to_char(data, 'mm')::integer) <= 2) then 1
	when ((to_char(data, 'mm')::integer) <= 4) then 2
	when ((to_char(data, 'mm')::integer) <= 6) then 3
	when ((to_char(data, 'mm')::integer) <= 8) then 4
	when ((to_char(data, 'mm')::integer) <= 10)  then 5
	when ((to_char(data, 'mm')::integer) <= 12) then 6 
	end as bimestre

,CASE when ((to_char(data, 'mm')::integer) <= 2) then '1° Bimestre' 
	when ((to_char(data, 'mm')::integer) <= 4) then '2° Bimestre'
	when ((to_char(data, 'mm')::integer) <= 6) then '3° Bimestre'
	when ((to_char(data, 'mm')::integer) <= 8) then '4° Bimestre'
	when ((to_char(data, 'mm')::integer) <= 10)  then '5° Bimestre'
	when ((to_char(data, 'mm')::integer) <= 12) then '6° Bimestre'
	end as bimestre_desc

,CASE when ((to_char(data, 'mm')::integer) <= 2) then '1° Bim' 
	when ((to_char(data, 'mm')::integer) <= 4) then '2° Bim'
	when ((to_char(data, 'mm')::integer) <= 6) then '3° Bim'
	when ((to_char(data, 'mm')::integer) <= 8) then '4° Bim'
	when ((to_char(data, 'mm')::integer) <= 10)  then '5° Bim'
	when ((to_char(data, 'mm')::integer) <= 12) then '6° Bim'
	end as bimestre_abrev

, to_char(data,'TMMONTH')::Character varying(9)as mes_desc
, to_char(data,'TMMon')::Character varying(3) as mes_abrev

, to_char(data,'WW')::BigInt as semana_ano
, to_char(data,'DDD')::BigInt as dia_ano
, to_char(data,'DD')::BigInt as dia_mes

, to_char(data,'D')::BigInt  as dia_semana
, to_char(data,'TMDay')::Character varying(13) as dia_semana_desc
, to_char(data,'TMDY')::Character varying(3) as dia_semana_abrev


FROM generate_series(
	 to_date('2013-01-01','YYYY-MM-DD')
	,to_date('2019-01-01','YYYY-MM-DD') -- - interval '365 day'
	,'1 day'
) data;


