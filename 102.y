/* C Declarations */

%{
	#include<stdio.h>
	extern char str[100];
	extern char sym2d[100][100];
	#include <math.h>
	int indx=0,t=1,z=0;
	extern int cnt;
	int sym[26],store[26];
	int flag=1,val,i,j,count=0;
	
		
%}

/* BISON Declarations */

%token VOIDMAIN INT STR FLOAT CHAR NUM VAR VAR1 CM FS FOR WHILE  COLON DEFAULT  CASE THEN IF ELSE SWITCH  LP RP START END  PRINT PLUS MINUS MULT DIV ASSIGN GT LT GE LE EQUAL INC FACTORIAL TOTHEPOWER FUNCdeclare FUNCdefine NAME
%nonassoc IFX
%nonassoc ELSE
%left LT GT
%left VAR
%left PLUS MINUS
%left MULT DIV
%left FACTORIAL
%left TOTHEPOWER


	
/* Simple grammar rules */

%%

program		: VOIDMAIN LP RP START cstatement callFunction END  { printf("\nsuccessfully compiled\n"); }
			;


callFunction :       ;
               | FUNCdefine NAME LP RP START functionBODY END  { printf("\n FUNCTION successfully executed\n"); }
               ;

cstatement	: /* empty */
			| cstatement statement
			| cstatement cdeclaration
			| cstatement Structure
			| cstatement function
			
			;


function   :  FUNCdeclare NAME LP RP  { printf("Function  is called");  printf("\n"); }
                                                      
           ;

	
cdeclaration: TYPE Variable FS	{ printf("valid declaration\n");  printf("\n"); }
			;
			
TYPE 		: INT | FLOAT | CHAR ;



functionBODY  :   NUM FS {
					      
					      if($1%2 == 0)
					       {
					           printf("\n Number %d is an EVEN number",$1);
					           printf("\n");
					       }
					       else{
					       printf("\n Number %d is an ODD number",$1);
					       printf("\n");
					       }

					       
		                   
					 }

				
					 ;	
				
Variable 	: VariableFurther CM Variable | VariableFurther ;
			
VariableFurther		: VAR					{
										if(store[$1] == 1) printf("variable %c Redeclared\n",$1+'a');
										else store[$1]=1;
									}
									
			| VAR1					{
										
									
										for(i=0; i<cnt-1; i++)
										{	
											
											for( j=0; sym2d[cnt-1][j]!='\0'; j++)
											{
												
												if(sym2d[i][j] == sym2d[cnt-1][j])
												{
													count++;
												}
									
											}
											
											if(count == j && sym2d[i][j]=='\0' && sym2d[cnt-1][j]=='\0'){
												
												printf("variable %s is Redeclared \n",sym2d[cnt-1]);
												 printf("\n");
											}
											count=0;
																					
										}
									
										
										
									}
									
			| VAR1 ASSIGN NUM 		{
										if(cnt<2)           
										{
											char c = (char) $3;
											sym2d[indx][99]=c;
											int i = (int) c;
											
											indx++;
											
										}
										
										
										for(i=0; i<cnt-1; i++) 
										{	
											
											for( j=0; sym2d[cnt-1][j]!='\0'; j++)
											{
												
												if(sym2d[i][j] == sym2d[cnt-1][j])
												{
													count++;
												}
									
											}
											
											
											if(count == j && sym2d[i][j]=='\0' && sym2d[cnt-1][j]=='\0')
											{
												
												printf("variable %s is Redeclared \n",sym2d[cnt-1]);
												 printf("\n");
												t=0;
											}
											
											count=0;
											
										}
									
										
										
										if(t&&cnt>1)
										{
											
											char c = (char) $3;
											sym2d[indx][99]=c;
											int i = (int) c;
											indx++;
										}
										
										if(t)printf("\nValue of the %s = %d\t\n",sym2d[cnt-1],sym2d[cnt-1][99]);
										 printf("\n");
										
									}						
									
									
			| VAR ASSIGN NUM 		{ 	
										if(store[$1] == 1) printf("variable %c Redeclared\n",$1+'a');
										else store[$1]=1;
										sym[$1] = $3; 
										printf("\nValue of the %c = %d\t\n",$1+'a',$3);
										 printf("\n");
									}
			;
			
Structure  	: IF Expresssion COLON START Expresssion END %prec IFX	{	
								
								if($2)
								{
									printf("\nvalue of Expresssion in if: %d\n",$5);

								}
								
								else
								{
									printf("condition value zero in IF block\n");
								}								}
															
			|IF Expresssion COLON START IF Expresssion COLON START Expresssion END ELSE START Expresssion END END ELSE START Expresssion END
									{
								    if($2)
									{
									   if($6)
									   { printf("\nvalue of Expresssion in if if: %d\n",$9); }
									   else
									   { printf("\nvalue of Expresssion in if else: %d\n",$13); }
									}
									else
									{
										printf("\nvalue of Expresssion in only else: %d\n",$18);
									}
									
								
									}

			|IF Expresssion COLON START Expresssion END ELSE START IF Expresssion COLON START Expresssion END ELSE START Expresssion END END
									{
								    if($2)
									{
										 printf("\nvalue of Expresssion in only if: %d\n",$6); 
									}
									else
									{
									   if($11)
									   { printf("\nvalue of Expresssion in else if: %d\n",$15); }
									   else
									   { printf("\nvalue of Expresssion in else else: %d\n",$19); }
									}
									
								
									}


		    | NUM FACTORIAL {
						int mult=1 ,i;
						for(i=$1;i>0;i--)
						{
							mult=mult*i;
						}
						$$=mult;
						printf("factorial value %d!\n",$$); 
					 }	
			
			| FOR LP VAR ASSIGN NUM CM VAR LE NUM CM VAR INC RP START Structure END 	{
																					printf("\nIn Loop:\n");
																					for( sym[$3]=$5; sym[$3] <= $9; sym[$3]++)
																					{
																						printf("%d",$15);
																						printf("\n");

																						
																					}printf("\n");
																				
																				}
			
			
			
			
			|Expresssion FS;
			

			
statement	: FS
			| Expresssion FS 				{ printf("\nValue of Expresssionession: %d\n", $1); }
			| VAR ASSIGN Expresssion FS 	{
										sym[$1] = $3; 
									
										if(store[$1]!=1)printf("'%c' is Undeclared",$1+'a');
										printf("\n");
										//printf("\nValue of the %c = %d\t\n",$1+'a',$3);
									}
			
			;
	
Expresssion 		: VAR					{ $$ = sym[$1]; } 
			| Expresssion LT Expresssion	{ $$ = $1 < $3; }

	        | Expresssion GT Expresssion	{ $$ = $1 > $3; }
			| Expresssion MULT Expresssion			{ $$ = $1 * $3; }
			| Expresssion DIV Expresssion		{ 
										if($3) 
										{
												$$ = $1 / $3;
										}
										else
										{
											$$ = 0;
											printf("\ndivision by zero\t");
										}
									}
			|Expresssion PLUS Expresssion		{ $$ = $1 + $3; }
			|Expresssion MINUS Expresssion		{ $$ = $1 - $3; }
			
					 
			| Expresssion TOTHEPOWER Expresssion { 
			                                       $$=pow($1,$3); printf("To the power value %d\n",$$);
			                                        printf("\n"); }				 

	
			|term
			 ;
			 
term 		: factor 
			;
			
factor 		: digit					{ $$ = $1; }
			|LP Expresssion RP				{ $$ = $2; }
			;
			
digit 		: NUM	    			{ $$ = $1; }
			;




			
%%

int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}

