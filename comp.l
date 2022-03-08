%{
    #include "analisador.h"
    #include <stdio.h>
    #include <stdlib.h>
    int Linhas=1;
    int erros=0;
%}

%option  nodefault yylineno


DIGITO [0-9]
LETRAS [A-Za-z]
ESPACO [\t\r" "]
LINHA \n
VARIAVEL ("_"|{LETRAS})({DIGITO}|{LETRAS}|"_")*
INTEIRO ("-"|"+"|""){DIGITO}+
FLUTUANTE ("-"|"+"|""){DIGITO}+"."{DIGITO}+ 
INT "int"
FLOAT "float"
MAIN "main"
WHILE "while"
FOR "for"
IF "if"
ELSE "else"
ABRE_PAR "("
FECHA_PAR ")"
ABRE_CHAVE "{"
FECHA_CHAVE "}"
PONT_VIRG ";"
MAIOR ">"
MENOR "<"
IGUAL "=="
DIF "!="
ADD "+"
SUB "-"
MULT "*"
DIV "/"
RECEBE "="

%%


{ESPACO} /* Reconhece espaço em branco*/


{LINHA} { 
Linhas++;
}

 /*Numeros*/

{INTEIRO} { 
 printf("Token Numero inteiro: %s\n",yytext);
 return (INTEIRO);
}

{FLUTUANTE} { 
 printf("Token Numero Real: %s\n",yytext);
 return (FLUTUANTE);
}

 /* Palavras Reservadas */

{INT} { 
 printf("Token Tipo de variavel INT: %s\n",yytext);
 return (INT);
}

{FLOAT} { 
 printf("Token Tipo de variavel FLOAT: %s\n",yytext);
 return (FLOAT);
}

{MAIN} { 
 printf("Token Palavra chave MAIN: %s\n",yytext);
 return (MAIN);
}

{RECEBE} { 
 printf("Token Atribuicao: %s\n",yytext); 
 return (RECEBE);
}

{WHILE} { 
 printf("Token Repeticao WHILE: %s\n",yytext); 
 return (WHILE);
}

{FOR} {
    printf("Token Repeticao FOR: %s\n", yytext);
    return (FOR);
}


{IF} { 
  printf("Token Condicional IF: %s\n",yytext); 
 return (IF);
}

{ELSE} { 
  printf("Token Condicioanl ELSE: %s\n",yytext); 
 return (ELSE);
}

 /* Caracteres Especiais */

{ABRE_PAR} { 
 printf("Token Caracter especial (: %s\n",yytext); 
 return (ABRE_PAR);
}

{FECHA_PAR} {
 printf("Token Caracter especial ): %s\n",yytext);
 return (FECHA_PAR);
}

{ABRE_CHAVE} { 
 printf("Token Caracter especial {: %s\n",yytext); 
 return (ABRE_CHAVE);
}

{FECHA_CHAVE} { 
 printf("Token Caracter especial }: %s\n",yytext); 
 return (FECHA_CHAVE);
}

{PONT_VIRG} {
    printf("Token Caracter especial ;: %s\n",yytext);
    return (PONT_VIRG);
}

 /* Operadores Logicos */

{MAIOR} { 
 printf("Token Operador Logico >: %s\n",yytext); 
 return (MAIOR);
}

{MENOR} { 
 printf("Token Operador Logico <: %s\n",yytext); 
 return (MENOR);
}

{DIF} { 
 printf("Token Operador Logico !=: %s\n",yytext); 
 return (DIF);
}

{IGUAL} { 
 printf("Token Operador Logico ==: %s\n",yytext); 
 return (IGUAL);
}

 /* Operadores Aritmeticos */

{ADD} { 
 printf("Token Operador Aritmetico +: %s\n",yytext); 
 return (ADD);
}

{SUB} { 
 printf("Token Operador Aritmetico -: %s\n",yytext); 
 return (SUB);
}

{MULT} { 
 printf("Token Operador Aritmetico *: %s\n",yytext); 
 return (MULT);
}

{DIV} { 
 printf("Token Operador Aritmetico /: %s\n",yytext); 
 return (DIV);
}

 /* Variaveis */

{VARIAVEL} { 
  printf("Token Variavel: %s\n",yytext); 
 return (VARIAVEL);
}

 /* Erros Lexicos */

{DIGITO}+{VARIAVEL} { 
	printf("Token invalido: %s\n",yytext);
	erros++;
	
}

{DIGITO}*"."{VARIAVEL} { 
	printf("Token invalido: %s\n",yytext);
	erros++;
	
}

{DIGITO}+"." {
    printf("Token invalido: %s\n", yytext);
    erros++;
}

{DIGITO}*","{DIGITO} { 
	printf("Token invalido: %s\n",yytext);
	erros++;
	
}

"."{DIGITO}* { 
	printf("Token invalido: %s\n",yytext);
	erros++;
}



. {
printf("Token inválido: %s - ",yytext);
erros++;
printf("Linha: %d\n", Linhas);
} 

%%

int yywrap();



int yywrap() {
return 1;
}























