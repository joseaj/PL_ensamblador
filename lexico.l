%{
#include <iostream>
#include <string>

using namespace std;

#include "parser.tab.h"

#ifdef YY_INPUT
#undef YY_INPUT
#endif
#define YY_INPUT(buf,result,max_size) \
   if (fgets(buf,max_size,yyin) != NULL) { \
      result = strlen(buf); \
      printf("## %s",buf);} \
   else if (! ferror(yyin)) \
      result = YY_NULL; \
   else \
      YY_FATAL_ERROR("fgets() in flex scanner failed");
%}

%option noyywrap

%%

[ \n\t\r]+                 ;
"//".*                     ;

[-+*/%();{}=,]                  return *yytext;

"var"                        return VARIABLE;
"function"                   return FUNCION;

[0-9]+                     {yylval.nombre = new string(yytext); return NUM;}
[a-zA-Z_][a-zA-Z0-9_]*     {yylval.nombre = new string(yytext); return ID;}

.                          cerr << "Error léxico, caracter (" << yytext << ") desconocido\n";

