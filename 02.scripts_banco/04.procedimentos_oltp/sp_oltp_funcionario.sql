create or alter procedure sp_oltp_funcionario(@dataCarga datetime)
as
begin

    -- DATA_CARGA, COD_FUNCIONARIO, FUNCIONARIO, COD_CARGO, CARGO 
	insert into tb_aux_funcionario
	select @dataCarga, f.cod_funcionario, f.nm_funcionario, c.cod_cargo, c.nm_cargo
	from tb_funcionario f inner join tb_cargo c on(f.cod_cargo = c.cod_cargo)
end