import"content.xs";
import"sequence.xs";

struct DynamicArray : Sequence{
    int capcity;
    int size;
    Content[] content;
    
    def this(int size);
    def Content first();
    def Content last();
    def void push_back(Content c);
    def void pop_back();
    def Content get(int i);
    def Content set(int i,Content c);
    def void reset_capcity(int c);

    def void clear(){
        this.size = 0;
    }
    
    def override void add(Content c){
        this.push_back(c);
    }

    def override Iterator iterator(){
        return new Iterator(this){
            int idx;
            DynamicArray darray;
            def this(DynamicArray darray){
                this.darray = darray;
                this.idx = -1;
            }
            
            def override void next(){
                if(this.idx < this.darray.size){
                    this.idx ++;
                }
            }
            
            def override bool hasNext(){
                return this.idx < this.darray.size - 1;
            }
            
            def override Content getValue(){
                return this.darray.get(this.idx);
            }
        };
    }
    
    def override int size(){
        return this.size;
    }

    def bool empty(){
        return this.size == 0;
    }

    def override bool isEmpty(){
        return this.size == 0;
    }
    
    def int capcity(){
        return this.capcity;
    }

    @string
    def string toString(){
        string buf = "[ ";
        for(int i = 0; i < this.size();i++){
            buf = buf + this.content[i] + " ";
        }
        buf += "]";
        return buf;
    }
}

def DynamicArray.this(int size){
    this.capcity = size;
    this.size = 0;
    this.content = new Content[size];
}

def Content DynamicArray.first(){
    return this.content[0];
}

def Content DynamicArray.last(){
    return this.content[this.size-1];
}

def void DynamicArray.push_back(Content c){
    if(this.size >= this.capcity){
        this.reset_capcity(this.capcity*2);
    }
    this.content[this.size] = c;
    this.size ++;
}

def void DynamicArray.pop_back(){
    if(this.size - 1 <= this.capcity / 4) {
        this.reset_capcity(this.capcity / 2);
    }
    this.size --;
}

def Content DynamicArray.get(int i){
    return this.content[i];
}

def Content DynamicArray.set(int i,Content c){
    return this.content[i] = c;
}

def void DynamicArray.reset_capcity(int c){
    int min = c<this.size?c:this.size;
    Content[] array = new Content[c];
    for(int i = 0;i< min;i++){
        array[i] = this.content[i];
    }
    this.size = min;
    this.capcity = c;
    this.content = array;
}

import "collector.xs";

def Collector toArray(){
    return new Collector(){
        def this(){
            super(new DynamicArray(10));
        }
    };
}