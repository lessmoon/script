package inter.expr;

import lexer.Num;
import lexer.Token;
import symbols.Array;
import symbols.Type;

public class NewArray extends Op {
    public Expr size;
    public NewArray(Token tok,Type of,Expr sz){
        super(tok,null);
        size = sz;
        type = new Array(of);
        check();
    }

    void check(){
        Type t = Type.max(Type.Int,size.type);
        if(t != Type.Int){
            error("Array size can't be `" + size.type + "'");
        }
        if( size.type != Type.Int )
            size = ConversionFactory.getConversion(size,Type.Int);
    }

    @Override
    public boolean isChangeable(){
        return true;
    }

    @Override
    public Expr optimize(){
        if(isChangeable()){
            size = size.optimize();
            return this;
        } else {
            return getValue();
        }
    }

    @Override
    public Value getValue(){
        Value v = size.getValue();
        int sz = ((Num)(v.op)).value;
        if(sz < 0){
            error("try to allocate `" + type +"' array with negative number:" + sz);
        }
        return new ArrayValue((Array)type,sz);
    }

    @Override
    public String toString(){
        return "new [" + size + "]" + type.toString();
    }
}