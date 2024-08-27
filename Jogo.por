programa
{
	inclua biblioteca Util
	inclua biblioteca Graficos
	inclua biblioteca Texto
	inclua biblioteca Tipos
	funcao vazio pergunte(cadeia enunciado){
		escreva("-> " + enunciado + ": ")
	}
	funcao inicio()
	{
		/*
		inteiro imagem_fundo
		// supostamento pega imagem
		imagem_fundo = Graficos.carregar_imagem("/home/lab/IIR/Portugol/65.png")
		// supostamente faz aparecer a imagem
		Graficos.iniciar_modo_grafico(verdadeiro)
		Graficos.definir_titulo_janela("Teste")
		Graficos.definir_dimensoes_janela(500,500)
		Graficos.limpar()
		Graficos.desenhar_imagem(-550, 0, imagem_fundo)
		Graficos.renderizar()
		Util.aguarde(10000)
		// x machine
		*/
		cadeia palavras[] = {"cachorro","gato","avião","carro","computador","livro","escola","floresta","amigo","telefone","bola","música","praia","chave","janela","cidade","hospital","bicicleta","pizza","desenho","mesa","porta","jogo","rato","cabelo","camisa","estrela","caderno","filme"}
		cadeia alfabeto[] = {"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"}
		caracter letras_tentadas[26]
		caracter tentativa = 'a'
		inteiro quantidade_de_tentativas = 0
		inteiro i
		inteiro j
		logico letra_escrita = falso
		logico tentativa_valida = falso
		cadeia palavra_sorteada = "teste k"//= palavras[Util.sorteia(0, (Util.numero_elementos(palavras)))]
		enquanto (verdadeiro) {
			para (i = 0; i < Texto.numero_caracteres(palavra_sorteada); i++) {
				se (quantidade_de_tentativas !=  0) {
					para (j = 0; j < Util.numero_elementos(letras_tentadas); j++) {
						se (Texto.obter_caracter(palavra_sorteada, i) == letras_tentadas[j]) {
							escreva(Texto.obter_caracter(palavra_sorteada, i), ' ')
							letra_escrita = verdadeiro
							pare
						}
					}
				}
				se (nao letra_escrita) {
					escreva("_ ")
				}
				letra_escrita = falso
			}
			escreva("\n")
			enquanto (verdadeiro) {
				pergunte("Digite uma letra")
				leia(tentativa)
				tentativa = Tipos.cadeia_para_caracter(Texto.caixa_baixa(Tipos.caracter_para_cadeia(tentativa)))
				para (i = 0; i < Util.numero_elementos(alfabeto); i++) {
					se (tentativa == Tipos.cadeia_para_caracter(alfabeto[i])) {
						tentativa_valida = verdadeiro
						pare
					}
				}
				se (quantidade_de_tentativas != 0)
				para (i = 0; i < quantidade_de_tentativas
				se (nao tentativa_valida) {
					escreva("Valor inválido, tente novamente!\n")
				}
				senao {
					pare
				}
			}
			tentativa_valida = falso
			quantidade_de_tentativas += 1
			letras_tentadas[quantidade_de_tentativas - 1] = tentativa
			para (i = 0; i < quantidade_de_tentativas; i ++){
				se (i == quantidade_de_tentativas - 1) {
					escreva(letras_tentadas[i])
				}
				senao {
					escreva(letras_tentadas[i], " - ")
				}
			}
			escreva("\n")
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 1894; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */