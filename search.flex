/*
* Search through source flagging any
* occurrances of pattern (a|b)*abb
* found.
*/
%%
%standalone
Letter = [a-zA-Z]
Digit = [0-9]
UnderScore = "_"

Identifier = {Letter}({Letter}|{Digit}|{UnderScore})*

DecInteger= 0 | [1-9][0-9]*
HexInteger = 0[xX][0-9A-Fa-f]+

DoubleConst= [0-9]+\.[0-9]*([eE][\+\-]?[0-9]+)

WhiteSpace = [ \t\n]+

Character = [^\"\\\n\r]

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
MultiLineComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"


SingleLineComment = "//" {InputCharacter}* {LineTerminator}?
Comment = {MultiLineComment} | {SingleLineComment}

%%

/* KEYWORDS*/
boolean     {System.out.print("boolean ");}
break       {System.out.print("break ");}
class       {System.out.print("class ");}
double      {System.out.print("double ");}
else        {System.out.print("else ");}
extends     {System.out.print("extends ");}
for         {System.out.print("for ");}
if          {System.out.print("if ");}
implements  {System.out.print("implements ");}
int         {System.out.print("int ");}
interface   {System.out.print("interface ");}
newarray    {System.out.print("newarray ");}
println     {System.out.print("println ");}
readln      {System.out.print("readln ");}
return      {System.out.print("return ");}
string      {System.out.print("string ");}
void        {System.out.print("void ");}
while       {System.out.print("while ");}

/* IDENTIFIER */
{Identifier} {System.out.print("id ");}

/* INTEGER CONSTANT*/
{DecInteger}|{HexInteger} {System.out.print("intconstant ");}

/* DOUBLE CONSTANT */
{DoubleConst} {System.out.print("doubleconstant ");}

/* BOOLEAN CONSTANT */
true        {System.out.print("booleanconstant");}
false       {System.out.print("booleanconstant");}

/* OPERATORS and PUNCTUATIONS*/
"+"       {System.out.print("plus ");}
"-"       {System.out.print("minus ");}
"*"       {System.out.print("mult ");}
"/"       {System.out.print("div ");}
"%"       {System.out.print("mod ");}
"<"       {System.out.print("less ");}
"<="      {System.out.print("lesseq ");}
">"       {System.out.print("greater ");}
">="      {System.out.print("greatereq ");}
"=="      {System.out.print("eqeq ");}
"!="      {System.out.print("noteq ");}
"&&"      {System.out.print("andand ");}
"||"      {System.out.print("oror ");}
"!"       {System.out.print("not ");}
"="       {System.out.print("eq ");}
";"       {System.out.print("semicolon ");}
","       {System.out.print("comma ");}
"."       {System.out.print("period ");}
"("       {System.out.print("leftparen ");}
")"       {System.out.print("rightparen ");}
"["       {System.out.print("leftbrac ");}
"]"       {System.out.print("rightbrac ");}
"{"       {System.out.print("leftbrace ");}
"}"       {System.out.print("rightbrace ");}

/* COMMENTS */
{Comment}       {System.out.print("\n");}

\n {System.out.print("\n");}
. { /* do nothing */}
