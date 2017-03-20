package inter.expr;

import lexer.Token;
import symbols.Struct;
import symbols.Type;

public class IsInstanceOf extends Op {
    public        Expr      expr;
    private final Type      cmptype;
    private boolean         precal = true;
    private boolean         haveto = false;
    public IsInstanceOf(Token tok,Expr e,Type t){
        super(tok,Type.Bool);
        expr = e;
        cmptype = t;
        check();
    }

    @Override
    public boolean isChangeable(){
        return expr.isChangeable();
    }

    void check(){
        if(cmptype instanceof Struct){
            if(expr.type instanceof Struct){
                if((expr.type).isCongruentWith(cmptype)){
                    precal = true;
                } else if(((Struct)expr.type).isChildOf((Struct)cmptype)){
                    precal = true;
                } else if(((Struct)cmptype).isChildOf((Struct)expr.type)){
                    precal = false;
                    haveto = true;
                } else {
                    precal = false;
                }
            } else {
                precal = false;
            }
        } else {
            precal = cmptype.isCongruentWith(expr.type);
        }
    }
    
    @Override
    public Expr optimize(){
        expr = expr.optimize();
        if(isChangeable()){
            return this;
        } else {
            return getValue();
        }
    }

    @Override
    public Value getValue(){
        Value c = expr.getValue();
        boolean  value = precal;
        if(haveto){
            assert(c.type instanceof Struct);
            assert(cmptype instanceof Struct);   
            value = cmptype.isCongruentWith(c.type)||((Struct)c.type).isChildOf((Struct)cmptype);
        }
        return value? Value.True: Value.False;
    }

    @Override
    public String toString(){
        return op.toString() + " " + expr.toString();
    }
}