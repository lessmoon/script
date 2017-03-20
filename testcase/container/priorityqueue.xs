import "content.xs";
import "sequence.xs";

struct PriorityQueue:Sequence{
    int size;
    int capacity;
    Comparable[] contents;
   
    def this(){
        this.size = 0;
        this.capacity = 15;
        this.contents = new Comparable[16];
    }
    
    def void swap(int i,int j){
        Comparable tmp = this.contents[i];
        this.contents[i]= this.contents[j];
        this.contents[j]= tmp;
    }
    
    def Comparable top(){
        return this.contents[1];
    }
    
    def Comparable pop(){
        if(this.size < 1){
            return null;
        }
        //swap the top to the end
        Comparable[] cc = this.contents;
        Comparable y = cc[1];
     
        this.swap(1,this.size);
        this.size--;
        int i = 1;
        int lc,rc;
        Comparable x = cc[1];
        do{
            lc = 2*i;
            rc = lc + 1;
            if(lc > this.size){
                break;
            } else if(rc > this.size){
                /*
                 *      [X]
                 *     /
                 *    Y (cc[lc]) 
                 *    we just need to compare X and Y
                 */
                if( x < cc[lc]){
                    this.swap(lc,i);
                }
                break;
            } else {
                /*
                 *      [X]
                 *     /  \
                 *    Y   Z
                 *    we need compare X,Y and Z,
                 *    choose the 'largest' one of them as the baseStruct node
                 */
                int max = lc;//the max index of child
                if(cc[lc] < cc[rc]){
                    max = rc;
                }
                if(cc[max] > x){
                    this.swap(max,i);
                    i = max;
                } else {
                    break;
                }
            }
        }while(true);
        
        if(this.size*4 < this.capacity){
            Comparable[] oldc = this.contents;
            this.capacity /= 2;
            this.contents = new Comparable[this.capacity + 1];
            for(int i = 1;i <= this.size;i++){
                this.contents[i] = oldc[i];
            }
        }
   
        return y;
    }
    
    def void push(Comparable e){
        if(++this.size > this.capacity){
            Comparable[] oldc = this.contents;
            this.capacity *= 2;
            this.contents = new Comparable[this.capacity + 1];
            for(int i = 1;i < this.size;i++){
                this.contents[i] = oldc[i];
            }
        }
        
        this.contents[this.size] = e;
        
        int x = this.size;
        //if the baseStruct node is less than the child node
        while(x >= 2 && this.contents[x/2] < e){
            this.swap(x,x/2);
            x /= 2;
        }
    }

    def override void add(Content c){
        this.push((Comparable)c);
    } 
    
    def override Iterator iterator(){
        PriorityQueue q = new PriorityQueue();
        q.size = this.size;
        q.capacity =this.capacity;
        q.contents = new Comparable[sizeof this.contents];
        
        for(int i = 1; i <= this.size() ;i++){
            q.contents[i] = this.contents[i];
        }
    
        return new Iterator(q){
            PriorityQueue p;
            Content value;
            
            def this(PriorityQueue q){
                this.p = q;
            }
            
            def override void next(){
                this.value = this.p.pop();
            }
            
            def override bool hasNext(){
                return !this.p.isEmpty();
            }
            
            def override Content getValue(){
                return this.value;
            }
        };
    }
    
    def void clear(){
        this.size = 0;
    }
    
    def override int size(){
        return this.size;
    }
    
    def override bool isEmpty(){
        return this.size == 0;
    }
    
    @string
    def string toString(){
        string b = "[ ";
        for(int i = 1 ; i <= this.size;i++){
            b += "" + this.contents[i] + " " ;
        }
        return b+"]";
    }
}


import "stream.xs";
import "../lib/sort.xs";

struct ComparableProxy : Comparable{
    Comparator compare;
    Content value;
    def this(Content value,Comparator compare){
        this.value = value;
        this.compare = compare;
    }
    
    def override bool less(Comparable b){
        return this.compare.compare(this.value,((ComparableProxy)b).value)<0;
    }
    
    def override string toString(){
        return this.value;
    }
};

def Stream Stream.sort(Comparator c){
    Iterator i;
    Sequence queue = new PriorityQueue();
    while((i = this.next()) != null){
        queue.add(new ComparableProxy(i.getValue(),c));
    }
    return queue.stream();
}

def Collector toPriorityQueue(){
    return new Collector(){
        def this(){
            super(new PriorityQueue());
        }
    };
}
