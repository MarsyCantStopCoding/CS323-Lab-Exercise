%{
    #define YYSTYPE char *
    #include "lex.yy.c"
    int yyerror(char* s);
    int is_ipv4 = 1;
    int is_ipv6 = 1;
    int dot_number = 0; 
    int colon_number = 0;
    int invalid_double_check = 0;
%}

%token X
%token DOT
%token COLON

%%
Ip: /* to allow empty input */
    | Exp {}
    ;
Exp: Term
    | Exp DOT Term {dot_number++;}
    | Exp COLON Term {colon_number++;}
    ;
Term: X{
    if($1[0]=='0' && strlen($1) > 1){
        is_ipv4 = 0;
    }

    if((strlen($1) > 4 || strlen($1) <= 0)){
        is_ipv6 = 0;
    } else {
        int length = (strlen($1));
        int counter = 0;
        while(counter <= length - 1){
            if(!(($1[counter]>='a'&& $1[counter]<='f') || ($1[counter]>='A' && $1[counter]<='F') || ($1[counter]>='0' && $1[counter]<='9'))) {
                is_ipv6 = 0;
                break;
            }
            counter++;
      }
    }
};
// please design a grammar for the valid ip addresses and provide necessary semantic actions for production rules
%%

int yyerror(char* s) {
    fprintf(stderr, "%s\n", "Invalid");
    invalid_double_check = 1;
    return 1;
}
int main() {
    yyparse();
    if(dot_number != 3){
        is_ipv4 = 0;
    }
    if(colon_number != 7){
        is_ipv6 = 0;
    }
    // printf("dot number = %d\n",dot_number);
    // printf("colon_number = %d\n",colon_number);
    if(is_ipv4 == 1){
        printf("IPv4\n");
        return 0;
    }
    if(is_ipv6 == 1){
        printf("IPv6\n");
        return 0;
    }
    if(invalid_double_check == 0){
        printf("Invalid\n");
    }
    return 0;
}
