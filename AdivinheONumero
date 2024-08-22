programa
{
	inclua biblioteca Matematica --> m
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u
	
	funcao inicio()
	{
	inteiro jogo = 0, valorAdivinha, tentativa
	inteiro numTentativas = 7
	escreva("Escolha um jogo a seguir:\n\n[1] Adivinhe o Número\n[2] Desafio da Tabuada\n[3] QUIZ\n[4] Jogo da Forca\nJogo escolhido: ")
	leia(jogo)
		se (jogo == 1)
		{
			limpa()
			valorAdivinha = u.sorteia(1, 100)
			faca 
			{
				limpa()
				escreva("Escolha um número entre 1 e 100.\n")
				escreva("Seu número de tentativas : ", numTentativas, "\n")
				escreva("Escolha um número: ")
				leia(tentativa)
				se (tentativa < valorAdivinha)
				{
					limpa()
					numTentativas -= 1
					escreva("O número secreto é maior do que o número sugerido!\n")
					u.aguarde(2000)
				}
				se (tentativa > valorAdivinha)
				{
					limpa()
					numTentativas -= 1
					escreva("O número secreto é menor do que o número sugerido!\n")
					u.aguarde(2000)
				}
			}
			enquanto (numTentativas >= 1 e tentativa != valorAdivinha)
			se (tentativa == valorAdivinha)
				{
				limpa()
				escreva("Você acertou! O número secreto é ", valorAdivinha,"!")
				}
			se (tentativa != valorAdivinha e numTentativas == 0)
			{
				limpa()
				escreva("Seu número de tentativas acabou! O número era ", valorAdivinha,". Boa sorte na próxima vez.")
			}
			}
			
	}
}
