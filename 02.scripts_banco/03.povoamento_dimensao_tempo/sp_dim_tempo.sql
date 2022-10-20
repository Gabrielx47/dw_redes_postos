use bd_rede_postos

-- 2º passo: Criação de Script para Povoar a Dimensão Tempo
create or alter procedure  sp_dim_tempo(@dt_inicial date, @dt_final date)
as
begin
	declare @dataAtual date, @weekend varchar(3), @trimestre int, @NIVEL varchar(8), @nomeTrimestre varchar(100), 
	@semestre int, @nomeSemestre varchar(100), @diaDaSemana varchar(50)

	set @dataAtual = @dt_inicial

	--Inserção dos dias do ano na tabela DIM_TEMPO
	while(@dataAtual >= @dt_inicial and @dataAtual <= @dt_final)
		begin
			set language Brazilian

			set @diaDaSemana = datename(dw, @dataAtual)
			--Define se aquele data corresponde a um dia do final de semana
			set @weekend = iif(@diaDaSemana = 'Sábado' or @diaDaSemana = 'Domingo', 'SIM', 'NAO')

			set @trimestre = datename(QUARTER, @dataAtual)
			--A estrutura de seleção abaixo define o nome do trimestre e nome do semestre
			if(@trimestre = 1 or @trimestre = 2) 
				begin
					set @nomeTrimestre = iif(@trimestre = 1, '1º trimestre', '2º trimestre') 

					set @semestre = 1
					set @nomeSemestre = '1º semestre'
				end
			else 
				begin
					set @nomeTrimestre = iif(@trimestre = 3, '3º trimestre', '4º trimestre')

					set @semestre = 2
					set @nomeSemestre = '2º semestre'
				end

			insert into DIM_TEMPO
			values ('DIA', @dataAtual,  datepart(dd, @dataAtual), datepart(dw, @dataAtual), @weekend,
			        datepart(mm, @dataAtual), datename(mm, @dataAtual), @trimestre, @nomeTrimestre, 
					@semestre, @nomeSemestre, datepart(year, @dataAtual) )

			set @dataAtual = dateadd(dd, 1, @dataAtual)
		end


		set @dataAtual = @dt_inicial
		--Inserção dos meses do ano na tabela DIM_TEMPO
	while(@dataAtual >= @dt_inicial and @dataAtual <= @dt_final)
		begin
			set language Brazilian

			set @trimestre = datename(QUARTER, @dataAtual)
			--A estrutura de seleção abaixo define o nome do trimestre e nome do semestre
			if(@trimestre = 1 or @trimestre = 2) 
				begin
					set @nomeTrimestre = iif(@trimestre = 1, '1º trimestre', '2º trimestre') 

					set @semestre = 1
					set @nomeSemestre = '1º semestre'
				end
			else 
				begin
					set @nomeTrimestre = iif(@trimestre = 3, '3º trimestre', '4º trimestre')

					set @semestre = 2
					set @nomeSemestre = '2º semestre'
				end

			insert into DIM_TEMPO
			values ('MES', null,  null, null, null,
			        datepart(mm, @dataAtual), datename(mm, @dataAtual), @trimestre, @nomeTrimestre, 
					@semestre, @nomeSemestre, datepart(year, @dataAtual) )

			set @dataAtual = dateadd(mm, 1, @dataAtual)
		end

		--Inserção do ano na tabela DIM_TEMPO
		insert into DIM_TEMPO(NIVEL, DATA, DIA, DIA_SEMANA,
	FIM_SEMANA, MES, NOME_MES, TRIMESTRE, NOME_TRIMESTRE, SEMESTRE, NOME_SEMESTRE, ANO)
		values ('ANO', null,  null, null, null, null, null, null, null, null, null, datepart(year, @dt_inicial))
end

--Testes
exec sp_dim_tempo '20220101', '20221231'

select * from DIM_TEMPO
delete DIM_TEMPO