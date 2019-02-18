%lex
%% 

\n+       {return 'NEWLINE'}
\s+      {/* skipe whitespace */}
[\w]+    {return 'TEXT'}
[#]{7,}  {return 'TEXT'}
[#]{1,6} {return 'HEADING'}
<<EOF>>  {return 'EOF'}

/lex


%start expressions
%% /* language grammar */
expressions
    :lines EOF
      {console.log($1);return $1;}
    ;
lines
    : e lines  
      {$$ = $1+$2}
    | e
      {$$ = $1}
    ;
e 
    : 'HEADING' e
      {$$ = `<h${$1.length}>${$2}<h${$1.length}/>`}
    | 'NEWLINE'
      {$$ = '<br/>'}
    | 'TEXT'
      {$$ = yytext}
    ;
