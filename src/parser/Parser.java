package parser;

import lexer.*;
import symbols.*;
import inter.*;
import runtime.LoadFunc;

import java.io.*;
import java.util.ArrayList;


public class Parser{
    private Lexer lex;
    private Token look;
    Env top = new Env();
    FuncTable table = new FuncTable();
    Type returnType = Type.Int;
    boolean hasDecl = true;
    /*integer numbers standing for the stack level*/
    public int lastIterationLevel = -1;
    /* The variable lastFunctionLevel is for the  
     * local function definition.
     * For now,it is just 0(which means global level).
     */
    public int lastFunctionLevel = 0;
    public int nowLevel = 0;

    public  Parser(Lexer l) throws IOException{
        lex = l;
        move();
    }

    public void move() throws IOException {
        look = lex.scan();
    }

    public Token copymove() throws IOException {
        Token tmp = look;
        move();
        return tmp;
    }

    public void error(String s){
        throw new RuntimeException("Line " + lex.line + " in file `" +  lex.filename + "':\n\t" + s);
    }

    public void match(int t) throws IOException{
        if(look.tag == t)
            move();
        else 
            error("syntax error");
    }

    public boolean check(int t) throws IOException{
        if(look.tag == t){
            move();
            return true;
        } else {
            return false;
        }
    }

    public Stmt program() throws IOException {
        Stmt s = Stmt.Null;
        while(look.tag != -1){
            switch(look.tag){
            case Tag.DEF:
                deffunc();
                break;
            case Tag.STRUCT:
                defstruct();
                break;
            case Tag.LDFUNC:
                loadfunc();
                break;
            case Tag.IMPORT:
                importlib();
                break;
            default:
                s = new Seq(s,stmt());
                break;
            }
        }
        return s;
    }

    public void importlib() throws IOException {
        match(Tag.IMPORT);
        Token l = look;
        match(Tag.STR);
        if( look.tag != ';'){
            error("Want ';'");
        }
        lex.open(((Str)l).value);
    }

    public void loadfunc() throws IOException {
        ArrayList<Para> pl  = null;
        match(Tag.LDFUNC);
        match('<');
        Token pkg = look;
        match(Tag.ID);
        match('>');
        match('{');
        while(!check('}')){
            pl = new ArrayList<Para>();
            Type t = type();
            Token name = look;
            match(Tag.ID);
            match('(');
            if(!check(')')){
                do{
                    Type vt = type();
                    Token n = look;
                    match(Tag.ID);
                    pl.add(new Para(vt,n));
                }while(check(','));
                match(')');
            }
            match(';');
            table.addFunc(name,LoadFunc.loadFunc(t,pkg,name,pl));
        }
    }

    public void defstruct() throws IOException {
        match(Tag.STRUCT);
        
        /*
         * Struct definition:
         *      struct name {
         *          type name;[...]
         *      }
         */
        
        Token name = look;
        match(Tag.ID);
        Struct s = new Struct(name);
        if( top.get(name) != null ){
            error("Struct `" + name + "' has a same name with a variable");
        }
        lex.defType(s);
        match('{');
        do{
            Type t = type();
            Token m = look;
            match(Tag.ID);
            if(s.addEntry(m,t) != null){
                error("Memeber `" + m.toString() + "' defined previously ");
            }
            match(';');
        }while(!check('}'));
    }

    public void deffunc() throws IOException {
        match(Tag.DEF);
        Type savedType = returnType;
        ArrayList<Para> pl = new ArrayList<Para>();
        returnType = type();
        Token name = look;
        match(Tag.ID);
        match('(');
        Env savedEnv = top;
        top = new Env(top);
        boolean savedHasDecl = hasDecl;
        hasDecl = true;
        if(!check(')')){
            do{
                Type t = type();
                Token n = look;
                match(Tag.ID);
                pl.add(new Para(t,n));
                top.put(n,t);
            }while(check(','));
            match(')');
        }
        Function f = new Function(name,returnType,pl);
        table.addFunc(name,f);
        match('{');
        Stmt s = stmts();
        match('}');
        f.init(name,returnType,s,pl);
        top = savedEnv;
        returnType = savedType;
        hasDecl = savedHasDecl;
        return;
    }

    public Stmt block() throws IOException {
        match('{');
        Env savedEnv = top;
        boolean savedHasDecl = hasDecl;
        hasDecl = false;
        //top = new Env(top);/*should not*/
        
        Stmt s = stmts();
        match('}');
        if(hasDecl)
            s = new Seq(Stmt.PushStack,new Seq(s,Stmt.RecoverStack));
        
        if(hasDecl){
            nowLevel--;
            top = savedEnv;
        }
        hasDecl = savedHasDecl;
        return s;
    }

    public Stmt stmts() throws IOException {
        if(look.tag == '}') {
            return Stmt.Null;
        } else {
            return new Seq(stmt(),stmts());
        }
    }

    public Stmt stmt() throws IOException {
        Expr x;
        Stmt s,s1,s2;
        Stmt savedStmt;
        int savedLastIterationLevel = lastIterationLevel;

        switch(look.tag){
        case ';':
            move();
            return Stmt.Null;
        case Tag.IF:
            match(Tag.IF);
            match('(');
            x = expr();
            match(')');
            s1 = stmt();
            if(look.tag != Tag.ELSE) 
                return new If(x,s1);
            match(Tag.ELSE);
            s2 = stmt();
            return new Else(x,s1,s2);
        case Tag.WHILE:
            lastIterationLevel = nowLevel;
            While whilenode = new While();
            savedStmt = Stmt.Enclosing;
            Stmt.Enclosing = whilenode;
            match(Tag.WHILE);
            match('(');
            x = expr();
            match(')');
            s1 = stmt();
            whilenode.init(x,s1);
            Stmt.Enclosing = savedStmt;
            lastIterationLevel = savedLastIterationLevel;
            return whilenode;
        case Tag.DO:
            lastIterationLevel = nowLevel;
            Do donode = new Do();
            savedStmt = Stmt.Enclosing;
            Stmt.Enclosing = donode;
            match(Tag.DO);
            s1 = stmt();
            match(Tag.WHILE);
            match('(');
            x = expr();
            match(')');
            match(';');
            donode.init(s1,x);
            Stmt.Enclosing = savedStmt;
            lastIterationLevel = savedLastIterationLevel;
            return donode;
        case Tag.FOR:
            lastIterationLevel = nowLevel;
            Stmt fornode = forloop();
            lastIterationLevel = savedLastIterationLevel;
            return fornode;
        case Tag.BREAK:
            match(Tag.BREAK);
            match(';');
            return new Break(nowLevel - lastIterationLevel);
        case Tag.CONTINUE:
            match(Tag.CONTINUE);
            match(';');
            return new Continue(nowLevel - lastIterationLevel);
        case Tag.RETURN:
            match(Tag.RETURN);
            Expr e = expr();
            match(';');
            return new Return(e,returnType,nowLevel - lastFunctionLevel);
        case '{':
            return block();
        case Tag.BASIC:
            if(!hasDecl){
                top = new Env(top);
                nowLevel ++;
            }
            hasDecl = true;
            return decls();
        default:
            /*single expression statement*/
            s = new ExprStmt(expr());
            match(';');
            return s;
        }
    }

    public Stmt forloop() throws IOException {
        lastIterationLevel = nowLevel;
        For fornode = new For();
        Stmt savedStmt = Stmt.Enclosing;
        Stmt.Enclosing = fornode;
        move();
        match('(');
        Stmt s1;
        Env savedTop = top;
        boolean hasdecl = false;
        if(look.tag == ';'){
            s1 = Stmt.Null;
        } else if( look.tag == Tag.BASIC) {
            System.out.println("ffff" + Lexer.line + ":" + Lexer.filename);
            hasdecl = true;
            top = new Env(top);
            s1 = fordecl();
        } else {
            s1 = new ExprStmt(expr());
        }
        match(';');
        Expr e2 = (look.tag == ';')?Constant.True:expr();
        match(';');
        Stmt s3 = (look.tag == ')')?Stmt.Null:new ExprStmt(expr());
        match(')');
        Stmt s = stmt();
        top = savedTop;
        Stmt.Enclosing = savedStmt;
        fornode.init(s1,e2,s3,s);
        s = hasdecl?new Seq(Stmt.PushStack,new Seq(fornode,Stmt.RecoverStack)):fornode;
        return s;
    }
    
    Stmt fordecl() throws IOException {
        /*
         * for(int i = 0,j = 0;;)
         */
        Decls s = new Decls();
        Type p = type();
        Token tok;
        do{
            Expr e = null;
            tok = look;
            match(Tag.ID);
            if(top.containsVar(tok)){
                error("variable `" + tok.toString() + "' redefined here");
            }
            top.put(tok,p);
            if(check('=')){
                e = expr();
            }
            s.addDecl(Decl.getDecl(tok,p,e));
        } while(check(','));
        return s;
    }

    public Decls decls() throws IOException{
        Decls s = new Decls();
        Expr  e = null;
        while( look.tag == Tag.BASIC){
            Type p = type();
            Token tok;
            do{
                e = null;
                tok = look;
                match(Tag.ID);
                if(top.containsVar(tok)){
                    error("variable `" + tok.toString() + "' redefined here");
                }
                top.put(tok,p);
                if(check('=')){
                    e = expr();
                }
                s.addDecl(Decl.getDecl(tok,p,e));
            } while(check(','));
            match(';');
        }
        return s;
    }    

    public Type type() throws IOException {
        Type p = (Type)look;
        match(Tag.BASIC);
        while( check('[') ){
            Token sz = look;
            match(Tag.NUM);
            p = new Array(p,((Num)sz).value);
            match(']');
        }
        return p;
    }

    public Expr expr() throws IOException {
        return assign().optimize();
    }

    public Expr assign() throws IOException {
        Expr l =  condition();
        while(look.tag == '=' || look.tag == Tag.ADDASS || look.tag == Tag.MINASS 
              || look.tag == Tag.MULTASS || look.tag == Tag.DIVASS || look.tag == Tag.MODASS){
            l = SetFactory.getSet(copymove(),l,condition());
        }
        return l;
    }

    public Expr condition() throws IOException {
        Expr e = bool();
        Token t = look;
        if(check('?')){
            Expr iftrue = assign();
            match(':');
            Expr iffalse = condition();
            e = new Condition(t,e,iftrue,iffalse);
        }
        return e;
    }

    public Expr bool() throws IOException {
       Expr l =  join();
       while(look.tag == Tag.OR){
            l = new Or( copymove() ,l,join());
       }
       return l;
    }

    public Expr join() throws IOException {
       Expr l =  equality();
       while(look.tag == Tag.AND){
            l = new And(copymove(),l,equality());
       }
       return l;
    }

    public Expr equality() throws IOException {
       Expr l =  rel();
       if(look.tag == Tag.EQ || look.tag == Tag.NE ){
            l = RelFactory.getRel( copymove(),l,rel());
       }
       return l;
    }

    public Expr rel() throws IOException {
       Expr l =  add();
       if(look.tag == Tag.GE || look.tag == Tag.LE
             ||look.tag == '<' || look.tag == '>'){
            l = RelFactory.getRel(copymove(),l,add());
       }
       return l;
    }

    public Expr add() throws IOException {
       Expr l =  mult();
       while(look.tag == '+' || look.tag == '-' ){
            l = ArithFactory.getArith(copymove(),l,mult());
       }
       return l;
    }

    public Expr mult() throws IOException {
       Expr l =  unary();
       while(look.tag == '*' || look.tag == '/' || look.tag == '%'){
            l = ArithFactory.getArith(copymove(),l,unary());
       }
       return l;
    }

    public Expr unary() throws IOException {
       switch(look.tag){
       case '!':
            return new Not(copymove(),unary());
       case '-':
       case Tag.INC:
       case Tag.DEC:
            return UnaryFactory.getUnary(copymove(),unary());
       default:
            return postinc();
       }
    }

    public Expr postinc() throws IOException {
        Expr e = postfix();
        switch(look.tag){
        case Tag.INC:
        case Tag.DEC:
            return PostUnaryFactory.getUnary(copymove(),e);
        default:
            return e;
        }
    }

    public Expr postfix() throws IOException {
       Expr e = factor();
       switch(look.tag){
       case '[':
       case '.':
            return access(e);
       default:
            return e;
       }
    }

    public Expr access(Expr e) throws IOException {
        do{
            if(look.tag == '.')
                e = memeber(e);
            else
                e = offset(e);
        }while(look.tag == '[' || look.tag == '.');
        return e;
    }

    public Expr memeber(Expr e) throws IOException {
        match('.');
        Token mname = look;
        match(Tag.ID);
        return new StructMemeberAccess(e,mname);
    }

    public Expr offset(Expr e) throws IOException {
        match('[');
        Expr loc = expr();
        match(']');
        /*if it is string item access*/
        if(e.type == Type.Str){
            if(e instanceof Var){
                e = new StringVarAccess((Var)e,loc);
            } else {
                e = new StringAccess(e,loc);
            }
            if(look.tag != '['){
                return e;
            }
        }

        if(!(e instanceof Var && e.type instanceof Array)){
            error("Operand `[]` should be used for array variable or string,not for " + e.type);
        }

        Type t = ((Array)(e.type)).of;/*element type*/
        int w = t.getSize();
        if(w != 1){
            loc = ArithFactory.getArith(Word.mult,loc,new Constant(w));
        }
        /*it is normal array access*/
        while(look.tag == '['){
            /*array end*/
            if(!(t instanceof Array))
                break;
            match('[');
            Expr i = expr();
            t = ((Array)t).of;/*element type*/
            w = t.getSize();
            if(w != 1){
                i = ArithFactory.getArith(Word.mult,i,new Constant(w));
            }
            loc = ArithFactory.getArith(Word.add,loc,i);
            match(']');
        }

        e = new ArrayVar((Var)e,t,loc);
        /*for string index access*/
        return e;
    }

    public Expr factor() throws IOException {
        Expr l,r;
        
        switch(look.tag){
        case Tag.ID:
            Token tmp = copymove();
            
            if(look.tag == '('){
                return function(tmp);
            }
            EnvEntry ee = top.get(tmp);
            if(ee == null){
                error("Variable `" + tmp + "' not declared.");
            }
            /*
             * Level 0 is for the global variables
             * By default,use offset to present stack level to get var 
             * address in runtime stack<stackoffset,varoffset>
             * But for the global variable,we can't know what it is 
             * exactly in functions.So we use the AbsoluteVar<stackbackoffset,varoffset>.
             */
            return ee.stacklevel == 0? new AbsoluteVar(tmp,ee.type,0,ee.offset) : new Var(tmp,ee.type,top.level - ee.stacklevel,ee.offset);
        case Tag.TRUE:
            move();
            return Constant.True;
        case Tag.FALSE:
            move();
            return Constant.False;
        case Tag.NUM:
            return new Constant(copymove(),Type.Int);
        case Tag.STR:
            return new Constant(copymove(),Type.Str);
        case Tag.REAL:
            return new Constant(copymove(),Type.Float);
        case Tag.CHAR:
            return new Constant(copymove(),Type.Char);
        case '(':
            return cast();
        default:
            error("Unknown token found:" + copymove().tag);
            return null;
        }
    }

    public Expr cast() throws IOException {
        Expr e = null;
        match('(');
        switch(look.tag){
        case Tag.BASIC:
            Type t = (Type) copymove();
            match(')');
            Expr f = unary();
            assert(f != null);
            e = f;
            if(f.type != t)
                e = ConversionFactory.getConversion(f,t);
            if(e == null)
                error("Can't convert " + f.type + " to " + t);
            break;
        default:
            e = assign();
            match(')');
            break;
        }
        return e;
    }

    public Expr function(Token id) throws IOException {
        FunctionBasic f = table.getFuncType(id);
        ArrayList<Expr> paras = new ArrayList<Expr>();
        if(f == null) {
            error("Function " + id + " not found.");
        }
        match('(');
        /*
         * Because when function invoke will 
         * cause a stack push before calculate  
         * the expr.We should make present
         * level + 1
         */
        Env savedEnv = top;
        top = new Env(top);
        if(!check(')')){
            do{
                paras.add(expr());
            }while(check(','));
            match(')');
        }
        top = savedEnv;
        return new FunctionInvoke(f,paras);
    }

    public static void main(String[] args) throws Exception {
        Lexer l = new Lexer();
        l.open("test.txt");
        new Parser(l).program().run();
    }
}