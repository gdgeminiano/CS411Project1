import java.io.*;

%%
%class ToyLexScanner
%standalone

%init{
    Trie dataTrie = new Trie();
    createFile();

%init}

%{

  // Print trie table
  public void printTrie()
    {
      dataTrie.print("OUTPUT.txt");
    }

  // Insert token/string into trie table
  public boolean insertData(String str)
  {
      return dataTrie.insert(str);
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
  true            {writeTo("booleanconstant ");
                    dataTrie.insert(yytext());}
  false           {writeTo("booleanconstant ");
                    dataTrie.insert(yytext());}

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
                    dataTrie.insert(yytext());}
  /* ILLEGAL IDENTIFIER */
  {UnderScore}({Letter}|{Digit}|{UnderScore})+  { throw new RuntimeException("Illegal identifier\""+yytext()+"\""); }

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
  // Begin checking string by going to state STRING
  \"              {yybegin(STRING);}

  /* COMMENTS */
  {Comment}       {writeTo("\r\n");}

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
