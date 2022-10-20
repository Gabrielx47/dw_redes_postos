use bd_rede_postos

create or alter procedure sp_dim_funcionario
as
BEGIN
	insert into DIM_FUNCIONARIO
	select COD_FUNCIONARIO, FUNCIONARIO, COD_CARGO, CARGO
	from TB_AUX_FUNCIONARIO
END