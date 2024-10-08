%{
// AUTHOR : Kevin Dong
// DATE   : 9/23/24
/*PURPOSE: A lex/flex file to implement 
           the lexical analyzer in the 
           main.cpp file, using the 
           Token class. */

#include <iostream>
#include <map>
#include <string>

using namespace std;

/* 
    Map that holds all the reserved keywords  
    name and their enum number from Token class,
    respectivity. 
*/
map<string, int> keywords = {
    {"void",24},
    {"int",25},
    {"float",26},
    {"begin",27},
    {"end",28},
    {"if",29},
    {"then",30},
    {"else",31},
    {"while",32}
};

%}

/* DEFINE SECTION*/ 
%option c++
%option noyywrap

/* Whitespace, tab, and newline */
WSPACE          [\ \t\n] 

NZ_DIGIT        [1-9]
DIGIT           [0-9]

/* Resource credit for [a-zA-Z]: https://www.geeksforgeeks.org/flex-fast-lexical-analyzer-generator/*/
ALPHA           [a-zA-Z]

/* RULE SECTION */
%%
"*"  {return 6;} 
"/"  {return 6;}
"+"  {return 5;}
"-"  {return 5;}
"("  {return 21;}
")"  {return 20;}
"["  {return 17;}
"]"  {return 18;}
";"  {return 16;}
","  {return 19;}
"~"  {return 22;}

"&"  {} /* Not a final state => do nothing */
"&&" {return 13;}

"|"  {} /* Not a final state => do nothing */
"||" {return 15;}

"<"  {return 10;}
"<-" {return 11;}
"<=" {return 8;}
">"  {return 7;}
">=" {return 8;}

"="  {} /* Not a final state => do nothing */
"==" {return 8;}

"#".* {} /* Handles comments: match anything after a comment, if any, up to the newline */

{WSPACE}+ {} /* Do nothing for one or more spaces, tabs, or new lines. */

"0" {return 2;} /* Handles the number zero:                            (EX: 0, 00, 0 0 0) */
{NZ_DIGIT}+ {return 2;} /* Handles one or more NONZERO numbers         (EX: 111 2222 999) */ 
{NZ_DIGIT}{DIGIT}* {return 2;} /* Handles double digit numbers         (EX: 122 123, 987) */
{NZ_DIGIT}{DIGIT}*"."{DIGIT}* {return 4;} /* Handles decimal numbers:  (EX: 123.9 124.0 99.09) */
{DIGIT}{DIGIT}*"."{DIGIT}* {return 4;} /* Handles x<=0 (0)+.(0)+       (EX: 0.0, 0.00, 0.08)*/

{ALPHA}+ { /* Handles one or more letters*/

    // Check if ID is a reserved keyword
    string id(yytext);
    if (keywords.find(id) != keywords.end()) //a reserved keyword!
        return (keywords[id]);
    else //an ID
        return 1;
} 

{ALPHA}+({DIGIT}*{ALPHA}*)* {return 1;} /* Requires at least one lowercase or uppercase letter followed by one or more occurrences of either as many DIGIT or as many ALPHA */

<<EOF>> {return 23;} /* Handles end of file. Credit: https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC13*/
%%
