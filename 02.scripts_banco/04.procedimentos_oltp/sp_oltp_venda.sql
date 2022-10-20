create database bd_rede_postos

use bd_rede_postos

create or alter procedure sp_oltp_venda(@dataDaVenda date)  
as
begin
	insert into tb_aux_venda 
	select @dataDaVenda, data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, volume, valor
	from tb_venda 
end

-- Testes
   -- Falta fazer