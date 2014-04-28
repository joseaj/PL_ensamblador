#ifndef NODO_H
#define NODO_H

#include <string>

class Nodo {
public:
	virtual std::string ass() const = 0;
	virtual std::string to_string() const = 0;
	virtual ~Nodo() {}
private:
};

class NodoUnario : public Nodo {
public:
	NodoUnario(Nodo& n) : n(&n_) {}
	virtual ~NodoUnario() {delete n; n= 0;}
protected:
	Nodo *n;
};

class NodoBinario : public Nodo {
public:
	NodoBinario(Nodo& n1_, Nodo& n2_) : n1(&n1_), n2(&n2_) {}
	virtual ~NodoBinario() {delete n1; delete n2; n1 = n2 = 0;}
protected:
	Nodo *n1, *n2;
};

class NodoAsig : public NodoBinario {
public:
	NodoAsig(Nodo& n1_, Nodo& n2_) : NodoBinario(n1_, n2_) {}
	virtual std::string ass() const {/*Pendiente*/}
	virtual std::string to_string() const {return n1->to_string() + std::string(":= ") + n2->to_string();}
};

class NodoSuma : public NodoBinario {
public:
	NodoSuma(Nodo& n1_, Nodo& n2_) : NodoBinario(n1_, n2_) {}
	virtual std::string ass() const {return n1->ass()+std::string("\tpushl\t%eax\n")+ 
	n2->std::string("\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\taddl\t%ebx, %eax\n");}

	virtual std::string to_string() const {return n1->to_string() + std::string(" + ") + n2->to_string();}
};

class NodoResta : public NodoBinario {
public:
	NodoResta(Nodo& n1_, Nodo& n2_) : NodoBinario(n1_, n2_) {}
	virtual std::string ass() const {return n1->ass()+std::string("\tpushl\t%eax\n")+ 
	n2->std::string("\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tsubl\t%ebx, %eax\n");}
	
	virtual std::string to_string() const {return n1->to_string() + std::string(" - ") + n2->to_string();}
};

class NodoMul : public NodoBinario {
public:
	NodoMul(Nodo& n1_, Nodo& n2_) : NodoBinario(n1_, n2_) {}
	virtual std::string ass() const {return n1->ass()+std::string("\tpushl\t%eax\n")+ 
	n2->std::string("\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\timull\t%ebx, %eax\n");}
	
	virtual std::string to_string() const {return n1->to_string() + std::string(" * ") + n2->to_string();}
};

class NodoDiv : public NodoBinario {
public:
	NodoDiv(Nodo& n1_, Nodo& n2_) : NodoBinario(n1_, n2_) {}
	virtual std::string ass() const {return n1->ass()+std::string("\tpushl\t%eax\n")+ 
	n2->std::string("\tmovl\t%eax, %ebx\n\tpopl\t%eax\n\tcdq\n\tidivl\t%ebx, %eax\n");}
	
	virtual std::string to_string() const {return n1->to_string() + std::string(" / ") + n2->to_string();}
};

#endif