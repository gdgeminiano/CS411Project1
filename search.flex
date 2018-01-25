/*
* Search through source flagging any
* occurrances of pattern (a|b)*abb
* found.
*/
%%
%standalone
Letter = [a-zA-Z]
Digit = [0-9]

Identifier = [:jletter:] [:jletterdigit:]*

/* INTEGER CONSTANT */
DecInteger= 0 | [1-9][0-9]*
HexInteger = 0[xX][0-9A-Fa-f]+


%%

/* KEYWORDS*/
boolean {System.out.println("boolean");}
break {System.out.println("break");}
class {System.out.println("class");}
double {System.out.println("double");}
else {System.out.println("else");}
extends {System.out.println("extends");}
false {System.out.println("false");}
for {System.out.println("for");}
if {System.out.println("if");}
implements {System.out.println("implements");}
int {System.out.println("int");}
interface {System.out.println("interface");}
newarray {System.out.println("newarray");}
println {System.out.println("println");}
readln {System.out.println("readln");}
return {System.out.println("return");}
string {System.out.println("string");}
true {System.out.println("true");}
void {System.out.println("void");}
while {System.out.println("while");}

/* IDENTIFIER */
{Identifier} {System.out.println("id");}

/* WHITESPACE*/

/* INTEGER CONSTANT*/
{DecInteger}|{HexInteger} {System.out.println("intconstant");}
/* DOUBLE CONSTANT */




\n { /* do nothing */}
. { /* do nothing */}
