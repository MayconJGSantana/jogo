programa
{
	inclua biblioteca Graficos --> g
	inclua biblioteca Teclado --> t
	inclua biblioteca Util --> u

	inteiro esgoto, protag = g.carregar_imagem("/personagens/protag.png")
	
	funcao inicio()
	{
		g.iniciar_modo_grafico(verdadeiro)
		g.entrar_modo_tela_cheia()
		esgoto = g.redimensionar_imagem(g.carregar_imagem("/portas_esgoto/esgoto.jpg"), g.largura_janela(), g.altura_janela(), verdadeiro)
		protag = g.redimensionar_imagem(protag, (g.largura_imagem(protag)/6), (g.altura_imagem(protag) /6), verdadeiro)
		labirinto(0)
	}
	funcao labirinto(inteiro ponto)
	{	
		enquanto (verdadeiro)
		{
			g.limpar()
			g.desenhar_imagem(0, 0, esgoto)
			se (ponto == 0)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 3
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 2
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 1	
					}
					u.aguarde(200)
				}
				se (ponto == 1)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(100, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 3
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 2
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 0
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 13
					}
					u.aguarde(200)
				}
				se (ponto == 2)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 100, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 3
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 0
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 1	
					}
					u.aguarde(200)
				}
				se (ponto == 3)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(100, 100, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 4
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 2
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 0
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 1	
					}
					u.aguarde(200)
				}
				se (ponto == 4)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 5
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 3
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 3
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 7
					}
					u.aguarde(200)
				}
				se (ponto == 5)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 6
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 4
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 7
					}
					u.aguarde(200)
				}
				se (ponto == 6)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 5
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 5
					}
					u.aguarde(200)
				}
				se (ponto == 7)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 5
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 8
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 9
					}
					u.aguarde(200)
				}
				se (ponto == 8)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 9
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 7
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 11
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 10
					}
					u.aguarde(200)
				}
				se (ponto == 9)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 7
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 8
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 10
					}
					u.aguarde(200)
				}
				se (ponto == 10)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 9
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 11
					}
					u.aguarde(200)
				}
				se (ponto == 11)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 11
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 8
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 12
					}
					u.aguarde(200)
				}
				se (ponto == 12)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 11
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 13
					}
					se (t.tecla_pressionada(t.TECLA_S))
					{
						ponto = 13
					}
					u.aguarde(200)
				}
				se (ponto == 13)
				{
					g.limpar()
					g.desenhar_imagem(0, 0, esgoto)
					g.desenhar_imagem(0, 0, protag)
					se (t.tecla_pressionada(t.TECLA_W))
					{
						ponto = 12
					}
					se (t.tecla_pressionada(t.TECLA_A))
					{
						ponto = 1
					}
					se (t.tecla_pressionada(t.TECLA_D))
					{
						ponto = 12
					}
					u.aguarde(200)
				}
				g.renderizar()
		}
	}
}
