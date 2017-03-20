package inter.expr;

public class OutPipe extends Expr{
    private InPipe inpipe;

    public OutPipe(InPipe inpipe){
        super(inpipe.op,inpipe.type);
        this.inpipe = inpipe;
    }
    
    @Override
    public Expr optimize(){
        Expr x = inpipe.optimize();
        if(x.isChangeable()){
            return this;
        }
        return x.getValue();
    }

    @Override
    public boolean isChangeable(){
        return inpipe.isChangeable();
    }

    @Override
    public Value getValue(){
        return inpipe.getPipeValue();
    }
}