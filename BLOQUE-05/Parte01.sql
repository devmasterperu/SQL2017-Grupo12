--05.01

select count(idficha) from Ficha --Total fichas
select count(idficha) from Ficha where tipoconsumidor='G'--Total fichas G
select count(idficha) from Ficha where tipoconsumidor='M'--Total fichas M
select count(idficha) from Ficha where tipoconsumidor='P'--Total fichas P

--FORMA-01
select count(idficha) as [TOTAL-FICHAS],
	   (select count(idficha) from Ficha where tipoconsumidor='G') as [TOTAL-G], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='M') as [TOTAL-M], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='P') as [TOTAL-P]  --CI
from Ficha --CE

--FORMA-02
select (select count(idficha) from Ficha) as [TOTAL-FICHAS],                     --CI
	   (select count(idficha) from Ficha where tipoconsumidor='G') as [TOTAL-G], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='M') as [TOTAL-M], --CI
	   (select count(idficha) from Ficha where tipoconsumidor='P') as [TOTAL-P]  --CI