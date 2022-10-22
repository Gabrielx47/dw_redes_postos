use bd_rede_postos

--Criar o procedimento sp_fato_venda() para transferir os dados da área de staging para o ambiente Data Warehouse.
--id_venda, id_tempo, id_loja, id_funcionario, id_produto, id_tipo_pagamento, cod_venda, volume, quantidade (fatoVenda)
--data_carga, data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, volume, valor (tb_aux_venda) sta
create or alter sp_fato_venda(@data_carga datetime)
as
begin
	declare @data_carga int, @data_venda datetime, @cod_loja int, @cod_funcionario int, 
	        @cod_produto int, @cod_tipo_pagamento int, @volume numeric(10,2), @valor numeric(10,2),
			@dt_vendaID   

   declare c_venda cursor for
   select data_carga, data_venda, cod_loja, cod_funcionario, cod_produto, cod_tipo_pagamento, volume, valor
          from TB_AUX_VENDA

   open c_venda
   fetch c_venda into @data_carga, @data_venda, @cod_loja, @cod_funcionario, @cod_produto, @cod_tipo_pagamento, 
                      @volume, @valor
   while(@@FETCH_STATUS = 0)
   begin
	   set @dt_vendaID = select id_tempo from DIM_TEMPO where DATA = @data_carga
	   
	   if @dt_vendaID is null
			insert into FATO_VENDA values @data_carga, @data_venda, @cod_loja,  @cod_funcionario, @cod_produto,
			                              @cod_tipo_pagamento, @volume, @valor

	   fetch c_venda into @data_carga, @data_venda, @cod_loja, @cod_funcionario, @cod_produto, @cod_tipo_pagamento, 
                      @volume, @valor
   end
   close c_venda
   deallocate c_venda
end