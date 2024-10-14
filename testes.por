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

		Graficos.entrar_modo_tela_cheia()
		Graficos.definir_dimensoes_janela(Graficos.largura_tela(), Graficos.altura_tela())
		imagem = Graficos.redimensionar_imagem(imagem, 1920 * (Graficos.largura_tela() / 1920.0), 1080 * (Graficos.altura_tela() / 1080.0), verdadeiro)
		Graficos.desenhar_imagem(0, 0, imagem)

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(1540 * (Graficos.largura_tela() / 1920.0), 1059 * (Graficos.altura_tela() / 1080.0), "Esse é um texto para testar as resoluções")
		
		Graficos.renderizar()
		
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
