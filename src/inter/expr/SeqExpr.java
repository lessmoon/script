package inter.expr;

import lexer.Token;

/*
 * calculate a first
 * (a,b) return a
 */
public class SeqExpr extends Expr {
    private Expr left;
    private Expr right;

    public SeqExpr(Token tok, Expr left, Expr right) {
        super(tok, left.type);
        this.left = left;
        this.right = right;
    }

    @Override
    public String toString() {
        return "(" + left + "," + right + ")";
    }

    @Override
    public Expr optimize() {
        left = left.optimize();
        right = right.optimize();
        if (right.isChangeable())
            return this;
        else
            return left;
    }

    @Override
    public boolean isChangeable() {
        return left.isChangeable() || right.isChangeable();
    }

    @Override
    public Value getValue() {
        Value c = left.getValue();
        right.getValue();
        return c;
    }
}
