create database bd_rede_postos

use bd_rede_postos

create or alter procedure sp_oltp_venda(@dataDaCarga date, @dataInicial date, @dataFinal date)  
as
begin
	insert into tb_aux_venda 
	select @dataDaCarga, data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, volume, valor
	from tb_venda 
	where data_venda >= @dataInicial and data_venda <= @dataFinal
end

-- Testes
   -- Falta fazer

exec sp_oltp_venda '20221101', '20210101', '20210105'

select * from TB_AUX_VENDA
select count(*)  FROM TB_VENDA

-- O comando abaixo é utilizado para apagar os dados de uma tabela
truncate table TB_AUX_VENDA