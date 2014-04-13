%{
#include <iostream>
#include <string>

using namespace std;

#include "parser.tab.h"
%}

%option noyywrap

%%

[ \n\t\r]+                 ;
"//".*                     ;

[-+*/%();]                  return *yytext;

[0-9]+                     {yylval.nombre = new string(yytext); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]*     {yylval.nombre = new string(yytext); return ID;}

.                          cerr << "Error léxico, caracter (" << yytext << ") desconocido\n";

