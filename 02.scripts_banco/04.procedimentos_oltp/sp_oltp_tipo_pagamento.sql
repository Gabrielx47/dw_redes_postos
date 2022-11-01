use bd_rede_postos

create or alter procedure sp_oltp_tipo_pagamento(@dataDaCarga date)  
as
begin
	insert into tb_aux_tipo_pagamento
	select @dataDaCarga, cod_tipo_pagamento, tipo_pagamento
	from tb_tipo_pagamento 
end

-- Testes
   -- Falta fazer
exec sp_oltp_tipo_pagamento '20221101'

select * from TB_AUX_TIPO_PAGAMENTO