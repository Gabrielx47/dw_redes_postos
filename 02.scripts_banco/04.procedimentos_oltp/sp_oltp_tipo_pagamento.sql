use bd_rede_postos

create or alter procedure sp_oltp_tipo_pagamento(@dataDaVenda date)  
as
begin
	insert into tb_aux_tipo_pagamento
	select @dataDaVenda, cod_tipo_pagamento, tipo_pagamento
	from tb_tipo_pagamento 
end

-- Testes
   -- Falta fazer