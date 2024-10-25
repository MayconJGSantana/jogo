programa
{
	inclua biblioteca Graficos
	inclua biblioteca Matematica
	inclua biblioteca Util
	inclua biblioteca Teclado
	inclua biblioteca Calendario
	inclua biblioteca Texto
	inclua biblioteca Tipos
	inclua biblioteca Arquivos

	inteiro posicao_x_usuario = adequar_largura(500)
	inteiro posicao_y_usuario = adequar_altura(155)
	
	cadeia lugar = ""
	cadeia curso = ""
	
	inteiro vida_bandido = 200
	
	inteiro vida_usuario = 200
	
	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	inteiro COR_CINZA_ESCURO = Graficos.criar_cor(128, 128, 128)
	
	inteiro posicao_x_seta = adequar_largura(40)
	inteiro posicao_y_seta = adequar_altura(930)
	
	funcao inicio()
	{
		cadeia tipo_investigacao = ""
		logico conseguiu_falar
		cadeia investigou = ""
		inteiro tela_escolha_investigacao

		inicia_grafico()
		
		historia(investigou)

		se (investigou == "ignorar_noticias") {
			morreu_ignorou()
		}
		senao se (investigou == "investigar") {
			lugar = "casa_usuario"
			guardar_imagens_moradores()
			
			aparecer_cidade()

			escolha_tipo_investigacao(tipo_investigacao)
			
			se (tipo_investigacao == "si_mesmo") {
				
			}
			senao se (tipo_investigacao == "ajuda_moradores") {
				conseguiu_falar = falar_moradores()
				se (conseguiu_falar) {
					escolher_edificio()
					se (lugar == "dentro_esgoto") {
						enquanto (verdadeiro) {
							se (lugar == "dentro_esgoto") {
								Util.aguarde(300)
								labirinto()
							}
							senao se (lugar == "esgoto") {
								posicao_x_usuario = adequar_largura(530)
								posicao_y_usuario = adequar_altura(900)
								
								movimentacao_cidade()
								Graficos.renderizar()
								
								enquanto (lugar != "dentro_esgoto") {
									movimentacao_cidade()
									Graficos.renderizar()
									consequencia_edificios(3.1)
								} 
	
							}
							
						}
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
	}
	
	funcao vazio guardar_imagens_moradores() {
		// Declaração de variáveis
		inteiro arquivo = 0
		
			// Principais
		inteiro usuario = Graficos.carregar_imagem("Find_IT/personagens/usuario/usuario.png")
		inteiro cidade = Graficos.carregar_imagem("Find_IT/cenarios/cidade/cidade.jpg")

		/*
			// Esgoto
		inteiro esgoto = Graficos.carregar_imagem("portas_esgoto/esgoto.jpg")
		inteiro sala_esgoto_teia = Graficos.carregar_imagem("Find_IT/Find_IT_slides/cenarios/esgoto/sala_esgoto_teia.png")

			// Bandidos
		// inteiro bandido_1 = Graficos.carregar_imagem("")
*/

		// Deixa a imagem do tamanho que queremos
		cidade = Graficos.redimensionar_imagem(cidade, Graficos.largura_tela(), Graficos.altura_tela(), verdadeiro)
		usuario = Graficos.redimensionar_imagem(usuario, adequar_largura(Graficos.largura_imagem(usuario) / 6), adequar_altura((Graficos.altura_imagem(usuario) / 6)), verdadeiro)

/*
		esgoto = Graficos.redimensionar_imagem(esgoto, Graficos.largura_tela(), Graficos.altura_tela(), verdadeiro)
		sala_esgoto_teia = Graficos.redimensionar_imagem(sala_esgoto_teia, Graficos.largura_tela(), Graficos.altura_tela(), verdadeiro)
*/


		// Se o arquivo ainda não foi criado no computador, ele cria
		se (Arquivos.arquivo_existe("imagens")) {
			Arquivos.apagar_arquivo("imagens")
		}

		// Abre
		arquivo = Arquivos.abrir_arquivo("imagens", Arquivos.MODO_ESCRITA)

			// Adiciona as imagens ao arquivo
				// Principais
		adiciona_imagem_arquivo(arquivo, cidade, "cidade")
		adiciona_imagem_arquivo(arquivo, usuario, "usuario")

/*
				// Esgoto
		adiciona_imagem_arquivo(arquivo, esgoto, "esgoto")
		adiciona_imagem_arquivo(arquivo, sala_esgoto_teia, "sala_esgoto_teia")
*/

		// Fecha
		Arquivos.fechar_arquivo(arquivo)
	}

	funcao vazio morreu_ignorou() {
		inteiro lugar_fim = 1
		inteiro fim_partes[11]
		
		fim_partes[0] = Graficos.carregar_imagem("Find_IT/historia/e_fake_news/historia_12.png")
		fim_partes[1] = Graficos.carregar_imagem("Find_IT/historia/e_fake_news/historia_13.png")
		fim_partes[2] = Graficos.carregar_imagem("Find_IT/historia/e_fake_news/historia_14.png")
		fim_partes[3] = Graficos.carregar_imagem("Find_IT/historia/e_fake_news/historia_15.png")
		
		enquanto (verdadeiro) {

			Graficos.desenhar_imagem(0, 0, fim_partes[lugar_fim - 1])
			Graficos.renderizar()
			se (Teclado.tecla_pressionada(Teclado.TECLA_E) e lugar_fim != 4) {
				lugar_fim++
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q) e lugar_fim != 1) {
				lugar_fim--
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
				Graficos.fechar_janela()
			}
 		}
	}

	funcao vazio adiciona_imagem_arquivo(inteiro arquivo, inteiro imagem, cadeia imagem_nome) {
		Arquivos.escrever_linha(imagem_nome, arquivo)
		Arquivos.escrever_linha(Tipos.inteiro_para_cadeia(imagem, 10), arquivo)
	}

	funcao inteiro reverter_imagem(cadeia nome_imagem) {
		inteiro arquivo
		inteiro numero_arquivo = 0
		
		arquivo = Arquivos.abrir_arquivo("imagens", Arquivos.MODO_LEITURA)
		enquanto (verdadeiro) {
			se (Arquivos.fim_arquivo(arquivo)) {
				Arquivos.fechar_arquivo(arquivo)
				arquivo = Arquivos.abrir_arquivo("imagens", Arquivos.MODO_LEITURA)
			}
			senao se (Arquivos.ler_linha(arquivo) == nome_imagem) {
				numero_arquivo = Tipos.cadeia_para_inteiro(Arquivos.ler_linha(arquivo), 10)
				pare
			}
		}
		Arquivos.fechar_arquivo(arquivo)
		retorne numero_arquivo
	}
	
	funcao vazio inicia_grafico() {
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.entrar_modo_tela_cheia()
	}

	funcao vazio historia(cadeia &investigou) {
		inteiro lugar_historia = 1
		inteiro i
		inteiro historia_partes[11]
		
		historia_partes[0] = Graficos.carregar_imagem("Find_IT/historia/historia_1.png")
		historia_partes[1] = Graficos.carregar_imagem("Find_IT/historia/historia_2.png")
		historia_partes[2] = Graficos.carregar_imagem("Find_IT/historia/escolha_curso.png")
		historia_partes[3] = Graficos.carregar_imagem("Find_IT/historia/historia_4.png")
		historia_partes[4] = Graficos.carregar_imagem("Find_IT/historia/historia_5.png")
		historia_partes[5] = Graficos.carregar_imagem("Find_IT/historia/historia_6.png")
		historia_partes[6] = Graficos.carregar_imagem("Find_IT/historia/historia_7.png")
		historia_partes[7] = Graficos.carregar_imagem("Find_IT/historia/historia_8.png")
		historia_partes[8] = Graficos.carregar_imagem("Find_IT/historia/historia_9.png")
		historia_partes[9] = Graficos.carregar_imagem("Find_IT/historia/historia_10.png")
		historia_partes[10] = Graficos.carregar_imagem("Find_IT/historia/escolha_noticia.png")
		
		enquanto (verdadeiro) {

			Graficos.desenhar_imagem(0, 0, historia_partes[lugar_historia - 1])
			Graficos.renderizar()

			se (lugar_historia == 3) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
					curso = "psicologia"
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
					curso = "seguranca_publica"
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_3)) {
					curso = "tecnico_desenvolvimento_sistemas"
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_E) e curso != "") {
					lugar_historia++
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_E) e curso == "") {
					Graficos.desenhar_imagem(0, 0, historia_partes[lugar_historia - 1])
					Graficos.definir_cor(Graficos.COR_VERMELHO)
					Graficos.definir_tamanho_texto(20.0)
					Graficos.desenhar_texto(0, 0, "Estás errado")
					Graficos.renderizar()
					Util.aguarde(2000)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					lugar_historia--
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
					Graficos.fechar_janela()
				}
			}
			senao se (lugar_historia == 11) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
					investigou = "ignorar_noticias"
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
					investigou = "investigar"
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_E) e investigou != "") {
					pare
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_E) e investigou == "") {
					Graficos.desenhar_imagem(0, 0, historia_partes[lugar_historia - 1])
					Graficos.definir_cor(Graficos.COR_VERMELHO)
					Graficos.definir_tamanho_texto(20.0)
					Graficos.desenhar_texto(0, 0, "Estás errado")
					Graficos.renderizar()
					Util.aguarde(2000)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					lugar_historia--
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
					Graficos.fechar_janela()
				}
				
			}
			senao {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
					lugar_historia++
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q) e lugar_historia != 1) {
					lugar_historia--
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
					Graficos.fechar_janela()
				}
			}
			
 		}

 		para (i = 0; i < Util.numero_elementos(historia_partes); i++) {
 			Graficos.liberar_imagem(historia_partes[i])
 		}
	}

	funcao logico pular_acao(inteiro TEMPO) {
		inteiro tempo_inicial
		logico pulou_acao = falso
		
		tempo_inicial = Util.tempo_decorrido()
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pulou_acao = verdadeiro
				pare
			}
		} enquanto (Util.tempo_decorrido() < tempo_inicial + TEMPO)
		retorne pulou_acao
	}

	// faz a cidade aparecer gradualmente
	funcao vazio aparecer_cidade() {
		inteiro i

		para (i = 5; i <= 255; i+= 10) {
			Graficos.definir_cor(COR_CINZA)
			Graficos.definir_opacidade(i)
			Graficos.desenhar_imagem(0, 0, reverter_imagem("cidade"))
			Graficos.renderizar()
			se (pular_acao(100)) {
				pare
			}
		}
	}

	funcao vazio escolha_tipo_investigacao(cadeia &tipo_investigacao) {
		inteiro tela_escolha_investigacao
		
		tela_escolha_investigacao = Graficos.carregar_imagem("Find_IT/historia/oq_eu_faco.png")
		
		enquanto (verdadeiro) {
			Graficos.desenhar_imagem(0, 0, tela_escolha_investigacao)
			Graficos.renderizar()

			se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
				tipo_investigacao = "ajuda_moradores"
				pare
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
				tipo_investigacao = "si_mesmo"
				pare
			}
		}
	}
	
	// mostra a primeira missão na tela
	funcao vazio mostrar_primeira_missao() {

		// interface de missão
		Graficos.definir_cor(Graficos.COR_AZUL)
		Graficos.desenhar_retangulo(1800, 20, 100, 50, verdadeiro, verdadeiro)

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(30, 1810, "Aqui missão")
	}

	// mostra a segunda missão na tela
	funcao vazio mostrar_segunda_missao() {
		
		// interface de missão
		Graficos.definir_cor(Graficos.COR_AZUL)
		Graficos.desenhar_retangulo(1700, 20, 200, 50, verdadeiro, verdadeiro)

		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(30, 1810, "Aqui missão")
	}

	// permite que o usuário mova pela cidade
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
		
		Graficos.desenhar_imagem(0, 0, reverter_imagem("cidade"))

		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, reverter_imagem("usuario"))
		Graficos.definir_rotacao(0)

		// não foi colocado Graficos.renderizar(), então tem que colocar fora da função, para conseguir aparecer
	}

	// escolhe quais moradores darão certo, em relação à classe
	funcao vazio escolher_moradores_certos(inteiro &moradores_certos[]) {
		inteiro infringir_morador_certo
		inteiro morador_ja_certo
		
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

	// o usuário precisa escolher entre os três moradores
	funcao logico falar_moradores() {
		inteiro moradores_certos[] = {0, 0, 0}
		caracter caracter_numero_morador
		inteiro inteiro_numero_morador
		logico conseguiu_informacao = falso
		inteiro numero_sorteado

		inteiro moradores_partes[5]

		moradores_partes[0] = Graficos.carregar_imagem("Find_IT/historia/moca.png")
		moradores_partes[1] = Graficos.carregar_imagem("Find_IT/historia/ngm.png")
		moradores_partes[2] = Graficos.carregar_imagem("Find_IT/historia/velho.png")
		moradores_partes[3] = Graficos.carregar_imagem("Find_IT/historia/tds_infarto.png")
		moradores_partes[4] = Graficos.carregar_imagem("Find_IT/historia/tds_infarto_final.png")

		
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
						Graficos.desenhar_imagem(0, 0, moradores_partes[0])
						Graficos.renderizar()
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
								pare
							}
						}
						conseguiu_informacao = verdadeiro
					}
					senao se (moradores_certos[inteiro_numero_morador] == 0) {
						Graficos.desenhar_imagem(0, 0, moradores_partes[Util.sorteia(1, 2)])
						Graficos.renderizar()
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
								pare
							}
						}
						conseguiu_informacao = falso
					}
					pare
				}
				senao se (curso == "tecnico_desenvolvimento_sistemas") {
					moradores_partes[5] = Graficos.carregar_imagem("Find_IT/historia/sim_ou_sim.png")
					
					enquanto (verdadeiro) {
						Graficos.desenhar_imagem(0, 0, moradores_partes[5])
						Graficos.renderizar()
						se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
							numero_sorteado = Util.sorteia(1, 6)
							se (numero_sorteado == 6) {
						Graficos.desenhar_imagem(0, 0, moradores_partes[5])
						Graficos.renderizar()
								conseguiu_informacao = verdadeiro
							}
							senao {
						Graficos.desenhar_imagem(0, 0, moradores_partes[5])
						Graficos.renderizar()
								conseguiu_informacao = falso
							}
							pare
						}
					}
					pare
				}
			}
		}
		retorne conseguiu_informacao
	}

	funcao vazio jogo_multiplicacao() {
		inteiro numero
		inteiro pontos = 0
		inteiro quantidade_vezes = 3
		inteiro multiplicador
		inteiro multiplicando
		inteiro i
		cadeia numero_entrado = ""
		cadeia enunciado
		inteiro resultado
		
		para (i = 1; i <= quantidade_vezes; i++) {
			multiplicador = Util.sorteia(1, 99)
			multiplicando = Util.sorteia(1, 99)
			resultado = multiplicador * multiplicando
			
			enunciado = multiplicando + " x " + multiplicador + " = "
			enquanto (verdadeiro) {
				Graficos.desenhar_texto(0, 0, enunciado)
				Graficos.desenhar_texto(300, 0, numero_entrado)
				Graficos.renderizar()
				numero_entrado += Teclado.caracter_tecla(Teclado.ler_tecla())
				se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
					pare
				}
			}
			
			se (numero_entrado == Tipos.inteiro_para_cadeia(resultado, 10)) {
				escreva("Ganhaste um ponto\n")
				pontos++
			}
			senao {
				escreva("Erraste, perdeste um ponto\n")
				pontos--
			}
		}
	}

	// permitirá que o usuário movimente e escolha entre os três edifícios, além disso, isso mostrará a missão no canto da tela
	funcao vazio escolher_edificio() {
		faca {
			movimentacao_cidade()
			mostrar_segunda_missao()
			Graficos.renderizar()
			consequencia_edificios(2.1)
		} enquanto (nao (lugar == "dentro_esgoto" ou lugar == "dentro_predio" ou lugar == "festa"))
	}

	// É usado para fazer uma ação, que dependerá do número da missão, caso o usuário escolha um dos edifícios
	funcao vazio consequencia_edificios(real missao) {
		
		se (lugar == "esgoto" e Teclado.tecla_pressionada(Teclado.TECLA_E) e (missao == 2.1 ou missao == 3.1)) {
			lugar = "dentro_esgoto"
		}
		senao se (lugar == "predio" e Teclado.tecla_pressionada(Teclado.TECLA_E) e missao == 2.1) {
			lugar = "dentro_predio"
		}
		senao se (lugar == "casa_abandonada" e Teclado.tecla_pressionada(Teclado.TECLA_E) e missao == 2.1) {
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
		senao se (lugar == "hospital" e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
			
		}
	}

	// Permite a movimentação no esgoto
	funcao vazio movimentacao_esgoto(inteiro &ponto, inteiro rotacao) {
		
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
		Graficos.desenhar_imagem(0, 0, reverter_imagem("esgoto"))
				
		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, reverter_imagem("usuario"))
		Graficos.definir_rotacao(0)
				
		Graficos.renderizar()
	}	

	// Dá a consequência da sala em que o usuário entre
	funcao vazio consequencia_salas(inteiro ponto, inteiro tipos_sala[][]) {
		mostre_sala_esgoto(ponto, tipos_sala)
		
		se (tipos_sala[ponto - 1][1] == 2) {
			se (tipos_sala[ponto - 1][2] == 0) {
				Graficos.desenhar_imagem(960, 0, reverter_imagem("aviso_agente"))

				mostre_bandido()
			}
			
			Graficos.renderizar()
			
			Util.aguarde(300)
			
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E) e tipos_sala[ponto - 1][2] == 0) {
					batalhar()
					
					se (vida_bandido <= 0) {
						vida_bandido = 200
						tipos_sala[ponto - 1][2] = 1
					}
					senao {
						
					}
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					pare
				}
			}
		}
		senao se (tipos_sala[ponto - 1][1] == 1) {
			se (tipos_sala[ponto - 1][2] == 0) {
				Graficos.desenhar_imagem(960, 0, reverter_imagem("aviso_agente"))

				mostre_bandido()
			}
			
			Graficos.renderizar()
			
			Util.aguarde(300)
			
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E) e tipos_sala[ponto - 1][2] == 0) {
					batalhar()
					
					se (vida_bandido <= 0) {
						vida_bandido = 200
						tipos_sala[ponto - 1][2] = 1
					}
					senao {
						
					}
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					pare
				}
			}
		}
		senao {
			Graficos.renderizar()
		
			Util.aguarde(300)
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					pare
				}
			}
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
		inteiro i
		inteiro tempo_desvio
		inteiro tempo_inicial
		inteiro tempo_final
		inteiro teclas[]
		
		inteiro ataque_infringido
		inteiro poder_ataque
		real dano
		logico usuario_desviou
		inteiro tecla
		
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

		// capacidade do usuário de desviar
		usuario_desviou = falso
		tempo_desvio = Util.sorteia(1000, 1500)

		tecla = Util.sorteia(65, 90)

		tempo_inicial = Util.tempo_decorrido()
		tempo_final = tempo_desvio + tempo_inicial
		
		cenario_batalha()
		// definir personagens
		Graficos.definir_cor(COR_CINZA)
		Graficos.desenhar_retangulo(adequar_largura(594 - 50 / 2), adequar_altura(1079 - 350 - 190 - 30 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		Graficos.desenhar_retangulo(adequar_largura(730 + (594 - 50 / 2)), adequar_altura(250 - 40 - 80), adequar_largura(50), adequar_altura(190), falso, verdadeiro)
		Graficos.definir_opacidade(230)
		Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
		Graficos.definir_opacidade(255)
		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(100.0)
		Graficos.desenhar_texto(0, 0, "Clique na tecla:")
		Graficos.desenhar_texto(0, 99, Tipos.caracter_para_cadeia(Teclado.caracter_tecla(tecla)))
		Graficos.renderizar()
		
		faca {
			se (Teclado.tecla_pressionada(tecla)) {
				usuario_desviou = verdadeiro
			}
		} enquanto (Util.tempo_decorrido() < tempo_final)

		se (nao usuario_desviou) {
			vida_usuario -= dano
			usuario_tomou_dano()
		}
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

	// mostra a sala da escada
	funcao vazio mostre_sala_escada() {
		Graficos.desenhar_imagem(0, 0, reverter_imagem("sala_esgoto_escada"))
		Graficos.renderizar()
	}

	// mostra a sala do esgoto, que há três designs
	funcao vazio mostre_sala_esgoto(inteiro ponto, inteiro tipos_sala[][]) {

		escolha (tipos_sala[ponto - 1][0]) {
			caso 1:
				Graficos.desenhar_imagem(0, 0, reverter_imagem("sala_esgoto_teia"))
				pare
			caso 2:
				Graficos.desenhar_imagem(0, 0, reverter_imagem("sala_esgoto_caixas"))
				pare
			caso 3:
				Graficos.desenhar_imagem(0, 0, reverter_imagem("sala_esgoto_lixo"))
				pare
		}
	}

	funcao vazio mostre_bandido() {
		Graficos.desenhar_retangulo(1700, 539, 100, 100, falso, verdadeiro)
	}

	// Escolhe um dos três tipos para as 12 salas
	funcao vazio escolha_sala_tipo(inteiro &tipos_sala[][]) {
		inteiro i

		para (i = 0; i < Util.numero_linhas(tipos_sala); i++) {
			tipos_sala[i][0] = Util.sorteia(1, 3)
		}
	}

	// Escolhe quais salas tem o bandido
	funcao vazio escolha_salas_bandido(inteiro &tipos_sala[][]) {
		inteiro sala_bandido
		inteiro i

		para (i = 1; i <= 5; i++) {
			enquanto (verdadeiro) {
				sala_bandido = Util.sorteia(0, 12)
	
				se (tipos_sala[sala_bandido][1] == 0) {
					tipos_sala[sala_bandido][1] = 1
					pare
				}
			}
		}

	}

	// Escolhe qual sala será a da escada
	funcao vazio escolha_sala_escada(inteiro &tipos_sala[][]) {
		inteiro sala_escada
		inteiro i

		enquanto (verdadeiro) {
			sala_escada = Util.sorteia(0, 12)
			se (tipos_sala[sala_escada][1] == 0) {
				tipos_sala[sala_escada][1] = 3
				pare
			}
		}


	}
	
	funcao vazio labirinto() {	
		// Declaração de variáveis
			// Interface bonita
		inteiro rotacao = 0
		
			// Usar para saber em que lugar está
		inteiro ponto = 0

			// As salas que tem bandido e escada, e seus tipos
		inteiro tipos_sala[13][3] // tipos[n][0] = qual a aparência da sala | tipos[n][1] = tem bandido (1), chave (2), nada (0) ou escada (3)? | tipos[n][2] = ele já batalhou?

			// Chave
		inteiro sala_bandido_chave
		logico tem_chave = falso

		// Muda lugar do usuário para ele ficar na entrada de dentro do esgoto
		posicao_x_usuario = adequar_largura(750)
		posicao_y_usuario = adequar_altura(860)
		
		escolha_salas_bandido(tipos_sala)

		// Arrumar
		enquanto (verdadeiro) { 
			sala_bandido_chave = Util.sorteia(0, Util.numero_linhas(tipos_sala) - 1)
			
			se (tipos_sala[sala_bandido_chave][1] == 1) {
				tipos_sala[sala_bandido_chave][1] = 2
				pare
			}
		} 

		escolha_sala_escada(tipos_sala)

		escolha_sala_tipo(tipos_sala)
		
		enquanto (verdadeiro) {
			movimentacao_esgoto(ponto, rotacao)
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
				se (ponto  == 0) {
					lugar = "esgoto"
					Util.aguarde(300)
					pare
				}
				senao se (tipos_sala[ponto - 1][1] == 3) {
					se (tem_chave) {
						mostre_sala_escada()
					}
					senao {
						
					}
				}
				senao {
					consequencia_salas(ponto, tipos_sala)
				}
			}

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
