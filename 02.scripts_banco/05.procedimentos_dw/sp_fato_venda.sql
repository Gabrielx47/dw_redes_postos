use bd_rede_postos

--Criar o procedimento sp_fato_venda() para transferir os dados da área de staging para o ambiente Data Warehouse.
--id_venda, id_tempo, id_loja, id_funcionario, id_produto, id_tipo_pagamento, cod_venda, volume, quantidade (fatoVenda)
--data_carga, data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, volume, valor (tb_aux_venda) sta
create or alter procedure sp_fato_venda
as
begin
	insert into FATO_VENDA
	select COD_VENDA, VOLUME, VALOR
	from TB_AUX_VENDA
	union
	select ID_TEMPO
	from DIM_TEMPO
	where 
	UNION
	SELECT ID_LOJA
	FROM DIM_LOJA
	UNION all
	SELECT ID_FUNCIONARIO
	FROM DIM_FUNCIONARIO
	UNION all
	SELECT ID_TIPO_PAGAMENTO
	FROM DIM_TIPO_PAGAMENTO
	UNION all
	SELECT ID_PRODUTO, 1
	FROM DIM_PRODUTO
end

-- Observação: O procedimento acima deve ser executado apenas quando todas as dimensões estiverem preenchidas
-- Testando
declare @data_venda datetime, @cod_loja int, @cod_funcionario int, 
	        @cod_produto int, @cod_tipo_pagamento int, @codVenda int, @volume numeric(10,2), @valor numeric(10,2),
			@dt_vendaID  int 

   declare c_venda cursor for
   select data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, COD_VENDA, volume, valor
          from TB_AUX_VENDA

   open c_venda
   fetch c_venda into @data_venda, @cod_loja, @cod_funcionario, @cod_produto, @cod_tipo_pagamento, 
                      @codVenda, @volume, @valor
   while(@@FETCH_STATUS = 0)
   begin
	   --select @dt_vendaID = id_tempo from DIM_TEMPO where DATA = @data_carga
	   
	   --if @dt_vendaID is null
			insert into FATO_VENDA values (@data_venda, @cod_loja,  @cod_funcionario, @cod_produto,
			                              @cod_tipo_pagamento, @codVenda, @volume, @valor, 1)

	   fetch c_venda into @data_venda, @cod_loja, @cod_funcionario, @cod_produto, @cod_tipo_pagamento, 
                      @codVenda, @volume, @valor
   end

   close c_venda
   deallocate c_venda