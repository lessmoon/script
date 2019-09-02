package inter.expr;

import lexer.*;
import symbols.Type;

import java.math.BigDecimal;
import java.math.BigInteger;

class BigIntSet extends Set {
    BigIntSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        BigInteger r = ((BigNum) (expr.getValue().op)).value;
        BigInteger l = ((BigNum) (id.getValue().op)).value;
        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l.add(r)));
        case Tag.MINASS:
            return id.setValue(new Value(l.subtract(r)));
        case Tag.MULTASS:
            return id.setValue(new Value(l.multiply(r)));
        case Tag.DIVASS:
            return id.setValue(new Value(l.divide(r)));
        case Tag.MODASS:
            return id.setValue(new Value(l.mod(r)));
        default:
            return null;
        }
    }
}

class IntSet extends Set {

    IntSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        int r = ((Num) (expr.getValue().op)).value;
        int l = ((Num) (id.getValue().op)).value;

        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l + r));
        case Tag.MINASS:
            return id.setValue(new Value(l - r));
        case Tag.MULTASS:
            return id.setValue(new Value(l * r));
        case Tag.DIVASS:
            return id.setValue(new Value(l / r));
        case Tag.MODASS:
            return id.setValue(new Value(l % r));
        default:
            return null;
        }
    }
}

class CharSet extends Set {

    CharSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        char r = ((Char) (expr.getValue().op)).value;
        char l = ((Char) (id.getValue().op)).value;

        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l + r));
        case Tag.MINASS:
            return id.setValue(new Value(l - r));
        case Tag.MULTASS:
            return id.setValue(new Value(l * r));
        case Tag.DIVASS:
            return id.setValue(new Value(l / r));
        case Tag.MODASS:
            return id.setValue(new Value(l % r));
        default:
            return null;
        }
    }
}

class BigRealSet extends Set {
    BigRealSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        BigDecimal r = ((BigFloat) (expr.getValue().op)).value;
        BigDecimal l = ((BigFloat) (id.getValue().op)).value;
        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l.add(r)));
        case Tag.MINASS:
            return id.setValue(new Value(l.subtract(r)));
        case Tag.MULTASS:
            return id.setValue(new Value(l.multiply(r)));
        case Tag.DIVASS:
            return id.setValue(new Value(l.divide(r)));
        default:
            return null;
        }
    }
}

class RealSet extends Set {
    RealSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        float r = ((lexer.Float) (expr.getValue().op)).value;
        float l = ((lexer.Float) (id.getValue().op)).value;

        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l + r));
        case Tag.MINASS:
            return id.setValue(new Value(l - r));
        case Tag.MULTASS:
            return id.setValue(new Value(l * r));
        case Tag.DIVASS:
            return id.setValue(new Value(l / r));
        default:
            return null;
        }
    }
}

class StrSet extends Set {
    StrSet(Token tok, Expr i, Expr x) {
        super(tok, i, x);
    }

    public Value getValue() {
        String r = ((Str) (expr.getValue().op)).value;
        String l = ((Str) (id.getValue().op)).value;

        switch (op.tag) {
        case Tag.ADDASS:
            return id.setValue(new Value(l + r));
        default:
            return null;
        }
    }
}

public class SetFactory {
    static public Set getSet(Token tok, Expr i, Expr x) {
        if (tok.tag == '=') {
            return new Set(tok, i, x);
        } else if (i.type == Type.Int) {
            return new IntSet(tok, i, x);
        } else if (i.type == Type.Real) {
            return new RealSet(tok, i, x);
        } else if (i.type == Type.Str) {
            return new StrSet(tok, i, x);
        } else if (i.type == Type.Char) {
            return new CharSet(tok, i, x);
        } else if (i.type == Type.BigInt) {
            return new BigIntSet(tok, i, x);
        } else/* ( i.type == Type.BigReal) */ {
            return new BigRealSet(tok, i, x);
        }
    }
}