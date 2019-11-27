space " "
newline "\n"
digit [0-9]
char [a-zA-Z]
%{
	#include <stdio.h>
	#include "prac.tab.h"
	int yyparse();
    int yylex();
	void yyerror();
%}

%%
{space} {}
{newline} {}
"float" {
	printf("Float\n");
	return Float;
}
"else if" {
	printf("ELSE IF\n");
	return ELSEIF;
}
"if" {
	printf("IF\n");
	return IF;
}
"else" {
	return ELSE;
}
{digit}+ {
	yylval=atoi(yytext);
	printf("%s\n",yytext);
	return NUM;
}
{char}+ {
    yylval=atoi(yytext);
	printf("%s\n",yytext);
	return CHAR;
}
"." {
	yylval=atoi(yytext);
	printf("%s\n",yytext);
	return DOT;
}
"=" {
	printf("equal\n");
	return EQAL;
}
"<" {
	return LT;
}
">" {
	printf("Greater\n");
	return GT;
}
"+" {
	return PLUS;
}
"-" {
	return MINUS;
}
"(" {
	printf("PB\n");
	return PB;
}
")" {
	printf("PE\n");
	return PE;
}
"{" {
	return BB;
}
"}" {
	return BE;
}
%%
int yywrap()
{
	return 1;
}
int main(){
    freopen("input.txt","r",stdin);
	yyparse();
}
