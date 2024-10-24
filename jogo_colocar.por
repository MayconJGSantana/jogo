programa
{
	inclua biblioteca Util
	funcao inicio()
	{
		inteiro numero
		inteiro pontos = 0
		inteiro multiplicador = Util.sorteia(1, 99)
		inteiro multiplicando = Util.sorteia(1, 99)
		cadeia deseja_continuar = ""
		enquanto(verdadeiro) {
			escreva(multiplicando, " x ", multiplicador, " = ")
			leia(numero)
			se (numero == multiplicando * multiplicador) {
				escreva("Ganhaste um ponto\n")
				pontos++
			}
			senao {
				escreva("Erraste, perdeste um ponto\n")
				pontos--
			}
			multiplicador = Util.sorteia(1, 99)
			multiplicando = Util.sorteia(1, 99)
			escreva("Pontuação: ", pontos, "\n")
			enquanto (verdadeiro) {
				escreva("Você deseja continuar [sim/nao]? ")
				leia(deseja_continuar)
				se (deseja_continuar == "sim" ou deseja_continuar == "nao" ou deseja_continuar == "não") {
					pare
				}
				senao {
					escreva("Valor inválido, tente novamente!\n")
				}
			}
			se (deseja_continuar != "sim") {
				inicio()
			}
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 535; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */