operator "="|"<="|"+"|".."|"!="|"-"|"/"|"*"
keyword "loop"|"print"|"if"|"else"|"temp"|"void"|"main"
sign ":"
line .*\n*

%{
#include<string.h>
   char str[][10]={"digit","loop","print","if","else","temp","void","main"};
   int key=0;
   int array[100]={0};
   int sign_ar[1000]={0};	
   int var=0;
   int operator=0;
   int punc=0;
   
%}

%%

[&].* {yytext[0]=' ';printf("single line comment :  %s\n",yytext);}
"#".* {yytext[0]=' ';printf("Library function : %s\n",yytext);}
"$"{line}*"$" {yytext[0]=' ';yytext[yyleng-1]='}';
                      printf("\nmultiple line comment :\n{%s\n",yytext);}					  
"loop"" "[a-zA-Z]+" "[0-9]+".."[0-9]+ {var++;operator++;if(array[1]==0){array[1]=1;key++;}printf("loop found:\n");}	
"loop".* {if(array[1]==0){array[1]=1;key++;}printf("syntax error loop format isn't right\n");}	
"temp"" "[a-zA-Z]+[a-zA-Z0-9]*" "[0-9]+":"	{var++;punc++;if(array[5]==0){array[5]=1;key++;}printf("array found:\n");}	
"temp"" "[a-zA-Z]+[a-zA-Z0-9]*" "[0-9]+	{var++;if(array[5]==0){array[5]=1;key++;}printf("syntax error give a ':'\n");}	
"temp"" "[0-9]+.* {punc++;if(array[5]==0){array[5]=1;key++;}printf("syntax error array can't start with number");}
"print""<".*">"":" {punc++;if(array[2]==0){array[2]=1;key++;}printf("print function found\n");}		  
"print""<".*">" {if(array[2]==0){array[2]=1;key++;}printf("syntax error give a ':'\n");}		  
"main".*"<".*">" {if(array[7]==0){array[7]=1;key++;var++;printf("<--main function start here-->\n");}else {printf("duplicate main function\n");}}
"void".*"<".*">" {if(array[6]==0){array[6]=1;key++;}var++;printf("void function\n");}
"void".* {printf("function declaration isn't right\n");}
"temp".*"="[0-9]+":" {var++;punc++;if(array[5]==0){array[5]=1;key++;}operator++;printf("assign operator\n");}
"temp".*"="[0-9]+ {var++;if(array[5]==0){array[5]=1;key++;}printf("syntax error give a ':'\n");}
"temp"" "[a-zA-Z]+[a-zA-Z0-9]*":" {var++;punc++;if(array[5]==0){array[5]=1;key++;}printf("variable declare\n");} 
"temp"" "[a-zA-Z]+[a-zA-Z0-9]* {var++;if(array[5]==0){array[5]=1;key++;}printf("syntax error give a ':'\n");}
"if".* {if(array[3]==0){array[3]=1;key++;}printf("condition found\n");}
"else" {if(array[4]==0){array[4]=1;key++;}printf("condition found\n");}
.*"="[0-9]+":" {var++;punc++;operator++;printf("assign operator\n");}
.*"="[0-9]+ {var++;printf("syntax error give a ':'\n");}
.*"="[0-9]+{operator}[0-9]+":" {var++;punc++;operator++;printf("mathematics operator\n");}

%%

int yywrap()
{
    return 1;
}

int main()
{
	yyin = freopen( "input.txt", "r" ,stdin);
	yyout = freopen( "output.txt","w",stdout);
	yylex();
    printf("\n               > count_no <             \n");
     printf("Variables: %d\n",var);
    printf("operators: %d\n",operator);
    printf("Keywords: %d\n",key);
    printf("{\n");
    int i=0;
    for(i=0 ;i<10 ;i++){
       if(array[i]==1){
       printf("    %s\n",str[i]);
       }
    }
    printf("\n}\n");
    printf("punchiation: %d\n",punc);
    return 0;

}