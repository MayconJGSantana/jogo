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

	// Declaração variáveis globais (Não queria ter feito isso mas facilitou minha vida usar elas ao invés de usar referencial
	// de função 30 vezes)
		// Posições para uso diversos
	inteiro posicao_x_usuario = 500
	inteiro posicao_y_usuario = 155
	
	inteiro posicao_x_seta = 40
	inteiro posicao_y_seta = 930
	
		// Curso escolhido e o lugar onde o usuário está
	cadeia lugar = ""
	cadeia curso = ""

		// Uso na batalha
	inteiro vida_bandido = 200
	inteiro vida_usuario = 200

		// Cores
	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	inteiro COR_CINZA_ESCURO = Graficos.criar_cor(128, 128, 128)
	
	funcao inicio()
	{
		cadeia tipo_investigacao = ""
		logico conseguiu_falar
		cadeia investigou = ""
		inteiro tela_escolha_investigacao
		inteiro imagens_esgoto[10]
		logico achou_informacao

		inicia_grafico()

		capa_jogo()
		passa_capa()
		
		historia(investigou)

		se (investigou == "ignorar_noticias") {
			morreu_ignorou()
		}
		senao se (investigou == "investigar") {
			lugar = "casa_usuario"
			guardar_imagem_usuario()
			guardar_imagens_cidade()
			
			aparecer_cidade()

			escolha_tipo_investigacao(tipo_investigacao)
			
			se (tipo_investigacao == "si_mesmo") {
				libera_imagens("imagens")
				Util.aguarde(500)
				achou_informacao = consequencia_investigacao()
				Util.aguarde(500)

				se (achou_informacao) {
					se (curso == "seguranca_publica") {
						inteiro investigar_sozinho_policial_original

						investigar_sozinho_policial_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/investigar_sozinho_policial.png")
						Graficos.desenhar_imagem(0, 0, investigar_sozinho_policial_original)
						Graficos.liberar_imagem(investigar_sozinho_policial_original)
						Graficos.renderizar()
						Util.aguarde(500)

						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
								pare
							}
						}
						
						Util.aguarde(500)
						guardar_imagens_cidade()

						lugar = "departamento_policial"
						posicao_x_usuario = 1370
						posicao_y_usuario = 150
						
						escolher_edificio()
					}
					senao se (curso == "tecnico_desenvolvimento_sistemas") {
						inteiro investigar_sozinho_tds_original

						investigar_sozinho_tds_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/investigar_sozinho_tds.png")
						Graficos.desenhar_imagem(0, 0, investigar_sozinho_tds_original)
						Graficos.liberar_imagem(investigar_sozinho_tds_original)
						Graficos.renderizar()
						Util.aguarde(500)

						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
								pare
							}
						}
					
						Util.aguarde(500)
						guardar_imagens_cidade()
					
						escolher_edificio()
					}
					senao se (curso == "psicologia") {
						inteiro investigar_sozinho_psicologia_original

						investigar_sozinho_psicologia_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/investigar_sozinho_psicologo.png")
						Graficos.desenhar_imagem(0, 0, investigar_sozinho_psicologia_original)
						Graficos.liberar_imagem(investigar_sozinho_psicologia_original)
						Graficos.renderizar()
						Util.aguarde(500)

						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
								pare
							}
						}
					
						Util.aguarde(500)
						guardar_imagens_cidade()
					
						psicologo_escolher_edificio()
					}
				}
				senao {
					se (curso == "psicologia") {
						Util.aguarde(500)
						inteiro tragedia_psicologo_original 

						tragedia_psicologo_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/tragedia_psicologo.png")
						Graficos.desenhar_imagem(0, 0, tragedia_psicologo_original)
						Graficos.liberar_imagem(tragedia_psicologo_original)
						Graficos.renderizar()
						Util.aguarde(500)
						
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
								pare
							}
						}

						morreu_ignorou()
					}
				}
			}
			senao se (tipo_investigacao == "ajuda_moradores") {
				conseguiu_falar = falar_moradores()
				se (conseguiu_falar) {
					Util.aguarde(500)
					
					escolher_edificio()
				}
				senao {
					libera_imagens("imagens")
					se (curso == "psicologia") {
						infarto_psicologia()
					}
					senao se (curso == "seguranca_publica") {
						infarto_seguranca_publica()
					}
					senao se (curso == "tecnico_desenvolvimento_sistemas") {
						infarto_tecnico_desenvolvimento_sistemas()
					}
				}
			}
			
					se (lugar == "dentro_esgoto") {
						// Colocar as imagens futuramente necessárias e guarda em um arquivo, ai depois eu posso usar eles em qualquer lugar do código
						guardar_imagens_esgoto()
						
						// Declaração de variáveis
							// esgoto
								// As salas que tem bandido e escada, e seus tipos
						inteiro tipos_sala[13][3] // tipos[n][0] = qual a aparência da sala | tipos[n][1] = tem bandido (1), chave (2), nada (0) ou escada (3)? | tipos[n][2] = ainda não batalhou (0), já batalhou (1)
								// Base bandidos
						logico voltar_esgoto = falso
							
							// Chave
						inteiro sala_bandido_chave
						logico tem_chave_escada = falso
						logico encontrou_porta_trancada = falso
							// Itens
						logico derrotou_bandido_escada = falso
						logico pegou_pe_de_cabra = falso
						logico pegou_chave_base = falso
							// Apartamento
						inteiro casas_apartamento[15][2] // casas_apartamento[n][0] = verifica se o usuário já olhou a casa | casas_apartamento[n][1] = tem bandido (1), não tem bandido (0)
						inteiro casa_com_chave

						casa_com_chave = Util.sorteia(0, 14)

						casas_apartamento[casa_com_chave][1] = 1
		
						escolha_salas_bandido(tipos_sala)
					
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
							se (lugar == "dentro_esgoto") {
								Util.aguarde(300)
								labirinto(tipos_sala, tem_chave_escada, pegou_pe_de_cabra, encontrou_porta_trancada, pegou_chave_base, voltar_esgoto)
							}
							senao se (lugar == "esgoto") {
								posicao_x_usuario = 530
								posicao_y_usuario = 900
								
								movimentacao_cidade()
								Graficos.renderizar()
								
								enquanto (lugar != "dentro_esgoto") {
									movimentacao_cidade()
									Graficos.renderizar()
									consequencia_edificios(3.1, tem_chave_escada, pegou_pe_de_cabra, casas_apartamento, pegou_chave_base, encontrou_porta_trancada)
								} 
		
							}
							senao se (lugar == "fim_perdeu") {
									inteiro fim
									fim = Graficos.carregar_imagem("Find_IT_2/final_derrotado.png")
									Graficos.desenhar_imagem(0, 0, fim)
									Graficos.renderizar()
									enquanto (verdadeiro) {
										se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
											pare
										}
									}
							}
								
						}
					}
		}
	}
	
	funcao vazio guardar_imagem_usuario() {
		// Declaração de variáveis
		inteiro arquivo = 0
		
			// Principais
		inteiro usuario_original
		inteiro usuario_redimensionada

		// Atribuição das imagens nas variáveis, sua redimensionamento e depois a liberação
		usuario_original = Graficos.carregar_imagem("Find_IT_3/personagens/usuario/usuario.png")
		usuario_redimensionada = Graficos.redimensionar_imagem(usuario_original, Graficos.largura_imagem(usuario_original) / 6, (Graficos.altura_imagem(usuario_original) / 6), verdadeiro)
		Graficos.liberar_imagem(usuario_original)

		// Abre
		arquivo = Arquivos.abrir_arquivo("usuario", Arquivos.MODO_ESCRITA)

		// Adiciona as imagens ao arquivo
				// Principais
		adiciona_imagem_arquivo(arquivo, usuario_redimensionada, "usuario")

		// Fecha
		Arquivos.fechar_arquivo(arquivo)
	}

	funcao vazio guardar_imagens_cidade() {
		// Declaração de variáveis
		inteiro arquivo
		
			// Principais
		inteiro cidade_original

		// Atribuição das imagens nas variáveis, sua redimensionamento e depois a liberação
		cidade_original = Graficos.carregar_imagem("Find_IT_1/cenarios/cidade/cidade.jpg")

		// Abre
		arquivo = Arquivos.abrir_arquivo("imagens", Arquivos.MODO_ESCRITA)

		// Adiciona as imagens ao arquivo
				// Principais
		adiciona_imagem_arquivo(arquivo, cidade_original, "cidade")

		// Fecha
		Arquivos.fechar_arquivo(arquivo)
	}

	funcao vazio guardar_imagens_esgoto() {
		// Declaração de variáveis
		inteiro arquivo
		
			// Esgoto
		inteiro esgoto_original
			// Prédio

		// Atribuição de variáveis, redimensionamento das necessárias e a liberação da original
			// Esgoto
		esgoto_original = Graficos.carregar_imagem("Find_IT_1/esgoto/esgoto.jpg")

		
		// Abre
		arquivo = Arquivos.abrir_arquivo("imagens", Arquivos.MODO_ESCRITA)

		// Adiciona as imagens ao arquivo
				// Principais
		adiciona_imagem_arquivo(arquivo, esgoto_original, "esgoto")

		// Fecha
		Arquivos.fechar_arquivo(arquivo)
	}

	funcao vazio libera_imagens(cadeia arquivo) {
		inteiro linha = -1
		inteiro abertura_arquivo
		cadeia texto_linha
		inteiro endereco_imagem
		
		abertura_arquivo = Arquivos.abrir_arquivo(arquivo, Arquivos.MODO_LEITURA)


		faca {
			linha++
			texto_linha = Arquivos.ler_linha(abertura_arquivo)
			se (linha % 2 == 1) {
				endereco_imagem = Tipos.cadeia_para_inteiro(texto_linha, 10)
				Graficos.liberar_imagem(endereco_imagem)
			}
		} enquanto (nao Arquivos.fim_arquivo(abertura_arquivo))

		Arquivos.fechar_arquivo(abertura_arquivo)
	}

	funcao vazio adiciona_imagem_arquivo(inteiro arquivo, inteiro imagem, cadeia imagem_nome) {
		Arquivos.escrever_linha(imagem_nome, arquivo)
		Arquivos.escrever_linha(Tipos.inteiro_para_cadeia(imagem, 10), arquivo)
	}

	funcao inteiro reverter_imagem(cadeia nome_imagem, cadeia nome_arquivo) {
		inteiro arquivo
		inteiro numero_arquivo = 0
		
		arquivo = Arquivos.abrir_arquivo(nome_arquivo, Arquivos.MODO_LEITURA)
		enquanto (verdadeiro) {
			se (Arquivos.fim_arquivo(arquivo)) {
				pare
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

	funcao vazio capa_jogo() {
		inteiro capa = Graficos.carregar_imagem("Find_IT_3/capa.png")

		Graficos.desenhar_imagem(0, 0, capa)
		Graficos.renderizar()

		Graficos.liberar_imagem(capa)
		
		Util.aguarde(1000)
	}

	funcao vazio passa_capa() {
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		} enquanto (verdadeiro)

		Graficos.renderizar()
	}
	
	funcao vazio historia(cadeia &investigou) {
		inteiro lugar_historia = 1
		inteiro i
		inteiro historia_partes[11]
		
		historia_partes[0] = Graficos.carregar_imagem("Find_IT_2/historia/historia_1.png")
		historia_partes[1] = Graficos.carregar_imagem("Find_IT_2/historia/historia_2.png")
		historia_partes[2] = Graficos.carregar_imagem("Find_IT_2/historia/escolha_curso.png")
		historia_partes[3] = Graficos.carregar_imagem("Find_IT_2/historia/historia_4.png")
		historia_partes[4] = Graficos.carregar_imagem("Find_IT_2/historia/historia_5.png")
		historia_partes[5] = Graficos.carregar_imagem("Find_IT_2/historia/historia_6.png")
		
		enquanto (verdadeiro) {

			Graficos.desenhar_imagem(0, 0, historia_partes[lugar_historia - 1])
			Graficos.renderizar()

			se (lugar_historia == 3) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
					curso = "psicologia"
					lugar_historia++
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
					curso = "seguranca_publica"
					lugar_historia++
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_3)) {
					curso = "tecnico_desenvolvimento_sistemas"
					lugar_historia++
					Util.aguarde(300)
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
					se (lugar_historia == 6) {
				 		para (i = 0; i < Util.numero_elementos(historia_partes); i++) {
				 			Graficos.liberar_imagem(historia_partes[i])
				 		}
						historia_partes[6] = Graficos.carregar_imagem("Find_IT_2/historia/historia_7.png")
						historia_partes[7] = Graficos.carregar_imagem("Find_IT_2/historia/historia_8.png")
						historia_partes[8] = Graficos.carregar_imagem("Find_IT_2/historia/historia_9.png")
						historia_partes[9] = Graficos.carregar_imagem("Find_IT_2/historia/historia_10.png")
						historia_partes[10] = Graficos.carregar_imagem("Find_IT_2/historia/escolha_noticia.png")
					}
					lugar_historia++
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q) e lugar_historia != 1 e lugar_historia != 7) {
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

	funcao vazio morreu_ignorou() {
		inteiro lugar_fim = 1
		inteiro fim_partes[11]
		
		fim_partes[0] = Graficos.carregar_imagem("Find_IT_3/e_fake_news/historia_12.png")
		fim_partes[1] = Graficos.carregar_imagem("Find_IT_3/e_fake_news/historia_13.png")
		fim_partes[2] = Graficos.carregar_imagem("Find_IT_3/e_fake_news/historia_14.png")
		fim_partes[3] = Graficos.carregar_imagem("Find_IT_3/e_fake_news/historia_15.png")
		
		enquanto (verdadeiro) {

			Graficos.desenhar_imagem(0, 0, fim_partes[lugar_fim - 1])
			Graficos.renderizar()
			se (Teclado.tecla_pressionada(Teclado.TECLA_E) e lugar_fim != 4) {
				lugar_fim++
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q) e lugar_fim != 1 e lugar_fim != 4) {
				lugar_fim--
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
				Graficos.fechar_janela()
			}
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
			Graficos.desenhar_imagem(0, 0, reverter_imagem("cidade", "imagens"))
			Graficos.renderizar()
			se (pular_acao(100)) {
				pare
			}
		}
		Graficos.definir_opacidade(255)
	}

	funcao vazio escolha_tipo_investigacao(cadeia &tipo_investigacao) {
		inteiro tela_escolha_investigacao
		
		tela_escolha_investigacao = Graficos.carregar_imagem("Find_IT_2/historia/oq_eu_faco.png")
		
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
	funcao vazio mostrar_primeira_missao(inteiro missao) {

		// interface de missão
		Graficos.desenhar_imagem(0, 0, missao)
	}

	// mostra a segunda missão na tela
	funcao vazio mostrar_segunda_missao(inteiro missao) {
		
		// interface de missão
		Graficos.desenhar_imagem(0, 0, missao)
	}

	funcao vazio mostrar_segunda_especial_missao(inteiro missao) {
		// interface de missão
		Graficos.desenhar_imagem(0, 0, missao)
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
				posicao_y_usuario = 455
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "casa_morador_1"
				posicao_x_usuario = 667
				posicao_y_usuario = 210
			}
		}
		senao se (lugar == "casa_morador_1") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "casa_morador_2"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 400
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_usuario"
				posicao_x_usuario = 500
				posicao_y_usuario = 155
			}
		}
		senao se (lugar == "casa_morador_2") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_morador_1"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 210
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_morador_3"
				posicao_x_usuario = 500
				posicao_y_usuario = 455
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = 530
				posicao_y_usuario = 900
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = 900
				posicao_y_usuario = 775
			}
		}
		senao se (lugar == "casa_morador_3") {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_usuario"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 155
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "casa_morador_2"
				posicao_x_usuario = 667
				posicao_y_usuario = 425
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = 530
				posicao_y_usuario = 900
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_abandonada"
				posicao_x_usuario = 130
				posicao_y_usuario = 775
			}
		}
		senao se (lugar == "esgoto") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "casa_morador_3"
				posicao_x_usuario = 500
				posicao_y_usuario = 455
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = 900
				posicao_y_usuario = 775
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "casa_abandonada"
				posicao_x_usuario = 130
				posicao_y_usuario = 775
			}
		}
		senao se (lugar == "casa_abandonada") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = 530
				posicao_y_usuario = 900
			}
		}
		senao se (lugar == "predio") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "esgoto"
				posicao_x_usuario = 530
				posicao_y_usuario = 900
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				lugar = "hospital"
				posicao_x_usuario = 1370
				posicao_y_usuario = 800
			}
		}
		senao se (lugar == "hospital") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				lugar = "departamento_policial"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 150
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				lugar = "predio"
				posicao_x_usuario = 900
				posicao_y_usuario = 775
			}
		}
		senao se (lugar == "departamento_policial") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				lugar = "hospital"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 800
			}
		}
		
		Graficos.desenhar_imagem(0, 0, reverter_imagem("cidade", "imagens"))

		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, reverter_imagem("usuario", "usuario"))
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
		inteiro i
		inteiro moradores_certos[] = {0, 0, 0}
		logico conseguiu_informacao = falso
		inteiro numero_sorteado
		logico parar = falso

		inteiro moradores_partes[7]

		moradores_partes[0] = Graficos.carregar_imagem("Find_IT_3/moradores/moca.png")
		moradores_partes[1] = Graficos.carregar_imagem("Find_IT_3/moradores/ngm.png")
		moradores_partes[2] = Graficos.carregar_imagem("Find_IT_3/moradores/velho.png")
		moradores_partes[6] = Graficos.carregar_imagem("Find_IT_3/missoes/falar_com_vizinho.png")
		
		escolher_moradores_certos(moradores_certos)
		
		enquanto (nao parar) {
			movimentacao_cidade()
			mostrar_primeira_missao(moradores_partes[6])
			Graficos.renderizar()

			conseguiu_informacao = consequencia_moradores(moradores_certos, parar, moradores_partes)
		}

		para (i = 0; i < Util.numero_elementos(moradores_partes); i++) {
			Graficos.liberar_imagem(moradores_partes[i])
		}
		
		retorne conseguiu_informacao
	}

	// Gera uma consequência em função do morador escolhido pelo usuário
	funcao logico consequencia_moradores(inteiro moradores_certo[], logico &parar, inteiro moradores_partes[]) {
		logico pegou_informacao = falso
		caracter caracter_numero_morador
		inteiro inteiro_numero_morador
		
		se ((lugar == "casa_morador_1" ou lugar == "casa_morador_2" ou lugar == "casa_morador_3") e Teclado.tecla_pressionada(Teclado.TECLA_E)) {
			se (curso == "seguranca_publica" ou curso == "psicologia") {
				caracter_numero_morador = Texto.obter_caracter(lugar, 13)
				inteiro_numero_morador = Tipos.caracter_para_inteiro(caracter_numero_morador) - 1
				se (moradores_certo[inteiro_numero_morador] == 1) {
					Graficos.desenhar_imagem(0, 0, moradores_partes[0])
					Graficos.renderizar()
					enquanto (verdadeiro) {
						se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
							pare
						}
					}
					pegou_informacao = verdadeiro
				}
				senao se (moradores_certo[inteiro_numero_morador] == 0) {
					se (curso == "psicologia") {
						pegou_informacao = falso
					}
					senao se (curso == "seguranca_publica") {
						Graficos.desenhar_imagem(0, 0, moradores_partes[Util.sorteia(1, 2)])
						Graficos.renderizar()
						Util.aguarde(500)
						
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
								pare
							}
						}
						moradores_partes[5] = Graficos.carregar_imagem("Find_IT_2/historia/sim_ou_sim.png")
		
						Graficos.desenhar_imagem(0, 0, moradores_partes[5])
						Graficos.renderizar()
						Graficos.liberar_imagem(moradores_partes[5])
						Util.aguarde(500)
						
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
								pare
							}
						}
						Util.aguarde(300)
						
						pegou_informacao = jogo_adivinha_numero()
						Util.aguarde(500)
						
						se (pegou_informacao) {
							Graficos.desenhar_imagem(0, 0, moradores_partes[0])
							Graficos.renderizar()
							Util.aguarde(500)
							
							enquanto (verdadeiro) {
								se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
									pare
								}
							}
						}
					}
					
				}
				parar = verdadeiro
			}
			senao se (curso == "tecnico_desenvolvimento_sistemas") {
				inteiro acertos
			
				Graficos.desenhar_imagem(0, 0, moradores_partes[Util.sorteia(1, 2)])
				Graficos.renderizar()
				Util.aguarde(300)
				
				enquanto (verdadeiro) {
					se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
						pare
					}
				}

				
				moradores_partes[5] = Graficos.carregar_imagem("Find_IT_2/historia/sim_ou_sim.png")

				Graficos.desenhar_imagem(0, 0, moradores_partes[5])
				Graficos.renderizar()
				Graficos.liberar_imagem(moradores_partes[5])
				Util.aguarde(300)
				
				enquanto (verdadeiro) {
					se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
						acertos = jogo_multiplicacao()

						se (acertos > 1) {
							pegou_informacao = verdadeiro
						}
						senao {
							pegou_informacao = falso
						}
						pare
					}
				}
				parar = verdadeiro
			}
		}
		retorne pegou_informacao
	}

	// Jogo de adivinhar qual o número sorteado
	funcao logico jogo_adivinha_numero() {
		inteiro numero_tentativas = 7
		inteiro valor_adivinha
		cadeia numero_entrado = ""
		logico adivinhou = falso
		inteiro plano_fundo_original

		plano_fundo_original = Graficos.carregar_imagem("Find_IT_4/minigame_fundo.png")
		
		valor_adivinha = Util.sorteia(1, 100)
		faca {
			Graficos.desenhar_imagem(0, 0, plano_fundo_original)
			Graficos.definir_tamanho_texto(60.0)
			Graficos.desenhar_texto(115, 350, "Escolha um número entre 1 e 100")
			Graficos.desenhar_texto(340, 700, "Número de tentativas : " + numero_tentativas)
			Graficos.desenhar_texto(170, 520, "Escolha um número: " + numero_entrado)
			Graficos.renderizar()
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER) e Texto.numero_caracteres(numero_entrado) > 0 e Texto.numero_caracteres(numero_entrado) < 4) {
				Util.aguarde(300)
				numero_tentativas -= 1

				se (numero_tentativas == 0) {
					pare
				}
				senao se (Tipos.cadeia_para_inteiro(numero_entrado, 10) == valor_adivinha) {
					pare
				}
				senao {
					Graficos.desenhar_imagem(0, 0, plano_fundo_original)
					Graficos.definir_cor(Graficos.COR_PRETO)
					Graficos.definir_tamanho_texto(60.0)
					se (Tipos.cadeia_para_inteiro(numero_entrado, 10) < valor_adivinha) {
						Graficos.desenhar_texto(200, 350, "O número secreto é maior")
						Graficos.desenhar_texto(200, 450, "do que o número sugerido!") 
					}
					senao se (Tipos.cadeia_para_inteiro(numero_entrado, 10) > valor_adivinha) {
						Graficos.desenhar_texto(200, 350, "O número secreto é menor")
						Graficos.desenhar_texto(200, 450, "do que o número sugerido!")
					}
					Graficos.renderizar()
					Util.aguarde(2000)
				}
				numero_entrado = ""
			}
			// eu sei que dava para usar o ler.tecla, para não precisar verificar cada uma,
			// mas dai eu não poderia colocar tempo para o usuário, na verdade, eu até poderia, mas ia ficar
			// pouco familiar a interface que ia ficar para o usuário, porque só depois que ele clicasse alguma tecla
			// que ia aparecer se ele ficou sem tempo
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_0) ou Teclado.tecla_pressionada(Teclado.TECLA_0_NUM)) {
				numero_entrado += 0
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_1) ou Teclado.tecla_pressionada(Teclado.TECLA_1_NUM)) {
				numero_entrado += 1
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_2) ou Teclado.tecla_pressionada(Teclado.TECLA_2_NUM)) {
				numero_entrado += 2
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_3) ou Teclado.tecla_pressionada(Teclado.TECLA_3_NUM)) {
				numero_entrado += 3
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_4) ou Teclado.tecla_pressionada(Teclado.TECLA_4_NUM)) {
				numero_entrado += 4
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_5) ou Teclado.tecla_pressionada(Teclado.TECLA_5_NUM)) {
				numero_entrado += 5
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_6) ou Teclado.tecla_pressionada(Teclado.TECLA_6_NUM)) {
				numero_entrado += 6
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_7) ou Teclado.tecla_pressionada(Teclado.TECLA_7_NUM)) {
				numero_entrado += 7
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_8) ou Teclado.tecla_pressionada(Teclado.TECLA_8_NUM)) {
				numero_entrado += 8
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_9) ou Teclado.tecla_pressionada(Teclado.TECLA_9_NUM)) {
				numero_entrado += 9
				Util.aguarde(300)
			}
			senao se (Teclado.tecla_pressionada(Teclado.TECLA_BACKSPACE) e Texto.numero_caracteres(numero_entrado) > 0) {
				numero_entrado = Texto.extrair_subtexto(numero_entrado, 0, Texto.numero_caracteres(numero_entrado) - 1)
				Util.aguarde(300)
			}
		} enquanto (verdadeiro)
		
		se (Tipos.cadeia_para_inteiro(numero_entrado, 10) == valor_adivinha) {
			adivinhou = verdadeiro
		}
		senao {
			adivinhou = falso
		}
		
		Graficos.liberar_imagem(plano_fundo_original)
		
		retorne adivinhou
	}

	// Jogo para acertar a conta matemática
	funcao inteiro jogo_multiplicacao() {
		inteiro acertos = 0
		inteiro quantidade_vezes = 3
		inteiro multiplicador
		inteiro multiplicando
		inteiro i
		cadeia numero_entrado = ""
		cadeia enunciado
		inteiro resultado
		cadeia tabela_pontos
		inteiro tempo_inicial
		inteiro intervalo
		inteiro tempo_final
		inteiro plano_fundo_original

		plano_fundo_original = Graficos.carregar_imagem("Find_IT_4/minigame_fundo.png")
		
		para (i = 1; i <= quantidade_vezes; i++) {
			multiplicador = Util.sorteia(1, 99)
			multiplicando = Util.sorteia(1, 99)
			tabela_pontos = acertos + "/3"
			resultado = multiplicador * multiplicando
			
			enunciado = multiplicando + " x " + multiplicador + " = "

			tempo_inicial = Util.tempo_decorrido()
			intervalo = Util.sorteia(33000, 36000)
			tempo_final = tempo_inicial + intervalo
			
			faca {
				Graficos.desenhar_imagem(0, 0, plano_fundo_original)
				Graficos.definir_tamanho_texto(70.0)
				Graficos.definir_cor(Graficos.COR_PRETO)
				Graficos.desenhar_texto(300, 350, enunciado)
				Graficos.desenhar_texto(620, 350, numero_entrado)
				Graficos.desenhar_texto(200, 520, "Pontuação: ")
				Graficos.desenhar_texto(570, 520, tabela_pontos)
				Graficos.desenhar_texto(370, 700, "Tempo restante:")
				Graficos.desenhar_texto(900, 700, Tipos.inteiro_para_cadeia((Util.tempo_decorrido() - tempo_final) * -1 / 1000, 10))
				Graficos.renderizar()
				
				se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER) e Texto.numero_caracteres(numero_entrado) > 0 e Texto.numero_caracteres(numero_entrado) < 5) {
					Util.aguarde(300)
					pare
				}
				// eu sei que dava para usar o ler.tecla, para não precisar verificar cada uma,
				// mas dai eu não poderia colocar tempo para o usuário, na verdade, eu até poderia, mas ia ficar
				// pouco familiar a interface que ia ficar para o usuário, porque só depois que ele clicasse alguma tecla
				// que ia aparecer se ele ficou sem tempo
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_0) ou Teclado.tecla_pressionada(Teclado.TECLA_0_NUM)) {
					numero_entrado += 0
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_1) ou Teclado.tecla_pressionada(Teclado.TECLA_1_NUM)) {
					numero_entrado += 1
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_2) ou Teclado.tecla_pressionada(Teclado.TECLA_2_NUM)) {
					numero_entrado += 2
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_3) ou Teclado.tecla_pressionada(Teclado.TECLA_3_NUM)) {
					numero_entrado += 3
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_4) ou Teclado.tecla_pressionada(Teclado.TECLA_4_NUM)) {
					numero_entrado += 4
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_5) ou Teclado.tecla_pressionada(Teclado.TECLA_5_NUM)) {
					numero_entrado += 5
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_6) ou Teclado.tecla_pressionada(Teclado.TECLA_6_NUM)) {
					numero_entrado += 6
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_7) ou Teclado.tecla_pressionada(Teclado.TECLA_7_NUM)) {
					numero_entrado += 7
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_8) ou Teclado.tecla_pressionada(Teclado.TECLA_8_NUM)) {
					numero_entrado += 8
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_9) ou Teclado.tecla_pressionada(Teclado.TECLA_9_NUM)) {
					numero_entrado += 9
					Util.aguarde(300)
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_BACKSPACE) e Texto.numero_caracteres(numero_entrado) > 0) {
					numero_entrado = Texto.extrair_subtexto(numero_entrado, 0, Texto.numero_caracteres(numero_entrado) - 1)
					Util.aguarde(300)
				}
			} enquanto (Util.tempo_decorrido() < tempo_final)
			
			se (numero_entrado == Tipos.inteiro_para_cadeia(resultado, 10)) {
				acertos++
			}
			numero_entrado = ""
			Util.aguarde(500)
		}
		
		Graficos.liberar_imagem(plano_fundo_original)
		
		retorne acertos
	}

	funcao logico jogo_forca() {
		cadeia palavras[] = {"cachorro","gato","avião","carro","computador","livro","escola","floresta","amigo","telefone","bola","música","praia","chave","janela","cidade","hospital","bicicleta","pizza","desenho","mesa","porta","jogo","rato","cabelo","camisa","estrela","caderno","filme"}
		caracter alfabeto[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'}
		caracter letras_tentadas[26]
		caracter tentativa
		inteiro quantidade_de_tentativas = 7
		inteiro vezes_tentadas = 0
		inteiro i
		inteiro j
		inteiro k
		logico palavra_completa = verdadeiro
		logico letra_escrita = falso
		logico tentativa_valida = falso
		logico tentativa_correta = falso
		cadeia palavra_sorteada = palavras[Util.sorteia(0, (Util.numero_elementos(palavras) - 1))]
		cadeia palavra_escondida = ""

		cadeia palavra_entrada = ""
		cadeia enunciado = ""
		inteiro tecla_tentada
		logico pegou_informacao = falso
		inteiro plano_fundo_original

		plano_fundo_original = Graficos.carregar_imagem("Find_IT_4/minigame_fundo.png")
		Graficos.definir_cor(Graficos.COR_PRETO)
		
		enquanto (verdadeiro) {
			// escreva a palavra sorteada, o usuário tiver tentado uma letra que está na palavra, ela troca "_ " pela letra
			para (i = 0; i < Texto.numero_caracteres(palavra_sorteada); i++) {
				se (vezes_tentadas !=  0) {
					para (j = 0; j < Util.numero_elementos(letras_tentadas); j++) {
						se (Texto.obter_caracter(palavra_sorteada, i) == letras_tentadas[j]) {
							palavra_escondida += Tipos.caracter_para_cadeia(Texto.obter_caracter(palavra_sorteada, i))
							letra_escrita = verdadeiro
							pare
						}
					}
				}
				se (nao letra_escrita) {
					se (Texto.obter_caracter(palavra_sorteada, i) == ' ') {
						palavra_escondida += "  "
					}
					senao {
						palavra_escondida += "_ "
						palavra_completa = falso
					}
				}
				letra_escrita = falso
			}
			
			// verifica se a palavra está completa
			se (palavra_completa) {
				pegou_informacao = verdadeiro
				pare
			}
			senao se (quantidade_de_tentativas == 0) {
				pegou_informacao = falso
				pare
			}
			palavra_completa = verdadeiro
			enquanto (verdadeiro) {
				enquanto (verdadeiro) {
					Graficos.desenhar_imagem(0, 0, plano_fundo_original)
					Graficos.definir_tamanho_texto(70.0)
					Graficos.desenhar_texto(200, 300, palavra_escondida)
					Graficos.definir_tamanho_texto(40.0)
					Graficos.desenhar_texto(200, 500, enunciado)
					Graficos.definir_tamanho_texto(70.0)
					Graficos.desenhar_texto(290, 700, "Tentativas restantes: " + quantidade_de_tentativas)
					Graficos.desenhar_texto(200, 400, "-> Digite uma letra: ")
					Graficos.desenhar_texto(820, 400, palavra_entrada)
					Graficos.renderizar()
					tecla_tentada = Teclado.ler_tecla()
					se (tecla_tentada > 64 e tecla_tentada < 91 e Texto.numero_caracteres(palavra_entrada) == 0) {
						palavra_entrada += Tipos.caracter_para_cadeia(Teclado.caracter_tecla(tecla_tentada))
					}
					senao se (tecla_tentada == Teclado.TECLA_BACKSPACE) {
						palavra_entrada = ""
					}
					senao se (tecla_tentada == Teclado.TECLA_ENTER e Texto.numero_caracteres(palavra_entrada) != 0) {
						pare
					}
				}
				para (i = 0; i < Util.numero_elementos(alfabeto); i++) {
					se (Tipos.cadeia_para_caracter(Texto.caixa_baixa(palavra_entrada)) == alfabeto[i]) {
						tentativa_valida = verdadeiro
						pare
					}
				}
				para (i = 0; i < Util.numero_elementos(letras_tentadas); i++) {
					se (Tipos.cadeia_para_caracter(Texto.caixa_baixa(palavra_entrada)) == letras_tentadas[i]) {
						tentativa_valida = falso
						pare
					}
				}
				se (nao tentativa_valida) {
					Graficos.definir_cor(Graficos.COR_BRANCO)
					Graficos.desenhar_texto(0, 200, "Valor inválido, tente novamente! ")
					Graficos.renderizar()
					Util.aguarde(1000)
				}
				senao {
					pare
				}
			}
			tentativa_valida = falso
			para (k = 0; k < Texto.numero_caracteres(palavra_sorteada); k++) {
				se (Texto.obter_caracter(palavra_sorteada, k) == Tipos.cadeia_para_caracter(Texto.caixa_baixa(palavra_entrada))) {
					tentativa_correta = verdadeiro
				}
			}
			se (nao tentativa_correta) {
				quantidade_de_tentativas--
			}
			tentativa_correta = falso
			vezes_tentadas += 1
			letras_tentadas[vezes_tentadas - 1] = Tipos.cadeia_para_caracter(Texto.caixa_baixa(palavra_entrada))
			enunciado = ""
			para (i = 0; i < vezes_tentadas; i ++){
				se (i == vezes_tentadas - 1) {
					enunciado += letras_tentadas[i]
				}
				senao {
					enunciado += letras_tentadas[i] + " - "
				}
			}
			palavra_escondida = ""
			palavra_entrada = ""
		}
		
		Graficos.liberar_imagem(plano_fundo_original)

		retorne pegou_informacao
	}

	funcao vazio infarto_tecnico_desenvolvimento_sistemas() {
		// Declaração de variáveis
			// Variáveis onde serão colocadas as imagens
		inteiro desmaio_original
		inteiro infarto_original

		// Entra com as imagens carregadas, libera se necessário e redimensiona se necessário
		desmaio_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_tds.png")
		infarto_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_tds_final.png")

		Graficos.desenhar_imagem(0, 0, desmaio_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(desmaio_original)
		Util.aguarde(500)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
				pare
			}
		} enquanto (verdadeiro)

		
		Graficos.desenhar_imagem(0, 0, infarto_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(infarto_original)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
				Graficos.fechar_janela()
			}
		} enquanto (verdadeiro)
	}

	funcao vazio infarto_psicologia() {
		// Declaração de variáveis
			// Variáveis onde serão colocadas as imagens
		inteiro desmaio_original
		inteiro infarto_original

		// Entra com as imagens carregadas, libera se necessário e redimensiona se necessário
		desmaio_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_psicologo.png")
		infarto_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_psicologo_final.png")

		Graficos.desenhar_imagem(0, 0, desmaio_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(desmaio_original)
		Util.aguarde(500)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		} enquanto (verdadeiro)

		
		Graficos.desenhar_imagem(0, 0, infarto_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(infarto_original)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
				Graficos.fechar_janela()
			}
		} enquanto (verdadeiro)
	}
	
	funcao vazio infarto_seguranca_publica() {
		// Declaração de variáveis
			// Variáveis onde serão colocadas as imagens
		inteiro desmaio_original
		inteiro infarto_original

		// Entra com as imagens carregadas, libera se necessário e redimensiona se necessário
		desmaio_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_policial.png")
		infarto_original = Graficos.carregar_imagem("Find_IT_4/infartos/infarto_policial_final.png")

		Graficos.desenhar_imagem(0, 0, desmaio_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(desmaio_original)
		Util.aguarde(500)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
				pare
			}
		} enquanto (verdadeiro)

		
		Graficos.desenhar_imagem(0, 0, infarto_original)
		Graficos.renderizar()
		Graficos.liberar_imagem(infarto_original)
		
		faca {
			se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
				Graficos.fechar_janela()
			}
		} enquanto (verdadeiro)
	}



	funcao logico consequencia_investigacao() {
		logico achou_informacao = falso

		se (curso == "tecnico_desenvolvimento_sistemas") {
			inteiro investigar_sozinho_tds_original

			investigar_sozinho_tds_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/investigar_sozinho_tds.png")

			Graficos.desenhar_imagem(0, 0, investigar_sozinho_tds_original)
			Graficos.liberar_imagem(investigar_sozinho_tds_original)
			Graficos.renderizar()
			Util.aguarde(500)

			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
					pare
				}
			}
			Util.aguarde(300)

			achou_informacao = verdadeiro
		}
		senao se (curso == "seguranca_publica") {
			inteiro investigar_sozinho_policial_original

			investigar_sozinho_policial_original = Graficos.carregar_imagem("Find_IT_4/investigar_sozinho/investigar_sozinho_policial.png")

			Graficos.desenhar_imagem(0, 0, investigar_sozinho_policial_original)
			Graficos.liberar_imagem(investigar_sozinho_policial_original)
			Graficos.renderizar()
			Util.aguarde(500)

			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
					pare
				}
			}
			Util.aguarde(300)

			achou_informacao = verdadeiro
		}
		senao se (curso == "psicologia") {
			achou_informacao = jogo_forca()
		}

		retorne achou_informacao
	}



	// Permitirá que o usuário movimente e escolha entre os três edifícios, além disso, isso mostrará a missão no canto da tela
	funcao vazio escolher_edificio() {
		logico conseguiu_pe_de_cabra = falso
		logico pegou_chave_base = falso
		inteiro salas_apartamento[2][2]
		inteiro imagem_aviso_original = Graficos.carregar_imagem("Find_IT_3/missoes/edificio_correto.png")
		
		faca {
			movimentacao_cidade()
			mostrar_segunda_missao(imagem_aviso_original)
			Graficos.renderizar()
			consequencia_edificios(2.1, falso, conseguiu_pe_de_cabra, salas_apartamento, pegou_chave_base, falso)
		} enquanto (nao (lugar == "dentro_esgoto" ou lugar == "dentro_predio" ou lugar == "festa"))
	}

	funcao vazio psicologo_escolher_edificio() {
		logico conseguiu_pe_de_cabra = falso
		logico pegou_chave_base = falso
		inteiro salas_apartamento[2][2]
		inteiro imagem_aviso_original = Graficos.carregar_imagem("Find_IT_3/missoes/investigar_esgoto.png")
		
		faca {
			movimentacao_cidade()
			mostrar_segunda_especial_missao(imagem_aviso_original)
			Graficos.renderizar()
			consequencia_edificios(2.2, falso, conseguiu_pe_de_cabra, salas_apartamento, pegou_chave_base, falso)
		} enquanto (nao (lugar == "dentro_esgoto" ou lugar == "dentro_predio" ou lugar == "festa"))
	}

	// É usado para fazer uma ação, que dependerá do número da missão, caso o usuário escolha um dos edifícios
	funcao vazio consequencia_edificios(real missao, logico derrotou_bandido_escada, logico &pegou_pe_de_cabra, inteiro casas_apartamento[][], logico &pegou_chave_base, logico encontrou_porta_trancada) {
		
		se (lugar == "esgoto" e Teclado.tecla_pressionada(Teclado.TECLA_E) e (missao == 2.1 ou missao == 3.1 ou missao == 2.2)) {
			lugar = "dentro_esgoto"
			libera_imagens("imagens")
			guardar_imagens_esgoto()
		}
		senao se (lugar == "predio" e Teclado.tecla_pressionada(Teclado.TECLA_E) e missao != 2.2) {
			se (derrotou_bandido_escada e nao pegou_chave_base) {
				inteiro andar = 1
				cadeia enunciado = ""
				inteiro i
				inteiro tecla
				logico parar = falso
				inteiro casa
				inteiro numero_escolhido

				faca {
					Graficos.definir_cor(Graficos.COR_PRETO)
					Graficos.limpar()
					Graficos.definir_cor(Graficos.COR_BRANCO)
					Graficos.definir_tamanho_texto(30.0)
					enunciado = "Andar: " + andar
					Graficos.desenhar_texto(0, 0, enunciado)
	
					para (i = 1; i <= 5; i++) {
						enunciado = "[" + i + "]" + "Vasculhar a " + (i + ((andar - 1) * 5)) + "° casa"
						Graficos.desenhar_texto(0, 100 * i, enunciado)
					}
					Graficos.renderizar()

					enquanto (verdadeiro) {
						tecla = Teclado.ler_tecla()
						se (tecla >= Teclado.TECLA_1 e tecla <= Teclado.TECLA_5) {
							numero_escolhido = Tipos.caracter_para_inteiro(Teclado.caracter_tecla(tecla))
							casa = numero_escolhido + ((andar - 1) * 5)
							se (casas_apartamento[casa - 1][0] == 1) {
								Graficos.definir_cor(Graficos.COR_PRETO)
								Graficos.limpar()
								Graficos.definir_cor(Graficos.COR_BRANCO)
								Graficos.definir_tamanho_texto(30.0)
								Graficos.desenhar_texto(0, 0, "Sala já foi brother")
								Graficos.renderizar()
								Util.aguarde(2000)
								pare
							}
							senao se (casas_apartamento[casa - 1][1] == 1) {
								inteiro imagem_batalhar
								inteiro aviso_vencida_original
								inteiro aviso_ganhou_chave_original
								
								imagem_batalhar = Graficos.carregar_imagem("Find_IT_3/predio/agente_predio.png")

								Graficos.desenhar_imagem(0, 0, imagem_batalhar)
								Graficos.renderizar()
								Graficos.liberar_imagem(imagem_batalhar)
								
								Util.aguarde(500)
								
								enquanto (verdadeiro) {
									se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
										pare
									}
								}
								Util.aguarde(500)

								batalhar()
								Util.aguarde(300)
								
								Graficos.definir_cor(Graficos.COR_PRETO)
								Graficos.limpar()
								Graficos.definir_cor(Graficos.COR_BRANCO)
								Graficos.definir_tamanho_texto(30.0)
								enunciado = "Andar: " + andar
								Graficos.desenhar_texto(0, 0, enunciado)
				
								para (i = 1; i <= 5; i++) {
									enunciado = "[" + i + "]" + "Vasculhar a " + (i + ((andar - 1) * 5)) + "° casa"
									Graficos.desenhar_texto(0, 100 * i, enunciado)
								}
								
								aviso_vencida_original = Graficos.carregar_imagem("Find_IT_3/final_da_batalha/vitoria.png")
								aviso_ganhou_chave_original = Graficos.carregar_imagem("Find_IT_3/final_da_batalha/encontrou_chave.png")
								
								Graficos.desenhar_imagem(0, 0, aviso_vencida_original)
								Graficos.desenhar_imagem(0, 0, aviso_ganhou_chave_original)
								Graficos.renderizar()

								Graficos.liberar_imagem(aviso_vencida_original)
								Graficos.liberar_imagem(aviso_ganhou_chave_original)
								
								Util.aguarde(2000)
								pegou_chave_base = verdadeiro
								pare
							}
							senao se (casas_apartamento[casa - 1][0] == 0) {
								inteiro casa_errada_original
								
								casa_errada_original = Graficos.carregar_imagem("Find_IT_3/predio/porta_errada.png")
								
								Graficos.desenhar_imagem(0, 0, casa_errada_original)
								Graficos.renderizar()
								Util.aguarde(300)
								
								enquanto (verdadeiro) {
									se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
										pare
									}
								}

								casas_apartamento[casa - 1][0] = 1
							}
							pare
						}
						senao se (tecla == Teclado.TECLA_ESC) {
							parar = verdadeiro
							pare
						}
						senao se (tecla == Teclado.TECLA_E e andar != 3) {
							andar++
						}
						senao se (tecla == Teclado.TECLA_Q e andar != 1) {
							andar--
						}
					}
				} enquanto (nao parar)
			}
			senao {
				lugar = "dentro_predio"
				Graficos.renderizar()

				enquanto (verdadeiro) {
					se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
						Graficos.fechar_janela()
					}
				}
			}
		}
		senao se (lugar == "casa_abandonada" e Teclado.tecla_pressionada(Teclado.TECLA_E) e missao != 2.2) {
			inteiro casa_abandonada_original
			
			casa_abandonada_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/escolha_festejar_0.png")
			Util.aguarde(300)
			
			enquanto (verdadeiro e nao (pegou_pe_de_cabra)) {
				Graficos.desenhar_imagem(0, 0, casa_abandonada_original)
				Graficos.renderizar()
								
				se (Teclado.tecla_pressionada(Teclado.TECLA_2)) {
					Graficos.liberar_imagem(casa_abandonada_original)
					Util.aguarde(200)
					pare
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_1)) {
					se (missao == 2.1) {
						Graficos.liberar_imagem(casa_abandonada_original)
						
						// Declaração variáveis
						inteiro festejou_original
						inteiro infartou_original
													
						// Entra com as imagens, redimensiona e libera (se necessário)
						festejou_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/festejei.png")
						infartou_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/final_infarto_festa.png")
	
						// Mostra as imagens
						Graficos.desenhar_imagem(0, 0, festejou_original)
						Graficos.renderizar()
						Util.aguarde(2000)
														
						Graficos.desenhar_imagem(0, 0, infartou_original)
						Graficos.renderizar()
			
						enquanto (verdadeiro) {
							se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
								Graficos.fechar_janela()
							}
						}
					}
					senao se (missao == 3.1) {
						se (nao (encontrou_porta_trancada)) {
							// Declaração variáveis
							inteiro festejou_original
							inteiro infartou_original
															
							// Entra com as imagens, redimensiona e libera (se necessário)
							festejou_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/festejei.png")
							infartou_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/final_infarto_festa.png")
			
							// Mostra as imagens
							Graficos.desenhar_imagem(0, 0, festejou_original)
							Graficos.renderizar()
							Util.aguarde(2000)
															
							Graficos.desenhar_imagem(0, 0, infartou_original)
							Graficos.renderizar()
				
							enquanto (verdadeiro) {
								se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
									Graficos.fechar_janela()
								}
							}
						}
						senao se (encontrou_porta_trancada) {
							Graficos.liberar_imagem(casa_abandonada_original)
							
							// Declaração variáveis
							inteiro festejou_original
							inteiro recebeu_pe_de_cabra_original
			
							// Entra com as imagens, redimensiona e libera (se necessário)
							festejou_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/festejei.png")
							recebeu_pe_de_cabra_original = Graficos.carregar_imagem("Find_IT_1/casa_abandonada/pe_de_cabra.png")
			
							// Mostra as imagens
							Graficos.desenhar_imagem(0, 0, festejou_original)
							Graficos.renderizar()
							Util.aguarde(2000)
							Graficos.liberar_imagem(festejou_original)
			
							Graficos.desenhar_imagem(0, 0, recebeu_pe_de_cabra_original)
							Graficos.renderizar()
			
							enquanto (verdadeiro) {
								se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
									pare
								}
							}
							pegou_pe_de_cabra = verdadeiro

							
							Graficos.liberar_imagem(recebeu_pe_de_cabra_original)
							pare
						}
					}
				}
 			} 
		}
		senao se (lugar == "hospital" e Teclado.tecla_pressionada(Teclado.TECLA_E) e vida_usuario != 200) {
			vida_usuario = 200
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
					pare
				}
			}
		}
	}



	funcao vazio guardar_imagens_batalha() {
		// Declaração de variáveis
		inteiro arquivo = 0
		
			// Principais
		inteiro usuario_batalha_original
		inteiro bandido_batalha_original
		inteiro fundo_original

		// Atribuição das imagens nas variáveis, sua redimensionamento e depois a liberação

		usuario_batalha_original = Graficos.carregar_imagem("Find_IT_3/personagens/usuario/usuario_batalha_0.png")

		bandido_batalha_original = Graficos.carregar_imagem("Find_IT_3/personagens/cris/cris_batalha_0.png")

		fundo_original = Graficos.carregar_imagem("Find_IT_2/fundo_modo_batalha.png")

		// Abre
		arquivo = Arquivos.abrir_arquivo("batalha", Arquivos.MODO_ESCRITA)

		// Adiciona as imagens ao arquivo
				// Principais
		adiciona_imagem_arquivo(arquivo, usuario_batalha_original, "usuario_batalha")
		adiciona_imagem_arquivo(arquivo, bandido_batalha_original, "cris_batalha")
		adiciona_imagem_arquivo(arquivo, fundo_original, "fundo_batalha")

		// Fecha
		Arquivos.fechar_arquivo(arquivo)
	}

	// cenário de batalha
	funcao vazio batalhar() {
		guardar_imagens_batalha()
		
		cadeia ataques_usuario[][] = {{"Voadora", "100"}, {"Chute", "15"}, {"Soco", "10"}, {"Peteleco", "5"}}
		
		enquanto (verdadeiro) {
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				atacar(ataques_usuario)
			}
			senao {
				cenario_batalha(ataques_usuario)
				
				// definir personagens
				Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
				Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))
				
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
			se (vida_bandido <= 0 ou vida_usuario <= 0) {
				pare
			}
		}
		libera_imagens("batalha")
		Arquivos.apagar_arquivo("batalha")
	}

	funcao inteiro ataque_escolhido() {
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

	funcao vazio atacar(cadeia ataques_usuario[][]) {
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


		inteiro nivel_bandido = 5
		cadeia ataques_bandido[][] = {{"Ataque 1", "100"}, {"Ataque 2", "15"}, {"Ataque 3", "10"}, {"Ataque 4", "5"}}
		inteiro pontos_ataque_bandido = 100
		inteiro pontos_defesa_bandido = 100

		// ataque usuário
		ataque_infringido = ataque_escolhido()
		poder_ataque = Tipos.cadeia_para_inteiro(ataques_usuario[ataque_infringido - 1][1], 10)
		dano = ((2.0 * nivel_usuario + 10) / 250 * (pontos_ataque_usuario / pontos_defesa_bandido) * poder_ataque + 2) * 1.5 * 2 * (Util.sorteia(85, 100) / 100.0)
		vida_bandido -= dano

		bandido_tomou_dano(ataques_usuario)
		
		cenario_batalha(ataques_usuario)
		// definir personagens
		Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
		Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))
		Graficos.renderizar()
		
		Util.aguarde(1500)

		se (vida_bandido > 0) {
			// contra-ataque bandido
			ataque_infringido = Util.sorteia(1, 4)
			poder_ataque = Tipos.cadeia_para_inteiro(ataques_bandido[ataque_infringido - 1][1], 10)
			dano = ((2.0 * nivel_bandido + 10) / 250 * (pontos_ataque_bandido / pontos_defesa_usuario) * poder_ataque + 2) * 1.5 * 2 * (Util.sorteia(85, 100) / 100.0)
	
			// capacidade do usuário de desviar
			usuario_desviou = falso
			tempo_desvio = Util.sorteia(500, 1000)
	
			tecla = Util.sorteia(65, 90)
	
			tempo_inicial = Util.tempo_decorrido()
			tempo_final = tempo_desvio + tempo_inicial
			
			cenario_batalha(ataques_usuario)
			// definir personagens
			Graficos.definir_cor(COR_CINZA)
			Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
			Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))
			Graficos.definir_opacidade(235)
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
				usuario_tomou_dano(ataques_usuario)
			}
		}
	}

	funcao vazio bandido_tomou_dano(cadeia ataques_usuario[][]) {
		inteiro i

		para (i = 0; i < 2; i++) {
			cenario_batalha(ataques_usuario)
			Graficos.definir_cor(COR_CINZA)
				Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
			
			Graficos.renderizar()
			Util.aguarde(150)
			
			cenario_batalha(ataques_usuario)
				Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
				Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))

			Graficos.renderizar()
			Util.aguarde(200)
		}
		
	}

	funcao vazio usuario_tomou_dano(cadeia ataques_usuario[][]) {
		inteiro i

		para (i = 0; i < 2; i++) {
			cenario_batalha(ataques_usuario)
				Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))
		
			Graficos.renderizar()
			Util.aguarde(150)
			
			cenario_batalha(ataques_usuario)
				Graficos.desenhar_imagem(450, 250, reverter_imagem("usuario_batalha", "batalha"))
				Graficos.desenhar_imagem(730 + 500, 0, reverter_imagem("cris_batalha", "batalha"))

			Graficos.renderizar()
			Util.aguarde(200)
		}
	}

	funcao vazio cenario_batalha(cadeia ataques_usuario[][]) {
		const inteiro ALTURA_BLOCOS_ATAQUE = 140
		const inteiro LARGURA_BLOCOS_ATAQUE = 400
		// fundo
		Graficos.desenhar_imagem(0, 0, reverter_imagem("fundo_batalha", "batalha"))

		// Lugar onde fica a barra de vida, o fundo da barra de vida
		Graficos.definir_cor(COR_CINZA)
		Graficos.desenhar_retangulo(20, 70, 720, 150, verdadeiro, verdadeiro)
		Graficos.desenhar_retangulo(1919 - 740, 1079 - (350 + 100 + 150), 720, 150, verdadeiro, verdadeiro)

		// Barra de vida e vida
		Graficos.definir_gradiente(Graficos.GRADIENTE_DIREITA, Graficos.COR_VERDE, Graficos.criar_cor(1, 50, 32))
		Graficos.desenhar_retangulo(30, 135, vida_bandido / 2 * 6, 75, verdadeiro, verdadeiro)
		Graficos.desenhar_retangulo(1919 - 730, 1079 - (350 + 100 + 10 + 75), vida_usuario / 2 * 6, 75, verdadeiro, verdadeiro)
		Graficos.definir_cor(COR_CINZA_ESCURO)
		Graficos.definir_tamanho_texto(30.0)
		Graficos.desenhar_texto(635, 135, vida_bandido + "/200")
		Graficos.desenhar_texto(1919 - 125, 1079 - (350 + 100 + 10 + 75), vida_usuario + "/200")
		Graficos.definir_tamanho_texto(70.0)
		Graficos.desenhar_texto(1919 - 740, 1079 - (350 + 100 + 150), "Você")
		Graficos.desenhar_texto(30, 75, "Agente")
		

		// Lugar onde os personagens ficam
		Graficos.definir_cor(COR_CINZA_ESCURO)
		Graficos.desenhar_elipse(594 - 800 / 2, 1079 - 350 - 150 - 30, 800, 150, verdadeiro)
		Graficos.desenhar_elipse(730 + (594 - 800 / 2) + 40, 300, 800, 150, verdadeiro)

		// interface dos ataques
			// fundo onde fica os ataques
		Graficos.definir_cor(COR_CINZA)
		Graficos.desenhar_retangulo(0, 1079 - 350, 1920, 350, falso, verdadeiro)

			// Bloco onde fica os ataques
		Graficos.definir_cor(COR_CINZA_ESCURO)
		Graficos.desenhar_retangulo(200, 1079 - (350 - 20), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
		Graficos.desenhar_retangulo(200, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
		Graficos.desenhar_retangulo(200 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
		Graficos.desenhar_retangulo(200 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30), LARGURA_BLOCOS_ATAQUE, ALTURA_BLOCOS_ATAQUE, falso, verdadeiro)
		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(70.0)
		Graficos.desenhar_texto(215, 1079 - (350 - 20) + 50, ataques_usuario[0][0])
		Graficos.desenhar_texto(215, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30) + 50, ataques_usuario[1][0])
		Graficos.desenhar_texto(210 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20) + 50, ataques_usuario[2][0])
		Graficos.desenhar_texto(210 + LARGURA_BLOCOS_ATAQUE + 230, 1079 - (350 - 20 - ALTURA_BLOCOS_ATAQUE - 30) + 50, ataques_usuario[3][0])

			// A seta que escolhe os ataques
		Graficos.definir_tamanho_texto(120.0)
		Graficos.desenhar_texto(posicao_x_seta, posicao_y_seta, ">")
	}



	// Permite a movimentação no esgoto
	funcao vazio movimentacao_esgoto(inteiro &ponto, inteiro rotacao) {
		
		se (ponto == 0) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 605
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = 560
				posicao_y_usuario = 690
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = 890
				posicao_y_usuario = 710
			}
		}

		senao se (ponto == 1) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = 750
				posicao_y_usuario = 605
				}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = 560
				posicao_y_usuario = 690
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = 750
				posicao_y_usuario = 860
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 13
				posicao_x_usuario = 1340
				posicao_y_usuario = 895
			}
		}
		senao se (ponto == 2) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = 750
				posicao_y_usuario = 605
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = 750
				posicao_y_usuario = 860
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = 890
				posicao_y_usuario = 710
			}
		}
		senao se (ponto == 3) {
			rotacao = 90
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 4
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 430
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 2
				posicao_x_usuario = 560
				posicao_y_usuario = 690
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 0
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 860
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 1	
				posicao_x_usuario = 890
				posicao_y_usuario = 710
			}
		}
		senao se (ponto == 4) {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = 560
				posicao_y_usuario = 225
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 605
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 3
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = 605
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = 1030
				posicao_y_usuario = 75
			}
		}
		senao se (ponto == 5) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 6
				posicao_x_usuario = 378
				posicao_y_usuario = 215
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 4
				posicao_x_usuario = 750
				posicao_y_usuario = 430
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = 1030
				posicao_y_usuario = 75
			}
		}
		senao se (ponto == 6) {
			rotacao = 0
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = 560
				posicao_y_usuario = 225
			}
		}
		senao se (ponto == 7) {
			rotacao = 90
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 5
				posicao_x_usuario = 560
				posicao_y_usuario = 225
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = 1185
				posicao_y_usuario = 215
			}
		}
		senao se (ponto == 8) {
			rotacao = 0
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = 1340
				posicao_y_usuario = 120
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 7
				posicao_x_usuario = 1030
				posicao_y_usuario = 75
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = 1335
				posicao_y_usuario = 345
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = 1480
				posicao_y_usuario = 225
			}
		}
		senao se (ponto == 9) {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = 1185
				posicao_y_usuario = 215
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = 1480
				posicao_y_usuario = 225
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = 1335
				posicao_y_usuario = 345
			}
		}
		senao se (ponto == 10) {
			rotacao = 180
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = 1185
				posicao_y_usuario = 215
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = 1340
				posicao_y_usuario = 120
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = 1335
				posicao_y_usuario = 345
			}
		}
		senao se (ponto == 11) {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 8
				posicao_x_usuario = 1185
				posicao_y_usuario = 215
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 9
				posicao_x_usuario = 1340
				posicao_y_usuario = 120
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 12
				posicao_x_usuario = 1505
				posicao_y_usuario = 700
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 10
				posicao_x_usuario = 1480
				posicao_y_usuario = 225
			}
		}
		senao se (ponto == 12) {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				Util.aguarde(200)
				ponto = 11
				posicao_x_usuario = 1335
				posicao_y_usuario = 345
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A) ou Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				Util.aguarde(200)
				ponto = 13
				posicao_x_usuario = 1345
				posicao_y_usuario = 900
			}
		}
		senao se (ponto == 13) {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W) ou Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				Util.aguarde(200)
				ponto = 12
				posicao_x_usuario = 1505
				posicao_y_usuario = 710
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				Util.aguarde(200)
				ponto = 1
				posicao_x_usuario = 890
				posicao_y_usuario = 710
			}
		}

		cenario_esgoto(rotacao)
	}	

	// Faz o cenário do esgoto, junto com o usuário
	funcao vazio cenario_esgoto(inteiro rotacao) {
		Graficos.desenhar_imagem(0, 0, reverter_imagem("esgoto", "imagens"))
				
		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, reverter_imagem("usuario", "usuario"))
		Graficos.definir_rotacao(0)
	}
	
	// Dá a consequência da sala em que o usuário entre
	funcao vazio consequencia_salas(inteiro ponto, inteiro tipos_sala[][], logico &pegou_chave) {
		//mostre_sala_esgoto(ponto, tipos_sala)
		
		se (tipos_sala[ponto - 1][1] == 0) {
			inteiro sala_esgoto_teia_original
			
			sala_esgoto_teia_original = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_teia.png")
			Graficos.desenhar_imagem(0, 0, sala_esgoto_teia_original)
			Graficos.renderizar()
		
			Util.aguarde(300)
			
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					pare
				}
			}
		}
		senao {
			inteiro sala_esgoto_original
			
			se (tipos_sala[ponto - 1][2] == 0) {
				sala_esgoto_original = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_bandido.png")
			}
			senao {
				sala_esgoto_original = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_teia.png")
			}
			Graficos.desenhar_imagem(0, 0, sala_esgoto_original)
			Graficos.liberar_imagem(sala_esgoto_original)
			
			Graficos.renderizar()
			
			Util.aguarde(300)
			
			enquanto (verdadeiro) {
				se (Teclado.tecla_pressionada(Teclado.TECLA_E) e tipos_sala[ponto - 1][2] == 0) {
					libera_imagens("imagens")
					batalhar()
					guardar_imagens_esgoto()
					
					se (vida_bandido <= 0) {
						inteiro aviso_vencida_original
						inteiro aviso_ganhou_chave_original
						vida_bandido = 200
						tipos_sala[ponto - 1][2] = 1

						sala_esgoto_original  = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_teia.png")
						Graficos.desenhar_imagem(0, 0, sala_esgoto_original)
						Graficos.liberar_imagem(sala_esgoto_original)
								
						aviso_vencida_original = Graficos.carregar_imagem("Find_IT_3/final_da_batalha/vitoria.png")
						Graficos.desenhar_imagem(0, 0, aviso_vencida_original)
						Graficos.liberar_imagem(aviso_vencida_original)
								
						se (tipos_sala[ponto - 1][1] == 2) {
							aviso_ganhou_chave_original = Graficos.carregar_imagem("Find_IT_3/final_da_batalha/encontrou_chave.png")
							Graficos.desenhar_imagem(0, 0, aviso_ganhou_chave_original)
							Graficos.liberar_imagem(aviso_ganhou_chave_original)
							
							pegou_chave = verdadeiro
						}
						Graficos.renderizar()
						Util.aguarde(3000)
						consequencia_salas(ponto, tipos_sala, pegou_chave)
						pare
					}
					senao se (vida_usuario <= 0) {
						pare
					}
				}
				senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
					pare
				}
			}
		}
	}

	// mostra a sala da escada
	funcao vazio mostre_sala_escada() {
		inteiro sala_esgoto_escada_original
		sala_esgoto_escada_original = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_escada.png")
		Graficos.desenhar_imagem(0, 0, sala_esgoto_escada_original)
		Graficos.liberar_imagem(sala_esgoto_escada_original)
	}

	// mostra a sala da escada
	funcao vazio mostre_sala_escada_bandido() {
		inteiro sala_esgoto_escada_bandido_original
		sala_esgoto_escada_bandido_original = Graficos.carregar_imagem("Find_IT_1/cenarios/esgoto/sala_esgoto_escada_bandido.png")
		Graficos.desenhar_imagem(0, 0, sala_esgoto_escada_bandido_original)
		Graficos.liberar_imagem(sala_esgoto_escada_bandido_original)
	}

	funcao vazio mostre_bandido() {
		inteiro aviso_batalha_original = Graficos.carregar_imagem("Find_IT_3/batalhe.png")
		inteiro bandido_original = Graficos.carregar_imagem("Find_IT_3/personagens/cris/cris.png")
		
		Graficos.desenhar_imagem(960, 0, aviso_batalha_original)
		Graficos.desenhar_imagem(1700, 539, bandido_original)
	}

	funcao vazio mostre_usuario() {
		Graficos.definir_rotacao(90)
		Graficos.desenhar_imagem(350, 539, reverter_imagem("usuario", "usuario"))
		Graficos.definir_rotacao(0)
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
	
	funcao vazio labirinto(inteiro &tipos_sala[][], logico &tem_chave, logico tem_pe_de_cabra, logico &encontrou_porta_trancada, logico pegou_chave_base, logico &voltar_esgoto) {	
		// Declaração de variáveis
			// Interface bonita
		inteiro rotacao = 0
		
			// Usar para saber em que lugar está
		inteiro ponto = 0

		// Muda lugar do usuário para ele ficar na entrada de dentro do esgoto
		posicao_x_usuario = 750
		posicao_y_usuario = 860
		
		enquanto (verdadeiro) {
			movimentacao_esgoto(ponto, rotacao)
			Graficos.renderizar()
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_E)) {
				se (ponto  == 0) {
					lugar = "esgoto"
					libera_imagens("imagens")
					guardar_imagens_cidade()
					Util.aguarde(300)
					pare
				}
				senao se (tipos_sala[ponto - 1][1] == 3) {
					se (tem_chave ou tem_pe_de_cabra) {
						enquanto (nao voltar_esgoto) {
							se (tipos_sala[ponto - 1][2] == 0) {
								mostre_sala_escada_bandido()
							}
							senao {
								mostre_sala_escada()
							}
			
							Graficos.renderizar()
							Util.aguarde(500)
							
							enquanto (verdadeiro) {
								se (Teclado.tecla_pressionada(Teclado.TECLA_E) e tipos_sala[ponto - 1][2] == 0) {
									batalhar()
									
									se (vida_bandido <= 0) {
										vida_bandido = 200
										mostre_sala_escada()
										Graficos.renderizar()
										
										tipos_sala[ponto - 1][2] = 1
										Util.aguarde(1000)
										pare
									}
									senao se (vida_usuario <= 0) {
										pare
									}
								}
								senao se (Teclado.tecla_pressionada(Teclado.TECLA_E) e tipos_sala[ponto - 1][2] == 1) {
									libera_imagens("imagens")
																
									inteiro fim
							
									fim = Graficos.carregar_imagem("Find_IT_1/esgoto/final_feliz.png")

									Graficos.desenhar_imagem(0, 0, fim)
									Graficos.renderizar()

									enquanto (verdadeiro) {
										se (Teclado.tecla_pressionada(Teclado.TECLA_ESC)) {
											Graficos.fechar_janela()
										}
 									}
								}
								senao se (Teclado.tecla_pressionada(Teclado.TECLA_Q)) {
									voltar_esgoto = verdadeiro
									pare
								}
							}
						}
						voltar_esgoto = falso
					}
					senao {
						movimentacao_esgoto(ponto, rotacao)
						Graficos.definir_cor(COR_CINZA)
						Graficos.definir_opacidade(240)
						Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
						Graficos.definir_opacidade(255)
						Graficos.definir_cor(Graficos.COR_BRANCO)
						Graficos.definir_tamanho_texto(100.0)
						Graficos.desenhar_texto(0, 539, "Sala trancada, procure a chave!")
						encontrou_porta_trancada = verdadeiro
								
						Graficos.renderizar()
						Util.aguarde(2000)
					}
				}
				senao {
					consequencia_salas(ponto, tipos_sala, tem_chave)
					se (vida_usuario  <= 0) {
						lugar = "fim_perdeu"
						Util.aguarde(300)
						pare
					}
				}
			}

		}
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
