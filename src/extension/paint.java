package extension;

import lexer.Num;
import inter.Constant;
import java.util.ArrayList;

public class paint extends Function {
    public Constant run(ArrayList<Constant> paras){
        return new Constant(PaintPad.paint());
    }
}