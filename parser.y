%{
#include <iostream>
#include <string>

using namespace std;

#include "nodo.h"

#define YYERROR_VERBOSE

int yylex();
int yyerror(const char*);

%}

%token NUM ID VARIABLE FUNCION

%union {
  std::string * nombre;
  int valor;
  class Nodo *n;
}

%type <nombre> NUM ID
%type <n> expr aritm sum factor


%%

entrada: entrada defGlobal
       |
       ;

defGlobal : VARIABLE vars ';'
          | VARIABLE ID '=' FUNCION '('  ')' '{' exprs '}'
          | VARIABLE ID '=' FUNCION '(' vars  ')' '{' exprs '}'
          ;

vars : vars ',' ID
     | ID
     ;

exprs : exprs expr {cout << $2->ensamblador() << endl;}
      |
      ;

expr : VARIABLE vars ';' {$$ = 0;}
     | ID '=' aritm ';' {$$ = new NodoAsig(*$1, $3);}
     | aritm ';' {$$ = new NodoAritmetico($1);}
     ;

aritm: aritm '+' sum {$$ = new NodoSuma($1, $3);}
     | aritm '-' sum {$$ = new NodoResta($1, $3);}
     | sum {$$ = $1;}
     ;

sum: sum '*' factor {$$ = new NodoProducto($1, $3);}
   | sum '/' factor {$$ = new NodoDivision($1, $3);}
   | sum '%' factor {$$ = new NodoModulo($1, $3);}
   | factor {$$ = $1;}
   ;

factor: '(' aritm ')' {$$ = $2;}
      | NUM   {$$ = new NodoNum(*$1);}
      | ID    {$$ = new NodoID(*$1);}
      | '-' factor {$$ = new NodoMenosUnario($2);}
      ;

%%

int main() {
  cout << "\t.section\t.rodata\ncadena:\t.string\t\"Resultado = %d\\n\"\n\n\t.text\n\t.globl\tmain\nmain:\n";
  cout << "\tpushl\t%ebp\n\tmovl\t%esp, %ebp\n\n";

  yyparse();

  cout << "\n\tmovl\t$0, %eax\n\tmovl\t%ebp, %esp\n\tpopl\t%ebp\n\tret\n";
}

int yyerror(const char* msg) {
  cerr << msg << endl;
}

