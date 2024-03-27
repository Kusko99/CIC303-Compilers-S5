/**
 * Analisador léxico para expressões simples
 */
package exemplo2;

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
    // Buffer para armazenar as cadeias de caracteres
    private StringBuffer buffer = new StringBuffer();
%}

%{
// Macros
%}

%xstate IN_STR

delim	= [\ \t\n]
ws		= {delim}+
letter	= [A-Za-z]
digit	= [0-9]
id		= {letter}({letter}|{digit})*
number	= {digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%
/* Regras e ações */
<YYINITIAL> {
    "\"" 	    { yybegin(IN_STR); buffer.setLength(0); }
    {ws}		{ /* ignorar */ }
    if			{ return new Token(Tag.IF); }
    then		{ return new Token(Tag.THEN); }
    else		{ return new Token(Tag.ELSE); }
    {id}		{ return new Id(yytext()); }
    {number}	{ return new Num(Double.parseDouble(yytext())); }
    "<"			{ return new Relop(Tag.LT);}
    "<="		{ return new Relop(Tag.LE);}
    "="			{ return new Relop(Tag.EQ);}
    "<>"		{ return new Relop(Tag.NE);}
    ">"			{ return new Relop(Tag.GT);}
    ">="		{ return new Relop(Tag.GE);}
    /* Qualquer outro - gerar erro */
    .		    { throw new Error("Símbolo ilegal <" + yytext() +
                    "(" + (int)(yytext().charAt(0)) + ")" + ">"); }
}
<IN_STR> {
	"\""		{ yybegin(YYINITIAL); 
				    return new Str(buffer.toString()); }
	.|{delim}	{ buffer.append(yytext()); }
}