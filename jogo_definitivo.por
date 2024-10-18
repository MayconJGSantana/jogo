programa
{
	inclua biblioteca Graficos
	inclua biblioteca Matematica
	inclua biblioteca Util
	inclua biblioteca Teclado
	inclua biblioteca Calendario

	inteiro posicao_x_usuario = adequar_largura(500)
	inteiro posicao_y_usuario = adequar_altura(155)
	inteiro usuario = Graficos.carregar_imagem("/personagens/usuario.png")
	inteiro cidade = Graficos.carregar_imagem("cidade.jpg")
	inteiro COR_CINZA = Graficos.criar_cor(190, 190, 190)
	
	funcao inicio()
	{
		cadeia lugar = ""
		inteiro rotacao = 0
		cadeia tipo_investigacao = ""
		cadeia curso
		
		cidade = Graficos.redimensionar_imagem(cidade, Graficos.largura_tela(), Graficos.altura_tela(), verdadeiro)
		usuario = Graficos.redimensionar_imagem(usuario, adequar_largura(Graficos.largura_imagem(usuario) / 6), adequar_altura((Graficos.altura_imagem(usuario) / 6)), verdadeiro)
		inicia_grafico()
		
		lugar = "historia"
		historia()

		Util.aguarde(20000)

		lugar = "escolha_curso"
		curso = escolha_curso()

		lugar = "opcao_investigacao"
		tipo_investigacao = investigacao()
		se (tipo_investigacao == "si_mesmo") {
			
			se (curso == "tecnico_desenvovlimento_sistemas") {
				
			}
			senao se (curso == "seguranca publica") {
				
			}
			senao se (curso == "psicologia") {
				
			}
			
		}
		senao se (tipo_investigacao == "ajuda_moradores") {

		}

		lugar = "casa_usuario"
		enquanto (verdadeiro) {
			movimentacao_cidade(lugar, rotacao)
		}
		
	}

	funcao vazio inicia_grafico() {
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.entrar_modo_tela_cheia()
	}

	funcao vazio historia() {
		// Graficos.desenhar_imagem(0, 0, historia)
		Graficos.desenhar_retangulo(0, 0, Graficos.largura_tela(), Graficos.altura_tela(), falso, verdadeiro)
		Graficos.definir_cor(Graficos.COR_BRANCO)
		Graficos.definir_tamanho_texto(20.0)
		Graficos.desenhar_texto(50, 50, "'Tram... Tram... Tram...', esse é um barulho familiar a seus auriculares. 'Meu Deus' tu dizes, depois de olhar no relógio, '7:49', lembrando-se da prova que seus colegas estão fazendo,")
		Graficos.desenhar_texto(50, 70, "a qual também deveria estar.")
		Graficos.desenhar_texto(50, 90, "...")
		Graficos.renderizar()
	}

	funcao vazio pular_historia(inteiro tempo, cadeia cenario) {
		inteiro i
		
		inteiro segundo_inical
		inteiro milisegundo_inicial

		inteiro segundo_final
		inteiro milisegundo_final
	
		const inteiro SEGUNDO_EM_MILISEGUNDO = 1000

		const inteiro TEMPO = 1687
		
		segundo_inical = Calendario.segundo_atual()
		milisegundo_inicial = Calendario.milisegundo_atual()
		
		segundo_final = (segundo_inical + (TEMPO / SEGUNDO_EM_MILISEGUNDO)) % 60
		milisegundo_final = (milisegundo_inicial + (TEMPO % SEGUNDO_EM_MILISEGUNDO)) % 1000
		
		faca {
			Util.aguarde(1)
			se (Teclado.tecla_pressionada(Teclado.TECLA_ENTER)) {
				pare
			}
		} enquanto (nao (segundo_final == Calendario.segundo_atual() e milisegundo_final <= Calendario.milisegundo_atual()))
	}

	funcao cadeia escolha_curso() {
		cadeia curso = ""
		
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
		
		retorne curso
	}

	funcao cadeia investigacao() {
		cadeia tipo_investigacao = ""
		
		faca {
			Graficos.desenhar_imagem(0, 0, cidade)
			Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, usuario)
			
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
	
	funcao inteiro adequar_largura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}

	funcao inteiro adequar_altura(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.altura_tela() / 1080.0), 0)
	}
        
	funcao inteiro adequar_texto(inteiro tamanho) {
		retorne Matematica.arredondar(tamanho * (Graficos.largura_tela() / 1920.0), 0)
	}	
	
	funcao vazio movimentacao_cidade(cadeia &lugar, inteiro rotacao) {
		se (lugar == "casa_usuario") {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				lugar = "casa_vizinho_3"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "casa_vizinho_1"
				posicao_x_usuario = adequar_largura(667)
				posicao_y_usuario = adequar_altura(210)
			}
		}
		senao se (lugar == "casa_vizinho_1") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				lugar = "casa_vizinho_2"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(400)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "casa_usuario"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(155)
			}
		}
		senao se (lugar == "casa_vizinho_2") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				lugar = "casa_vizinho_1"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(210)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "casa_vizinho_3"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "prédio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "casa_vizinho_3") {
			rotacao = 90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				lugar = "casa_usuario"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(155)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "casa_vizinho_2"
				posicao_x_usuario = adequar_largura(667)
				posicao_y_usuario = adequar_altura(425)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "casa_abandonada"
				posicao_x_usuario = adequar_largura(130)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "esgoto") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				lugar = "casa_vizinho_3"
				posicao_x_usuario = adequar_largura(500)
				posicao_y_usuario = adequar_altura(455)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "prédio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "casa_abandonada"
				posicao_x_usuario = adequar_largura(130)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "casa_abandonada") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
		}
		senao se (lugar == "prédio") {
			rotacao = 0
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "esgoto"
				posicao_x_usuario = adequar_largura(530)
				posicao_y_usuario = adequar_altura(900)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_D)) {
				lugar = "hospital"
				posicao_x_usuario = adequar_largura(1370)
				posicao_y_usuario = adequar_altura(800)
			}
		}
		senao se (lugar == "hospital") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_W)) {
				lugar = "departamento_policial"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(150)
			}
			se (Teclado.tecla_pressionada(Teclado.TECLA_A)) {
				lugar = "prédio"
				posicao_x_usuario = adequar_largura(900)
				posicao_y_usuario = adequar_altura(775)
			}
		}
		senao se (lugar == "departamento_policial") {
			rotacao = -90
			
			se (Teclado.tecla_pressionada(Teclado.TECLA_S)) {
				lugar = "hospital"
				posicao_x_usuario = posicao_x_usuario
				posicao_y_usuario = adequar_altura(800)
			}
		}
		
		Graficos.desenhar_imagem(0, 0, cidade)

		Graficos.definir_rotacao(rotacao)
		Graficos.desenhar_imagem(posicao_x_usuario, posicao_y_usuario, usuario)
		Graficos.definir_rotacao(0)
		
		Graficos.definir_tamanho_texto(40.0)
		Graficos.desenhar_texto(0, 0, lugar)
		Graficos.renderizar()
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