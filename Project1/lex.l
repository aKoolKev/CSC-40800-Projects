%{
#include <iostream>
// #include "Token.hpp"
using namespace std;

%}

%option c++
%option noyywrap

WSPACE      [\ \t\n]

NZ_DIGIT    [1-9]
DIGIT       [0-9]

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


<<EOF>> {return 23;}


.                             {cout <<" UNKNOWN <" << yytext[0] << ">" << endl;
                               return 99;}

%%
