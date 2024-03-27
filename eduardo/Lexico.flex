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
%eof}

%{
    
private enum Tag {
    EOF, ID, NUMBER, IF, THEN, ELSE, WHILE, DO, LET, IN, BEGIN, END, LT, EQ, GT, MULT, PLUS, MINUS, DIV, BACKSLASH, SEMICOLON, LPAREN, RPAREN, ASSIGN, CONST, VAR, TILDE, COLON
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

private class Word extends Token {
    private final String lexeme;
    public Word(Tag tag, String lexeme) {
        super(tag);
        this.lexeme = lexeme;
    }

    @Override
    public String toString() {
        return "Word: <" + this.tag + ",\"" + this.lexeme + "\">";
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
"if"        { return new Word(Tag.IF);}
"then"      { return new Word(Tag.THEN);}
"else"      { return new Word(Tag.ELSE);}
"while"     { return new Word(Tag.WHILE);}
"do"        { return new Word(Tag.DO);}
"let"       { return new Word(Tag.LET);}
"in"        { return new Word(Tag.IN);}
"begin"     { return new Word(Tag.BEGIN);}
"end"       { return new Word(Tag.END);}

"<"			{ return new Word(Tag.LT, yytext());}
"="			{ return new Word(Tag.EQ, yytext());}
">"			{ return new Word(Tag.GT, yytext());}
"*"			{ return new Word(Tag.MULT, yytext());}
"+"			{ return new Word(Tag.PLUS, yytext());}
"-"			{ return new Word(Tag.MINUS, yytext());}
"/"			{ return new Word(Tag.DIV, yytext());}
"\\\\"		{ return new Word(Tag.BACKSLASH, yytext());}
":="		{ return new Word(Tag.ASSIGN, yytext()); }
";"			{ return new Word(Tag.SEMICOLON, yytext()); }
"("			{ return new Word(Tag.LPAREN, yytext()); }
")"			{ return new Word(Tag.RPAREN, yytext()); }
"const"     { return new Word(Tag.CONST, yytext()); }
"var"       { return new Word(Tag.VAR, yytext()); }
"~"         { return new Word(Tag.TILDE, yytext()); }
":"         { return new Word(Tag.COLON, yytext()); }
{identifier}		{ return new Id(yytext()); }
{integer_literal}	{ return new Num(Double.parseDouble(yytext())); }
