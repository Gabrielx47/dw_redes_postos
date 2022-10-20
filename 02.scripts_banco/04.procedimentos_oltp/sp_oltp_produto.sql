use bd_rede_postos

create or alter procedure sp_oltp_produto(@dataDaVenda date)  
as
begin
	insert into tb_aux_produto
	select @dataDaVenda, p.cod_produto, p.produto, s.cod_subcategoria, s.subcategoria, c.cod_categoria, c.categoria 
	from tb_produto p inner join tb_subcategoria s on(p.cod_subcategoria = s.cod_subcategoria)
	     inner join tb_categoria c on(s.cod_categoria = c.cod_categoria)
end

-- Testes
   -- Falta fazer