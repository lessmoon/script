struct point{
    int x;
    int y;
}

//int RAND_SEED = 0;
def int abs(int a){
    return a > 0? a : -a;
}

//def int srand(int v){
//    return RAND_SEED = v;
//}

//def int rand(){
//    RAND_SEED *= 134775813;
//    RAND_SEED += 1073676287;
//    RAND_SEED %= 2147483647;
//    return abs(RAND_SEED);
//}

def int qsort(int[] s,int l,int r){
    while (l < r){
        int i = l, j = r, x = s[l];  
        while (i < j)  
        {  
            while(i < j && s[j]>= x) j--;   
            if(i < j) s[i++] = s[j];  
            while(i < j && s[i]< x) i++;
            if(i < j) s[j--] = s[i];
        }
        s[i] = x;  
        qsort(s, l, i - 1);
        l++;
    }
    return 0;
}

native<extension.math.functions>{
    "sin":real sin(real theta);
    "cos":real cos(real theta);
    "SetSeed":void srand(int seed);
    "Random":int rand();
}