package inter.stmt;

import inter.expr.ConversionFactory;
import inter.expr.Expr;
import runtime.VarTable;
import symbols.Type;

public class Return extends Stmt {
    protected Expr expr;
    private final int sizeOfStack;
    public Return(Expr e,Type t,int s){
        expr = e;
        check(t);
        sizeOfStack = s;
    }

    public void check(Type t){
        if(!t.isCongruentWith(expr.type)) {
            expr = ConversionFactory.getConversion(expr,t);
        }
    }

    @Override
    public Stmt optimize(){
        expr = expr.optimize();
        return this;
    }
    
    @Override
    public void run(){
        /*
         * I *KNOW* it is wrong use of exception
         * But it works well.
         * Maybe I will change the virtual machine.
         */
        ReturnResult r = new ReturnResult(expr.getValue());
        for(int i = 0 ; i < sizeOfStack;i++)
            VarTable.popTop();
        
        throw r;
    }

	@Override
	public boolean isLastStmt(){
		return true;
	}
    
    /*
        void emitBinaryCode(BinaryCode x){
            if(Expr.VoidExpr != expr){
                expr.emit(x,eax);
            }
            if(sizeOfStack == 0){
                x.emit(SRET_CALL);
            } else {
                x.emit(RET_CALL);
                x.emit(sizeOfStack);
            }
        }
    */

    @Override
    public String toString(){
        return "Return " + expr.toString() + "(" + sizeOfStack +")\n";
    }
}