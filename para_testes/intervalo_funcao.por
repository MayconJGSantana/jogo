programa
{
	inclua biblioteca Util
	inclua biblioteca Calendario
	inclua biblioteca Teclado
	
	funcao inicio()
	{
		inteiro segundo_inicial
		inteiro milisegundo_inicial
		inteiro milisegundo_final
		inteiro segundo_final
		inteiro milisegundo_intermediario
		inteiro segundo_intermediario

		const inteiro TEMPO = 1687
		const inteiro SEGUNDO_EM_MILISEGUNDO = 1000
		
		segundo_inicial = Calendario.segundo_atual()
		milisegundo_inicial = Calendario.milisegundo_atual()

		milisegundo_intermediario = (milisegundo_inicial + (TEMPO % SEGUNDO_EM_MILISEGUNDO))
		segundo_intermediario = (segundo_inicial + (TEMPO / SEGUNDO_EM_MILISEGUNDO)) + (milisegundo_intermediario / 1000)
		segundo_final = (segundo_inicial + (TEMPO / SEGUNDO_EM_MILISEGUNDO)) % 60
		milisegundo_final = (milisegundo_inicial + (TEMPO % SEGUNDO_EM_MILISEGUNDO)) % 1000
		
		faca {
			Util.aguarde(1)
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		} enquanto (nao (segundo_final == Calendario.segundo_atual() e milisegundo_final <= Calendario.milisegundo_atual()))
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 679; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */