%{
    #define EXIT_OK 0
    #define EXIT_FAIL 1

    // global variables
    int identifiers = 0;
    int lines = 0;
%}
letter [a-zA-Z]
letter_ {letter}|_
digit [0-9]

%%
[0-9']{letter_}({letter_}|{digit})* {/* invalid identifier: do nothing */}
{letter_}({letter_}|{digit})* {
    if(lines==0) lines++;
    if(strcmp(yytext,"char") && strcmp(yytext,"int") && strcmp(yytext,"return") && 
        strcmp(yytext,"while") && strcmp(yytext,"if") && strcmp(yytext,"else")){
        identifiers++; 
        printf("line %d: %s\n", lines, yytext);
    }
} 
\n {lines++;}
[\t\r ]+ { /* does nothing when seeing white spaces except new line */ }
. { /* a final rule that matches when seeing any character but new line */ }
<<EOF>> { printf("There are %d occurrences of valid identifiers\n", identifiers); yyterminate(); }

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
