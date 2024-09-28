%{
#include <iostream>
#include <map>
#include <string>
using namespace std;

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

WSPACE          [\ \t\n]

NZ_DIGIT        [1-9]
DIGIT           [0-9]

/*CREDIT: https://www.geeksforgeeks.org/flex-fast-lexical-analyzer-generator/*/
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

"&"  {} /* Not a final state, do nothing */
"&&" {return 13;}

"|"  {} /* Not a final state, do nothing */
"||" {return 15;}

"<"  {return 10;}
"<-" {return 11;}
"<=" {return 8;}

">"  {return 7;}
">=" {return 8;}

"="  {} /* Not a final state, do nothing */
"==" {return 8;}


{WSPACE}+ {} /* Do nothing for one or more spaces, tabs, or new lines. */


"0" {return 2;} /* Handles the number zero */
{NZ_DIGIT}+ {return 2;} /* Handles one or more NONZERO numbers */ 
{NZ_DIGIT}{DIGIT}* {return 2;} /* Handles double digit numbers */
{NZ_DIGIT}{DIGIT}*"."{DIGIT}* {return 4;} /* Handles decimal numbers */
{DIGIT}{DIGIT}*"."{DIGIT}* {return 4;} /* Handles 0+.0+ case: 0.0, 0.00, 0.08*/

{ALPHA}+ {
    string id(yytext);
    if (keywords.find(id) != keywords.end()) //a reserved keyword!
    {
        return (keywords[id]);
    }
    else //an ID
    {
        return 1;
    }
} /* Handles one or more letters*/

{ALPHA}+({DIGIT}|{ALPHA})+ {return 1;} /* Requires at least one lowercase or uppercase letter followed by one or more occurrences of either DIGIT or more ALPHA*/

<<EOF>> {return 23;} /* Handles end of file. Credit: https://ftp.gnu.org/old-gnu/Manuals/flex-2.5.4/html_mono/flex.html#SEC13*/


. {cout <<" UNKNOWN <" << yytext[0] << ">" << endl; return 99;} /* For debugging and unknown tokens*/
%%
