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
		caracter letras_tentadas[26]
		caracter tentativa
		inteiro quantidade_de_tentativas = -1
		inteiro palavra_sorteada_indice
		inteiro i
		cadeia palavra_sorteada
		palavra_sorteada_indice = Util.sorteia(0, (Util.numero_elementos(palavras)))
		palavra_sorteada = palavras[palavra_sorteada_indice]
		enquanto (verdadeiro) {
			para (i = 0; i < Texto.numero_caracteres(palavra_sorteada); i++){
				escreva("_ ")
			}
			escreva("\n")
			pergunte("Digite uma letra")
			leia(tentativa)
			quantidade_de_tentativas += 1
			letras_tentadas[quantidade_de_tentativas] = tentativa
			para (i = 0; i < Util.numero_elementos(letras_tentadas); i ++){
				se (Tipos.cadeia_e_caracter(letras_tentadas[i]) == ''){
					escreva(letras_tentadas[i])
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
 * @POSICAO-CURSOR = 1101; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */