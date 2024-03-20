/**
 * Analisador léxico para expressões simples
 */
package Lexico;

%%

%class Lexer
%public
%unicode
%debug
%standalone
%line
%column
%type Token

%eofval{
    return new Token(Tag.EOF);
%eofval}

%eof{
    System.out.println("Análise léxica terminada com sucesso!");
%}

%{
    
private enum Tag {
    ID, NUMBER, IF, THEN, ELSE, WHILE, DO, LET, IN, BEGIN, END, LT, EQ, GT, MULT, PLUS, MINUS, DIV, BACKSLASH
}

private class Token {
    public final Tag tag;
    public Token(Tag t) {
        tag = t;
    }
    @Override
    public String toString() {
        return "Token: <" + tag + ">";
    }
}

private class Num extends Token {
    public final double value;
    public Num(double v) {
        super(Tag.NUMBER);
        value = v;
    }

    @Override
    public String toString() {
        return "Number: <" + this.tag + "," + this.value + ">";
    }
}

private class Id extends Token {
    public final String lexeme;
    public Id(String s) {
        super(Tag.ID);
        lexeme = new String(s);
    }

    @Override
    public String toString() {
        return "ID: <" + this.tag + ",\"" + this.lexeme + "\">";
    }
}

private class Relop extends Token {
    public final Tag op;
    public Relop(Tag op) {
        super(Tag.RELOP);
        this.op = op;
    }

    @Override
    public String toString() {
        return "RELOP: <" + this.tag + ",\"" + this.op + "\">";
    }
}

%}

%{
// Macros
%}

letter	= [A-Za-z]
digit	= [0-9]
identifier = {letter}({letter}|{digit})*
integer_literal = {digit}({digit})*

%%
"if"        { return new Relop(Tag.IF);}
"then"      { return new Relop(Tag.THEN);}
"else"      { return new Relop(Tag.ELSE);}
"while"     { return new Relop(Tag.WHILE);}
"do"        { return new Relop(Tag.DO);}
"let"       { return new Relop(Tag.LET);}
"in"        { return new Relop(Tag.IN);}
"begin"     { return new Relop(Tag.BEGIN);}
"end"       { return new Relop(Tag.END);}

"<"			{ return new Relop(Tag.LT);}
"="			{ return new Relop(Tag.EQ);}
">"			{ return new Relop(Tag.GT);}
"*"			{ return new Relop(Tag.MULT);}
"+"			{ return new Relop(Tag.PLUS);}
"-"			{ return new Relop(Tag.MINUS);}
"/"			{ return new Relop(Tag.DIV);}
"\"			{ return new Relop(Tag.BACKSLASH);}
{identifier}		{ return new Id(yytext()); }
{integer_literal}	{ return new Num(Double.parseDouble(yytext())); }