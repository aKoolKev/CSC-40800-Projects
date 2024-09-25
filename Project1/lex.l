%{
#include <iostream>
#include "Token.hpp"
using namespace std;

%}

%option c++
%option noyywrap

WSPACE    [\ \t\n]

%%

"*" {return 6;}
"/" {return 6;}
"+" {return 5;}
"-" {return 5;}

{WSPACE}+                     {}
.                             {cout <<" UNKNOWN <" << yytext[0] << ">" << endl;
                               return 99;}
%%
