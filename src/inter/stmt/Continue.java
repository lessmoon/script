package inter.stmt;

import runtime.VarTable;

public class Continue extends Stmt {
    static public  final Throwable ContinueCause = new Throwable();
    Stmt stmt;
    private final int sizeOfStack;
    public Continue(int s){
        if( Stmt.Enclosing == Stmt.Null )
            error("unenclosed continue");
        stmt = Stmt.Enclosing;
        sizeOfStack = s;
    }

    @Override
    public void run(){
        /*
         * I *KNOW* it is wrong use of exception
         * But it works well.
         * Maybe I will change the virtual machine.
         */
        for(int i = 0 ; i < sizeOfStack;i++)
            VarTable.popTop();

        throw new RuntimeException(ContinueCause);
    }
	
	@Override
	public boolean isLastStmt(){
		return true;
	}
}