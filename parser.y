%{
#include <iostream>
#include <string>

using namespace std;

#define YYERROR_VERBOSE

int yylex();
int yyerror(const char*);

%}

%token NUM ID

%union {
  std::string * nombre;
  int valor;
}

%type <nombre> NUM ID


%%

entrada: expr {cout << "\n\tpushl\t%eax\n\tpushl\t$cadena\n\tcall\tprintf\n\taddl\t$8, %esp\n\n";} ';' entrada
       |
       ;

expr: expr '+' {cout << "\tpushl\t%eax\n";} sum {cout << "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\taddl\t%ebx, %eax\n";}
    | expr '-' {cout << "\tpushl\t%eax\n";} sum {cout << "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tsubl\t%ebx, %eax\n";}
    | sum
    ;

sum: sum '*' {cout << "\tpushl\t%eax\n";} factor {cout << "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\timull\t%ebx, %eax\n";}
   | sum '/' {cout << "\tpushl\t%eax\n";} factor {cout << "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tcdq\n\tidivl\t%ebx, %eax\n";}
   | sum '%' {cout << "\tpushl\t%eax\n";} factor {cout << "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tcdq\n\tidivl\t%ebx, %eax\n\tmovl\t%edx, %eax\n";}
   | factor
   ;

factor: '(' expr ')'
      | NUM   { cout << "\tmovl\t$" << *$1 << ", %eax\n";}
      | ID
      | '-' factor {cout << "\tneg\t%eax\n";}
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

