/*
* CS 411 Project 1 Lexical Analyzer
* Name: Gerianna Geminiano, Andrew Quach
*/
import java.io.*;

%%
%class ToyLexScanner
%standalone

%init{
    Trie dataTrie = new Trie(500);
    createFile();

%init}

%{

  // Print trie table
  public void printTrie()
    {
      dataTrie.print("OUTPUT.txt");
    }

  // Print the tokens as their associated integers
    public void printLexerOutput()
    {
        writeTo(lexerOutput);
    }

  // Overwrite file OUTPUT.txt
  public void createFile(){
    try (BufferedWriter bw = new BufferedWriter(new FileWriter("OUTPUT.txt",false))) {
    bw.write("");
    bw.close();
    } catch (IOException e) {
        e.printStackTrace();
        }
  }

  //Append to file OUTPUT.txt
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

// ID = a Letter followed by a sequene of 0 or more Letters, Digits, or Underscores,
Identifier = {Letter}({Letter}|{Digit}|{UnderScore})*

// Decimal = 0 or [1-9] followed by a sequnce zero or more digits
DecInteger= 0 | [1-9][0-9]*

// Hex = 0x or 0X followed by 1 or more digits or the letters a-f or A-F
HexInteger = 0[xX][0-9A-Fa-f]+

// Integer can be in decimal or hexadecimal
Integer = {DecInteger}|{HexInteger}

/*Double = at least 1 digit ([0-9]+) followed by a period (\.)
 followed by zero or more digits ([0-9]*). The exponent is optional (?).
 Sign of exponent is optional ([\+\-]?). Exponent can be upper or lower
 case ([eE]). One or more digits must follow exponent ([0-9]+)
 */
DoubleConst= [0-9]+\.[0-9]*([eE][\+\-]?[0-9]+)?

// White space can be blank or tabs
WhiteSpace = [ \t]+

// White space can also be new line/end of line
EndOfLine = \r|\n|\r\n

// Single Line comment cannt include return or newline inside ([^\r\n])
CommentChar = [^\r\n]
// SingleLineComment = // followed by valid charcter and stops when there an end of line char
SingleLineComment = "//" {CommentChar}* {EndOfLine}?

// MultLineComment = /* followed by anything until (~) you reach */  OR
// /* with anything but */ in the middle and ends with */ (no nesting)
MultiLineComment = "/*" ~"*/" | "/*" [^"*/"]* "*/"

// Comment is either single line or multi line
Comment = {MultiLineComment} | {SingleLineComment}

// String cannot include a new line (\r\n) or double qoute (")
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

  /* Errors for Illegal Char */
  "~"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "@"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "#"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "$"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "^"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "|"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "?"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  ":"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }
  "'"  { throw new RuntimeException("Illegal character \""+yytext()+"\""); }

  /* IDENTIFIER */
  {Identifier}    {writeTo("id ");
                    dataTrie.insert(yytext());
                    lexerOutput += " " + Sym.ID;}

  /* ILLEGAL IDENTIFIER */
  {UnderScore}({Letter}|{Digit}|{UnderScore})+  { throw new RuntimeException("Illegal identifier\""+yytext()+"\""); }

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
  // Begin checking string by going to state STRING
  \"              {yybegin(STRING);}

  /* COMMENTS */
  {Comment}       {writeTo("\n");}

  {WhiteSpace}    { /* do nothing */}

  \n              {writeTo("\r\n");}

  .               { /* do nothing */}
}

<STRING> {
  /* ERRORS */
  \\.             { throw new RuntimeException("Illegal new line \""+yytext()+"\" in string."); }
  {EndOfLine}     {throw new RuntimeException("Unterminated string at end of line"); }

  /* END OF STRING */
  // Go back to inital state and read as normal
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
