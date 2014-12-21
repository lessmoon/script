/*test code */

import  "lib/file.xs";
import  "lib/system.xs";
import  "math/Math.xs";
/*
    def
*/


struct list {
    int    value;
    list   next;
    list   prev;
}

struct tree_node{
    tree_node left;
    tree_node right;
    int value;
}

tree_node null;
null = null.left;

def tree_node randomly_create_tree(){
    tree_node t;
    if(rand()%10 > 5)
        t.left  = randomly_create_tree();
    if(rand()%10 < 5)
        t.right = randomly_create_tree();
    t.value = rand()%1000;
    return t;
}

def int prettily_show_tree(tree_node tree,int level){
    if(tree != null){
        repeat_print("  |",level);
        print(tree.value);
        print("\n");
        prettily_show_tree( tree.left,level + 1 );
        prettily_show_tree( tree.right,level + 1 );
    }
    return level;
}

{
    srand(time());
    tree_node tree ;
    tree = randomly_create_tree();
    prettily_show_tree(tree,0);
}

def list create_list(list next,int value){
    list tmp ;
    tmp.value = value;
    tmp.next  = next;
    return tmp;
}

def list nulllist(){
    list tmp;
    return tmp.next;
}

def list printlist(list d){	
	list tmp = d;
	while( nulllist() != tmp){
   		print( (string)tmp + "\n" );
   		tmp = tmp.next;
	}
}

{
   int i = 0;
   print("pok\n");
   srand(time());
   list d = nulllist();
   int max = rand()%20;
   print("max = " + max + "\n");
   for(i = 0 ; i < max; i++){
        d = create_list(d,rand()%20);
   }
   printlist(d);
}

def string toString( char[80] c_str ){
    string r = "";
    int i = 0;
    while(c_str[i] != '\0'){
        r += c_str[i++];
    }
    return r;
}

def int[10][10] mult( int[10][10] a,int[10][10] b){
    string r = "";
    int[10][10] res;
    int i = 0;
    int sum = 0;
    int j = 0;
    int k = 0;
    for(i = 0 ; i < 10 ;i++){        
        for(j = 0 ; j < 10;j++){
            sum = 0;
            for(k = 0;k<10;k++){
                sum += a[i][k] * b[k][j];
            }
            res[i][j] = sum;
        }
    }
    return res;
}


def int printarray(int[2] arr,int len){
    int i = 0;
    print("[");
    for(i;i < len;i++){
        print(" " + arr[i]);
    }
    print(" ]\n");
    return len;
}

{
  int[1000] arr;
  int i = 0;
  int seed = time();
  print("seed = " + seed + "\n");
  srand( seed );
  int len = rand()%200;
  for(i = 0 ; i < len;i++){
    arr[i] = rand()%len;
  }
  printarray(arr,len);
  qsort(arr,0,len-1);
  printarray(arr,len);

  string[10][20] nums;
  i = 0;
  string test = "i am a test value";
  char[80] c_str;

  int[10][10] a;
  int[10][10] b;
  int[10][10] c;
  for(i ;i < 10;i++){
    int j = 0;
    for(i ;j < 10;j++){
      a[i][j] = i;
      b[i][j] = j;
    }
  }

  c = mult(a,b);
  for(i = 0 ;i < 10;i++){
    int j = 0;
    print("[");
    for(i ;j < 10;j++){
        print(" ");
        print(c[i][j]);
    }
    print(" ]\n");
  }

  for(i = 0;i < strlen(test);i++){
    c_str[i] = test[i];
  }
  c_str[i] = '\0';

  print(toString(c_str));
  print("\n");
  i = 0;
  for(i ;i < 10;i++){
    int j = 0;
    for(i ;j < 20;j++){
      nums[i][j] = (string)i + "," + j;
    }
  }

  for(i = 0 ;i < 10;i++){
    int j = 0;
    for(i ;j < 20;j++){
        print("(" + nums[i][j] + ")");
    }
    print("\n");
  }
  print("\n");
  /*
  int fid= open("t.txt");
   
  real y = 1.5;
  for (y; y > -1.5; y -= 0.1) {
    real x = -1.5;
    for (x; x < 1.5; x += 0.05) {
        real a = x * x + y * y - 1;
        writech(fid,a * a * a - x * x * y * y * y <= 0.0 ? '*' : ' ');
    }
    writech(fid,'\r');
    writech(fid,'\n');
  }
   close(fid);
  */
}

def int max(int a,int b){
    return a>b?a:b;
}

def string trim(string str){
    string result = "";
    int len = strlen(str);
    int i = 0,j = len - 1;
    while(str[i] == ' ') i++;
    while(str[j] == ' ') j--;
    for(i;i <= j;i++){
       result += str[i];
    }
    return result;
}

def bool is_prime(int n){
    if(n == 1)
        return false;
    int i = 2;
    for(i;i * i <= n;i++ ){
        if(n%i == 0){
            return false;
        }
    }
    return true;
}

def real sqrt(real n){
    real a = n/2;
    int i = 0;
    for(i;i < 20;i++){
        a = (n/a+a)/2;
    }
    return a;
}

def int string2int(string s){
    int i = 0;
    int v = 0;
    int len = strlen(s);
    for(i;i < len;i++){
        v *= 10;
        v += (s[i] - '0');
    }
    return v;
}

def bool println(string str){
    print(str);
    return print("\n");
}

{
    println((string)string2int("2556478"));
    print("" + sqrt(3) + "\n");
}

def string gestring(string str,char c,int i){
     string result = "";
     while(i < strlen(str)){
          if(str[i] >= c)
              result += str[i];
          i++;
     }
     return result;
}

def string lsstring(string str,char c,int i){
     int l = strlen(str);
     string result = "";
     while(i < l){
          if(str[i] < c)
              result += str[i];
          i++;
     }
     return result;
}

def string quicksort(string str){
    return strlen(str) <= 1?str:quicksort(lsstring(str,str[0],1)) + str[0]+quicksort(gestring(str,str[0],1));
}

{
    string a = "    32145547852248562244    ";
    print("quicksort(\"" + a + "\") = \""+ quicksort(a) + "\"\n");
    print("trim( \"" + a +"\") = \"" + trim(a) + "\"\n");
}
print("end test\n");