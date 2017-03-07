/*
* RPGScript -> E | Statement RPGScript
* Statement -> <VAL> Statement | Command 
* Command -> VAL : VAL-LIST \n
* VAL-LIST = E | VAL VAL-LIST
* SUPPORTED function:
"sleep":seconds
"jump":label
"condition": varname value jumplabel
"dialog": content color name
"choice": varname val,...
"set":varname val
"set_global":varname val
"add_num":varname val
"open":val

while( condition ) {
    do
}
      || ||
      || ||
      || ||
<"beg">"condition" varname value "a"
"jump":"end" 
<"a">
 
"jump":"beg"
<"end">
*/

import "../container/content.xs";
import "../container/hashmap.xs";
import "../container/darray.xs";
import "../lib/system.xs";
import "../lib/utils.xs";
import "../ui/paintpad.xs";

struct FunctionBasic:Content{}

struct RuntimeBasic {
    //HashMap globalVarMap;//<string,string>
    HashMap varMap;//<string,string>
    HashMap labelMap;//<string,integer>
    int index;
    
    def this(){
        this.varMap = new HashMap();
        this.labelMap = new HashMap();
        int index = 0;
    }
    
    def string getVar(string varname){
        return ((StringContent)this.varMap.get( new StringHashContent(varname)).value);
    }
    
    def void setVar(string varname,string val){
        this.varMap.set( new StringHashContent(varname), new StringContent(val) );
    }
    
    def void jump(string label){
        auto l = (IntContent) this.labelMap.get(new StringHashContent(label)).value;
        this.index = (int)l - 1;
    }
    
    def void sleep(int second){
        sleep(second);
    }
    
    def virtual void open(string filename);
    
    def virtual void step();
}

struct Function:FunctionBasic{
    def virtual void run(RuntimeBasic r,string[] args);
    
    def override string toString(){
        return "";
    }
}

struct RuntimeBasic_ : RuntimeBasic{
    HashMap functionMap;//<string,Function>
    def this(){
        super();
        this.functionMap = new HashMap();
    }

    def Function getFunction(string funcname){
       return (Function)this.functionMap.get(new StringHashContent(funcname)).value;
    }
    
    def void registerFunction(string funcname,Function function){
       this.functionMap.set(new StringHashContent(funcname),function);
    }

}



struct Instruction:Content{
    string[] args;
    string function;
    
    def this(string function,string[] args){
        this.args = args;
        this.function = function;
    }

    def void run(RuntimeBasic_ r){
        r.getFunction(this.function).run(r,this.args);
    }
    
    def override string toString(){
        return this.function;
    }
    
}

struct Runtime:RuntimeBasic_{
    DynamicArray instructions;

    
    def this(){
        super();
        this.instructions = new DynamicArray(1000);
    }
    
    def void addLable(string label){
        this.labelMap.set(new StringHashContent(label),new IntContent( this.instructions.size()));
    }
    
    def void addInstructions2(string function,string[] args){
        this.instructions.push_back(new Instruction(function,args));
    }
    
    def bool isEnd(){
        return this.instructions.size()<=this.index;
    }
    
    def void addInstructions(Instruction i){
        this.instructions.push_back(i);
    }
    
    def void clearInstructions(){
        this.instructions.clear();
    }
    
    def override void step(){
        ((Instruction)this.instructions.get(this.index)).run(this);
        this.index++;
    }
}

struct RPGToken:Content{
    int tag;

    def override string toString(){
        return "";
    }
}

struct ValueToken:RPGToken{
    string value;
    def this(string str){
        this.value = str;
        this.tag = 256;
    }

    def override string toString(){
        return this.value;
    }
}

struct SymbolToken:RPGToken{
    def this(int c){
        this.tag = c;
    }
    
    def override string toString(){
        return "" + (char)this.tag + ":" +this.tag;
    }
}

struct RPGLexer{
    File f;
    int peak;
    
    def this(){
        this.peak = ' ';
        this.f = new File();
    }
    
    def void close(){
        this.f.close();
    }
    
    def void open(string filename){
        this.f.close();
        this.peak = ' ';
        this.f.open(filename);
    }
    
    def bool check(int c);
    
    def void readch(){
        this.peak = this.f.readch();
    }
    
    def RPGToken scan(){
        RPGToken t;
        while(this.check('\t')||this.check(' ')||this.check('\r'));
        
        switch(this.peak){
        case '\"':
            StringBuffer sb = new StringBuffer();
            this.readch();
            while(!this.check('\"')){
                sb.appendCharacter(this.peak);
                this.readch();
            }
            t = new ValueToken(sb.toString());
            break;
        default:
            t = new SymbolToken(this.peak);
            this.readch();
        }
        return t;
    }
}


def bool RPGLexer.check(int c){
    if(c == this.peak){
        this.readch();
        return true;
    }
    return false;
}

/*
* RPGScript -> E | Statement RPGScript
* Statement -> <VAL> Statement | Command 
* Command -> VAL : VAL-LIST \n
* VAL-LIST = E | VAL VAL-LIST
*/

struct RPGParser{
    RPGToken look;
    RPGLexer lexer;
    
    def this(){
        this.lexer = new RPGLexer();
    }

    def bool check(int id);
    
    def void parse(string file,Runtime r);

    def string value();
    
    def void error(string msg){
        println("error "+msg);
    }
    
    def void move(){
        this.look = this.lexer.scan();
    }
    
    def void match(int id){
        if(this.look.tag != id){
            this.error("wrong id" + this.look);
        }
        this.move();
    }
    
     def string[] args(){
        auto arg = new string[20];
        int i = 0;
        while(this.look.tag == 256){
            arg[i++] = this.value();
        }
        auto tmp = new string[i];
        while(--i >= 0){
            tmp[i] = arg[i];
        }
        return tmp;
    }
    
    def Instruction instruction(){
        auto funcname = this.value();
        this.match(':');
        auto args = this.args();
        return new Instruction(funcname,args);
    }
    
    def void statement(Runtime r){
        while(this.check('\n'));
        while(this.check('<')){
           r.addLable(this.value());
           this.match('>');
           while(this.check('\n'));
        }
        if(this.look.tag != -1)
            r.addInstructions(this.instruction());
    }
    
}

def bool RPGParser.check(int c){
    if(this.look.tag == c){
        this.move();
        return true;
    }
    return false;
}

def string RPGParser.value(){
    auto arg = this.look;
    this.match(256);
    
    return ((ValueToken)arg).value;
}

def void RPGParser.parse(string file,Runtime r){
    this.lexer.open(file);
    this.move();
    while(this.look.tag != -1){
        this.statement(r);
    }
    this.lexer.close();
}

struct RPGRuntime:Runtime{
    RPGParser parser;

    def this(RPGParser p){
        super();
        this.parser = p;
    }
    
    def override void open(string filename){
        this.labelMap.clear();
        this.instructions.clear();
        this.parser.parse(filename,this);
    }

    def void run(){
        while(!this.isEnd()){
            super.step();
        }
    }
}

struct Sleep:Function{
    def override void run(RuntimeBasic r,string[] args){
        sleep(parseInt(args[0]));
    }
}

struct Choice:Function{
    def override void run(RuntimeBasic r,string[] args){
        string var = args[0];
        println("Choose");
        for(int i=1;i< sizeof args;i++){
            println("" + i + "." + args[i]);
        }
        print("Enter:");
        int c = readNumber();
        r.setVar(var,c);
    }
} 

struct Set:Function{
    def override void run(RuntimeBasic r,string[] args){
        r.setVar(args[0],args[1]);
    }
}

struct Cond:Function{
    def override void run(RuntimeBasic r,string[] args){
        if(r.getVar(args[0]) == args[1]){
            r.jump(args[2]);
        }
    }
}

struct Print:Function{
    def override void run(RuntimeBasic r,string[] args){
        
        string content = args[0];
        if(sizeof args < 1){
            println(content);
        }
        int len_1 = strlen(content) - 1;
        int j = 1;

        StringBuffer sb = new StringBuffer();

        for( int i = 0 ; i <= len_1 ; i++ ){
            if( content[i] == '$' ){
                if( i < len_1 ){
                    if( content[i+1] == '$' ){
                        i++;
                        sb.appendCharacter('$');
                        continue;
                    }
                }
                sb.append( r.getVar( args[j++] ) );
            } else {
                sb.appendCharacter( content[i] );
            }
        }
        println(sb.toString());
    }
}

struct StopPrint:Function{
    def override void run(RuntimeBasic r,string[] args){
        string content = args[0];
        int stop = parseInt(args[1]);
        if(sizeof args > 2){
            StringBuffer sb = new StringBuffer();
            int len_1 = strlen(content) - 1;
            int j = 2;
            
            for( int i = 0 ; i <= len_1 ; i++ ){
                if( content[i] == '$' ){
                    if( i < len_1 ){
                        if( content[i+1] == '$' ){
                            i++;
                            sb.appendCharacter('$');
                            continue;
                        }
                    }
                    sb.append( r.getVar( args[j++] ) );
                } else {
                    sb.appendCharacter( content[i] );
                }
            }
            
            content = sb.toString();
        }
        
        for(int i = 0 ; i < strlen( content );i++){
            print( content[i] );
            sleep( stop );
        }
        println("");
    }
}

struct Jump:Function{
    def override void run(RuntimeBasic r,string[] args){
        r.jump(args[0]);
    }
}

struct TypeString:Function{
    def override void run(RuntimeBasic r,string[] args){
        r.setVar(args[0],readString());
    }
}

struct RPGAdd:Function{
    def override void run(RuntimeBasic r,string[] args){
        int val = parseInt(r.getVar(args[0]));
        val += parseInt(r.getVar(args[1]));
        r.setVar(args[0],val);
    }
}

/*
 * It can also be done by "set tmp val, add var,tmp"
 */
struct RPGAddConst:Function{
    def override void run(RuntimeBasic r,string[] args){
        int val = parseInt(r.getVar(args[0]));
        val += parseInt(args[1]);
        r.setVar(args[0],val);
    }
}

struct Open:Function{
    def override void run(RuntimeBasic r,string[] args){
        r.open(args[0]);
        r.index = -1;
    }
}