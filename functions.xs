File.this(){
NullStmt
}
void File.close(){
if(!=($$this[0,0].[2]fis,null)){
$$this[0,0].[2]fis.close()
}
if(!=($$this[0,0].[3]fos,null)){
$$this[0,0].[3]fos.close()
}
Set($$this[0,0].[1]file=null)
}
bool File.open(string fname,bool append){
$$this[0,0].close()
Set($$this[0,0].[0]fname=$$fname[0,1])
Set($$this[0,0].[1]file=(new SimpleFile,SimpleFile.this(OutPipe,$$this[0,0].[0]fname)))
if(! $$this[0,0].[1]file.exists()){
$$this[0,0].[1]file.createNewFile()
}
if(==($$this[0,0].[2]fis,null) ){
Set($$this[0,0].[2]fis=(new FileInputStream,FileInputStream.this(OutPipe,$$this[0,0].[1]file)))
}else {
$$this[0,0].[2]fis.open($$this[0,0].[1]file)
}
if(==($$this[0,0].[3]fos,null) ){
Set($$this[0,0].[3]fos=(new FileOutputStream,FileOutputStream.this(OutPipe,$$this[0,0].[1]file,$$append[0,2])))
}else {
$$this[0,0].[3]fos.open($$this[0,0].[1]file,$$append[0,2])
}
}
bool File.is_open(){
Return !=($$this[0,0].[1]file,null)(0)
}
string File.file_name(){
Return $$this[0,0].[0]fname(0)
}
int File.readch(){
Return $$this[0,0].[2]fis.readChar()(0)
}
void File.writech(char c){
$$this[0,0].[3]fos.writeInt(CharIntConversion($$c[0,1]))
}
string MyTime.toString(){
Return StrConversion($$this[0,0].[0]hour) + : + StrConversion($$this[0,0].[1]minute) + : + StrConversion($$this[0,0].[2]second)(0)
}
int  repeat_print(string s,int c){
Decl[int] i=0
for(Set($$i[0,2]=0)
;<($$i[0,2],$$c[0,1]);++ $$i[0,2]
){
print($$s[0,0])
}
Return 0(0)
}
void  println(string s){
SEQ{print($$s[0,0] + 
)
Return void expr(0)
}}
bool  isDigit(char c){
Return &&(>=($$c[0,0],0),<=($$c[0,0],9))(0)
}
bool  isEndLine(char c){
Return ||(==($$c[0,0],),==($$c[0,0],
))(0)
}
bool  isBlank(char c){
Return ||(==($$c[0,0], ),isEndLine($$c[0,0]))(0)
}
bigint  parseBigInt(string str){
Decl[bigint] num=0
Decl[int] len=strlen($$str[0,0])
Decl[bool] is_minus=false
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$len[1,2]);++ $$i[0,0]
){
if(isDigit(StringVarAccess) ){
SEQ{BigIntSet($$num[1,1]*=10)
BigIntSet($$num[1,1]+=IntBigIntConversion(CharIntConversion(StringVarAccess - 0)))
}}else {
if(==(StringVarAccess,-) ){
SEQ{Set($$is_minus[1,3]=! $$is_minus[1,3])
inter.stmt.Continue
}}else {
inter.stmt.Break
}
}
}
RecoverStack
Return (($$is_minus[0,3])?(- $$num[0,1]):($$num[0,1]))(0)
}
int  parseInt(string str){
Decl[int] num=0
Decl[int] len=strlen($$str[0,0])
Decl[bool] is_minus=false
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$len[1,2]);++ $$i[0,0]
){
if(isDigit(StringVarAccess) ){
SEQ{IntSet($$num[1,1]*=10)
IntSet($$num[1,1]+=CharIntConversion(StringVarAccess - 0))
}}else {
if(==(StringVarAccess,-) ){
SEQ{Set($$is_minus[1,3]=! $$is_minus[1,3])
inter.stmt.Continue
}}else {
inter.stmt.Break
}
}
}
RecoverStack
Return (($$is_minus[0,3])?(- $$num[0,1]):($$num[0,1]))(0)
}
int  readNumber(){
Decl[StringBuffer] l=(new StringBuffer,StringBuffer.this(OutPipe))
Decl[char] c= 
while(! isDigit(Set($$c[0,1]=IntCharConversion(getchar())))){
NullStmt
}
do{
$$l[0,0].appendCharacter($$c[0,1])
}while(isDigit(Set($$c[0,1]=IntCharConversion(getchar()))));
Return parseInt($$l[0,0].toString())(0)
}
string  readString(){
Decl[StringBuffer] l=(new StringBuffer,StringBuffer.this(OutPipe))
Decl[char] c= 
while(isBlank(Set($$c[0,1]=IntCharConversion(getchar())))){
NullStmt
}
do{
$$l[0,0].appendCharacter($$c[0,1])
}while(! isEndLine(Set($$c[0,1]=IntCharConversion(getchar()))));
Return $$l[0,0].toString()(0)
}
void Timer.start(){
SEQ{$$this[0,0].clear()
Set($$this[0,0].[1]start=BigIntIntConversion(time()))
}}
void Timer.pause(){
if(!=($$this[0,0].[1]start,0)){
SEQ{IntSet($$this[0,0].[0]duration+=BigIntIntConversion(time() - IntBigIntConversion($$this[0,0].[1]start)))
Set($$this[0,0].[1]start=0)
}}
}
void Timer.resume(){
if(==($$this[0,0].[1]start,0)){
Set($$this[0,0].[1]start=BigIntIntConversion(time()))
}
}
int Timer.getDuration(){
if(==($$this[0,0].[1]start,0) ){
Return $$this[0,0].[0]duration(0)
}else {
Return BigIntIntConversion(time() - IntBigIntConversion($$this[0,0].[1]start))(0)
}
}
void Timer.clear(){
SEQ{Set($$this[0,0].[1]start=0)
Set($$this[0,0].[0]duration=0)
}}
IntContent.this(int val){
Set($$this[0,0].[0]val=$$val[0,1])
}
string IntContent.toString(){
Return StrConversion($$this[0,0].[0]val)(0)
}
int IntContent.toInt(){
Return $$this[0,0].[0]val(0)
}
StringContent.this(string val){
Set($$this[0,0].[0]val=$$val[0,1])
}
string StringContent.toString(){
Return $$this[0,0].[0]val(0)
}
StringHashContent.this(string value){
Set($$this[0,0].[0]value=$$value[0,1])
}
int StringHashContent.hash(){
Decl[int] len=strlen($$this[0,0].[0]value)
Decl[int] hash_code=0
while(>(-- $$len[0,1],0)){
SEQ{IntSet($$hash_code[0,2]*=10)
IntSet($$hash_code[0,2]+=CharIntConversion(StringVarAccess))
}}
if(<($$hash_code[0,2],0)){
Set($$hash_code[0,2]=- $$hash_code[0,2])
}
Return $$hash_code[0,2](0)
}
string StringHashContent.toString(){
Return $$this[0,0].[0]value(0)
}
bool StringHashContent.equals(HashContent c){
Return ||(==($$c[0,1],$$this[0,0]),&&(instanceof $$c[0,1],==(DownCastConversion($$c[0,1]).[0]value,$$this[0,0].[0]value)))(0)
}
Trigger.this(){
Set($$this[0,0].[0]imp=(new MyTrigger,MyTrigger.this(OutPipe)))
}
void Trigger.triggerAll(){
$$this[0,0].[0]imp.triggerAll()
}
void Trigger.wait(){
$$this[0,0].[0]imp.wait()
}
Schedule.this(int interval,Condition cond,Runnable run){
Set($$this[0,0].[0]interval=$$interval[0,1])
Set($$this[0,0].[1]cond=$$cond[0,2])
Set($$this[0,0].[2]run=$$run[0,3])
}
void Schedule.run(){
while($$this[0,0].[1]cond.[virtual]isTrue()){
SEQ{sleep($$this[0,0].[0]interval)
$$this[0,0].[2]run.[virtual]run()
}}
}
bool RepeatSchedule.isTrue(){
Return true(0)
}
Timer2.this(Runnable run,int interval){
Set($$this[0,0].[0]thread=(new Thread,Thread.this(OutPipe,(new Schedule,Schedule.this(OutPipe,$$interval[0,2],new RepeatSchedule,$$run[0,1])))))
}
void Timer2.start(){
$$this[0,0].[0]thread.start()
}
void Timer2.stop(){
$$this[0,0].[0]thread.interrupt()
}
Timer2Adapter.this(int interval){
Set($$this[0,0].[0]timer=(new Timer2,Timer2.this(OutPipe,$$this[0,0],$$interval[0,1])))
}
void Timer2Adapter.start(){
$$this[0,0].[0]timer.start()
}
void Timer2Adapter.stop(){
$$this[0,0].[0]timer.stop()
}
void Timer2Adapter.run(){
NullStmt
}
AtomicInteger.this(){
Set($$this[0,0].[0]value=0)
Set($$this[0,0].[1]lock=(new MutexLock,MutexLock.this(OutPipe)))
Set($$this[0,0].[2]n=(new Trigger,Trigger.this(OutPipe)))
}
int AtomicInteger.getAndSet(int value){
$$this[0,0].[1]lock.wait()
Decl[int] res=$$this[0,0].[0]value
Set($$this[0,0].[0]value=$$value[0,1])
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
Return $$res[0,2](0)
}
int AtomicInteger.setAndGet(int value){
SEQ{$$this[0,0].getAndSet($$value[0,1])
Return $$value[0,1](0)
}}
int AtomicInteger.incrementAndGet(){
$$this[0,0].[1]lock.wait()
Decl[int] res=++ $$this[0,0].[0]value
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
Return $$res[0,1](0)
}
void AtomicInteger.waitAndDecrement(int min){
do{
$$this[0,0].[1]lock.wait()
if(>($$this[0,0].[0]value,$$min[0,1])){
-- $$this[0,0].[0]value
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
Return void expr(0)
}
$$this[0,0].[1]lock.release()
$$this[0,0].[2]n.wait()
}while(true);
}
void AtomicInteger.waitAndIncrement(int max){
do{
$$this[0,0].[1]lock.wait()
if(<($$this[0,0].[0]value,$$max[0,1])){
++ $$this[0,0].[0]value
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
Return void expr(0)
}
$$this[0,0].[1]lock.release()
$$this[0,0].[2]n.wait()
}while(true);
}
int AtomicInteger.getAndIncrement(){
Return $$this[0,0].incrementAndGet() - 1(0)
}
int AtomicInteger.decrementAndGet(){
$$this[0,0].[1]lock.wait()
Decl[int] res=-- $$this[0,0].[0]value
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
Return $$res[0,1](0)
}
int AtomicInteger.getAndDecrement(){
Return $$this[0,0].decrementAndGet() + 1(0)
}
int AtomicInteger.get(){
$$this[0,0].[1]lock.wait()
Decl[int] res=$$this[0,0].[0]value
$$this[0,0].[1]lock.release()
Return $$res[0,1](0)
}
void AtomicInteger.set(int value){
$$this[0,0].[1]lock.wait()
Set($$this[0,0].[0]value=$$value[0,1])
$$this[0,0].[2]n.triggerAll()
$$this[0,0].[1]lock.release()
}
string AtomicInteger.toString(){
Return StrConversion($$this[0,0].get())(0)
}
ReadLock.this(Lock write){
Set($$this[0,0].[0]writeLock=$$write[0,1])
}
void ReadLock.unlock(){
NullStmt
}
void ReadLock.lock(){
NullStmt
}
void AsyncRunnable.run(){
Set($$this[0,0].[0]value=$$this[0,0].[virtual]get())
}
Future.this(AsyncRunnable r){
Set($$this[0,0].[0]t=(new Thread,Thread.this(OutPipe,$$r[0,1])))
Set($$this[0,0].[1]r=$$r[0,1])
$$this[0,0].[0]t.start()
}
Content Future.get(){
SEQ{$$this[0,0].[0]t.join(0)
Return $$this[0,0].[1]r.[0]value(0)
}}
binode.this(Content value,binode prev,binode next){
Set($$this[0,0].[2]value=$$value[0,1])
Set($$this[0,0].[0]next=$$next[0,3])
Set($$this[0,0].[1]prev=$$prev[0,2])
}
string binode.toString(){
Return $$this[0,0].[2]value.[virtual]toString()(0)
}
bilist.this(){
Set($$this[0,0].[0]head=(new binode,binode.this(OutPipe,null,null,null)))
Set($$this[0,0].[1]tail=(new binode,binode.this(OutPipe,null,$$this[0,0].[0]head,null)))
Set($$this[0,0].[0]head.[0]next=$$this[0,0].[1]tail)
}
void bilist.push_front(Content value){
SEQ{Set($$this[0,0].[0]head.[0]next=(new binode,binode.this(OutPipe,$$value[0,1],$$this[0,0].[0]head,$$this[0,0].[0]head.[0]next)))
Set($$this[0,0].[0]head.[0]next.[0]next.[1]prev=$$this[0,0].[0]head.[0]next)
}}
void bilist.push_back(Content value){
SEQ{Set($$this[0,0].[1]tail.[1]prev=(new binode,binode.this(OutPipe,$$value[0,1],$$this[0,0].[1]tail.[1]prev,$$this[0,0].[1]tail)))
Set($$this[0,0].[1]tail.[1]prev.[1]prev.[0]next=$$this[0,0].[1]tail.[1]prev)
}}
binode bilist.front(){
Return $$this[0,0].[0]head.[0]next(0)
}
binode bilist.back(){
Return $$this[0,0].[1]tail.[1]prev(0)
}
Content bilist.pop_front(){
Decl[Content] tmp=$$this[0,0].[0]head.[0]next.[2]value
Set($$this[0,0].[0]head.[0]next=$$this[0,0].[0]head.[0]next.[0]next)
Set($$this[0,0].[0]head.[0]next.[1]prev=$$this[0,0].[0]head)
Return $$tmp[0,1](0)
}
Content bilist.pop_back(){
Decl[Content] tmp=$$this[0,0].[1]tail.[1]prev.[2]value
Set($$this[0,0].[1]tail.[1]prev=$$this[0,0].[1]tail.[1]prev.[1]prev)
Set($$this[0,0].[1]tail.[1]prev.[0]next=$$this[0,0].[1]tail)
Return $$tmp[0,1](0)
}
string bilist.toString(){
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
$$sb[0,1].append([)
PushStack
for(Decl[binode] i=$$this[1,0].front()
;!=($$i[0,0].[0]next,null);Set($$i[0,0]=$$i[0,0].[0]next)
){
$$sb[1,1].append(  + $$i[0,0].toString())
}
RecoverStack
$$sb[0,1].append( ])
}
ConcurrentQueue.this(){
Set($$this[0,0].[0]full=(new AtomicInteger,AtomicInteger.this(OutPipe)))
Set($$this[0,0].[1]empty=(new AtomicInteger,AtomicInteger.this(OutPipe)))
Set($$this[0,0].[2]lock=(new MutexLock,MutexLock.this(OutPipe)))
$$this[0,0].[0]full.set(100)
$$this[0,0].[1]empty.set(0)
Set($$this[0,0].[3]list=(new bilist,bilist.this(OutPipe)))
}
void ConcurrentQueue.put(Content i){
$$this[0,0].[0]full.waitAndDecrement(0)
$$this[0,0].[2]lock.wait()
$$this[0,0].[3]list.push_back($$i[0,1])
$$this[0,0].[2]lock.release()
$$this[0,0].[1]empty.incrementAndGet()
}
Content ConcurrentQueue.pop(){
$$this[0,0].[1]empty.waitAndDecrement(0)
$$this[0,0].[2]lock.wait()
Decl[Content] res=$$this[0,0].[3]list.pop_front()
$$this[0,0].[2]lock.release()
$$this[0,0].[0]full.incrementAndGet()
Return $$res[0,1](0)
}
int ConcurrentQueue.size(){
Return $$this[0,0].[1]empty.get()(0)
}
int  abs(int a){
Return ((>($$a[0,0],0))?($$a[0,0]):(- $$a[0,0]))(0)
}
int  qsort(int[] s,int l,int r){
SEQ{while(<($$l[0,1],$$r[0,2])){
SEQ{PushStack
Decl[int] i=$$l[1,1]
Decl[int] j=$$r[1,2]
Decl[int] x=$$s[1,0][$$l[1,1]]
while(<($$i[0,0],$$j[0,1])){
while(&&(<($$i[0,0],$$j[0,1]),>=($$s[1,0][$$j[0,1]],$$x[0,2]))){
-- $$j[0,1]
}
if(<($$i[0,0],$$j[0,1])){
Set($$s[1,0][++ $$i[0,0]]=$$s[1,0][$$j[0,1]])
}
while(&&(<($$i[0,0],$$j[0,1]),<($$s[1,0][$$i[0,0]],$$x[0,2]))){
++ $$i[0,0]
}
if(<($$i[0,0],$$j[0,1])){
Set($$s[1,0][-- $$j[0,1]]=$$s[1,0][$$i[0,0]])
}
}
Set($$s[1,0][$$i[0,0]]=$$x[0,2])
qsort($$s[1,0],$$l[1,1],$$i[0,0] - 1)
++ $$l[1,1]
RecoverStack
}}
Return 0(0)
}}
int  do_gcd(int a,int b){
Return ((>($$b[0,1],0))?(do_gcd($$b[0,1],$$a[0,0] % $$b[0,1])):($$a[0,0]))(0)
}
int  gcd(int a,int b){
Set($$a[0,0]=((>($$a[0,0],0))?($$a[0,0]):(- $$a[0,0])))
Set($$b[0,1]=((>($$b[0,1],0))?($$b[0,1]):(- $$b[0,1])))
Return do_gcd($$a[0,0],$$b[0,1])(0)
}
Ratio Ratio.reduce(){
Decl[int] f=gcd($$this[0,0].[0]num,$$this[0,0].[1]den)
IntSet($$this[0,0].[0]num/=$$f[0,1])
IntSet($$this[0,0].[1]den/=$$f[0,1])
Return $$this[0,0](0)
}
void Ratio.init(int num,int den){
Set($$this[0,0].[0]num=$$num[0,1])
Set($$this[0,0].[1]den=$$den[0,2])
$$this[0,0].reduce()
}
Ratio Ratio.add(Ratio r){
Decl[Ratio] tmp=new Ratio
Set($$tmp[0,2].[0]num=$$r[0,1].[1]den * $$this[0,0].[0]num + $$this[0,0].[1]den * $$r[0,1].[0]num)
Set($$tmp[0,2].[1]den=$$r[0,1].[1]den * $$this[0,0].[1]den)
Return $$tmp[0,2].reduce()(0)
}
Ratio Ratio.sub(Ratio r){
Decl[Ratio] tmp=new Ratio
Set($$tmp[0,2].[0]num=$$r[0,1].[1]den * $$this[0,0].[0]num - $$this[0,0].[1]den * $$r[0,1].[0]num)
Set($$tmp[0,2].[1]den=$$r[0,1].[1]den * $$this[0,0].[1]den)
Return $$tmp[0,2].reduce()(0)
}
Ratio Ratio.mult(Ratio r){
Decl[Ratio] tmp=new Ratio
Set($$tmp[0,2].[0]num=$$r[0,1].[0]num * $$this[0,0].[0]num)
Set($$tmp[0,2].[1]den=$$r[0,1].[1]den * $$this[0,0].[1]den)
Return $$tmp[0,2].reduce()(0)
}
Ratio Ratio.div(Ratio r){
Decl[Ratio] tmp=new Ratio
Set($$tmp[0,2].[0]num=$$this[0,0].[0]num * $$r[0,1].[1]den)
Set($$tmp[0,2].[1]den=$$r[0,1].[0]num * $$this[0,0].[1]den)
Return $$tmp[0,2].reduce()(0)
}
bool Ratio.equals(Ratio r){
$$r[0,1].reduce()
$$this[0,0].reduce()
Return &&(==($$this[0,0].[0]num,$$r[0,1].[0]num),==($$this[0,0].[1]den,$$r[0,1].[1]den))(0)
}
string Ratio.toString(){
Return StrConversion($$this[0,0].[0]num) + / + StrConversion($$this[0,0].[1]den)(0)
}
void Arith.init(Expr e1,Expr e2){
SEQ{Set($$this[0,0].[0]e1=$$e1[0,1])
Set($$this[0,0].[1]e2=$$e2[0,2])
}}
real Add.getValue(){
Return $$this[0,0].[0]e1.[virtual]getValue() + $$this[0,0].[1]e2.[virtual]getValue()(0)
}
real Sub.getValue(){
Return $$this[0,0].[0]e1.[virtual]getValue() - $$this[0,0].[1]e2.[virtual]getValue()(0)
}
real Mult.getValue(){
Return $$this[0,0].[0]e1.[virtual]getValue() * $$this[0,0].[1]e2.[virtual]getValue()(0)
}
real Div.getValue(){
Return $$this[0,0].[0]e1.[virtual]getValue() / $$this[0,0].[1]e2.[virtual]getValue()(0)
}
void Const.setValue(int v){
Set($$this[0,0].[0]value=IntRealConversion($$v[0,1]))
}
real Const.getValue(){
Return $$this[0,0].[0]value(0)
}
string Token.toString(){
Return StrConversion($$this[0,0].[0]tag)(0)
}
void Token.setTag(int d){
Set($$this[0,0].[0]tag=$$d[0,1])
}
string Num.toString(){
Return StrConversion($$this[0,0].[1]value)(0)
}
void Num.init(real value){
SEQ{Set($$this[0,0].[1]value=$$value[0,1])
$$this[0,0].setTag(256)
}}
bool  isDigital(char c){
Return &&(<=($$c[0,0],9),>=($$c[0,0],0))(0)
}
void lexer.init(string poly){
Set($$this[0,0].[2]poly=$$poly[0,1])
Set($$this[0,0].[1]peek= )
Set($$this[0,0].[0]no=0)
}
void lexer.readch(){
if(>=($$this[0,0].[0]no,strlen($$this[0,0].[2]poly)) ){
Set($$this[0,0].[1]peek= )
}else {
SEQ{Set($$this[0,0].[1]peek=StringVarAccess)
++ $$this[0,0].[0]no
}}
}
Token lexer.scan(){
Decl[Token] t=new Token
while(==($$this[0,0].[1]peek, )){
$$this[0,0].readch()
}
Decl[char] c=$$this[0,0].[1]peek
if(isDigital($$c[0,2])){
PushStack
Decl[int] i=0
do{
IntSet($$i[0,0]*=10)
IntSet($$i[0,0]+=CharIntConversion($$c[1,2] - 0))
$$this[1,0].readch()
Set($$c[1,2]=$$this[1,0].[1]peek)
}while(isDigital($$c[1,2]));
Decl[Num] n=new Num
$$n[0,1].init(IntRealConversion($$i[0,0]))
Return $$n[0,1](1)
}
$$t[0,1].setTag(CharIntConversion($$c[0,2]))
Set($$this[0,0].[1]peek= )
Return $$t[0,1](0)
}
void parser.init(lexer l){
SEQ{Set($$this[0,0].[0]lex=$$l[0,1])
Set($$this[0,0].[2]xVar=new Var)
}}
Var parser.getVar(){
Return $$this[0,0].[2]xVar(0)
}
void parser.next(){
Set($$this[0,0].[1]look=$$this[0,0].[0]lex.scan())
}
Expr parser.expr(){
SEQ{$$this[0,0].next()
Return $$this[0,0].add()(0)
}}
Expr parser.term(){
IntSwitch($$this[0,0].[1]look.[0]tag){
case 40=>{
$$this[0,0].next()
PushStack
Decl[Expr] e=$$this[1,0].add()
if(!=($$this[1,0].[1]look.[0]tag,41) ){
println(`(' mismatched)
}else {
$$this[1,0].next()
}
Return $$e[0,0](1)
}
case 256=>{
PushStack
Decl[Const] e=new Const
$$e[0,0].setValue(RealIntConversion(DownCastConversion($$this[1,0].[1]look).[1]value))
$$this[1,0].next()
Return $$e[0,0](1)
}
case 120 88=>{
$$this[0,0].next()
Return $$this[0,0].getVar()(0)
default=>{
println(Unknown token ` + $$this[0,0].[1]look.[virtual]toString() + ' found)
}
}
}
Expr parser.mult(){
Decl[Expr] e=$$this[0,0].term()
while(||(==($$this[0,0].[1]look.[0]tag,42),==($$this[0,0].[1]look.[0]tag,47))){
if(==($$this[0,0].[1]look.[0]tag,42) ){
SEQ{$$this[0,0].next()
PushStack
Decl[Mult] m=new Mult
$$m[0,0].init($$e[1,1],$$this[1,0].term())
Set($$e[1,1]=$$m[0,0])
RecoverStack
}}else {
SEQ{$$this[0,0].next()
PushStack
Decl[Div] d=new Div
$$d[0,0].init($$e[1,1],$$this[1,0].term())
Set($$e[1,1]=$$d[0,0])
RecoverStack
}}
}
Return $$e[0,1](0)
}
Expr parser.add(){
Decl[Expr] e=$$this[0,0].mult()
while(||(==($$this[0,0].[1]look.[0]tag,43),==($$this[0,0].[1]look.[0]tag,45))){
if(==($$this[0,0].[1]look.[0]tag,43) ){
SEQ{$$this[0,0].next()
PushStack
Decl[Add] a=new Add
$$a[0,0].init($$e[1,1],$$this[1,0].mult())
Set($$e[1,1]=$$a[0,0])
RecoverStack
}}else {
SEQ{$$this[0,0].next()
PushStack
Decl[Sub] s=new Sub
$$s[0,0].init($$e[1,1],$$this[1,0].mult())
Set($$e[1,1]=$$s[0,0])
RecoverStack
}}
}
Return $$e[0,1](0)
}
void DynamicArray.clear(){
Set($$this[0,0].[1]size=0)
}
int DynamicArray.size(){
Return $$this[0,0].[1]size(0)
}
bool DynamicArray.empty(){
Return ==($$this[0,0].[1]size,0)(0)
}
int DynamicArray.capcity(){
Return $$this[0,0].[0]capcity(0)
}
string DynamicArray.toString(){
Decl[string] buf=[ 
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$this[1,0].size());++ $$i[0,0]
){
Set($$buf[1,1]=$$buf[1,1] + $$this[1,0].[2]content[$$i[0,0]].[virtual]toString() +  )
}
RecoverStack
StrSet($$buf[0,1]+=])
Return $$buf[0,1](0)
}
DynamicArray.this(int size){
Set($$this[0,0].[0]capcity=$$size[0,1])
Set($$this[0,0].[1]size=0)
Set($$this[0,0].[2]content=new [$$size[0,1]]Content[])
}
Content DynamicArray.first(){
Return $$this[0,0].[2]content[0](0)
}
Content DynamicArray.last(){
Return $$this[0,0].[2]content[$$this[0,0].[1]size - 1](0)
}
void DynamicArray.push_back(Content c){
if(>=($$this[0,0].[1]size,$$this[0,0].[0]capcity)){
$$this[0,0].reset_capcity($$this[0,0].[0]capcity * 2)
}
Set($$this[0,0].[2]content[$$this[0,0].[1]size]=$$c[0,1])
++ $$this[0,0].[1]size
}
void DynamicArray.pop_back(){
SEQ{if(<=($$this[0,0].[1]size - 1,$$this[0,0].[0]capcity / 4)){
$$this[0,0].reset_capcity($$this[0,0].[0]capcity / 2)
}
-- $$this[0,0].[1]size
}}
Content DynamicArray.get(int i){
Return $$this[0,0].[2]content[$$i[0,1]](0)
}
Content DynamicArray.set(int i,Content c){
Return Set($$this[0,0].[2]content[$$i[0,1]]=$$c[0,2])(0)
}
void DynamicArray.reset_capcity(int c){
Decl[int] min=((<($$c[0,1],$$this[0,0].[1]size))?($$c[0,1]):($$this[0,0].[1]size))
Decl[Content[]] array=new [$$c[0,1]]Content[]
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$min[1,2]);++ $$i[0,0]
){
Set($$array[1,3][$$i[0,0]]=$$this[1,0].[2]content[$$i[0,0]])
}
RecoverStack
Set($$this[0,0].[1]size=$$min[0,2])
Set($$this[0,0].[0]capcity=$$c[0,1])
Set($$this[0,0].[2]content=$$array[0,3])
}
HashPair.this(HashContent key,Content value){
SEQ{Set($$this[0,0].[0]key=$$key[0,1])
Set($$this[0,0].[1]value=$$value[0,2])
}}
string HashPair.toString(){
Return [ + $$this[0,0].[0]key.[virtual]toString() + : + $$this[0,0].[1]value.[virtual]toString() + ](0)
}
HashMapNode.this(HashPair value,HashMapNode next){
SEQ{Set($$this[0,0].[1]next=$$next[0,2])
Set($$this[0,0].[0]value=$$value[0,1])
}}
string HashMapNode.toString(){
Return $$this[0,0].[0]value.toString() + ((==($$this[0,0].[1]next,null))?():(, + $$this[0,0].[1]next.toString()))(0)
}
HashMap.this(){
Set($$this[0,0].[0]size=0)
Set($$this[0,0].[1]capcity=11)
Set($$this[0,0].[2]map=new [$$this[0,0].[1]capcity]HashMapNode[])
}
void HashMap.rehash(int newcapcity){
Decl[int] oldcapcity=$$this[0,0].[1]capcity
Set($$this[0,0].[1]capcity=$$newcapcity[0,1])
Decl[HashMapNode[]] tmp=$$this[0,0].[2]map
Set($$this[0,0].[2]map=new [$$newcapcity[0,1]]HashMapNode[])
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$oldcapcity[1,2]);++ $$i[0,0]
){
PushStack
for(Decl[HashMapNode] p=$$tmp[2,3][$$i[1,0]]
;!=($$p[0,0],null);Set($$p[0,0]=$$p[0,0].[1]next)
){
SEQ{PushStack
Decl[int] index=$$p[1,0].[0]value.[0]key.[virtual]hash() % $$newcapcity[3,1]
Set($$this[3,0].[2]map[$$index[0,0]]=(new HashMapNode,HashMapNode.this(OutPipe,$$p[1,0].[0]value,$$this[3,0].[2]map[$$index[0,0]])))
RecoverStack
}}
RecoverStack
}
RecoverStack
}
HashPair HashMap.set(HashContent key,Content val){
Decl[int] h=$$key[0,1].[virtual]hash()
Decl[int] index=$$h[0,3] % $$this[0,0].[1]capcity
Decl[HashMapNode] p=$$this[0,0].[2]map[$$index[0,4]]
if(!=($$p[0,5],null)){
SEQ{if($$p[0,5].[0]value.[0]key.[virtual]equals($$key[0,1])){
SEQ{Set($$this[0,0].[2]map[$$index[0,4]]=(new HashMapNode,HashMapNode.this(OutPipe,(new HashPair,HashPair.this(OutPipe,$$key[0,1],$$val[0,2])),$$p[0,5].[1]next)))
Return $$p[0,5].[0]value(0)
}}
PushStack
Decl[HashMapNode] pn=$$p[1,5].[1]next
while(!=($$pn[0,0],null)){
if($$pn[0,0].[0]value.[0]key.[virtual]equals($$key[1,1])){
SEQ{Set($$p[1,5].[1]next=(new HashMapNode,HashMapNode.this(OutPipe,(new HashPair,HashPair.this(OutPipe,$$key[1,1],$$val[1,2])),$$pn[0,0].[1]next)))
Return $$pn[0,0].[0]value(1)
}}
Set($$p[1,5]=$$p[1,5].[1]next)
Set($$pn[0,0]=$$p[1,5].[1]next)
}
RecoverStack
}}
Set($$this[0,0].[2]map[$$index[0,4]]=(new HashMapNode,HashMapNode.this(OutPipe,(new HashPair,HashPair.this(OutPipe,$$key[0,1],$$val[0,2])),$$this[0,0].[2]map[$$index[0,4]])))
++ $$this[0,0].[0]size
if(>(IntRealConversion($$this[0,0].[0]size),0.75 * IntRealConversion($$this[0,0].[1]capcity))){
$$this[0,0].rehash(2 * $$this[0,0].[1]capcity)
}
Return null(0)
}
int HashMap.size(){
Return $$this[0,0].[0]size(0)
}
void HashMap.clear(){
Set($$this[0,0].[0]size=0)
}
HashPair HashMap.get(HashContent key){
Decl[HashMapNode] p=$$this[0,0].[2]map[$$key[0,1].[virtual]hash() % $$this[0,0].[1]capcity]
for(NullStmt
;!=($$p[0,2],null);Set($$p[0,2]=$$p[0,2].[1]next)
){
if($$p[0,2].[0]value.[0]key.[virtual]equals($$key[0,1])){
Return $$p[0,2].[0]value(0)
}
}
Return null(0)
}
HashPair HashMap.remove(HashContent key){
Decl[int] h=$$key[0,1].[virtual]hash()
Decl[int] index=$$h[0,2] % $$this[0,0].[1]capcity
Decl[HashMapNode] p=$$this[0,0].[2]map[$$index[0,3]]
if(!=($$p[0,4],null)){
SEQ{if($$p[0,4].[0]value.[0]key.[virtual]equals($$key[0,1])){
-- $$this[0,0].[0]size
Set($$this[0,0].[2]map[$$index[0,3]]=$$p[0,4].[1]next)
if(<(IntRealConversion($$this[0,0].[0]size),0.25 * IntRealConversion($$this[0,0].[1]capcity))){
$$this[0,0].rehash($$this[0,0].[1]capcity / 2)
}
Return $$p[0,4].[0]value(0)
}
PushStack
Decl[HashMapNode] pn=$$p[1,4].[1]next
while(!=($$pn[0,0],null)){
if($$pn[0,0].[0]value.[0]key.[virtual]equals($$key[1,1])){
-- $$this[1,0].[0]size
Set($$p[1,4].[1]next=$$pn[0,0].[1]next)
if(<(IntRealConversion($$this[1,0].[0]size),0.25 * IntRealConversion($$this[1,0].[1]capcity))){
$$this[1,0].rehash($$this[1,0].[1]capcity / 2)
}
Return $$pn[0,0].[0]value(1)
}
Set($$p[1,4]=$$pn[0,0])
Set($$pn[0,0]=$$p[1,4].[1]next)
}
RecoverStack
}}
Return null(0)
}
string HashMap.toString(){
Decl[StringBuffer] buf=(new StringBuffer,StringBuffer.this(OutPipe))
$$buf[0,1].append({)
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$this[1,0].[1]capcity);++ $$i[0,0]
){
if(!=($$this[1,0].[2]map[$$i[0,0]],null)){
$$buf[1,1].append(StrConversion($$i[0,0])).append(.).append($$this[1,0].[2]map[$$i[0,0]].toString()).append(
)
}
}
RecoverStack
$$buf[0,1].append(})
Return $$buf[0,1].toString()(0)
}
string  list_toString(list l){
Decl[list_node] i=$$l[0,0].[0]head
Decl[string] v=[ 
while(!=($$i[0,1].[0]next,$$l[0,0].[1]tail)){
SEQ{StrSet($$v[0,2]+=StrConversion($$i[0,1].[0]next.[2]value) +  )
Set($$i[0,1]=$$i[0,1].[0]next)
}}
StrSet($$v[0,2]+=])
Return $$v[0,2](0)
}
list  create_list(){
Decl[list_node] head=new list_node
Decl[list_node] tail=new list_node
Decl[list] l=new list
Set($$l[0,2].[0]head=$$head[0,0])
Set($$l[0,2].[1]tail=$$tail[0,1])
Set($$l[0,2].[2]count=0)
Set($$head[0,0].[0]next=$$tail[0,1])
Set($$head[0,0].[1]prev=null)
Set($$tail[0,1].[0]next=null)
Set($$tail[0,1].[1]prev=$$head[0,0])
Return $$l[0,2](0)
}
list  push_back(list l,int value){
Decl[list_node] n=new list_node
++ $$l[0,0].[2]count
Set($$n[0,2].[2]value=$$value[0,1])
Set($$n[0,2].[1]prev=$$l[0,0].[1]tail.[1]prev)
Set($$n[0,2].[0]next=$$l[0,0].[1]tail)
Set($$n[0,2].[1]prev.[0]next=$$n[0,2])
Set($$l[0,0].[1]tail.[1]prev=$$n[0,2])
Return $$l[0,0](0)
}
bool  list_isEmpty(list l){
Return ==($$l[0,0].[2]count,0)(0)
}
int  list_size(list l){
Return $$l[0,0].[2]count(0)
}
int  pop_front(list l){
Decl[list_node] n=new list_node
if(>($$l[0,0].[2]count,0)){
Set($$n[0,1]=$$l[0,0].[0]head.[0]next)
Set($$l[0,0].[0]head.[0]next=$$n[0,1].[0]next)
Set($$n[0,1].[0]next.[1]prev=$$n[0,1].[1]prev)
-- $$l[0,0].[2]count
Return $$n[0,1].[2]value(0)
}
Return -1(0)
}
int  pop_back(list l){
Decl[list_node] n=new list_node
if(>($$l[0,0].[2]count,0)){
Set($$n[0,1]=$$l[0,0].[1]tail.[1]prev)
Set($$l[0,0].[1]tail.[1]prev=$$n[0,1].[1]prev)
Set($$n[0,1].[1]prev.[0]next=$$n[0,1].[0]next)
-- $$l[0,0].[2]count
Return $$n[0,1].[2]value(0)
}
Return -1(0)
}
list  union_list(list a,list b){
Set($$a[0,0].[1]tail.[1]prev.[0]next=$$b[0,1].[0]head.[0]next)
Set($$b[0,1].[0]head.[0]next.[1]prev=$$a[0,0].[1]tail.[1]prev)
Set($$a[0,0].[1]tail=$$b[0,1].[1]tail)
IntSet($$a[0,0].[2]count+=$$b[0,1].[2]count)
Set($$b[0,1]=$$a[0,0])
Return $$a[0,0](0)
}
list  lesslist(list l,int v){
Decl[list] tmp=create_list()
Decl[list_node] i=$$l[0,0].[0]head
while(!=($$i[0,3].[0]next,$$l[0,0].[1]tail)){
SEQ{if(<($$i[0,3].[0]next.[2]value,$$v[0,1])){
push_back($$tmp[0,2],$$i[0,3].[0]next.[2]value)
}
Set($$i[0,3]=$$i[0,3].[0]next)
}}
Return $$tmp[0,2](0)
}
list  greatlist(list l,int v){
Decl[list] tmp=create_list()
Decl[list_node] i=$$l[0,0].[0]head
while(!=($$i[0,3].[0]next,$$l[0,0].[1]tail)){
SEQ{if(>=($$i[0,3].[0]next.[2]value,$$v[0,1])){
push_back($$tmp[0,2],$$i[0,3].[0]next.[2]value)
}
Set($$i[0,3]=$$i[0,3].[0]next)
}}
Return $$tmp[0,2](0)
}
void  reprint(char c,int v){
while(>(-- $$v[0,1],0)){
print(StrConversion($$c[0,0]))
}
}
list  union_listc(list a,list b,int c){
Set($$a[0,0].[1]tail.[1]prev.[0]next=$$b[0,1].[0]head.[0]next)
Set($$b[0,1].[0]head.[0]next.[1]prev=$$a[0,0].[1]tail.[1]prev)
Set($$a[0,0].[1]tail=$$b[0,1].[1]tail)
IntSet($$a[0,0].[2]count+=$$b[0,1].[2]count)
Set($$b[0,1]=$$a[0,0])
Return $$a[0,0](0)
}
list  qlsort(list l,int level){
reprint( ,$$level[0,1] * 2)
println(|s( + list_toString($$l[0,0]) + ))
if(<=($$l[0,0].[2]count,1) ){
PushStack
Decl[list] x=create_list()
Return union_listc($$x[0,0],$$l[1,0],$$level[1,1])(1)
}else {
PushStack
Decl[int] v=pop_front($$l[1,0])
Decl[list] r=qlsort(lesslist($$l[1,0],$$v[0,0]),$$level[1,1] + 1)
push_back($$r[0,1],$$v[0,0])
Return union_listc($$r[0,1],qlsort(greatlist($$l[1,0],$$v[0,0]),$$level[1,1] + 1),$$level[1,1])(1)
}
}
PaintPad.this(string name,int width,int height){
SEQ{PaintPadX.this($$PaintPad[0,0],$$name[0,1],$$width[0,2],$$height[0,3])
Set($$this[0,0].[0]t=(new Trigger,Trigger.this(OutPipe)))
}}
void PaintPad.show(){
$$super[0,0].open()
}
void PaintPad.onClose(){
SEQ{$$super[0,0].onClose()
$$this[0,0].[0]t.triggerAll()
}}
void PaintPad.wait(){
$$this[0,0].[0]t.wait()
}
void  addRect(PaintPad pad,int x,int y,int w,int height){
$$pad[0,0].addLine($$x[0,1],$$y[0,2],$$x[0,1] + $$w[0,3],$$y[0,2])
$$pad[0,0].addLine($$x[0,1],$$y[0,2],$$x[0,1],$$y[0,2] + $$height[0,4])
$$pad[0,0].addLine($$x[0,1],$$y[0,2] + $$height[0,4],$$x[0,1] + $$w[0,3],$$y[0,2] + $$height[0,4])
$$pad[0,0].addLine($$x[0,1] + $$w[0,3],$$y[0,2],$$x[0,1] + $$w[0,3],$$y[0,2] + $$height[0,4])
}
void Point.init(int x,int y){
SEQ{Set($$this[0,0].[0]x=$$x[0,1])
Set($$this[0,0].[1]y=$$y[0,2])
}}
Point Point.add(Point p){
Return (new Point,Point.this(OutPipe,$$this[0,0].[0]x + $$p[0,1].[0]x,$$this[0,0].[1]y + $$p[0,1].[1]y))(0)
}
Point Point.sub(Point p){
Return (new Point,Point.this(OutPipe,$$this[0,0].[0]x - $$p[0,1].[0]x,$$this[0,0].[1]y - $$p[0,1].[1]y))(0)
}
Point.this(int x,int y){
$$this[0,0].init($$x[0,1],$$y[0,2])
}
Color.this(int r,int g,int b){
Set($$this[0,0].[0]r=$$r[0,1])
Set($$this[0,0].[1]g=$$g[0,2])
Set($$this[0,0].[2]b=$$b[0,3])
}
void Graphics.init(PaintPad pad,int width,int height){
Set($$this[0,0].[0]width=$$width[0,2])
Set($$this[0,0].[1]height=$$height[0,3])
Set($$this[0,0].[2]center=(new Point,Point.this(OutPipe,0,0)))
Set($$this[0,0].[5]pad=$$pad[0,1])
$$this[0,0].[5]pad.show()
Set($$this[0,0].[3]brushcolor=(new Color,Color.this(OutPipe,0,0,0)))
Set($$this[0,0].[4]rects=(new DynamicArray,DynamicArray.this(OutPipe,10)))
}
int Graphics.addPoint(Point p){
SEQ{Decl[Point] real_p=$$p[0,1].add($$this[0,0].[2]center)
if(&&(&&(&&(>($$this[0,0].[0]width,$$real_p[0,2].[0]x),>=($$real_p[0,2].[0]x,0)),>($$this[0,0].[1]height,$$real_p[0,2].[1]y)),>=($$real_p[0,2].[1]y,0))){
$$this[0,0].[5]pad.addPoint($$real_p[0,2].[0]x,$$real_p[0,2].[1]y)
}
}}
int Graphics.setPoint(int id,Point p){
Decl[Point] real_p=$$p[0,2].add($$this[0,0].[2]center)
if(&&(&&(&&(>($$this[0,0].[0]width,$$real_p[0,3].[0]x),>=($$real_p[0,3].[0]x,0)),>($$this[0,0].[1]height,$$real_p[0,3].[1]y)),>=($$real_p[0,3].[1]y,0))){
SEQ{$$this[0,0].[5]pad.setPoint($$id[0,1],$$real_p[0,3].[0]x,$$real_p[0,3].[1]y)
Return $$id[0,1](0)
}}
Return -1(0)
}
void Graphics.addRect(Point o,int width,int height){
addRect($$this[0,0].[5]pad,$$o[0,1].[0]x + $$this[0,0].[2]center.[0]x,$$o[0,1].[1]y + $$this[0,0].[2]center.[1]y,$$width[0,2],$$height[0,3])
}
int Graphics.addString(Point pos,string text){
Return $$this[0,0].[5]pad.addString($$text[0,2],$$pos[0,1].[0]x + $$this[0,0].[2]center.[0]x,$$pos[0,1].[1]y + $$this[0,0].[2]center.[1]y)(0)
}
int Graphics.setString(int id,Point pos,string text){
SEQ{Decl[bool] r=$$this[0,0].[5]pad.setString($$id[0,1],$$text[0,3])
$$this[0,0].[5]pad.setStringPosition($$id[0,1],$$pos[0,2].[0]x + $$this[0,0].[2]center.[0]x,$$pos[0,2].[1]y + $$this[0,0].[2]center.[1]y)
}}
void Graphics.draw(){
$$this[0,0].[5]pad.redraw()
}
void Graphics.show(){
$$this[0,0].[5]pad.show()
}
void Graphics.clear(){
$$this[0,0].[5]pad.clear()
}
void Graphics.close(){
$$this[0,0].[5]pad.close()
}
void Graphics.wait(){
$$this[0,0].[5]pad.wait()
}
void Graphics.transite(Point offset){
Set($$this[0,0].[2]center=$$this[0,0].[2]center.add($$offset[0,1]))
}
void Graphics.setCenter(Point center){
Set($$this[0,0].[2]center=$$center[0,1])
}
Point Graphics.getCenter(){
Return $$this[0,0].[2]center(0)
}
void Graphics.setBrushColor(Color c){
SEQ{Set($$this[0,0].[3]brushcolor=$$c[0,1])
$$this[0,0].[5]pad.setBrushColor($$c[0,1].[0]r,$$c[0,1].[1]g,$$c[0,1].[2]b)
}}
Color Graphics.getBrushColor(){
Return $$this[0,0].[3]brushcolor(0)
}
Screen.this(){
SEQ{Set($$this[0,0].[0]text=0)
Set($$this[0,0].[1]index=-1)
}}
void Screen.add(Graphics g){
SEQ{$$g[0,1].[virtual]addRect((new Point,Point.this(OutPipe,0,0)),80,20)
Set($$this[0,0].[1]index=$$g[0,1].[virtual]addString((new Point,Point.this(OutPipe,0,15)),$$this[0,0].[0]text))
}}
string Screen.getContent(){
Return $$this[0,0].[0]text(0)
}
void Screen.clear(Graphics g){
Set($$this[0,0].[0]text=0)
$$g[0,1].[virtual]setString($$this[0,0].[1]index,(new Point,Point.this(OutPipe,0,15)),$$this[0,0].[0]text)
println(clear)
}
void Screen.setText(Graphics g,string text){
SEQ{Set($$this[0,0].[0]text=$$text[0,2])
$$g[0,1].[virtual]setString($$this[0,0].[1]index,(new Point,Point.this(OutPipe,0,15)),$$this[0,0].[0]text)
}}
void Screen.appendText(Graphics g,string text){
StrSet($$this[0,0].[0]text+=$$text[0,2])
println(app: + $$this[0,0].[0]text)
println(StrConversion($$g[0,1].[virtual]setString($$this[0,0].[1]index,(new Point,Point.this(OutPipe,0,15)),$$this[0,0].[0]text)))
}
cal_state.this(){
Set($$this[0,0].[0]is_result=true)
Set($$this[0,0].[1]operand=+)
Set($$this[0,0].[2]prev=0.0)
Set($$this[0,0].[3]has_dot=false)
Set($$this[0,0].[4]present=0.0)
Set($$this[0,0].[5]pre_scal=1.0)
}
void cal_state.reset(){
Set($$this[0,0].[0]is_result=true)
Set($$this[0,0].[1]operand=+)
Set($$this[0,0].[2]prev=0.0)
Set($$this[0,0].[3]has_dot=false)
Set($$this[0,0].[4]present=0.0)
Set($$this[0,0].[5]pre_scal=1.0)
}
Button.this(string text,int id,Color c){
Set($$this[0,0].[0]text=$$text[0,1])
Set($$this[0,0].[1]color=$$c[0,3])
Set($$this[0,0].[2]id=$$id[0,2])
Set($$this[0,0].[3]index=-1)
}
void Button.add(Graphics g){
$$g[0,1].setBrushColor($$this[0,0].[1]color)
$$g[0,1].[virtual]addRect((new Point,Point.this(OutPipe,0,0)),20,20)
Set($$this[0,0].[3]index=$$g[0,1].[virtual]addString((new Point,Point.this(OutPipe,10,15)),$$this[0,0].[0]text))
}
void Button.setString(Graphics g,string text){
SEQ{Set($$this[0,0].[0]text=$$text[0,2])
$$g[0,1].[virtual]setString($$this[0,0].[3]index,(new Point,Point.this(OutPipe,10,15)),$$this[0,0].[0]text)
}}
void Button.onclick(Graphics g,Screen scr,cal_state cs){
SEQ{println(CLICKED  + $$this[0,0].[0]text + : + StrConversion($$this[0,0].[2]id))
IntSwitch($$this[0,0].[2]id){
case 49 50 51 52 53 54 55 56 57 48=>{
if($$cs[0,3].[0]is_result){
SEQ{Set($$cs[0,3].[4]present=0.0)
Set($$cs[0,3].[0]is_result=false)
}}
if($$cs[0,3].[3]has_dot ){
SEQ{RealSet($$cs[0,3].[5]pre_scal/=10.0)
Set($$cs[0,3].[4]present=$$cs[0,3].[4]present + $$cs[0,3].[5]pre_scal * IntRealConversion($$this[0,0].[2]id - 48))
}}else {
Set($$cs[0,3].[4]present=$$cs[0,3].[4]present * 10.0 + IntRealConversion($$this[0,0].[2]id - 48))
}
$$scr[0,2].setText($$g[0,1],StrConversion($$cs[0,3].[4]present))
inter.stmt.Break
}
case 46=>{
if(! $$cs[0,3].[3]has_dot){
Set($$cs[0,3].[3]has_dot=true)
}
inter.stmt.Break
}
case 43 45 42 47=>{
if(! $$cs[0,3].[0]is_result){
CharSwitch($$cs[0,3].[1]operand){
case +=>{
RealSet($$cs[0,3].[2]prev+=$$cs[0,3].[4]present)
inter.stmt.Break
}
case -=>{
RealSet($$cs[0,3].[2]prev-=$$cs[0,3].[4]present)
inter.stmt.Break
}
case *=>{
RealSet($$cs[0,3].[2]prev*=$$cs[0,3].[4]present)
inter.stmt.Break
}
case /=>{
RealSet($$cs[0,3].[2]prev/=$$cs[0,3].[4]present)
inter.stmt.Break
}
}
Set($$cs[0,3].[0]is_result=true)
$$scr[0,2].setText($$g[0,1],StrConversion($$cs[0,3].[2]prev))
}
Set($$cs[0,3].[1]operand=IntCharConversion($$this[0,0].[2]id))
inter.stmt.Break
}
case 99=>{
$$scr[0,2].clear($$g[0,1])
$$cs[0,3].reset()
println(cls)
inter.stmt.Break
}
}
}}
Region.this(Point o,int width,int height){
Set($$this[0,0].[0]o=$$o[0,1])
Set($$this[0,0].[1]width=$$width[0,2])
Set($$this[0,0].[2]height=$$height[0,3])
}
bool Region.contains(Point p){
SEQ{Decl[Point] o=$$this[0,0].[0]o
Return &&(&&(&&(>=($$p[0,1].[0]x,$$o[0,2].[0]x),<=($$p[0,1].[0]x,$$o[0,2].[0]x + $$this[0,0].[1]width)),>=($$p[0,1].[1]y,$$o[0,2].[1]y)),<=($$p[0,1].[1]y,$$o[0,2].[1]y + $$this[0,0].[2]height))(0)
}}
PairContent.this(Button b,Region r){
SEQ{Set($$this[0,0].[0]b=$$b[0,1])
Set($$this[0,0].[1]r=$$r[0,2])
}}
string PairContent.toString(){
Return (0)
}
EventPool.this(){
Set($$this[0,0].[0]eps=(new DynamicArray,DynamicArray.this(OutPipe,1)))
}
void EventPool.addListener(Region r,Button b){
$$this[0,0].[0]eps.push_back((new PairContent,PairContent.this(OutPipe,$$b[0,2],$$r[0,1])))
}
void EventPool.onclick(Point p,Graphics g,Screen scr,cal_state cs){
Decl[int] size=$$this[0,0].[0]eps.size()
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$size[1,5]);++ $$i[0,0]
){
SEQ{PushStack
Decl[PairContent] pc=DownCastConversion($$this[2,0].[0]eps.get($$i[1,0]))
if($$pc[0,0].[1]r.contains($$p[2,1])){
$$pc[0,0].[0]b.onclick($$g[2,2],$$scr[2,3],$$cs[2,4])
$$g[2,2].[virtual]draw()
Return void expr(2)
}
RecoverStack
}}
RecoverStack
}
Calculator.this(string title,int width,int height,EventPool pool,Graphics g,Screen scr){
PaintPad.this($$Calculator[0,0],$$title[0,1],$$width[0,2],$$height[0,3])
Set($$this[0,0].[1]pool=$$pool[0,4])
Set($$this[0,0].[2]g=$$g[0,5])
Set($$this[0,0].[3]scr=$$scr[0,6])
Set($$this[0,0].[4]cs=(new cal_state,cal_state.this(OutPipe)))
}
void Calculator.onMouseClick(int bid,int x,int y){
$$this[0,0].[1]pool.onclick((new Point,Point.this(OutPipe,$$x[0,2],$$y[0,3])),$$this[0,0].[2]g,$$this[0,0].[3]scr,$$this[0,0].[4]cs)
}
CyclePaintPad.this(PaintPad pad,int interval){
SEQ{Timer2Adapter.this($$CyclePaintPad[0,0],$$interval[0,2])
Set($$this[0,0].[1]pad=$$pad[0,1])
}}
void CyclePaintPad.run(){
$$this[0,0].[1]pad.redraw()
}
RuntimeBasic.this(){
Set($$this[0,0].[0]varMap=(new HashMap,HashMap.this(OutPipe)))
Set($$this[0,0].[1]labelMap=(new HashMap,HashMap.this(OutPipe)))
Decl[int] index=0
}
string RuntimeBasic.getVar(string varname){
Return DownCastConversion($$this[0,0].[0]varMap.get((new StringHashContent,StringHashContent.this(OutPipe,$$varname[0,1]))).[1]value).[virtual]toString()(0)
}
void RuntimeBasic.setVar(string varname,string val){
$$this[0,0].[0]varMap.set((new StringHashContent,StringHashContent.this(OutPipe,$$varname[0,1])),(new StringContent,StringContent.this(OutPipe,$$val[0,2])))
}
void RuntimeBasic.jump(string label){
SEQ{Decl[IntContent] l=DownCastConversion($$this[0,0].[1]labelMap.get((new StringHashContent,StringHashContent.this(OutPipe,$$label[0,1]))).[1]value)
Set($$this[0,0].[2]index=$$l[0,2].toInt() - 1)
}}
void RuntimeBasic.sleep(int second){
sleep($$second[0,1])
}
string Function.toString(){
Return (0)
}
string Function.preprocessArg(RuntimeBasic r,string arg){
Decl[int] len_1=strlen($$arg[0,2]) - 1
Decl[int] j=1
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$$len_1[1,3]);++ $$i[0,0]
){
SEQ{if(==(StringVarAccess,$)){
if(<($$i[0,0],$$len_1[1,3])){
if(==(StringVarAccess,{)){
IntSet($$i[0,0]+=2)
PushStack
Decl[StringBuffer] tmp=(new StringBuffer,StringBuffer.this(OutPipe))
do{
$$tmp[0,0].appendCharacter(StringVarAccess)
}while(!=(StringVarAccess,}));
$$sb[2,5].append($$r[2,1].getVar($$tmp[0,0].toString()))
inter.stmt.Continue
}
}
}
$$sb[1,5].appendCharacter(StringVarAccess)
}}
RecoverStack
Return $$sb[0,5].toString()(0)
}
void Function.preprocessArgs(RuntimeBasic r,string[] args){
Decl[int] len=sizeof $$args[0,2]
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$len[1,3]);++ $$i[0,0]
){
Set($$args[1,2][$$i[0,0]]=$$this[1,0].[virtual]preprocessArg($$r[1,1],$$args[1,2][$$i[0,0]]))
}
RecoverStack
}
void Function.procedure(RuntimeBasic r,string[] args){
SEQ{$$this[0,0].preprocessArgs($$r[0,1],$$args[0,2])
$$this[0,0].[virtual]run($$r[0,1],$$args[0,2])
}}
RuntimeBasic_.this(){
SEQ{RuntimeBasic.this($$RuntimeBasic_[0,0])
Set($$this[0,0].[3]functionMap=(new HashMap,HashMap.this(OutPipe)))
}}
Function RuntimeBasic_.getFunction(string funcname){
Return DownCastConversion($$this[0,0].[3]functionMap.get((new StringHashContent,StringHashContent.this(OutPipe,$$funcname[0,1]))).[1]value)(0)
}
void RuntimeBasic_.registerFunction(string funcname,Function function){
$$this[0,0].[3]functionMap.set((new StringHashContent,StringHashContent.this(OutPipe,$$funcname[0,1])),$$function[0,2])
}
Instruction.this(string function,string[] args){
SEQ{Set($$this[0,0].[0]args=$$args[0,2])
Set($$this[0,0].[1]function=$$function[0,1])
}}
void Instruction.run(RuntimeBasic_ r){
Decl[string[]] tmp=new [sizeof $$this[0,0].[0]args]string[]
PushStack
for(Decl[int] i=0
;<($$i[0,0],sizeof $$this[1,0].[0]args);++ $$i[0,0]
){
Set($$tmp[1,2][$$i[0,0]]=$$this[1,0].[0]args[$$i[0,0]])
}
RecoverStack
$$r[0,1].getFunction($$this[0,0].[1]function).procedure($$r[0,1],$$tmp[0,2])
}
string Instruction.toString(){
Return $$this[0,0].[1]function(0)
}
Runtime.this(){
SEQ{RuntimeBasic_.this($$Runtime[0,0])
Set($$this[0,0].[4]instructions=(new DynamicArray,DynamicArray.this(OutPipe,1000)))
}}
void Runtime.addLable(string label){
$$this[0,0].[1]labelMap.set((new StringHashContent,StringHashContent.this(OutPipe,$$label[0,1])),(new IntContent,IntContent.this(OutPipe,$$this[0,0].[4]instructions.size())))
}
void Runtime.addInstructions2(string function,string[] args){
$$this[0,0].[4]instructions.push_back((new Instruction,Instruction.this(OutPipe,$$function[0,1],$$args[0,2])))
}
bool Runtime.isEnd(){
Return <=($$this[0,0].[4]instructions.size(),$$this[0,0].[2]index)(0)
}
void Runtime.addInstructions(Instruction i){
$$this[0,0].[4]instructions.push_back($$i[0,1])
}
void Runtime.clearInstructions(){
$$this[0,0].[4]instructions.clear()
}
void Runtime.step(){
SEQ{DownCastConversion($$this[0,0].[4]instructions.get($$this[0,0].[2]index)).run($$this[0,0])
++ $$this[0,0].[2]index
}}
string RPGToken.toString(){
Return (0)
}
ValueToken.this(string str){
SEQ{Set($$this[0,0].[1]value=$$str[0,1])
Set($$this[0,0].[0]tag=256)
}}
string ValueToken.toString(){
Return $$this[0,0].[1]value(0)
}
SymbolToken.this(int c){
Set($$this[0,0].[0]tag=$$c[0,1])
}
string SymbolToken.toString(){
Return StrConversion(IntCharConversion($$this[0,0].[0]tag)) + : + StrConversion($$this[0,0].[0]tag)(0)
}
RPGLexer.this(){
SEQ{Set($$this[0,0].[1]peak=32)
Set($$this[0,0].[0]f=(new File,File.this(OutPipe)))
}}
void RPGLexer.close(){
$$this[0,0].[0]f.close()
}
void RPGLexer.open(string filename){
$$this[0,0].[0]f.close()
Set($$this[0,0].[1]peak=32)
Set($$this[0,0].[2]lineno=1)
Set($$this[0,0].[3]index=0)
$$this[0,0].[0]f.open($$filename[0,1],true)
}
void RPGLexer.readch(){
SEQ{Set($$this[0,0].[1]peak=$$this[0,0].[0]f.readch())
if(==($$this[0,0].[1]peak,10) ){
SEQ{++ $$this[0,0].[2]lineno
Set($$this[0,0].[3]index=0)
}}else {
++ $$this[0,0].[3]index
}
}}
RPGToken RPGLexer.scan(){
Decl[RPGToken] t=null
while(||(||($$this[0,0].check(9),$$this[0,0].check(32)),$$this[0,0].check(13))){
NullStmt
}
IntSwitch($$this[0,0].[1]peak){
case 34=>{
PushStack
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
$$this[1,0].readch()
while(! $$this[1,0].check(34)){
SEQ{$$sb[0,0].appendCharacter(IntCharConversion($$this[1,0].[1]peak))
$$this[1,0].readch()
}}
Set($$t[1,1]=(new ValueToken,ValueToken.this(OutPipe,$$sb[0,0].toString())))
inter.stmt.Break
default=>{
Set($$t[0,1]=(new SymbolToken,SymbolToken.this(OutPipe,$$this[0,0].[1]peak)))
$$this[0,0].readch()
}
}
Return $$t[0,1](0)
}
bool RPGLexer.check(int c){
SEQ{if(==($$c[0,1],$$this[0,0].[1]peak)){
SEQ{$$this[0,0].readch()
Return true(0)
}}
Return false(0)
}}
RPGParser.this(){
Set($$this[0,0].[1]lexer=(new RPGLexer,RPGLexer.this(OutPipe)))
}
void RPGParser.error(string msg){
println(error  + $$msg[0,1] + @ + StrConversion($$this[0,0].[1]lexer.[2]lineno) + : + StrConversion($$this[0,0].[1]lexer.[3]index))
}
void RPGParser.move(){
Set($$this[0,0].[0]look=$$this[0,0].[1]lexer.scan())
}
void RPGParser.match(int id){
SEQ{if(!=($$this[0,0].[0]look.[0]tag,$$id[0,1])){
$$this[0,0].error(wrong id + $$this[0,0].[0]look.[virtual]toString())
}
$$this[0,0].move()
}}
string[] RPGParser.args(){
Decl[string[]] arg=new [20]string[]
Decl[int] i=0
while(==($$this[0,0].[0]look.[0]tag,256)){
Set($$arg[0,1][++ $$i[0,2]]=$$this[0,0].value())
}
Decl[string[]] tmp=new [$$i[0,2]]string[]
while(>=(-- $$i[0,2],0)){
Set($$tmp[0,3][$$i[0,2]]=$$arg[0,1][$$i[0,2]])
}
Return $$tmp[0,3](0)
}
Instruction RPGParser.instruction(){
Decl[string] funcname=$$this[0,0].value()
$$this[0,0].match(58)
Decl[string[]] args=$$this[0,0].args()
Return (new Instruction,Instruction.this(OutPipe,$$funcname[0,1],$$args[0,2]))(0)
}
void RPGParser.statement(Runtime r){
while($$this[0,0].check(10)){
NullStmt
}
while($$this[0,0].check(60)){
$$r[0,1].addLable($$this[0,0].value())
$$this[0,0].match(62)
while($$this[0,0].check(10)){
NullStmt
}
}
if(!=($$this[0,0].[0]look.[0]tag,-1)){
$$r[0,1].addInstructions($$this[0,0].instruction())
}
}
bool RPGParser.check(int id){
SEQ{if(==($$this[0,0].[0]look.[0]tag,$$c[0,1])){
SEQ{$$this[0,0].move()
Return true(0)
}}
Return false(0)
}}
string RPGParser.value(){
Decl[RPGToken] arg=$$this[0,0].[0]look
$$this[0,0].match(256)
Return DownCastConversion($$arg[0,1]).[1]value(0)
}
void RPGParser.parse(string file,Runtime r){
$$this[0,0].[1]lexer.open($$file[0,1])
$$this[0,0].move()
while(!=($$this[0,0].[0]look.[0]tag,-1)){
$$this[0,0].statement($$r[0,2])
}
$$this[0,0].[1]lexer.close()
}
RPGRuntime.this(RPGParser p){
SEQ{Runtime.this($$RPGRuntime[0,0])
Set($$this[0,0].[5]parser=$$p[0,1])
}}
void RPGRuntime.open(string filename){
$$this[0,0].[1]labelMap.clear()
$$this[0,0].[4]instructions.clear()
$$this[0,0].[5]parser.parse($$filename[0,1],$$this[0,0])
}
void RPGRuntime.run(){
while(! $$this[0,0].isEnd()){
$$super[0,0].step()
}
}
void Sleep.run(RuntimeBasic r,string[] args){
sleep(parseInt($$args[0,2][0]))
}
void Choice.run(RuntimeBasic r,string[] args){
Decl[string] var=$$args[0,2][0]
println(Choose)
PushStack
for(Decl[int] i=1
;<($$i[0,0],sizeof $$args[1,2]);++ $$i[0,0]
){
println(StrConversion($$i[0,0]) + . + $$args[1,2][$$i[0,0]])
}
RecoverStack
print(Enter:)
Decl[int] c=readNumber()
$$r[0,1].setVar($$var[0,3],StrConversion($$c[0,4]))
}
void Set.run(RuntimeBasic r,string[] args){
$$r[0,1].setVar($$args[0,2][0],$$args[0,2][1])
}
void Cond.run(RuntimeBasic r,string[] args){
if(==($$args[0,2][0],$$args[0,2][1])){
$$r[0,1].jump($$args[0,2][2])
}
}
void Select.run(RuntimeBasic r,string[] args){
Decl[string] var=$$args[0,2][0]
Decl[int] i=parseInt($$args[0,2][1])
$$r[0,1].setVar($$var[0,3],$$args[0,2][$$i[0,4] - 1])
}
void Print.run(RuntimeBasic r,string[] args){
Decl[string] content=$$args[0,2][0]
if(<(sizeof $$args[0,2],1)){
println($$content[0,3])
}
Decl[int] len_1=strlen($$content[0,3]) - 1
Decl[int] j=1
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$$len_1[1,4]);++ $$i[0,0]
){
if(==(StringVarAccess,$) ){
SEQ{if(<($$i[0,0],$$len_1[1,4])){
if(==(StringVarAccess,$)){
++ $$i[0,0]
$$sb[1,6].appendCharacter($)
inter.stmt.Continue
}
}
$$sb[1,6].append($$r[1,1].getVar($$args[1,2][++ $$j[1,5]]))
}}else {
$$sb[1,6].appendCharacter(StringVarAccess)
}
}
RecoverStack
println($$sb[0,6].toString())
}
void StopPrint.run(RuntimeBasic r,string[] args){
Decl[string] content=$$args[0,2][0]
Decl[int] stop=parseInt($$args[0,2][1])
if(>(sizeof $$args[0,2],2)){
SEQ{PushStack
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
Decl[int] len_1=strlen($$content[1,3]) - 1
Decl[int] j=2
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$$len_1[1,1]);++ $$i[0,0]
){
if(==(StringVarAccess,$) ){
SEQ{if(<($$i[0,0],$$len_1[1,1])){
if(==(StringVarAccess,$)){
++ $$i[0,0]
$$sb[1,0].appendCharacter($)
inter.stmt.Continue
}
}
$$sb[1,0].append($$r[2,1].getVar($$args[2,2][++ $$j[1,2]]))
}}else {
$$sb[1,0].appendCharacter(StringVarAccess)
}
}
RecoverStack
Set($$content[1,3]=$$sb[0,0].toString())
RecoverStack
}}
PushStack
for(Decl[int] i=0
;<($$i[0,0],strlen($$content[1,3]));++ $$i[0,0]
){
SEQ{print(StrConversion(StringVarAccess))
sleep($$stop[1,4])
}}
RecoverStack
println()
}
void Jump.run(RuntimeBasic r,string[] args){
$$r[0,1].jump($$args[0,2][0])
}
void TypeString.run(RuntimeBasic r,string[] args){
$$r[0,1].setVar($$args[0,2][0],readString())
}
void RPGTime.run(RuntimeBasic r,string[] args){
$$r[0,1].setVar($$args[0,2][0],StrConversion(time()))
}
void RPGAdd.run(RuntimeBasic r,string[] args){
Decl[bigint] val=parseBigInt($$r[0,1].getVar($$args[0,2][0]))
BigIntSet($$val[0,3]+=parseBigInt($$args[0,2][1]))
$$r[0,1].setVar($$args[0,2][0],StrConversion($$val[0,3]))
}
void RPGCase.run(RuntimeBasic r,string[] args){
Decl[int] len=sizeof $$args[0,2]
Decl[int] c=parseInt($$args[0,2][0])
if(<($$c[0,4],$$len[0,3] - 1)){
$$r[0,1].jump($$args[0,2][$$c[0,4]])
}
}
void Open.run(RuntimeBasic r,string[] args){
SEQ{$$r[0,1].[virtual]open($$args[0,2][0])
Set($$r[0,1].[2]index=-1)
}}
ScrollTextOutput.this(int width_tile,int height_tile){
Set($$this[0,0].[1]width=$$width_tile[0,1])
Set($$this[0,0].[2]height=$$height_tile[0,2])
Set($$this[0,0].[4]contents=(new bilist,bilist.this(OutPipe)))
Set($$this[0,0].[0]x=(new PaintPad,PaintPad.this(OutPipe,XLand,16 * $$height_tile[0,2] + 20,8 * $$width_tile[0,1] + 20)))
Set($$this[0,0].[3]ids=new [$$height_tile[0,2]]int[])
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$height_tile[1,2]);++ $$i[0,0]
){
Set($$this[1,0].[3]ids[$$i[0,0]]=$$this[1,0].[0]x.addString(,10,16 * $$i[0,0] + 20))
}
RecoverStack
Set($$this[0,0].[5]line=0)
}
void ScrollTextOutput.update(){
if(>=($$this[0,0].[5]line,$$this[0,0].[2]height) ){
SEQ{PushStack
Decl[binode] beg=$$this[1,0].[4]contents.front()
PushStack
for(Decl[int] i=$$this[2,0].[2]height - 1
;>=($$i[0,0],0);-- $$i[0,0]
){
SEQ{$$this[2,0].[0]x.setString($$this[2,0].[3]ids[$$i[0,0]],$$beg[1,0].[2]value.[virtual]toString())
Set($$beg[1,0]=$$beg[1,0].[0]next)
}}
RecoverStack
RecoverStack
}}else {
SEQ{PushStack
Decl[int] i=0
PushStack
for(Decl[binode] iter=$$this[2,0].[4]contents.back()
;!=($$iter[0,0].[1]prev,null);Set($$iter[0,0]=$$iter[0,0].[1]prev)
){
SEQ{$$this[2,0].[0]x.setString($$this[2,0].[3]ids[$$i[1,0]],$$iter[0,0].[2]value.[virtual]toString())
++ $$i[1,0]
}}
RecoverStack
RecoverStack
}}
}
void ScrollTextOutput.addString(string str,int r,int p,int g){
SEQ{Decl[int] len=strlen($$str[0,1])
if(>($$len[0,5],$$this[0,0].[1]width) ){
SEQ{PushStack
Decl[StringBuffer] sb1=(new StringBuffer,StringBuffer.this(OutPipe))
$$sb1[0,0].append($$str[1,1])
$$sb1[0,0].delete($$this[1,0].[1]width - 1,$$len[1,5] - 1)
$$this[1,0].[4]contents.push_front((new StringContent,StringContent.this(OutPipe,$$sb1[0,0].toString())))
IntSet($$len[1,5]-=$$this[1,0].[1]width)
Decl[int] i=$$this[1,0].[1]width
++ $$this[1,0].[5]line
do{
SEQ{PushStack
Decl[StringBuffer] sb=(new StringBuffer,StringBuffer.this(OutPipe))
PushStack
for(Decl[int] j=0
;&&(<($$j[0,0],$$this[3,0].[1]width),>($$len[3,5],0));++ $$j[0,0]
){
SEQ{$$sb[1,0].append(StrConversion(StringVarAccess))
-- $$len[3,5]
}}
RecoverStack
$$this[2,0].[4]contents.push_front((new StringContent,StringContent.this(OutPipe,$$sb[0,0].toString())))
IntSet($$i[1,1]+=$$this[2,0].[1]width)
++ $$this[2,0].[5]line
RecoverStack
}}while(>($$len[1,5],0));
RecoverStack
}}else {
SEQ{$$this[0,0].[4]contents.push_front((new StringContent,StringContent.this(OutPipe,$$str[0,1])))
++ $$this[0,0].[5]line
}}
}}
void ScrollTextOutput.addCharacter(char c,int r,int p,int g){
if(==($$this[0,0].[4]contents.front(),null)){
$$this[0,0].[4]contents.push_front((new StringContent,StringContent.this(OutPipe,StrConversion($$c[0,1]))))
}
}
void ScrollTextOutput.changeLine(){
++ $$this[0,0].[5]line
}
void ScrollTextOutput.open(){
$$this[0,0].[0]x.show()
}
void ScrollTextOutput.close(){
$$this[0,0].[0]x.close()
}
void ScrollTextOutput.wait(){
$$this[0,0].[0]x.wait()
}
void rrr.test(derive d){
$$d[0,1].[virtual]getBase()
}
MyPaintPad.this(){
PaintPad.this($$MyPaintPad[0,0],test,200,200)
Decl[Font] f=$$super[0,0].getFont()
println($$f[0,1].getFontName() +  : end)
}
void MyPaintPad.onClick(int bid){
SEQ{$$super[0,0].onClick($$bid[0,1])
IntSwitch($$bid[0,1]){
case 37=>{
IntSet($x[0,2]-=10)
inter.stmt.Break
}
case 39=>{
IntSet($x[0,2]+=10)
inter.stmt.Break
}
case 27=>{
$$this[0,0].close()
inter.stmt.Break
default=>{
println(StrConversion($$bid[0,1]))
}
}
}}
void MyPaintPad.onPress(int bid){
$$this[0,0].[virtual]onClick($$bid[0,1])
}
Game.this(){
CyclePaintPad.this($$Game[0,0],(new MyPaintPad,MyPaintPad.this(OutPipe)),1)
Set($$this[0,0].[2]cid=$$this[0,0].[1]pad.addCircle(50,50,10))
$$this[0,0].[1]pad.setBrushColor(0,255,255)
Set($$this[0,0].[7]lid=$$this[0,0].[1]pad.addLine($x[0,2],$y[0,3],$width[0,4] + $x[0,2],$y[0,3]))
$$this[0,0].[1]pad.setBrushColor(0,0,255)
$$this[0,0].[1]pad.addLine(10,10,10,190)
$$this[0,0].[1]pad.addLine(10,10,190,10)
$$this[0,0].[1]pad.addLine(10,190,190,190)
$$this[0,0].[1]pad.addLine(190,10,190,190)
Set($$this[0,0].[5]v_x=0.05)
Set($$this[0,0].[6]v_y=0.1)
Set($$this[0,0].[3]x=55.0)
Set($$this[0,0].[4]y=55.0)
}
void Game.run(){
RealSet($$this[0,0].[3]x+=$$this[0,0].[5]v_x)
RealSet($$this[0,0].[4]y+=$$this[0,0].[6]v_y)
if(||(<=($$this[0,0].[3]x,5.0),>=($$this[0,0].[3]x,185.0))){
Set($$this[0,0].[5]v_x=- $$this[0,0].[5]v_x)
}
if(||(<=($$this[0,0].[4]y,5.0),>=($$this[0,0].[4]y,185.0))){
Set($$this[0,0].[6]v_y=- $$this[0,0].[6]v_y)
}
if(<($x[0,2],10)){
Set($x[0,2]=10)
}
if(>($x[0,2],150)){
Set($x[0,2]=150)
}
if(&&(&&(>=($$this[0,0].[4]y,IntRealConversion($y[0,3])),>=($$this[0,0].[3]x,IntRealConversion($x[0,2]))),<=($$this[0,0].[3]x,IntRealConversion($x[0,2] + $width[0,4])))){
Set($$this[0,0].[6]v_y=- $$this[0,0].[6]v_y)
}
$$this[0,0].[1]pad.setLine($$this[0,0].[7]lid,$x[0,2],$y[0,3],$width[0,4] + $x[0,2],$y[0,3])
$$this[0,0].[1]pad.setCircle($$this[0,0].[2]cid,RealIntConversion($$this[0,0].[3]x),RealIntConversion($$this[0,0].[4]y))
$$super[0,0].run()
}
void Game.open(){
$$this[0,0].[1]pad.show()
}
void Game.wait(){
$$this[0,0].[1]pad.wait()
}
void baseA.init(int id){
Set($$this[0,0].[0]id=$$id[0,1])
}
string baseA.who(){
Return baseA: + StrConversion($$this[0,0].[0]id)(0)
}
baseB.this(int i){
$$super[0,0].init($$i[0,1])
}
string baseB.who(){
Return baseB: + $$super[0,0].who()(0)
}
deriveC.this(int i){
$$super[0,0].init($$i[0,1])
}
string deriveC.who(){
Return baseC: + $$super[0,0].who()(0)
}
MyXPaintPad.this(string name,int width,int height){
PaintPad.this($$MyXPaintPad[0,0],$$name[0,1],$$width[0,2],$$height[0,3])
}
void MyXPaintPad.onMouseClick(int code,int x,int y){
println(( + StrConversion($$x[0,2]) + , + StrConversion($$y[0,3]) + ))
if(==($$code[0,1],1) ){
$$this[0,0].addPoint($$x[0,2],$$y[0,3])
}else {
$$this[0,0].addLine($$x[0,2],$$y[0,3],$$this[0,0].[1]lastx,$$this[0,0].[2]lasty)
}
Set($$this[0,0].[1]lastx=$$x[0,2])
Set($$this[0,0].[2]lasty=$$y[0,3])
$$this[0,0].redraw()
}
void MyXPaintPad.onClose(){
SEQ{println(closed)
$$this[0,0].close()
}}
void MyXPaintPad.onClick(int code){
println(StrConversion($$code[0,1]))
}
PrintCount.this(){
Set($$this[0,0].[0]i=0)
}
void PrintCount.run(){
println(StrConversion(++ $$this[0,0].[0]i))
}
PairContent2.this(int id,int value){
SEQ{Set($$this[0,0].[0]id=$$id[0,1])
Set($$this[0,0].[1]value=$$value[0,2])
}}
string PairContent2.toString(){
Return StrConversion($$this[0,0].[0]id) + : + StrConversion($$this[0,0].[1]value)(0)
}
PrintNumber.this(int id){
Set($$this[0,0].[0]id=$$id[0,1])
}
void PrintNumber.run(){
SEQ{Decl[int] v=0
while(<(Set($$v[0,1]=$value[0,5].getAndIncrement()),100)){
SEQ{$queue[0,6].put((new PairContent2,PairContent2.this(OutPipe,$$this[0,0].[0]id,$$v[0,1])))
sleep(50)
}}
}}
void  f1(int a){
println(f1: + StrConversion($$a[0,0]))
if(>($$a[0,0],10)){
Return void expr(0)
}
f2($$a[0,0] + 1)
}
void  f2(int b){
SEQ{println(f2: + StrConversion($$b[0,0]))
if(>($$b[0,0],10)){
Return void expr(0)
}
}}
bool llist.isEmpty(){
Return ==($$this[0,0].getSize(),0)(0)
}
int llist.getSize(){
Return $$this[0,0].[0]size(0)
}
void JustOnce.run(){
Decl[Thread] t=getCurrentThread()
PushStack
for(Decl[int] i=0
;<($$i[0,0],10);++ $$i[0,0]
){
SEQ{print([ + StrConversion($$t[1,1].getThreadId()) + ]: + StrConversion($$i[0,0]) +  will stop
)
$$t[1,1].interrupt()
}}
RecoverStack
}
void  drawHand(PaintPad p,int v,real theta,int len,int r,int g,int b){
Decl[real] arctheta=$$theta[0,2] * 2.0 * $PI[0,7]
Decl[int] x=RealIntConversion(cos($$arctheta[0,7]) * IntRealConversion($$len[0,3]))
Decl[int] y=RealIntConversion(sin($$arctheta[0,7]) * IntRealConversion($$len[0,3]))
$$p[0,0].setBrushColor($$r[0,4],$$g[0,5],$$b[0,6])
$$p[0,0].addLine(150,150,150 + $$x[0,8],$$y[0,9] + 150)
}
void  drawClock(PaintPad p,Time t){
PushStack
for(Decl[int] i=1
;<($$i[0,0],13);++ $$i[0,0]
){
SEQ{PushStack
Decl[real] arctheta=IntRealConversion($$i[1,0]) - 3.0 / 6.0 * $PI[0,7]
Decl[int] x=RealIntConversion(cos($$arctheta[0,0]) * 140.0)
Decl[int] y=RealIntConversion(sin($$arctheta[0,0]) * 140.0)
$$p[2,0].addString(StrConversion($$i[1,0]),150 + $$x[0,1],150 + $$y[0,2])
RecoverStack
}}
RecoverStack
drawHand($$p[0,0],$$t[0,1].[0]hour,IntRealConversion($$t[0,1].[0]hour) - 3.0 / 12.0,70,0,0,255)
drawHand($$p[0,0],$$t[0,1].[1]minute,IntRealConversion($$t[0,1].[1]minute) - 15.0 / 60.0,110,0,255,0)
drawHand($$p[0,0],$$t[0,1].[2]second,IntRealConversion($$t[0,1].[2]second) - 15.0 / 60.0,130,255,0,0)
}
string TestS.toString(){
Return StrConversion($$this[0,0].[0]x) + : + StrConversion($$this[0,0].[1]y)(0)
}
AISofRunnable#048444.this(PaintPad p){
Set($$this[0,0].[0]p=$$p[0,1])
}
void AISofRunnable#048444.run(){
Decl[TestS] t=new TestS
Set($$t[0,1].[0]x=11)
Set($$t[0,1].[1]y=12)
println(test23232)
println($$t[0,1].toString())
while(true){
println($$t[0,1].toString())
$$this[0,0].[0]p.clear()
$$this[0,0].[0]p.redraw()
sleep(500)
}
}
void shape.init(string name){
Set($$this[0,0].[0]name=$$name[0,1])
}
string shape.toString(){
Return $$this[0,0].[0]name(0)
}
void square.setWidth(int w){
Set($$this[0,0].[1]width=$$w[0,1])
}
void square.draw(){
Decl[int] w=$$this[0,0].[1]width
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$w[1,1]);++ $$i[0,0]
){
PushStack
for(Decl[int] j=0
;<($$j[0,0],$$w[2,1]);++ $$j[0,0]
){
print(* )
}
RecoverStack
print(
)
}
RecoverStack
}
void rectangle.setLength(int l){
Set($$this[0,0].[2]length=$$l[0,1])
}
void rectangle.draw(){
Decl[int] w=$$this[0,0].[1]width
Decl[int] l=$$this[0,0].[2]length
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$w[1,1]);++ $$i[0,0]
){
PushStack
for(Decl[int] j=0
;<($$j[0,0],$$l[2,2]);++ $$j[0,0]
){
print(* )
}
RecoverStack
print(
)
}
RecoverStack
}
void  drawRectangle(PaintPad p,int x,int y,int w,int h){
$$p[0,0].addLine($$x[0,1],$$y[0,2],$$x[0,1] + $$w[0,3],$$y[0,2])
$$p[0,0].addLine($$x[0,1],$$y[0,2],$$x[0,1],$$y[0,2] + $$h[0,4])
$$p[0,0].addLine($$x[0,1],$$y[0,2] + $$h[0,4],$$x[0,1] + $$w[0,3],$$y[0,2] + $$h[0,4])
$$p[0,0].addLine($$x[0,1] + $$w[0,3],$$y[0,2],$$x[0,1] + $$w[0,3],$$y[0,2] + $$h[0,4])
}
void  drawChessPad(PaintPad p,int x,int y){
$$p[0,0].clear()
$$p[0,0].setBrushColor(0,0,0)
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$WIDTH[0,8]);++ $$i[0,0]
){
$$p[1,0].addLine($TILE_WIDTH[0,10] * $$i[0,0],0,$TILE_WIDTH[0,10] * $$i[0,0],$HEIGHT[0,9] * $TILE_WIDTH[0,10])
}
RecoverStack
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$HEIGHT[0,9]);++ $$i[0,0]
){
$$p[1,0].addLine(0,$TILE_WIDTH[0,10] * $$i[0,0],$WIDTH[0,8] * $TILE_WIDTH[0,10],$TILE_WIDTH[0,10] * $$i[0,0])
}
RecoverStack
$$p[0,0].setBrushColor(255,0,0)
Decl[int] co=$TILE_WIDTH[0,10] - $CHESS_WIDTH[0,11] / 2
drawRectangle($$p[0,0],$$x[0,1] * $TILE_WIDTH[0,10] + $$co[0,3],$$y[0,2] * $TILE_WIDTH[0,10] + $$co[0,3],$CHESS_WIDTH[0,11],$CHESS_WIDTH[0,11])
$$p[0,0].redraw()
}
ChessPad.this(string name,int w,int h){
PaintPad.this($$ChessPad[0,0],$$name[0,1],$$w[0,2],$$h[0,3])
}
void ChessPad.onClick(int id){
NullStmt
}
void  drawWorld(PaintPad p,bool[][] worldmap){
$$p[0,0].clear()
$$p[0,0].setBrushColor(0,0,0)
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$WIDTH[0,8]);++ $$i[0,0]
){
$$p[1,0].addLine($TILE_WIDTH[0,10] * $$i[0,0],0,$TILE_WIDTH[0,10] * $$i[0,0],$HEIGHT[0,9] * $TILE_WIDTH[0,10])
}
RecoverStack
PushStack
for(Decl[int] i=0
;<=($$i[0,0],$HEIGHT[0,9]);++ $$i[0,0]
){
$$p[1,0].addLine(0,$TILE_WIDTH[0,10] * $$i[0,0],$WIDTH[0,8] * $TILE_WIDTH[0,10],$TILE_WIDTH[0,10] * $$i[0,0])
}
RecoverStack
$$p[0,0].setBrushColor(255,0,0)
Decl[int] co=$TILE_WIDTH[0,10] - $CHESS_WIDTH[0,11] / 2
PushStack
for(Decl[int] x=0
;<($$x[0,0],$WIDTH[0,8]);++ $$x[0,0]
){
PushStack
for(Decl[int] y=0
;<($$y[0,0],$HEIGHT[0,9]);++ $$y[0,0]
){
if($$worldmap[2,1][$$x[1,0]][$$y[0,0]]){
drawRectangle($$p[2,0],$$x[1,0] * $TILE_WIDTH[0,10] + $$co[2,2],$$y[0,0] * $TILE_WIDTH[0,10] + $$co[2,2],$CHESS_WIDTH[0,11],$CHESS_WIDTH[0,11])
}
}
RecoverStack
}
RecoverStack
$$p[0,0].redraw()
}
bool  isAlive(bool[][] src,int x,int y){
Decl[int] counter=0
if(>($$x[0,1],0)){
SEQ{if($$src[0,0][$$x[0,1] - 1][$$y[0,2]]){
++ $$counter[0,3]
}
if(<($$y[0,2],$HEIGHT[0,9] - 1)){
if($$src[0,0][$$x[0,1] - 1][$$y[0,2] + 1]){
++ $$counter[0,3]
}
}
}}
if(<($$x[0,1],$WIDTH[0,8] - 1)){
SEQ{if($$src[0,0][$$x[0,1] + 1][$$y[0,2]]){
++ $$counter[0,3]
}
if(>($$y[0,2],0)){
if($$src[0,0][$$x[0,1] + 1][$$y[0,2] - 1]){
++ $$counter[0,3]
}
}
}}
if(>($$y[0,2],0)){
SEQ{if($$src[0,0][$$x[0,1]][$$y[0,2] - 1]){
++ $$counter[0,3]
}
if(>($$x[0,1],0)){
if($$src[0,0][$$x[0,1] - 1][$$y[0,2] - 1]){
++ $$counter[0,3]
}
}
}}
if(<($$y[0,2],$HEIGHT[0,9] - 1)){
SEQ{if($$src[0,0][$$x[0,1]][$$y[0,2] + 1]){
++ $$counter[0,3]
}
if(<($$x[0,1],$WIDTH[0,8] - 1)){
if($$src[0,0][$$x[0,1] + 1][$$y[0,2] + 1]){
++ $$counter[0,3]
}
}
}}
IntSwitch($$counter[0,3]){
case 2=>{
Return $$src[0,0][$$x[0,1]][$$y[0,2]](0)
}
case 3=>{
Return true(0)
default=>{
Return false(0)
}
}
}
void  calMap(bool[][] src,bool[][] tar){
PushStack
for(Decl[int] x=0
;<($$x[0,0],$WIDTH[0,8]);++ $$x[0,0]
){
PushStack
for(Decl[int] y=0
;<($$y[0,0],$HEIGHT[0,9]);++ $$y[0,0]
){
Set($$tar[2,1][$$x[1,0]][$$y[0,0]]=isAlive($$src[2,0],$$x[1,0],$$y[0,0]))
}
RecoverStack
}
RecoverStack
}
void  GameOfLife(int max){
Decl[PaintPad] pad=(new PaintPad,PaintPad.this(OutPipe,Game Of Life,$WIDTH[0,8] * $TILE_WIDTH[0,10] + 1,$HEIGHT[0,9] * $TILE_WIDTH[0,10] + 1))
Decl[bool[][]] world=null
Decl[bool[][]] world1=new [$WIDTH[0,8]]bool[][]
Decl[bool[][]] world2=new [$WIDTH[0,8]]bool[][]
PushStack
for(Decl[int] i=0
;<($$i[0,0],$WIDTH[0,8]);++ $$i[0,0]
){
SEQ{Set($$world1[1,3][$$i[0,0]]=new [$HEIGHT[0,9]]bool[])
Set($$world2[1,4][$$i[0,0]]=new [$HEIGHT[0,9]]bool[])
}}
RecoverStack
srand(BigIntIntConversion(time()))
Decl[int] sum=rand() % $WIDTH[0,8] * $HEIGHT[0,9]
PushStack
for(Decl[int] i=0
;<($$i[0,0],$$sum[1,5]);++ $$i[0,0]
){
SEQ{PushStack
Decl[int] x=0
Decl[int] y=0
do{
SEQ{Set($$x[0,0]=rand() % $WIDTH[0,8])
Set($$y[0,1]=rand() % $HEIGHT[0,9])
}}while($$world1[2,3][$$x[0,0]][$$y[0,1]]);
Set($$world1[2,3][$$x[0,0]][$$y[0,1]]=true)
RecoverStack
}}
RecoverStack
drawWorld($$pad[0,1],$$world1[0,3])
$$pad[0,1].show()
sleep(200)
while(>(-- $$max[0,0],0)){
calMap($$world1[0,3],$$world2[0,4])
Set($$world[0,2]=$$world2[0,4])
Set($$world2[0,4]=$$world1[0,3])
Set($$world1[0,3]=$$world[0,2])
drawWorld($$pad[0,1],$$world[0,2])
sleep(200)
}
$$pad[0,1].close()
}
complex complex.add(complex x){
Decl[complex] res=new complex
Set($$res[0,2].[0]r=$$x[0,1].[0]r + $$this[0,0].[0]r)
Set($$res[0,2].[1]img=$$x[0,1].[1]img + $$this[0,0].[0]r)
Return $$res[0,2](0)
}
bool complex.isGreaterThan(complex c){
if(>($$this[0,0].[0]r,$$c[0,1].[0]r) ){
Return true(0)
}else {
Return &&(==($$this[0,0].[0]r,$$c[0,1].[0]r),>($$this[0,0].[1]img,$$c[0,1].[1]img))(0)
}
}
string complex.toString(){
Return StrConversion($$this[0,0].[0]r) + + + StrConversion($$this[0,0].[1]img) + *i(0)
}
void CORD.init(real x,real y){
SEQ{Set($$this[0,0].[0]x=$$x[0,1])
Set($$this[0,0].[1]y=$$y[0,2])
}}
string CORD.toString(){
Return ( + StrConversion($$this[0,0].[0]x) + , + StrConversion($$this[0,0].[1]y) + )(0)
}
int  bufgetchar(){
if(<($buffer[0,13],0) ){
Return getchar()(0)
}else {
PushStack
Decl[int] tmp=$buffer[0,13]
Set($buffer[0,13]=-1)
Return $$tmp[0,0](1)
}
}
int  readint(){
Decl[int] i=0
Decl[int] c=bufgetchar()
while(&&(<=($$c[0,1],57),>=($$c[0,1],48))){
IntSet($$i[0,0]*=10)
IntSet($$i[0,0]+=$$c[0,1] - 48)
Set($$c[0,1]=bufgetchar())
}
Set($buffer[0,13]=$$c[0,1])
Return $$i[0,0](0)
}
tree_node  randomly_create_tree(){
Decl[tree_node] t=new tree_node
if(>(rand() % 10,5)){
Set($$t[0,0].[0]left=randomly_create_tree())
}
if(<(rand() % 10,5)){
Set($$t[0,0].[1]right=randomly_create_tree())
}
Set($$t[0,0].[2]value=rand() % 1000)
Return $$t[0,0](0)
}
int  prettily_show_tree(tree_node tree,int level){
SEQ{if(!=($$tree[0,0],null)){
repeat_print(  |,$$level[0,1])
print(StrConversion($$tree[0,0].[2]value))
print(
)
prettily_show_tree($$tree[0,0].[0]left,$$level[0,1] + 1)
prettily_show_tree($$tree[0,0].[1]right,$$level[0,1] + 1)
}
Return $$level[0,1](0)
}}
string  toString(char[] c_str){
Decl[string] r=
Decl[int] i=0
while(!=($$c_str[0,0][$$i[0,2]],0)){
StrSet($$r[0,1]+=StrConversion($$c_str[0,0][++ $$i[0,2]]))
}
Return $$r[0,1](0)
}
int[][]  mult(int[][] a,int[][] b){
Decl[string] r=
Decl[int[][]] res=new [10]int[][]
Decl[int] i=0
Decl[int] sum=0
Decl[int] j=0
Decl[int] k=0
for(Set($$i[0,4]=0)
;<($$i[0,4],10);++ $$i[0,4]
){
SEQ{Set($$res[0,3][$$i[0,4]]=new [10]int[])
for(Set($$j[0,6]=0)
;<($$j[0,6],10);++ $$j[0,6]
){
Set($$sum[0,5]=0)
for(Set($$k[0,7]=0)
;<($$k[0,7],10);++ $$k[0,7]
){
IntSet($$sum[0,5]+=$$a[0,0][$$i[0,4]][$$k[0,7]] * $$b[0,1][$$k[0,7]][$$j[0,6]])
}
Set($$res[0,3][$$i[0,4]][$$j[0,6]]=$$sum[0,5])
}
}}
Return $$res[0,3](0)
}
int  printarray(int[] arr,int len){
Decl[int] i=0
print([)
for($$i[0,2]
;<($$i[0,2],$$len[0,1]);++ $$i[0,2]
){
print(  + StrConversion($$arr[0,0][$$i[0,2]]))
}
print( ]
)
Return $$len[0,1](0)
}
int  max(int a,int b){
Return ((>($$a[0,0],$$b[0,1]))?($$a[0,0]):($$b[0,1]))(0)
}
string  trim(string str){
Decl[string] result=
Decl[int] len=strlen($$str[0,0])
Decl[int] i=0
Decl[int] j=$$len[0,2] - 1
while(==(StringVarAccess, )){
++ $$i[0,3]
}
while(==(StringVarAccess, )){
-- $$j[0,4]
}
for($$i[0,3]
;<=($$i[0,3],$$j[0,4]);++ $$i[0,3]
){
StrSet($$result[0,1]+=StrConversion(StringVarAccess))
}
Return $$result[0,1](0)
}
bool  is_prime(int n){
if(==($$n[0,0],1)){
Return false(0)
}
Decl[int] i=2
for($$i[0,1]
;<=($$i[0,1] * $$i[0,1],$$n[0,0]);++ $$i[0,1]
){
if(==($$n[0,0] % $$i[0,1],0)){
Return false(0)
}
}
Return true(0)
}
bigreal  sqrt(bigreal n){
Decl[bigreal] a=$$n[0,0] / 2
PushStack
for(Decl[int] i=0
;<($$i[0,0],40);++ $$i[0,0]
){
Set($$a[1,1]=$$n[1,0] / $$a[1,1] + $$a[1,1] / 2)
}
RecoverStack
Return $$a[0,1](0)
}
int  string2int(string s){
Decl[int] i=0
Decl[int] v=0
Decl[int] len=strlen($$s[0,0])
for($$i[0,1]
;<($$i[0,1],$$len[0,3]);++ $$i[0,1]
){
SEQ{IntSet($$v[0,2]*=10)
IntSet($$v[0,2]+=CharIntConversion(StringVarAccess - 0))
}}
Return $$v[0,2](0)
}
string  gestring(string str,char c,int i){
Decl[string] result=
while(<($$i[0,2],strlen($$str[0,0]))){
SEQ{if(>=(StringVarAccess,$$c[0,1])){
StrSet($$result[0,3]+=StrConversion(StringVarAccess))
}
++ $$i[0,2]
}}
Return $$result[0,3](0)
}
string  lsstring(string str,char c,int i){
Decl[int] l=strlen($$str[0,0])
Decl[string] result=
while(<($$i[0,2],$$l[0,3])){
SEQ{if(<(StringVarAccess,$$c[0,1])){
StrSet($$result[0,4]+=StrConversion(StringVarAccess))
}
++ $$i[0,2]
}}
Return $$result[0,4](0)
}
string  quicksort(string str){
Return ((<=(strlen($$str[0,0]),1))?($$str[0,0]):(quicksort(lsstring($$str[0,0],StringVarAccess,1)) + StrConversion(StringVarAccess) + quicksort(gestring($$str[0,0],StringVarAccess,1))))(0)
}
