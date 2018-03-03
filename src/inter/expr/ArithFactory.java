package inter.expr;

import inter.stmt.FunctionBasic;
import lexer.*;
import symbols.Struct;
import symbols.Type;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.List;

class IntArith extends Arith {
    IntArith(Token tok, Expr x1, Expr x2){
        super(tok,x1,x2);
    }

    public boolean check(){
        switch(op.tag){
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
            return true;
        default:/*error*/
            return false;
        }
    }
    
    public Value getValue(){
        int lv = ((Num)(expr1.getValue().op)).value;
        int rv = ((Num)(expr2.getValue().op)).value;
        Value v = null;
        switch(op.tag){
        case '+':
            return new Value(lv + rv);
        case '-':
            return new Value(lv - rv);
        case '*':
            return new Value(lv * rv);
        case '/':
            try{
                v = new Value(lv / rv);
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        case '%':
            try{
                v = new Value(lv % rv);
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        default:/*error*/
            return null;
        }

    }
}

class BigIntArith extends Arith{
    BigIntArith(Token tok, Expr x1, Expr x2){
        super(tok,x1,x2);
    }

    public boolean check(){
        switch(op.tag){
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
            return true;
        default:/*error*/
            return false;
        }
    }
    
    public Value getValue(){
        BigInteger lv = ((BigNum)(expr1.getValue().op)).value;
        BigInteger rv = ((BigNum)(expr2.getValue().op)).value;
        Value v = null;
        switch(op.tag){
        case '+':
            return new Value(lv.add(rv));
        case '-':
            return new Value(lv.subtract(rv));
        case '*':
            return new Value(lv.multiply(rv));
        case '/':
            try{
                v = new Value(lv.divide(rv));
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        case '%':
            try{
                v = new Value(lv.mod(rv));
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        default:/*error*/
            return null;
        }
    }
}

class RealArith extends Arith {
    RealArith(Token tok, Expr x1, Expr x2){
        super(tok,x1,x2);
    }

    public boolean check(){
        switch(op.tag){
        case '+':
        case '-':
        case '*':
        case '/':
            return true;
        default:/*error*/
            return false;
        }
    }
    
    public Value getValue(){
        float lv = ((lexer.Float)(expr1.getValue().op)).value;
        float rv = ((lexer.Float)(expr2.getValue().op)).value;

        Value v = null;
        switch(op.tag){
        case '+':
            return new Value(lv + rv);
        case '-':
            return new Value(lv - rv);
        case '*':
            return new Value(lv * rv);
        case '/':
            try{
                v = new Value(lv / rv);
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        default:/*error*/
            return null;
        }
    }
}

class BigRealArith extends Arith{
	private static int DIVIDE_SCALE = 100;

	static void setDivideScale(int scale){
		DIVIDE_SCALE = scale;
	}
	
    BigRealArith(Token tok, Expr x1, Expr x2){
        super(tok,x1,x2);
    }

    public boolean check(){
        switch(op.tag){
        case '+':
        case '-':
        case '*':
        case '/':
            return true;
        default:/*error*/
            return false;
        }
    }
    
    public Value getValue(){
        BigDecimal lv = ((BigFloat)(expr1.getValue().op)).value;
        BigDecimal rv = ((BigFloat)(expr2.getValue().op)).value;
        Value v = null;
        switch(op.tag){
        case '+':
            return new Value(lv.add(rv));
        case '-':
            return new Value(lv.subtract(rv));
        case '*':
            return new Value(lv.multiply(rv));
        case '/':
            try{
                v = new Value(lv.divide(rv,DIVIDE_SCALE,BigDecimal.ROUND_HALF_EVEN));
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        default:/*error*/
            return null;
        }
    }
}

class CharArith extends Arith {  
    CharArith(Token op, Expr x1, Expr x2){
        super(op,x1,x2);
    }

    public boolean check(){
        switch(op.tag){
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
            return true;
        default:/*error*/
            return false;
        }
    }

    public Value getValue(){
        char lv = ((Char)(expr1.getValue().op)).value;
        char rv = ((Char)(expr2.getValue().op)).value;

        Value v = null;
        switch(op.tag){
        case '+':
            return new Value((char)(lv + rv));
        case '-':
            return new Value((char)(lv - rv));
        case '*':
            return new Value((char)(lv * rv));
        case '/':
            try{
                v = new Value((char)(lv / rv));
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        case '%':
            try{
                v = new Value((char)(lv % rv));
            } catch(RuntimeException e){
                error(e.getMessage());
            }
            return v;
        default:/*error*/
            return null;
        }
    }
}

class StringCat extends Arith {  
    StringCat(Token op, Expr x1, Expr x2){
        super(op,x1,x2);
        if(expr1.type != Type.Str || expr2.type != Type.Str)
            error("String can't cat");
    }

    public boolean check(){
        switch(op.tag){
        case '+':
            return true;
        default:/*error*/
            return false;
        }
    }

    @Override
    public Expr optimize(){
        expr1 = expr1.optimize();
        expr2 = expr2.optimize();
        if(!expr1.isChangeable()){
            Value r = expr1.getValue();
            if(((Str)r.op).value.isEmpty()){
                return expr2;
            }
            if(!expr2.isChangeable())
                return this.getValue();
        } else if(!expr2.isChangeable()){
            Value r = expr2.getValue();
            if(((Str)r.op).value.isEmpty()){
                return expr1;
            }
        } 
        return this;
    }

    @Override
    public Value getValue(){
        Value str1 = expr1.getValue();
        Value str2 = expr2.getValue();
        String str = ((Str)(str1.op)).value + ((Str)(str2.op)).value;
        return new Value(str);
    }
}

public class ArithFactory {
    public static void setBigRealDivideScale(int scale){
        BigRealArith.setDivideScale(scale);
    }

    public static Expr getArith(Token tok, Expr e1, Expr e2){
        if(e1.type instanceof Struct){
            Token fName = ((Struct)(e1.type)).getOverloading(tok);
            if(fName != null){

                if(e2 != null){
                    List<Expr> p = new ArrayList<>();
                    FunctionBasic f = ((Struct)(e1.type)).getNaiveFunction(fName);
                    if(f != null){
                        p.add(e1);
                        p.add(e2);
                        return new FunctionInvoke(f, p);
                    }
                    f = ((Struct)(e1.type)).getVirtualFunction(fName);
                    if(f != null){
                        p.add(e2);
                        return new VirtualFunctionInvoke(e1, f, p);
                    }
                }
            }
            e1.error("Operand `" + tok + "' can't be used between `" + e1.type + "' and `" + e2.type + "'");
            return null;
        }

        Type t = Type.max(e1.type,e2.type);

        if(Type.numeric(t) || t == Type.Str){
            if(e1.type != t){
                e1 = ConversionFactory.getConversion(e1,t);
            }
            if(e2.type != t){
                e2 = ConversionFactory.getConversion(e2,t);
            }
            if(t == Type.Int){
                return new IntArith(tok,e1,e2);
            } else if(t == Type.Real){
                return new RealArith(tok,e1,e2);
            } else if(t == Type.Char){
                return new CharArith(tok,e1,e2);
            } else if(t == Type.Str){
                if(tok.tag == '+'){
                    return new StringCat(tok,e1,e2);
                }
            } else if(t == Type.BigInt){
                return new BigIntArith(tok,e1,e2);
            } else if(t == Type.BigReal){
                return new BigRealArith(tok,e1,e2);
            }
        }
        e1.error("Operand `" + tok + "' can't be used between `" + e1.type + "' and `" + e2.type + "'");
        return null;
    }
}