programa
{
	inclua biblioteca Teclado
	inclua biblioteca Tipos
	inclua biblioteca Mouse
	inclua biblioteca Graficos
	inclua biblioteca Util


	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	inteiro COR_CINZA_ESCURO = Graficos.criar_cor(128, 128, 128)
	
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
		inteiro posicao_x_seta = 40
		inteiro posicao_y_seta = 930

		const inteiro ALTURA_BLOCOS_ATAQUE = 140
		const inteiro LARGURA_BLOCOS_ATAQUE = 400

		inteiro vida_usuario = 200
		inteiro ataque_infringido_usuario
		real dano_usuario = 0.0
		inteiro nivel_usuario = 5
		inteiro pontos_ataque_usuario = 100
		inteiro pontos_defesa_usuario = 100
		cadeia ataques_usuario_policial[][] = {{"Ataque 1", "100"}, {"Ataque 2", "15"}, {"Ataque 3", "10"}, {"Ataque 4", "5"}}
		inteiro poder_ataque_usuario

		inteiro vida_bandido = 200
		inteiro nivel_bandido = 5
		inteiro ataques_bandido[][]
		inteiro poder_ataque_bandido
		inteiro pontos_defesa_bandido = 100
		
		enquanto (verdadeiro) {
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.limpar()
			
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.desenhar_retangulo(20, 70, 720, 150, verdadeiro, verdadeiro)
			Graficos.desenhar_retangulo(1919 - 740, 1079 - (350 + 100 + 150), 720, 150, verdadeiro, verdadeiro)

			Graficos.definir_cor(Graficos.COR_AMARELO)
			Graficos.desenhar_retangulo(30, 135, vida_bandido / 2 * 7, 75, verdadeiro, verdadeiro)
			Graficos.desenhar_retangulo(1919 - 730, 1079 - (350 + 100 + 10 + 75), vida_usuario / 2 * 7, 75, verdadeiro, verdadeiro)

			Graficos.definir_cor(COR_CINZA_ESCURO)
			Graficos.desenhar_elipse(594 - 800 / 2, 1079 - 350 - 150 - 30, 800, 150, verdadeiro)
			Graficos.desenhar_elipse(730 + (594 - 800 / 2), 250, 800, 150, verdadeiro)

			// interface dos ataques
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
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				ataque_infringido_usuario = ataque_escolhido(posicao_y_seta, posicao_x_seta)
				// vai ser o bandido tomando dano
				poder_ataque_usuario = Tipos.cadeia_para_inteiro(ataques_usuario_policial[ataque_infringido_usuario - 1][1], 10)
				dano_usuario = ((2.0 * nivel_usuario + 10) / 250 * (pontos_ataque_usuario / pontos_defesa_bandido) * poder_ataque_usuario + 2) * 1.5 * 2 * (Util.sorteia(85, 100) / 100.0)
				vida_bandido -= dano_usuario
				Util.aguarde(1000)
			}
			Graficos.renderizar()
			se (vida_bandido <= 0) {
				pare
			}
		}
	}

	funcao inteiro ataque_escolhido(inteiro posicao_y_seta, inteiro posicao_x_seta) {
		se (posicao_y_seta == 760 e posicao_x_seta == 40) {
			retorne 1
		}
		senao se (posicao_y_seta == 930 e posicao_x_seta == 40) {
			retorne 2
		}
		senao se (posicao_y_seta == 760 e posicao_x_seta == 657) {
			retorne 3
		}
		senao se (posicao_y_seta == 930 e posicao_x_seta == 657) {
			retorne 4
		}
		senao {
			retorne 0
		}
	}

	funcao vazio escolher_categoria() {
		enquanto (verdadeiro) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.limpar()
			
			Graficos.definir_tamanho_texto(20.0)
			Graficos.desenhar_texto(990, 100, "TEstando")
		}
	}
	
	funcao inicio()
	{
		
		inteiro posicao_x_usuario = 10
		inteiro posicao_y_usuario = 10
		inteiro largura_usuario = 100
		inteiro altura_usuario = 100
		logico usuario_moveu
		inteiro nivel_usuario
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
 * @POSICAO-CURSOR = 7312; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */