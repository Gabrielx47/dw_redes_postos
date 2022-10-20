use bd_rede_postos

-- 2� passo: Cria��o de Script para Povoar a Dimens�o Tempo
create or alter procedure  sp_dim_tempo(@dt_inicial date, @dt_final date)
as
begin
	declare @dataAtual date, @weekend varchar(3), @trimestre int, @NIVEL varchar(8), @nomeTrimestre varchar(100), 
	@semestre int, @nomeSemestre varchar(100), @diaDaSemana varchar(50)

	set @dataAtual = @dt_inicial

	--Inser��o dos dias do ano na tabela DIM_TEMPO
	while(@dataAtual >= @dt_inicial and @dataAtual <= @dt_final)
		begin
			set language Brazilian

			set @diaDaSemana = datename(dw, @dataAtual)
			--Define se aquele data corresponde a um dia do final de semana
			set @weekend = iif(@diaDaSemana = 'S�bado' or @diaDaSemana = 'Domingo', 'SIM', 'NAO')

			set @trimestre = datename(QUARTER, @dataAtual)
			--A estrutura de sele��o abaixo define o nome do trimestre e nome do semestre
			if(@trimestre = 1 or @trimestre = 2) 
				begin
					set @nomeTrimestre = iif(@trimestre = 1, '1� trimestre', '2� trimestre') 

					set @semestre = 1
					set @nomeSemestre = '1� semestre'
				end
			else 
				begin
					set @nomeTrimestre = iif(@trimestre = 3, '3� trimestre', '4� trimestre')

					set @semestre = 2
					set @nomeSemestre = '2� semestre'
				end

			insert into DIM_TEMPO
			values ('DIA', @dataAtual,  datepart(dd, @dataAtual), datepart(dw, @dataAtual), @weekend,
			        datepart(mm, @dataAtual), datename(mm, @dataAtual), @trimestre, @nomeTrimestre, 
					@semestre, @nomeSemestre, datepart(year, @dataAtual) )

			set @dataAtual = dateadd(dd, 1, @dataAtual)
		end


		set @dataAtual = @dt_inicial
		--Inser��o dos meses do ano na tabela DIM_TEMPO
	while(@dataAtual >= @dt_inicial and @dataAtual <= @dt_final)
		begin
			set language Brazilian

			set @trimestre = datename(QUARTER, @dataAtual)
			--A estrutura de sele��o abaixo define o nome do trimestre e nome do semestre
			if(@trimestre = 1 or @trimestre = 2) 
				begin
					set @nomeTrimestre = iif(@trimestre = 1, '1� trimestre', '2� trimestre') 

					set @semestre = 1
					set @nomeSemestre = '1� semestre'
				end
			else 
				begin
					set @nomeTrimestre = iif(@trimestre = 3, '3� trimestre', '4� trimestre')

					set @semestre = 2
					set @nomeSemestre = '2� semestre'
				end

			insert into DIM_TEMPO
			values ('MES', null,  null, null, null,
			        datepart(mm, @dataAtual), datename(mm, @dataAtual), @trimestre, @nomeTrimestre, 
					@semestre, @nomeSemestre, datepart(year, @dataAtual) )

			set @dataAtual = dateadd(mm, 1, @dataAtual)
		end

		--Inser��o do ano na tabela DIM_TEMPO
		insert into DIM_TEMPO(NIVEL, DATA, DIA, DIA_SEMANA,
	FIM_SEMANA, MES, NOME_MES, TRIMESTRE, NOME_TRIMESTRE, SEMESTRE, NOME_SEMESTRE, ANO)
		values ('ANO', null,  null, null, null, null, null, null, null, null, null, datepart(year, @dt_inicial))
end

--Testes
exec sp_dim_tempo '20220101', '20221231'

select * from DIM_TEMPO
delete DIM_TEMPO