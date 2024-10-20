programa
{
	inclua biblioteca Graficos
	inclua biblioteca Matematica
	inclua biblioteca Util
	inclua biblioteca Teclado
	inclua biblioteca Calendario
	inclua biblioteca Texto
	inclua biblioteca Tipos

	inteiro posicao_x_usuario = adequar_largura(500)
	inteiro posicao_y_usuario = adequar_altura(155)
	inteiro usuario = Graficos.carregar_imagem("personagens/usuario.png")
	inteiro cidade = Graficos.carregar_imagem("cidade.jpg")
	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	cadeia lugar = ""
	cadeia curso = ""
	
	funcao inicio()
	{
		cadeia tipo_investigacao = ""
		logico conseguiu_falar
		
		cidade = Graficos.redimensionar_imagem(cidade, Graficos.largura_tela(), Graficos.altura_tela(), verdadeiro)
		usuario = Graficos.redimensionar_imagem(usuario, adequar_largura(Graficos.largura_imagem(usuario) / 6), adequar_altura((Graficos.altura_imagem(usuario) / 6)), verdadeiro)

		inicia_grafico()
		
		historia()

		escolha_curso()
		
		aparecer_cidade()

		tipo_investigacao = investigacao()
		
		lugar = "casa_usuario"
		
		se (tipo_investigacao == "si_mesmo") {
			
			
		}
		senao se (tipo_investigacao == "ajuda_moradores") {
			conseguiu_falar = falar_moradores()
			se (conseguiu_falar) {
				escolher_edificio()
				se (lugar == "dentro_esgoto") {
					labirinto()
				}
				senao se (lugar == "festa") {
					
				}
				senao se (lugar == "dentro_predio") {
					
				}
			}
			senao {
				
			}
		}
	}

	funcao vazio inicia_grafico() {
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.entrar_modo_tela_cheia()
	}

	funcao vazio historia() {
		lugar = "historia"
		
		// Graficos.desenhar_imagem(0, 0, historia)
		Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(50, 50, "'Tram... Tram... Tram...', esse é um barulho familiar a seus auriculares. 'Meu Deus' tu dizes, depois de olhar no relógio, '7:49', lembrando-se da prova que seus colegas estão fazendo,")
		Graficos.desenhar_texto(50, 70, "a qual também deveria estar.")
		Graficos.desenhar_texto(50, 90, "...")
		Graficos.renderizar()

		pular_acao(20000)
	}

	funcao vazio pular_acao(inteiro TEMPO) {
		inteiro i
		
		para (i = 1; i <= TEMPO; i++) {
			Util.aguarde(1)
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		}
	}

	funcao vazio escolha_curso() {
		lugar = "escolha_curso"
		
		enquanto (curso == "") {
			// Graficos.desenhar_imagem(0, 0, cidade)
			Graficos.definir_opacidade(200)
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
			Graficos.definir_opacidade(255)
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.desenhar_retangulo(300, 300, adequar_largura(600), adequar_altura(600), verdadeiro, verdadeiro)
			
			Graficos.definir_cor(Graficos.COR_PRETO)
			Graficos.definir_tamanho_texto(20.0)
			Graficos.desenhar_texto(310, 310, "Psicologia - Aperte 1")
			Graficos.desenhar_texto(310, 340, "Segurança Pública (Policial) - Aperte 2")
			Graficos.desenhar_texto(310, 370, "Técnico em Desenvolvimento de Sistemas - Aperte 3")
			Graficos.renderizar()

			se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
				curso = "psicologia"
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
				curso = "seguranca_publica"
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_3)) {
				curso = "tecnico_desenvolvimento_sistemas"
			}
		}
		
	}

	funcao vazio aparecer_cidade() {
		inteiro i

		para (i = 5; i <= 255; i+= 10) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.definir_opacidade(i)
			Graficos.desenhar_imagem(0, 0, cidade)
			Graficos.renderizar()
			Util.aguarde(100)
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		}
	}

	funcao cadeia investigacao() {
		cadeia tipo_investigacao = ""
		
		lugar = "opcao_investigacao"
		
		faca {
			Graficos.desenhar_imagem(0, 0, cidade)
			Graficos.definir_rotacao(90)
			Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, usuario)
			Graficos.definir_rotacao(0)
			
			Graficos.definir_opacidade(200)
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
			Graficos.definir_opacidade(255)
			
			Graficos.definir_cor(Graficos.COR_BRANCO)
			Graficos.desenhar_retangulo(300, 300, adequar_largura(600), adequar_altura(600), verdadeiro, verdadeiro)
			Graficos.definir_cor(Graficos.COR_PRETO)
			
			Graficos.definir_tamanho_texto(20.0)
			Graficos.desenhar_texto(310, 310, "Saiste para procurá-lo desesperadamente, mas não o encontrei. À junção de pontos,")
			Graficos.desenhar_texto(310, 340, "descobriste que os cachorros da vizinhança também estavam desaparecidos.")
			Graficos.desenhar_texto(310, 370, "* Ação")
			Graficos.desenhar_texto(310, 390, "	[ Aperte 1 ] Perguntar para os moradores sobre pistas de onde está os cachorros.")
			Graficos.desenhar_texto(310, 410, "	[ Aperte 2 ] Fazer uma investigação por si mesmo.")
			Graficos.renderizar()

			se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
				tipo_investigacao = "ajuda_moradores"
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
				tipo_investigacao = "si_mesmo"
			}
		} enquanto (tipo_investigacao == "")

		retorne tipo_investigacao
	}

	funcao vazio mostrar_primeira_missao() {

		// interface de missão
		Graficos.definir_cor(Graficos.COR_AZUL)
		Graficos.desenhar_retangulo(1800, 20, 100, 50, verdadeiro, verdadeiro)

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(30, 1810, "Aqui missão")
	}

	funcao vazio mostrar_segunda_missao() {
		
		// interface de missão
		Graficos.definir_cor(Graficos.COR_AZUL)
		Graficos.desenhar_retangulo(1700, 20, 200, 50, verdadeiro, verdadeiro)

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(30, 1810, "Aqui missão")
	}

	funcao vazio movimentacao_cidade() {
		inteiro rotacao = 0
		
		se (lugar == "casa_usuario") {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "casa_morador_3"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "casa_morador_1"
				posicao_x_usuario = adequar_largura(667)
				posicao_y_usuario = adequar_altura(210)
			}
		}
		senao se (lugar == "casa_morador_1") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "casa_morador_2"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(400)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_usuario"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(155)
			}
		}
		senao se (lugar == "casa_morador_2") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_morador_1"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(210)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_morador_3"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "casa_morador_3") {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_usuario"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(155)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "casa_morador_2"
				posicao_x_usuario = adequar_largura(667)
				posicao_y_usuario = adequar_altura(425)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_abandonada"
				posicao_x_usuario = adequar_largura(130)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "esgoto") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_morador_3"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_abandonada"
				posicao_x_usuario = adequar_largura(130)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "casa_abandonada") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
		}
		senao se (lugar == "predio") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "hospital"
				posicao_x_usuario = adequar_largura(1370)
				posicao_y_usuario = adequar_altura(800)
			}
		}
		senao se (lugar == "hospital") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "departamento_policial"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(150)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "departamento_policial") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "hospital"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(800)
			}
		}
		
		Graficos.desenhar_imagem(0, 0, cidade)

		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, usuario)
		Graficos.definir_rotacao(0)

		// não foi colocado Graficos.renderizar(), então tem que colocar fora da função, para conseguir aparecer
	}

	funcao vazio escolher_moradores_certos(inteiro &moradores_certos[]) {
		inteiro infringir_morador_certo
		inteiro morador_ja_certo
		inteiro i
		inteiro expoente = 2
		inteiro ordem_moradores
		
		se (curso == "seguranca_publica") {
			infringir_morador_certo = Util.sorteia(0, 2)
			moradores_certos[infringir_morador_certo] = 1
		}
		senao se (curso == "psicologia") {
			infringir_morador_certo = Util.sorteia(0, 2)
			moradores_certos[infringir_morador_certo] = 1
			morador_ja_certo = infringir_morador_certo
			
			faca {
				infringir_morador_certo = Util.sorteia(0, 2)
			} enquanto (infringir_morador_certo == morador_ja_certo)
			moradores_certos[infringir_morador_certo] = 1
		}
	}

	funcao logico falar_moradores() {
		inteiro moradores_certos[] = {0, 0, 0}
		caracter caracter_numero_morador
		inteiro inteiro_numero_morador
		logico conseguiu_informacao = falso
		inteiro numero_sorteado

		escolher_moradores_certos(moradores_certos)
		
		enquanto (verdadeiro) {
			movimentacao_cidade()
			mostrar_primeira_missao()
			Graficos.renderizar()
			
			se ((lugar == "casa_morador_1" ou lugar == "casa_morador_2" ou lugar == "casa_morador_3") e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
				se (curso == "seguranca_publica" ou curso == "psicologia") {
					caracter_numero_morador = Texto.obter_caracter(lugar, 13)
					inteiro_numero_morador = Tipos.caracter_para_inteiro(caracter_numero_morador) - 1
					se (moradores_certos[inteiro_numero_morador] == 1) {
						conseguiu_informacao = verdadeiro
					}
					senao se (moradores_certos[inteiro_numero_morador] == 0) {
						conseguiu_informacao = falso
					}
					pare
				}
				senao se (curso == "tecnico_desenvolvimento_sistemas") {
					numero_sorteado = Util.sorteia(1, 6)
					se (numero_sorteado == 6) {
						conseguiu_informacao = verdadeiro
					}
					senao {
						conseguiu_informacao = falso
					}
					pare
				}
			}
		}
		retorne conseguiu_informacao
	}

	funcao vazio escolher_edificio() {
		faca {
			movimentacao_cidade()
			mostrar_segunda_missao()
			Graficos.renderizar()
			consequencia_edificios()
		} enquanto (nao (lugar == "dentro_esgoto" ou lugar == "dentro_predio" ou lugar == "festa"))
	}

	funcao vazio consequencia_edificios() {
		
		se (lugar == "esgoto" e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
			lugar = "dentro_esgoto"
		}
		senao se (lugar == "predio" e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
			lugar = "dentro_predio"
		}
		senao se (lugar == "casa_abandonada" e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
			// escolhe
			enquanto (verdadeiro) {
				Graficos.renderizar()
				se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
					pare
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
					lugar = "festa"
					pare
				}
 			} 
		}		
	}

	funcao vazio movimentacao_esgoto(inteiro esgoto, inteiro &ponto, inteiro rotacao) {
		
		se (ponto == 0) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(605)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(690)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = adequar_largura(890)
				posicao_y_usuario = adequar_altura(710)
			}
		}

		senao se (ponto == 1) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = adequar_largura(750)
				posicao_y_usuario = adequar_altura(605)
				}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(690)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = adequar_largura(750)
				posicao_y_usuario = adequar_altura(860)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 13
				posicao_x_usuario = adequar_largura(1340)
				posicao_y_usuario = adequar_altura(895)
			}
		}
		senao se (ponto == 2) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = adequar_largura(750)
				posicao_y_usuario = adequar_altura(605)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = adequar_largura(750)
				posicao_y_usuario = adequar_altura(860)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = adequar_largura(890)
				posicao_y_usuario = adequar_altura(710)
			}
		}
		senao se (ponto == 3) {
			rotacao = 90
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 4
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(430)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(690)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(860)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = adequar_largura(890)
				posicao_y_usuario = adequar_altura(710)
			}
		}
		senao se (ponto == 4) {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(225)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(605)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(605)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = adequar_largura(1030)
				posicao_y_usuario = adequar_altura(75)
			}
		}
		senao se (ponto == 5) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 6
				posicao_x_usuario = adequar_largura(378)
				posicao_y_usuario = adequar_altura(215)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 4
				posicao_x_usuario = adequar_largura(750)
				posicao_y_usuario = adequar_altura(430)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = adequar_largura(1030)
				posicao_y_usuario = adequar_altura(75)
			}
		}
		senao se (ponto == 6) {
			rotacao = 0
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(225)
			}
		}
		senao se (ponto == 7) {
			rotacao = 90
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = adequar_largura(560)
				posicao_y_usuario = adequar_altura(225)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = adequar_largura(1185)
				posicao_y_usuario = adequar_altura(215)
			}
		}
		senao se (ponto == 8) {
			rotacao = 0
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = adequar_largura(1340)
				posicao_y_usuario = adequar_altura(120)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = adequar_largura(1030)
				posicao_y_usuario = adequar_altura(75)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = adequar_largura(1335)
				posicao_y_usuario = adequar_altura(345)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = adequar_largura(1480)
				posicao_y_usuario = adequar_altura(225)
			}
		}
		senao se (ponto == 9) {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = adequar_largura(1185)
				posicao_y_usuario = adequar_altura(215)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = adequar_largura(1480)
				posicao_y_usuario = adequar_altura(225)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = adequar_largura(1335)
				posicao_y_usuario = adequar_altura(345)
			}
		}
		senao se (ponto == 10) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = adequar_largura(1185)
				posicao_y_usuario = adequar_altura(215)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = adequar_largura(1340)
				posicao_y_usuario = adequar_altura(120)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = adequar_largura(1335)
				posicao_y_usuario = adequar_altura(345)
			}
		}
		senao se (ponto == 11) {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = adequar_largura(1185)
				posicao_y_usuario = adequar_altura(215)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = adequar_largura(1340)
				posicao_y_usuario = adequar_altura(120)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 12
				posicao_x_usuario = adequar_largura(1505)
				posicao_y_usuario = adequar_altura(700)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = adequar_largura(1480)
				posicao_y_usuario = adequar_altura(225)
			}
		}
		senao se (ponto == 12) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = adequar_largura(1335)
				posicao_y_usuario = adequar_altura(345)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 13
				posicao_x_usuario = adequar_largura(1345)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 13
				posicao_x_usuario = adequar_largura(1345)
				posicao_y_usuario = adequar_altura(900)
			}
		}
		senao se (ponto == 13) {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 12
				posicao_x_usuario = adequar_largura(1505)
				posicao_y_usuario = adequar_altura(710)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 1
				posicao_x_usuario = adequar_largura(890)
				posicao_y_usuario = adequar_altura(710)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 12
				posicao_x_usuario = adequar_largura(1505)
				posicao_y_usuario = adequar_altura(710)
			}
		}
			Graficos.desenhar_imagem(0, 0, esgoto)
				
			Graficos.definir_rotacao(rotacao)
			Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, usuario)
			Graficos.definir_rotacao(0)
				
			Graficos.renderizar()
	}
	
	funcao vazio labirinto()
	{	
		inteiro esgoto = Graficos.carregar_imagem("/portas_esgoto/esgoto.jpg")
		inteiro rotacao = 0
		inteiro ponto = 0
		
		esgoto = Graficos.redimensionar_imagem(esgoto, Graficos.largura_janela(), Graficos.altura_janela(), verdadeiro)
		
		posicao_x_usuario = adequar_largura(750)
		posicao_y_usuario = adequar_altura(860)
		
		enquanto (verdadeiro) {
			movimentacao_esgoto(esgoto, ponto, rotacao)
		}
	}
	
	funcao inteiro adequar_largura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}

	funcao inteiro adequar_altura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.altura_tela() / 1080.0), 0)
	}
        
	funcao inteiro adequar_texto(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}	
	
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2898; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */
