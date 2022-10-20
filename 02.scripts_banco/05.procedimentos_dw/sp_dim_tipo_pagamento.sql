use bd_rede_postos

create procedure sp_dim_tipo_pagamento 
as 
BEGIN
	insert into DIM_TIPO_PAGAMENTO
	select COD_TIPO_PAGAMENTO, TIPO_PAGAMENTO
	from TB_AUX_TIPO_PAGAMENTO
END