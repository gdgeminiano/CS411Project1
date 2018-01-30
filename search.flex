
import java.io.*;

%%
%class ToyLexScanner
%standalone

%init{
    Trie dataTrie = new Trie(500);
    createFile();

%init}

%{

  public void printTrie()
    {
      dataTrie.print("OUTPUT.txt");
    }

  public void printLexerOutput()
    {
        writeTo(lexerOutput);
    }

  public void createFile(){
    try (BufferedWriter bw = new BufferedWriter(new FileWriter("OUTPUT.txt",false))) {
    bw.write("");
    bw.close();
    } catch (IOException e) {
        e.printStackTrace();
        }
  }

  public void writeTo(String token){
    try (BufferedWriter bw = new BufferedWriter(new FileWriter("OUTPUT.txt",true))) {
			bw.write(token);
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
  }
%}

Letter = [a-zA-Z]
Digit = [0-9]
UnderScore = "_"

Identifier = {Letter}({Letter}|{Digit}|{UnderScore})*

DecInteger= 0 | [1-9][0-9]*
HexInteger = 0[xX][0-9A-Fa-f]+

Integer = {DecInteger}|{HexInteger}

DoubleConst= [0-9]+\.[0-9]*([eE][\+\-]?[0-9]+)?

WhiteSpace = [ \t]+

EndOfLine = \r|\n|\r\n
CommentChar = [^\r\n]
MultiLineComment = "/*" ~"*/" | "/*" [^"*/"]* "*/"
SingleLineComment = "//" {CommentChar}* {EndOfLine}?
Comment = {MultiLineComment} | {SingleLineComment}

StringChar = [^\r\n\"\\. ]

%state STRING
%%

<YYINITIAL> {

  /* KEYWORDS */
  boolean         {writeTo("boolean ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.BOOL;}
  break           {writeTo("break ");
                   dataTrie.insert(yytext());
                   lexerOutput += " " + Sym.BREAK;}
  class           {writeTo("class ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.CLASS;}
  double          {writeTo("double ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.DOUBLE;}
  else            {writeTo("else ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.ELSE;}
  extends         {writeTo("extends ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.EXTENDS;}
  for             {writeTo("for ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.FOR;}
  if              {writeTo("if ");
                   dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.IF;}
  implements      {writeTo("implements ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.IMPLEMENTS;}
  int             {writeTo("int ");
                    dataTrie.insert(yytext());
                     lexerOutput += " " + Sym.INT;}
  interface       {writeTo("interface ");
                    dataTrie.insert(yytext());
                     lexerOutput += " " + Sym.INTERFACE;}
  newarray        {writeTo("newarray ");
                    dataTrie.insert(yytext());
                     lexerOutput += " " + Sym.NEWARRAY;}
  println         {writeTo("println ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.PRINTLN;}
  readln          {writeTo("readln ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.READLN;}
  return          {writeTo("return ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.RETURN;}
  string          {writeTo("string ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.STRING;}
  void            {writeTo("void ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.VOID;}
  while           {writeTo("while ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.WHILE;}

  /* BOOLEAN CONSTANT */
  true            {writeTo("booleanconstant ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.BOOL_CONST;}
  false           {writeTo("booleanconstant ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.BOOL_CONST;}

  /* IDENTIFIER */
  {Identifier}    {writeTo("id ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.ID;}

  /* INTEGER CONSTANT*/
  {Integer}       {writeTo("intconstant ");
                    lexerOutput += " " + Sym.INT_CONST;}

  /* DOUBLE CONSTANT */
  {DoubleConst}   {writeTo("doubleconstant ");
                    lexerOutput += " " + Sym.DOUBLE_CONST;}

  /* OPERATORS and PUNCTUATIONS*/
  "+"             {writeTo("plus ");
                    lexerOutput += " " + Sym.PLUS;}
  "-"             {writeTo("minus ");
                    lexerOutput += " " + Sym.MINUS;}
  "*"             {writeTo("mult ");
                    lexerOutput += " " + Sym.MULTI;}
  "/"             {writeTo("div ");
                    lexerOutput += " " + Sym.DIVIDE;}
  "%"             {writeTo("mod ");
                    lexerOutput += " " + Sym.MOD;}
  "<"             {writeTo("less ");
                    lexerOutput += " " + Sym.LESS;}
  "<="            {writeTo("lesseq ");
                    lexerOutput += " " + Sym.LESS_EQ;}
  ">"             {writeTo("greater ");
                    lexerOutput += " " + Sym.GTR;}
  ">="            {writeTo("greatereq ");
                    lexerOutput += " " + Sym.GTR_EQ;}
  "=="            {writeTo("eqeq ");
                    lexerOutput += " " + Sym.EQ;}
  "!="            {writeTo("noteq ");
                    lexerOutput += " " + Sym.NOT_EQ;}
  "&&"            {writeTo("andand ");
                    lexerOutput += " " + Sym.AND;}
  "||"            {writeTo("oror ");
                    lexerOutput += " " + Sym.OR;}
  "!"             {writeTo("not ");
                    lexerOutput += " " + Sym.NOT;}
  "="             {writeTo("eq ");
                    lexerOutput += " " + Sym.ASSIGN;}
  ";"             {writeTo("semicolon ");
                    lexerOutput += " " + Sym.SEMI;}
  ","             {writeTo("comma ");
                    lexerOutput += " " + Sym.COMMA;}
  "."             {writeTo("period ");
                    lexerOutput += " " + Sym.PERIOD;}
  "("             {writeTo("leftparen ");
                    lexerOutput += " " + Sym.LEFT_PAREN;}
  ")"             {writeTo("rightparen ");
                    lexerOutput += " " + Sym.RIGHT_PAREN;}
  "["             {writeTo("leftbrac ");
                    lexerOutput += " " + Sym.LEFT_BRKT;}
  "]"             {writeTo("rightbrac ");
                    lexerOutput += " " + Sym.RT_BRKT;}
  "{"             {writeTo("leftbrace ");
                    lexerOutput += " " + Sym.L_BRACE;}
  "}"             {writeTo("rightbrace ");
                    lexerOutput += " " + Sym.R_BRACE;}

  /* STRING CONSTANT */
  \"              {yybegin(STRING);}

  /* COMMENTS */
  {Comment}       {writeTo("\n");}

  {WhiteSpace}    { /* do nothing */}

  \n              {writeTo("\n");}
  .               { /* do nothing */}
}

<STRING> {
  /* ERRORS */
  \\.             { System.out.println("Illegal escape sequence \""+yytext()+"\""); }
  {EndOfLine}     { System.out.println("Unterminated string at end of line"); yybegin(YYINITIAL); }

  /* END OF STRING */
  \"              { yybegin(YYINITIAL); writeTo("string ");
                    lexerOutput += " " + Sym.STRING_CONST;}

  /* STRING CHARACTERS */
  {StringChar}+   { }

  /* escape sequences */
  "\\b"           { }
  "\\t"           { }
  "\\n"           { }
  "\\f"           { }
  "\\r"           { }
  "\\\""          { }
  "\\'"           { }
  "\\\\"          { }

}
