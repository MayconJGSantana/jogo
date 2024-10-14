programa
{
	inclua biblioteca Graficos
	inclua biblioteca Util
	inclua biblioteca Matematica
	
	funcao inicio()
	{
		inteiro imagem = Graficos.carregar_imagem("blackhole.jpg")
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.definir_dimensoes_janela(Graficos.largura_imagem(imagem), Graficos.altura_imagem(imagem))
		Graficos.desenhar_imagem(0, 0, imagem)
		Graficos.renderizar()

		Graficos.definir_dimensoes_janela(Graficos.largura_tela(), Graficos.altura_tela())
		imagem = Graficos.redimensionar_imagem(imagem, 1366, 1080 * (Graficos.altura_tela() / 1080.0), verdadeiro)
		Graficos.desenhar_imagem(0, 0, imagem)
		Graficos.renderizar()

		escreva(Graficos.altura_imagem(imagem))
			
		escreva("Altura: ", 1920 * (Graficos.largura_tela() / 1920.0), " - Largura: ", 1080 * (Graficos.altura_tela() / 1080.0))
		
		escreva("Altura: ", Graficos.altura_tela(), " - Largura: ", Graficos.largura_tela())
		inteiro i
		enquanto (verdadeiro) {
			/*Graficos.definir_cor(Graficos.COR_BRANCO)
			para (i = 0; i < 999; i++) {
				Graficos.desenhar_retangulo(Util.sorteia(0, Graficos.largura_imagem(imagem)), Util.sorteia(0, Graficos.altura_imagem(imagem)), 100, 100, falso, verdadeiro)
			}
			Graficos.renderizar()*/
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1223; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */