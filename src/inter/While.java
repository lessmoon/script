package inter;

import symbols.*;

public class While extends Stmt{
    Expr expr;
    Stmt stmt;
    
    public While(){
        expr = null;
        stmt = null;
    }

    public void init(Expr x,Stmt s){
        expr = x;
        stmt = s;
        if(expr.type != Type.Bool)
            expr.error("boolean required in while");
    }

    public void run(){
        while(expr.getValue() != Constant.False){
            try{
                stmt.run();
            }catch(RuntimeException e){
                if(e.getCause() == Break.BreakCause)
                    break;
                else if(e.getCause() == Continue.ContinueCause)
                    continue;
                else
                    throw e;
            }
        }
    }

    public Stmt optimize(){
        stmt = stmt.optimize();
        if(expr == Constant.False){/*constant False,it will never happen to run the stmt*/
            return Stmt.Null;
        }
        return this;
    }
}