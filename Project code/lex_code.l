digit              [0-9]
id                 [A-Z][a-zA-Z0-9]*
unsigned_integer   {digit}*
signed_integer     -{digit}*
unsigned_float     {digit}*\.{digit}*[e[+|-]?{digit}*]?
keyword            when|until|iterate|while|return|pass|else
arop               [+\-\*\/\%]
p                  print
%{
#include<stdio.h>
#include<string.h>
int cnt=0,i=0,j=0;
char st[20][10];
int c=0,m=0;
int look_up(char st[10][10],char *id,int n);
%}
%%
"\n"   {c=0;}
"@"    {c=1;}
"/@"   {m=1;}
"@/"   {m=0;}
{keyword}            {if(!c&&!m)fprintf(yyout,"\n%s is Keyword",yytext);}
{unsigned_integer}   {if(!c&&!m)fprintf(yyout,"\n%s is Unsigned Integer",yytext);}
{signed_integer}     {if(!c&&!m)fprintf(yyout,"\n%s is Signed Integer",yytext);}
{unsigned_float}     {if(!c&&!m)fprintf(yyout,"%s is Unsigned Float.",yytext);}
{id}                 {if(c==0&&m==0){
                       if (!lookup(st,yytext,i)){
                         strcpy(st[i++],yytext);
			 fprintf(yyout,"\n%s is Identifier",yytext);
			 cnt++; }}}
"<=" {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Lessthan or Equal to",yytext);}
"<"  {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Lessthan",yytext);}
">=" {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Greaterthan or Equal to",yytext);}
">"  {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Greaterthan",yytext);}
"==" {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Equal to",yytext);}
"!=" {if(!c&&!m)fprintf(yyout,"\n %s is Relational operator Not Equal to",yytext);}
"="    {if(!c&&!m)fprintf(yyout,"\n %s is Assignment operator",yytext);}
{arop} {if(!c&&!m)fprintf(yyout,"\n %s is arithmetic operator",yytext);}
"$"    {if(!c&&!m)fprintf(yyout,"\n %s is statement terminator",yytext);}
{p}  {if(!c&&!m)fprintf(yyout,"\n %s is function",yytext);}
.      {if(!c&&!m)fprintf(yyout,"\n %s is delimiter",yytext);}

%%
int main(int argc,char**argv)
{
yyin=fopen(argv[1],"r");
yyout=fopen(argv[2],"w");
yylex();
printf(" No. of identifiers are : %d ",cnt);
printf("\n the contents of symbol table are :\n");
for(j=0;j<i;j++)
printf("\n %s",st[j]);
return 0;
}

int yywrap()
{
return 1;
}

int lookup(char st[10][10],char *id,int n)
{
for(j=0;j<n;j++)
if(!strcmp(st[j],id))
  return 1;
return 0;
}


