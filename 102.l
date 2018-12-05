
digit [0-9]
space [" "]

%{
	#include<stdio.h>
	#include "102.tab.h"
	#include<stdlib.h>
	#include <math.h>

	extern int yylval;
	char str[100];
	char sym2d[100][100];
	int i,cnt=0;
%}




%%
"void"{space}"main"	                 { return VOIDMAIN; }
"function"                           { return FUNCdeclare; }
"typeINT"{space}"function"           { return FUNCdefine; }

"if"		{ return IF;		}
"else"		{ return ELSE;		}
"then"		{ return THEN; }

"typeINT"		{ return INT; }
"typeFLOAT"	{ return FLOAT; }
"Character"		{ return CHAR; }

{digit}+	{ 
				yylval = atoi(yytext);
				return NUM;
			}

","			{ return CM; }
"."			{ return FS; }
":"			{ return COLON; }


"("		{ return LP; }
")"		{ return RP; }
"start"		{ return START; }
"end"		{ return END; }


"+"		{ return PLUS; }
"-"		{ return MINUS; }
"*"		{ return MULT; }
"/"		{ return DIV; }


"=>"	{ return ASSIGN;  }

">>"		{ return GT; }
"<<"		{ return LT; }
">="		{ return GE; }
"<="		{ return LE; }
"="		    { return EQUAL; }
"++"		{ return INC; }

"!" { return FACTORIAL; }
"^" { return TOTHEPOWER; }

"while"  {return WHILE; }
"cycle"		{ return FOR; }
"change" 	{ return SWITCH; }
"event"	{ return CASE; }



[a-z]		{
				yylval = *yytext - 'a';
				return	VAR;
			}


[a-z]+[0-9]		{
				yylval = *yytext - 'a';
				return	NAME;
			}	
		

[a-z][a-z]+ {
				for(i=0;i<yyleng;i++) sym2d[cnt][i] = yytext[i];
				cnt++;
				return VAR1;
			}			


[ \t\n]*	;

"//"(.)*"\n" { printf("Comment Line\n");}


%%

/* user subroutines */

int main()
{
	
	yyin = freopen("102.txt","r",stdin);
	yyout = freopen("output.txt","w",stdout);
	yyparse();
}

