#ifndef NODO_H
#define NODO_H

#include <iostream>
#include <string>
#include <sstream> 

#include <typeinfo>

using namespace std;

/*
class Nodo;
extern map<string, Nodo *> tabla;
*/

/************* clase abstracta *************************/

class Nodo {
public:
	virtual string ensamblador() = 0;
	virtual string toStr() = 0;
} ; // fin de la clase abstracta Nodo

/************ clases derivadas *************************/

class NodoNum : public Nodo{
	string num;
public:
	NodoNum(string num): num(num) {}
	string ensamblador(){
		return "\tmovl\t$" + num + ", %eax\n";
	}
	string toStr(){
		// stringstream ss;
  //  		ss << "NodoNum(" << num << ")\n";
  //  		return ss.str();
	}
};

class NodoID : public Nodo{
	string id;
public:
	NodoID(string id): id(id) {}
	string ensamblador(){
		return "\tmovl " + id + ", %eax\n";
	}
	string toStr(){
		return "NodoID(" + id + ")\n";
	}
};

class NodoMenosUnario : public Nodo{
	Nodo *n;
public:
	NodoMenosUnario(Nodo *n): n(n) {}
	string ensamblador(){
		return n->ensamblador() + "\tneg\t%eax\n";
	}
	string toStr(){
		//return "Nodo"
	}
};

class NodoProducto : public Nodo{
	Nodo *iz, *dr;
public:
	NodoProducto(Nodo *iz, Nodo *dr): iz(iz), dr(dr) {}
	string ensamblador(){
		return iz->ensamblador() + "\tpushl\t%eax\n" + 
		dr->ensamblador() +
		 "\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\timull\t%ebx, %eax\n";
	}
	string toStr(){
		//return
	}
};

class NodoDivision : public Nodo{
	Nodo *iz, *dr;
public:
	NodoDivision(Nodo *iz, Nodo *dr): iz(iz), dr(dr) {}
	string ensamblador(){
		return iz->ensamblador() + "\tpushl\t%eax\n" + 
		dr->ensamblador() +
		"\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tcdq\n\tidivl\t%ebx, %eax\n";
	}
	string toStr(){
		//return
	}

};

class NodoModulo : public Nodo{
	Nodo *iz, *dr;
public:
	NodoModulo(Nodo *iz, Nodo *dr): iz(iz), dr(dr) {}
	string ensamblador(){
		return iz->ensamblador() + "\tpushl\t%eax\n" + 
		dr->ensamblador() +
		"\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tcdq\n\tidivl\t%ebx, %eax\n\tmovl\t%edx, %eax\n";
	}
	string toStr(){
		//return
	}
};

class NodoSuma : public Nodo{
	Nodo *iz, *dr;
public:
	NodoSuma(Nodo *iz, Nodo *dr): iz(iz), dr(dr) {}
	string ensamblador(){
		return iz->ensamblador() + "\tpushl\t%eax\n" + 
		dr->ensamblador() +
		"\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\taddl\t%ebx, %eax\n";
	}
	string toStr(){
		//return
	}

};

class NodoResta : public Nodo{
	Nodo *iz, *dr;
public:
	NodoResta(Nodo *iz, Nodo *dr): iz(iz), dr(dr) {}
	string ensamblador(){
		return iz->ensamblador() + "\tpushl\t%eax\n" + 
		dr->ensamblador() +
		"\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tsubl\t%ebx, %eax\n";
	}
	string toStr(){
		//return
	}

};

class NodoAritmetico : public Nodo{
	Nodo *n;
public:
	NodoAritmetico(Nodo *n): n(n) {}
	string ensamblador(){
		return n->ensamblador() + 
		"\n\tpushl\t%eax\n\tpushl\t$cadena\n\tcall\tprintf\n\taddl\t$8, %esp\n\n";
	}
	string toStr(){

	}
};

class NodoAsig : public Nodo{
	string id;
	Nodo *n;
public:
	NodoAsig(string id, Nodo *n): id(id), n(n) {}
	string ensamblador(){
		return n->ensamblador() + "\n\tmovl %eax, " + id + "\n"
		+ "\n\tpushl\t%eax\n\tpushl\t$cadena\n\tcall\tprintf\n\taddl\t$8, %esp\n\n";
	}
	string toStr(){

	}
};

/*class NodoSecuencia{

};*/


#endif