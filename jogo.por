programa
{
	inclua biblioteca Teclado
	inclua biblioteca Tipos
	inclua biblioteca Mouse
	inclua biblioteca Graficos
	inclua biblioteca Util

	funcao vazio criar_usuario(inteiro posicao_y_usuario, inteiro posicao_x_usuario, inteiro largura_usuario, inteiro altura_usuario) {
		Graficos.desenhar_retangulo(posicao_x_usuario, posicao_y_usuario, 100, 100, falso, verdadeiro)
	}

	funcao logico mover_usuario(inteiro &posicao_y_usuario, inteiro &posicao_x_usuario, inteiro largura_usuario, inteiro altura_usuario) {
		logico dentro_tela_cima = ((posicao_y_usuario - 10) >= 0)
		logico dentro_tela_baixo = (((posicao_y_usuario + altura_usuario) + 10) <= 1079)
		logico dentro_tela_direita = (((posicao_x_usuario + largura_usuario) + 10) <= 1919)
		logico dentro_tela_esquerda = ((posicao_x_usuario - 10) >= 0)
		
		se (Teclado.tecla_pressionada(Teclado.TECLA_W) e dentro_tela_cima) {
			posicao_y_usuario += -10
			retorne verdadeiro
		}
		senao se (Teclado.tecla_pressionada(Teclado.TECLA_A) e dentro_tela_esquerda) {
			posicao_x_usuario += -10
			retorne verdadeiro
		}
		senao se (Teclado.tecla_pressionada(Teclado.TECLA_S) e dentro_tela_baixo) {
			posicao_y_usuario += 10
			retorne verdadeiro
		}
		senao se (Teclado.tecla_pressionada(Teclado.TECLA_D) e dentro_tela_direita) {
			posicao_x_usuario += 10
			retorne verdadeiro
		}
		senao {
			retorne falso
		}
	}

	funcao logico aparecer_bandido() {
		inteiro chances = Util.sorteia(1, 6)
		se (chances == 1) {
			retorne verdadeiro
		}
		senao {
			retorne falso
		}
	}

	funcao vazio batalhar() {
		inteiro vida_bandido = 100
		inteiro vida_usuario = 100
		inteiro COR_CINZA_ESCURO = Graficos.criar_cor(128, 128, 128)
		inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)

		inteiro posicao_x_seta = 40
		inteiro posicao_y_seta = 930

		inteiro ataque_escolhido

		
		const inteiro ALTURA_BLOCOS_ATAQUE = 140
		const inteiro LARGURA_BLOCOS_ATAQUE = 400
		enquanto (verdadeiro) {
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.limpar()
	
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.desenhar_retangulo(10, 10, 720, 150, verdadeiro, verdadeiro)

			Graficos.definir_cor(Graficos.COR_AMARELO)
			Graficos.desenhar_retangulo(20, 75, vida_bandido * 7, 75, verdadeiro, verdadeiro)

			
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.desenhar_retangulo(1919 - 730, 1079 - (160 + 350), 720, 150, verdadeiro, verdadeiro)

			Graficos.definir_cor(Graficos.COR_AMARELO)
			Graficos.desenhar_retangulo(1919 - 720, 1079 - (350 + 95), vida_bandido * 7, 75, verdadeiro, verdadeiro)

			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(0, 1079 - 350, 1920, 350, falso, verdadeiro)

			Graficos.definir_cor(COR_CINZA_ESCURO)
			Graficos.desenhar_retangulo(200, 1079 - (350 - 20), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
			Graficos.desenhar_retangulo(200, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
			Graficos.desenhar_retangulo(200 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
			Graficos.desenhar_retangulo(200 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)

			Graficos.definir_tamanho_texto(120.0)
			Graficos.desenhar_texto(posicao_x_seta, posicao_y_seta, ">")
			se (Teclado.tecla_pressionada(Teclado.TECLA_W) e posicao_y_seta == 930) {
				posicao_y_seta -= 170
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_S) e posicao_y_seta == 760) {
				posicao_y_seta += 170
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_A) e posicao_x_seta == 657) {
				posicao_x_seta -= 617
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_D) e posicao_x_seta == 40) {
				posicao_x_seta += 617
			}

			Graficos.renderizar()
		}
	}
	
	funcao inicio()
	{
		inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
		inteiro posicao_x_usuario = 10
		inteiro posicao_y_usuario = 10
		inteiro largura_usuario = 100
		inteiro altura_usuario = 100
		logico usuario_moveu
		inteiro i
		cadeia lugar = ""
		inteiro j
		
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.entrar_modo_tela_cheia()

		enquanto (verdadeiro) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.limpar()
	
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.desenhar_retangulo(1600, 200, 300, 300, verdadeiro, verdadeiro)
			
			criar_usuario(posicao_y_usuario, posicao_x_usuario, largura_usuario, altura_usuario)
			usuario_moveu = mover_usuario(posicao_y_usuario, posicao_x_usuario, largura_usuario, altura_usuario)

			se (usuario_moveu) {
				logico bandido_apareceu
				bandido_apareceu = aparecer_bandido()
				se (bandido_apareceu) {
					batalhar()
				}
			}
			
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.definir_tamanho_texto(20.0)
			Graficos.desenhar_texto(1625, 210, "Posição x (mouse): ")
			Graficos.desenhar_texto(1800, 210, Tipos.inteiro_para_cadeia(Mouse.posicao_x(), 10))
			
			Graficos.desenhar_texto(1625, 235, "Posição y (mouse): ")
			Graficos.desenhar_texto(1800, 235, Tipos.inteiro_para_cadeia(Mouse.posicao_y(), 10))
			
			Graficos.desenhar_texto(1625, 285, "Posição x (usuário): ")
			Graficos.desenhar_texto(1810, 285, Tipos.inteiro_para_cadeia(posicao_x_usuario, 10))
			
			Graficos.desenhar_texto(1625, 305, "Posição y (usuário): ")
			Graficos.desenhar_texto(1810, 305, Tipos.inteiro_para_cadeia(posicao_y_usuario, 10))
			
			Graficos.renderizar()
			
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3998; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */