Class: CS411

Assignment: Project1

Names: Gerianna Geminiano
       
        Andrew Quach

Program: Implementing a lexical analyzer

Software Used: Jflex



Given:

- flex file: search.flex

- input files: SampleCode.txt
               
	       LexicalRules.txt

- java files: ToyLexScanner.java
              
              Trie.java
             
  	      Sym.java

- output file: OUTPUT.txt



Instructions:

- Go to command prompt

- Navigate to directory with flex, java and text files

- Compile java files:
              
		javac Trie.java
              
		javac ToyLexScanner.java

- Run ToyLexScanner program
              
		java ToyLexerScanner SampleCode.txt
              
             
		java ToyLexerScanner LexicalRules.txt

- Output will be written to OUTPUT.txt
. This file will include the list of tokens and the trie table

- Each time you test out a new text file, OUTPUT.txt is overwritten with
 the new outputs.


 
**IMPORTANT NOTE WHEN TESTING OUT TEXTFILE MAKE SURE TEXT FILE IS USING PROPER DOUBLE QUOTES**
