%{
    #include "cabecalho.h"
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    extern int linhas;
    extern int erros;
    extern int yylineno;
    int yylex();
    int yyerror (char const *s);
    
%}


%define parse.error verbose

%token INT FLOAT MAIN WHILE IF ELSE FOR
%token ABRE_PAR FECHA_PAR ABRE_CHAVE FECHA_CHAVE PONT_VIRG
%token VARIAVEL INTEIRO FLUTUANTE
%token MAIOR MENOR IGUAL DIF
%token ADD SUB MULT DIV RECEBE

%%

Inicio_Programa: MAIN ABRE_PAR FECHA_PAR ABRE_CHAVE Comandos FECHA_CHAVE ;


Comandos: Comando Comandos | Comando ;

Comando:  Declaracao |  Atribuicao |  Condicional |  Repeticao |  Aritmetica;

Declaracao: Tipo VARIAVEL  | Tipo VARIAVEL RECEBE Valor ;

Tipo: INT | FLOAT;

Valor: INTEIRO | FLUTUANTE ;

Atribuicao: VARIAVEL RECEBE Dado ;

Dado: INTEIRO| FLUTUANTE | VARIAVEL | Aritmetica;

Repeticao:  WHILE ABRE_PAR Condicao FECHA_PAR ABRE_CHAVE Comandos FECHA_CHAVE | FOR ABRE_PAR Atribuicao PONT_VIRG Condicao PONT_VIRG Incremento FECHA_PAR ABRE_CHAVE Comandos FECHA_CHAVE;

Condicao:  VARIAVEL Logico VARIAVEL  |  VARIAVEL Logico Valor  |  Valor Logico VARIAVEL ;

Incremento: VARIAVEL ADD ADD | VARIAVEL SUB SUB;

Logico: MAIOR | MENOR | IGUAL | DIF  ;

Condicional:  IF ABRE_PAR Condicao FECHA_PAR ABRE_CHAVE Comandos FECHA_CHAVE  |  IF ABRE_PAR Condicao FECHA_PAR ABRE_CHAVE Comandos FECHA_CHAVE ELSE ABRE_CHAVE Comandos FECHA_CHAVE  ;

Aritmetica:  Valor Operador Valor  |  VARIAVEL Operador VARIAVEL | Valor Operador VARIAVEL | VARIAVEL Operador Valor;

Operador: ADD | SUB | MULT | DIV ;

%%

FILE *yyin;

int yyerror(char const *s){
    printf("Foi encontrado um erro sintatico :  %s . Este erro esta proximo a linha %d \n",s,yylineno);
    erros++;
    return erros;

}

int main (int argc, char **argv)
{
    ++argv, --argc; //desconsidera o nome do programa
    if ( argc > 0)
        yyin=fopen( argv[0], "r");
    else
    {
        puts("Falha ao abrir o arquivo, nome incorreto ou não especificado");
        exit(0);
    }
    do{
        yyparse();
    }while(!feof(yyin));
    if(erros==0)
        puts("Analise concluida com sucesso");
    else
        puts("Erros encontrados no programa!");
}


