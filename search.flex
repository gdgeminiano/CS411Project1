
import java.io.*;

%%
%class ToyLexScanner
%standalone

%init{
    dataTrie = new Trie();
    createFile();

%init}

%{

  public boolean insertData(String str)
  {
      return dataTrie.insert(str);
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
                   dataTrie.insert(yytext());}
  break           {writeTo("break ");
                   dataTrie.insert(yytext());}
  class           {writeTo("class ");
                   dataTrie.insert(yytext());}
  double          {writeTo("double ");
                   dataTrie.insert(yytext());}
  else            {writeTo("else ");
                   dataTrie.insert(yytext());}
  extends         {writeTo("extends ");
                   dataTrie.insert(yytext());}
  for             {writeTo("for ");
                   dataTrie.insert(yytext());}
  if              {writeTo("if ");
                   dataTrie.insert(yytext());}
  implements      {writeTo("implements ");
                    dataTrie.insert(yytext());}
  int             {writeTo("int ");
                    dataTrie.insert(yytext());}
  interface       {writeTo("interface ");
                    dataTrie.insert(yytext());}
  newarray        {writeTo("newarray ");
                    dataTrie.insert(yytext());}
  println         {writeTo("println ");
                    dataTrie.insert(yytext());}
  readln          {writeTo("readln ");
                    dataTrie.insert(yytext());}
  return          {writeTo("return ");
                    dataTrie.insert(yytext());}
  string          {writeTo("string ");
                    dataTrie.insert(yytext());}
  void            {writeTo("void ");
                    dataTrie.insert(yytext());}
  while           {writeTo("while ");
                    dataTrie.insert(yytext());}

  /* BOOLEAN CONSTANT */
  true            {writeTo("booleanconstant ");}
  false           {writeTo("booleanconstant ");}

  /* IDENTIFIER */
  {Identifier}    {writeTo("id ");
                    dataTrie.insert(yytext());}

  /* INTEGER CONSTANT*/
  {Integer}       {writeTo("intconstant ");}

  /* DOUBLE CONSTANT */
  {DoubleConst}   {writeTo("doubleconstant ");}

  /* OPERATORS and PUNCTUATIONS*/
  "+"             {writeTo("plus ");}
  "-"             {writeTo("minus ");}
  "*"             {writeTo("mult ");}
  "/"             {writeTo("div ");}
  "%"             {writeTo("mod ");}
  "<"             {writeTo("less ");}
  "<="            {writeTo("lesseq ");}
  ">"             {writeTo("greater ");}
  ">="            {writeTo("greatereq ");}
  "=="            {writeTo("eqeq ");}
  "!="            {writeTo("noteq ");}
  "&&"            {writeTo("andand ");}
  "||"            {writeTo("oror ");}
  "!"             {writeTo("not ");}
  "="             {writeTo("eq ");}
  ";"             {writeTo("semicolon ");}
  ","             {writeTo("comma ");}
  "."             {writeTo("period ");}
  "("             {writeTo("leftparen ");}
  ")"             {writeTo("rightparen ");}
  "["             {writeTo("leftbrac ");}
  "]"             {writeTo("rightbrac ");}
  "{"             {writeTo("leftbrace ");}
  "}"             {writeTo("rightbrace ");}

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
  \"              { yybegin(YYINITIAL); writeTo("string "); }

  /* STRING CHARACRERS */
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
