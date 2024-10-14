programa
{
	inclua biblioteca Teclado
	inclua biblioteca Tipos
	inclua biblioteca Mouse
	inclua biblioteca Graficos
	inclua biblioteca Util
	inclua biblioteca Matematica

	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	inteiro COR_CINZA_ESCURO = Graficos.criar_cor(128, 128, 128)
	
	inteiro posicao_x_seta = adequar_largura(40)
	inteiro posicao_y_seta = adequar_altura(930)
	
	inteiro vida_bandido = 200
	
	inteiro vida_usuario = 200
	inteiro posicao_x_usuario = adequar_largura(10)
	inteiro posicao_y_usuario = adequar_altura(10)

// movimentação
	funcao vazio criar_usuario() {
		Graficos.desenhar_retangulo(posicao_x_usuario, posicao_y_usuario, adequar_largura(100), adequar_altura(100), falso, verdadeiro)
	}

	funcao logico mover_usuario() {
		inteiro LARGURA_USUARIO = adequar_largura(100)
		inteiro ALTURA_USUARIO = adequar_altura(100)
		
		logico dentro_tela_cima = ((posicao_y_usuario - 10) >= 0)
		logico dentro_tela_baixo = (((posicao_y_usuario + ALTURA_USUARIO) + 10 <= adequar_altura(1079)))
		logico dentro_tela_direita = (((posicao_x_usuario + LARGURA_USUARIO) + 10 <= adequar_largura(1919)))
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
		inteiro chances = Util.sorteia(1, 10)
		se (chances == 1) {
			retorne verdadeiro
		}
		senao {
			retorne falso
		}
	}

// cenário de batalha
	funcao vazio batalhar() {

		
		enquanto (verdadeiro) {
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				atacar()
			}
			senao {
				cenario_batalha()
				
				// definir personagens
				Graficos.definir_cor(COR_CINZA)
				Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
				Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
				
				se (Teclado.tecla_pressionada(Teclado.TECLA_W) e posicao_y_seta == adequar_altura(930)) {
					posicao_y_seta -= adequar_altura(170)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_S) e posicao_y_seta == adequar_altura(760)) {
					posicao_y_seta += adequar_altura(170)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_A) e posicao_x_seta == adequar_largura(657)) {
					posicao_x_seta -= adequar_largura(617)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_D) e posicao_x_seta == adequar_largura(40)) {
					posicao_x_seta += adequar_largura(617)
				}
				
				Graficos.renderizar()
			}
			se (vida_bandido <= 0 ou vida_usuario <= 0) {
				pare
			}
		}
	}

	funcao inteiro ataque_escolhido() {
		se (posicao_y_seta == adequar_altura(760) e posicao_x_seta == adequar_largura(40)) {
			retorne 1
		}
		senao se (posicao_y_seta == adequar_altura(930) e posicao_x_seta == adequar_largura(40)) {
			retorne 2
		}
		senao se (posicao_y_seta == adequar_altura(760) e posicao_x_seta == adequar_largura(657)) {
			retorne 3
		}
		senao se (posicao_y_seta == adequar_altura(930) e posicao_x_seta == adequar_largura(657)) {
			retorne 4
		}
		senao {
			retorne 0
		}
	}

	funcao vazio atacar() {

		inteiro ataque_infringido
		inteiro poder_ataque
		real dano
		
		inteiro nivel_usuario = 5
		inteiro pontos_ataque_usuario = 100
		inteiro pontos_defesa_usuario = 100
		cadeia ataques_usuario_policial[][] = {{"Ataque 1", "100"}, {"Ataque 2", "15"}, {"Ataque 3", "10"}, {"Ataque 4", "5"}}


		inteiro nivel_bandido = 5
		cadeia ataques_bandido[][] = {{"Ataque 1", "100"}, {"Ataque 2", "15"}, {"Ataque 3", "10"}, {"Ataque 4", "5"}}
		inteiro pontos_ataque_bandido = 100
		inteiro pontos_defesa_bandido = 100

		// ataque usuário
		ataque_infringido = ataque_escolhido()
		poder_ataque = Tipos.cadeia_para_inteiro(ataques_usuario_policial[ataque_infringido - 1][1], 10)
		dano = ((2.0 * nivel_usuario + 10) / 250 * (pontos_ataque_usuario / pontos_defesa_bandido) * poder_ataque + 2) * 1.5 * 2 * (Util.sorteia(85, 100) / 100.0)
		vida_bandido -= dano

		bandido_tomou_dano()
		
		cenario_batalha()
		// definir personagens
		Graficos.definir_cor(COR_CINZA)
		Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		Graficos.renderizar()
		
		Util.aguarde(1500)

		// contra-ataque bandido
		ataque_infringido = Util.sorteia(1, 4)
		poder_ataque = Tipos.cadeia_para_inteiro(ataques_bandido[ataque_infringido - 1][1], 10)
		dano = ((2.0 * nivel_bandido + 10) / 250 * (pontos_ataque_bandido / pontos_defesa_usuario) * poder_ataque + 2) * 1.5 * 2 * (Util.sorteia(85, 100) / 100.0)
		vida_usuario -= dano

		usuario_tomou_dano()
	}

	funcao vazio bandido_tomou_dano() {
		inteiro i

		para (i = 0; i < 2; i++) {
			cenario_batalha()
			
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		
			Graficos.renderizar()
			Util.aguarde(150)
			
			cenario_batalha()

			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)

			Graficos.renderizar()
			Util.aguarde(200)
		}
	}

	funcao vazio usuario_tomou_dano() {
		inteiro i

		para (i = 0; i < 2; i++) {
			cenario_batalha()
			
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		
			Graficos.renderizar()
			Util.aguarde(150)
			
			cenario_batalha()

			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)

			Graficos.renderizar()
			Util.aguarde(200)
		}
	}

	funcao vazio cenario_batalha() {
		const inteiro ALTURA_BLOCOS_ATAQUE = 140
		const inteiro LARGURA_BLOCOS_ATAQUE = 400

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.limpar()
			
		Graficos.definir_cor(Graficos.COR_PRETO)
		Graficos.desenhar_retangulo(adequar_largura(20), adequar_altura(70), adequar_largura(720), adequar_altura(150), verdadeiro, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(1919 - 740),adequar_altura( 1079 - (350 + 100 + 150)), adequar_largura(720), adequar_altura(150), verdadeiro, verdadeiro)

		Graficos.definir_cor(Graficos.COR_AMARELO)
		Graficos.desenhar_retangulo(adequar_largura(30), adequar_altura(135), adequar_largura(vida_bandido / 2 * 7), adequar_altura(75), verdadeiro, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(1919 - 730), adequar_altura(1079 - (350 + 100 + 10 + 75)), adequar_largura(vida_usuario / 2 * 7), adequar_altura(75), verdadeiro, verdadeiro)

		Graficos.definir_cor(COR_CINZA_ESCURO)
		Graficos.desenhar_elipse(adequar_largura(594 - 800 / 2), adequar_altura(1079 - 350 - 150 - 30), adequar_largura(800), adequar_altura(150), verdadeiro)
		Graficos.desenhar_elipse(adequar_largura(730 + (594 - 800 / 2)), adequar_altura(250), adequar_largura(800), adequar_altura(150), verdadeiro)

		// interface dos ataques
		Graficos.definir_cor(COR_CINZA)
		Graficos.desenhar_retangulo(adequar_largura(0), adequar_altura(1079 - 350), adequar_largura(1920), adequar_altura(350), falso, verdadeiro)

		Graficos.definir_cor(COR_CINZA_ESCURO)
		Graficos.desenhar_retangulo(adequar_largura(200), adequar_altura(1079 - (350 - 20)), adequar_largura(LARGURA_BLOCOS_ATAQUE), adequar_altura(ALTURA_BLOCOS_ATAQUE), falso, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(200), adequar_altura(1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30)), adequar_largura(LARGURA_BLOCOS_ATAQUE), adequar_altura(ALTURA_BLOCOS_ATAQUE), falso, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(200 + LARGURA_BLOCOS_ATAQUE + 230), adequar_altura(1079 - (350 - 20)), adequar_largura(LARGURA_BLOCOS_ATAQUE), adequar_altura(ALTURA_BLOCOS_ATAQUE), falso, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(200 + LARGURA_BLOCOS_ATAQUE + 230), adequar_altura(1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30)), adequar_largura(LARGURA_BLOCOS_ATAQUE), adequar_altura(ALTURA_BLOCOS_ATAQUE), falso, verdadeiro)
		
		Graficos.definir_tamanho_texto(adequar_texto(120.0))
		Graficos.desenhar_texto(posicao_x_seta, posicao_y_seta, ">")
	}
	
// começo
	funcao vazio escolher_categoria() {
		enquanto (verdadeiro) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.limpar()
			
			Graficos.definir_tamanho_texto(adequar_texto(20.0))
			Graficos.desenhar_texto(adequar_largura(990), adequar_altura(100), "Testando")
		}
	}

// variados
	funcao inteiro adequar_largura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}

	funcao inteiro adequar_altura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.altura_tela() / 1080.0), 0)
	}

	funcao inteiro adequar_texto(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}
	
	funcao inicio()
	{
		

		logico usuario_moveu
		cadeia lugar = ""
		logico bandido_apareceu

		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.entrar_modo_tela_cheia()

		enquanto (verdadeiro) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.limpar()
	
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.desenhar_retangulo(adequar_largura(1600), adequar_altura(200), adequar_largura(300), adequar_altura(300), verdadeiro, verdadeiro)
			
			criar_usuario()
			usuario_moveu = mover_usuario()

			se (usuario_moveu) {
				bandido_apareceu = aparecer_bandido()
				se (bandido_apareceu) {
					batalhar()
				}
			}
			
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.definir_tamanho_texto(adequar_texto(20.0))
			Graficos.desenhar_texto(adequar_largura(1625), adequar_altura(210), "Posição x (mouse): ")
			Graficos.desenhar_texto(adequar_largura(1800), adequar_altura(210), Tipos.inteiro_para_cadeia(Mouse.posicao_x(), 10))
			
			Graficos.desenhar_texto(adequar_largura(1625), adequar_altura(235), "Posição y (mouse): ")
			Graficos.desenhar_texto(adequar_largura(1800), adequar_altura(235), Tipos.inteiro_para_cadeia(Mouse.posicao_y(), 10))
			
			Graficos.desenhar_texto(adequar_largura(1625), adequar_altura(285), "Posição x (usuário): ")
			Graficos.desenhar_texto(adequar_largura(1810), adequar_altura(285), Tipos.inteiro_para_cadeia(posicao_x_usuario, 10))
			
			Graficos.desenhar_texto(adequar_largura(1625), adequar_altura(305), "Posição y (usuário): ")
			Graficos.desenhar_texto(adequar_largura(1810), adequar_altura(305), Tipos.inteiro_para_cadeia(posicao_y_usuario, 10))
			
			Graficos.renderizar()
			
		}
	}
}
