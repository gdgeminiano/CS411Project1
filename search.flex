
import java.io.*;

%%
%standalone
%{
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
  boolean         {writeTo("boolean ");}
  break           {writeTo("break ");}
  class           {writeTo("class ");}
  double          {writeTo("double ");}
  else            {writeTo("else ");}
  extends         {writeTo("extends ");}
  for             {writeTo("for ");}
  if              {writeTo("if ");}
  implements      {writeTo("implements ");}
  int             {writeTo("int ");}
  interface       {writeTo("interface ");}
  newarray        {writeTo("newarray ");}
  println         {writeTo("println ");}
  readln          {writeTo("readln ");}
  return          {writeTo("return ");}
  string          {writeTo("string ");}
  void            {writeTo("void ");}
  while           {writeTo("while ");}

  /* BOOLEAN CONSTANT */
  true            {writeTo("booleanconstant ");}
  false           {writeTo("booleanconstant ");}

  /* IDENTIFIER */
  {Identifier}    {writeTo("id ");}

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
  \\.             { throw new RuntimeException("Illegal escape sequence \""+yytext()+"\""); }
  {EndOfLine}     { throw new RuntimeException("Unterminated string at end of line"); }

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
