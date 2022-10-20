use bd_rede_postos

create or alter procedure sp_oltp_loja(@dataDaCarga date)  
as
begin
	insert into tb_aux_loja
	select @dataDaCarga, cod_loja, nm_loja, f.nm_funcionario, c.cidade, E.estado, E.sigla 
	from tb_loja j inner join tb_loja_funcionario gerente on(j.cod_loja = gerente.cod_loja)
	     inner join tb_funcionario f on(gerente.cd_funcionario = f.cod_funcionario)
		 inner join tb_cidade c on(j.cod_cidade = c.cod_cidade)
		 inner join tb_estado E on(c.cod_estado = E.cod_estado)
end

-- Testes
   -- Falta fazer