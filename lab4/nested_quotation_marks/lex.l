%{
  #define EXIT_OK 0
  #define EXIT_FAIL 1
%}
%%
\"[^\"]*\" { 
  // printf("%s\n", yytext); 
  if(yytext[yyleng-2] == '\\') {
    // if the last second char is back slash, put the last quotation mark back to the input buffer
    yyless(yyleng-1);
    // yymore() causes the next matched token's yytext to be appended to the current yytext
    yymore();
  } else {
    printf("Matched a string literal: %s\n", yytext);
  }
}
\n {}
. {}
%%
int main(int argc, char **argv){
    char *file_path;
    if(argc < 2){
        fprintf(stderr, "Usage: %s <file_path>\n", argv[0]);
        return EXIT_FAIL;
    } else if(argc == 2){
        file_path = argv[1];
        if(!(yyin = fopen(file_path, "r"))){
            perror(argv[1]);
            return EXIT_FAIL;
        }
        yylex();
        return EXIT_OK;
    } else{
        fputs("Too many arguments! Expected: 2.\n", stderr);
        return EXIT_FAIL;
    }
}
