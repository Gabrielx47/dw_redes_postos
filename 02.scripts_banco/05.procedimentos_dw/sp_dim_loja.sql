use bd_rede_postos

create procedure sp_dim_loja(@dataDaCarga date)
as
BEGIN
	insert into DIM_LOJA
	SELECT COD_LOJA, LOJA, GERENTE, CIDADE, ESTADO, SIGLA_ESTADO, @dataDaCarga, null, 'SIM'
	FROM TB_AUX_LOJA
END