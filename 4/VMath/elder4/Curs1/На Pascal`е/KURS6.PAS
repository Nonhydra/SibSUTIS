{$N+}
uses crt, graph;
const eps=0.01;
      y_0=1;
      y_1=0.5;
      rastx=300;
      rasty=300;
type
  typeY=array[1..2] of double;

var kkk,k:double; {� �����뢠���� ��������� ���祭�� y1(0)}
    yy:TypeY;
    EndH:double; {������ 蠣 ��� �筮��}
    uzels:array[1..6,1..6] of real;
function func(x:double; y:double; y1:double; y2:double):double;
begin
func:=y2-cos(y2)-(x*x+y)-k*y1;
end;

function FindK:double;
var a,b,k,kt,c,d,h:double;
    i:byte;

  Function f(x:double):double;
  begin
   f:=2*x*x*x*x*x-sin(x)-3;
  end;

  Function MPD(a,b:double): double;
  Var
     c:double;
  Begin
    c:=(a+b)/2;
    while abs((b-a)/2)>eps/1000 do begin
      if (f(a)*f(c)<0) then b:=c else a:=c;
      c:=(a+b)/2;
    end;
    mpd:=c;
  end;
begin
  h:=1; c:=-5; d:=5;
  a:=c; b:=a+h;i:=0; k:=10000;
while i<1 do begin
 while b<=d do
  begin
    if f(a)*f(b)<0 then
      begin
         kt:=mpd(a,b);
         if (kt<k) and (kt>0) then k:=kt;
         inc(i);
      end;
    a:=b; b:=b+h;
  end;
c:=c-1; d:=d+1; h:=h/2;
end;
findK:=k;
end;

procedure searchInt(var a:double; var b:double; x:double; y:double; y1:double);
var c,d,h,fa,fb: double;
    i: integer;
begin
c:=-5; d:=5 ;h:=1; a:=c; b:=a+h;
fa:=1; fb:=1;
 while fa*fb>0 do
   begin
   a:=c;b:=a+h;
   fa:=func(x,y,y1,a); fb:=func(x,y,y1,b);
   while b<d do
      begin a:=b;
            b:=b+h;
            fa:=fb;
            fb:=func(x,y,y1,b);
            if fa*fb<0 then break;
      end;
      c:=c-1; d:=d+1; h:=h/2;
   end;
end;


procedure Mh(x:double; y:double; y1:double; var kr:double);
var fa,fb,fc,c,cp,a,b:double;
begin
     searchInt(a,b,x,y,y1);
     fa:=func(x,y,y1,a);fb:=func(x,y,y1,b);
     c:=0; cp:=(fb*a-fa*b)/(fb-fa);
     While (abs(cp-c)>eps) do
      begin
        c:=cp;
        fc:=func(x,y,y1,c);
        if fa*fc<0 then begin b:=c; fb:=fc; end
        else begin a:=c; fa:=fc; end;
        cp:=(fb*a-fa*b)/(fb-fa);
      end;
        kr:=cp;
end;
{�����頥� ���祭�� y2 c ����⠢����묨 ��ࠬ��ࠬ�}
function Difur(x:double; y:double; y1:double):double;
var a,b,kkk:double;
begin
Mh(x,y,y1,kkk);
difur:=kkk;
end;

{� ��� ��⮤ ����⠢������ ���祭��  y � y1, � ���������� � �窥 x+h}
function Ronge_Kutt(xi:double; var Y:TypeY; h:double):double;{�뤠�� Yi+1}
var K:array[1..4,1..2] of double;
    rrr:typeY;
begin
k[1,1]:=y[2];              k[1,2]:=difur(xi,y[1],y[2]);
k[2,1]:=y[2]+(h/2)*k[1,2]; k[2,2]:=difur(xi+h/2,y[1]+(h/2)*k[1,1],y[2]+(h/2)*k[1,2]);
k[3,1]:=y[2]+(h/2)*k[2,2]; k[3,2]:=difur(xi+h/2,y[1]+(h/2)*k[2,1],y[2]+(h/2)*k[2,2]);
k[4,1]:=y[2]+h*k[3,2];     k[4,2]:=difur(xi+h,y[1]+h*k[3,1],y[2]+h*k[3,2]);
y[1]:=y[1]+(h/6)*(k[1,1]+2*k[2,1]+2*k[3,1]+k[4,1]);
y[2]:=y[2]+(h/6)*(k[1,2]+2*k[2,2]+2*k[3,2]+k[4,2]);
end;

procedure DoublePereschet(var Yb:typeY; kr:double);
var hh, xi:double;
    Yh,Yh_2:TypeY;
    i: integer;
begin
hh:=0.05;
xi:=0;
yh[1]:=y_0;
yh[2]:=kr;
yh_2:=yh;
While (xi<1) do
  begin
  Ronge_Kutt(xi,Yh,hh);
  Ronge_Kutt(xi,Yh_2,hh/2);
  Ronge_Kutt(xi+hh/2,Yh_2,hh/2);

  if (abs(Yh[1]-Yh_2[1])>3*eps) then
     begin
       hh:=hh/2;
       xi:=0;
       yh[1]:=y_0;
       yh[2]:=kr;
       yh_2:=yh;
     end else xi:=xi+hh;
end;
endH:=hh/2;
yb:=yh_2;
writeln('y(1)= ',yh_2[1]:11:10,'  y1(1)= ',yh_2[2]:11:10,' �� y1(0)=',kr:11:10);
end;

procedure searchInt1(var a:double; var b:double);
var c,d,h:double;
    ya:TypeY; t:boolean;
begin
a:=-2; h:=1; b:=a+h;
doublePereschet(ya,a);
if ya[1]<y_1 then t:=true else t:=false;
while (t=(ya[1]<y_1)) do
   begin
     if ya[1]<y_1 then begin t:=true; a:=b; b:=b+h; end else begin t:=false; b:=a; a:=a-h; end;
     doublePereschet(ya,a);
   end;
   b:=a; a:=a-h;
end;

procedure strelba;
var  a,b,c,t:double;
     ya,yb,yc:TypeY;
Begin
  writeln('���� ���ࢠ�� :');
  searchInt1(a,b);
  writeln(' a= ',a:2:2,'   b=',b:2:2);
  DoublePereschet(ya,a);DoublePereschet(yb,b);
  repeat
    c:=((yb[1]-y_1)*a-(ya[1]-y_1)*b)/(yb[1]-ya[1]);
    DoublePereschet(yc,c);
    if ((ya[1]-y_1)*(yc[1]-y_1))<0 then begin b:=c; yb:=yc;  end else begin a:=c; ya:=yc; end;
  until (abs(y_1-yc[1])<eps);
 kkk:=c;
 writeln('��襭�� �ࠥ��� ����� k=y1(0)===',kkk:10:10);
end;

procedure zapoln_tabl;
 var i,j:integer;
  begin
     for i:=2 to 6 do
       for j:=6-i+1 downto 1 do
         uzels[j,i]:=uzels[j+1,i-1]-uzels[j,i-1];
  end;
procedure print;
 var i,j:integer;
  begin
     for i:=1 to 6 do
       begin
         for j:=1 to 6 do
           write(uzels[i,j]:10:4);
         writeln;
       end;
  end;

function nuton(x:real; h:real):real;
 var  i,j   :integer;
     fuck   :longint;
     q,qq,p :real;
  begin
      fuck:=1;
      q:=(x)/h;
      qq:=q;
      p:=uzels[1,1];

      for i:=2 to 6 do
        begin
          p:=p+(uzels[1,i]*qq)/fuck;
          qq:=qq*(q-i+1);
          fuck:=fuck*i;
        end;
      nuton:=p;
  end;

procedure graphik;
 var i:real; j,gm,gd: integer;
     yy:Typey;
     oy,ox:integer;
  begin
     gm:=0; gd:=0;
     initgraph(gm,gd,'c:\tp7\bgi');
     cleardevice;
     settextstyle(7,0,3);
     outtextxy(170,350,'�p�䨪 �㭪樨 �������� �� ��');
     setcolor(green);
     outtextxy(190,400,'� ���௮�����饩 �㭪樨');

     ox:=20;
     oy:=470;
     uzels[1,1]:=y_0;
     j:=1;
     yy[1]:=y_0;
     yy[2]:=kkk;

    setcolor(white);
    line(ox,0,ox,480);
    line(0,oy,640,oy);

    i:=0;
    moveto(round(i*rastx)+ox,oy-round(y_0*rasty));
    while i<=1 do
       begin
         ronge_Kutt(i,yy,endh);
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(yy[1]*rasty));
         if round(i*1000)=round(200*j) then
           begin
              uzels[j+1,1]:=yy[1];
              inc(j);
           end;
       end;
    readkey;
    zapoln_tabl;

    setcolor(2);
    i:=0;
    moveto(round(i*rastx)+ox,oy-round(nuton(i,0.2)*rasty));
    while i< 1.1 do
       begin
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(nuton(i,0.2)*rasty));
       end;

    setcolor(white);
    for j:=0 to 5 do
      circle(round((j/5)*rastx)+ox,oy-round(uzels[j+1,1]*rasty),3);
   readkey;
   closegraph;

  end;

function Simpson(a:double; b:double; h:double):double;
var aa,bb,int:double;
begin
aa:=a; bb:=a+2*h;
Int:=0;

while round(bb*1000)<round((b+2*h)*1000) do
     begin
      if bb>=b then bb:=b;
      Int:=Int+(bb-aa)*((1/6)*nuton(aa,0.05)*nuton(aa,0.05)+
      (2/3)*nuton(aa+(bb-a)/2,0.05)*nuton(aa+(bb-a)/2,0.05)+(1/6)*nuton(bb,0.05)*nuton(bb,0.05));
      aa:=bb; bb:=bb+2*h;
     end;
Simpson:=Int;
end;

{�뢮� �� ��࠭ ���祭�� 䨭�樨 �ந������� � ᯫ���� � �窠� �� [0,1] c 蠣�� 0.05}
procedure vivod;
var i: integer;
    yy: typeY;
    x:double;
begin
  clrscr;
  x:=0;
  yy[1]:=y_0;
  yy[2]:=kkk;
  i:=1;
  writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y1(',x:2:2,')= ',yy[2]:13:10,'   ','nuton(',x:2:2,')= ',nuton(x,0.2):13:10);
    while x<=1 do
       begin
         ronge_Kutt(x,yy,endh);
         x:=x+endh;
         if round(x*1000000)=round(50000*i) then
           begin
             writeln('y(',x:2:2,')= ',yy[1]:13:10,'   ','y1(',x:2:2,')= ',
             yy[2]:13:10,'   ','nuton(',x:2:2,')= ',nuton(x,0.2):13:10);
             inc(i);
           end;
       end;
    readkey;
end;

var i: integer;
begin
clrscr;
writeln;
k:=findk;
writeln('��襭�� ��������� �ࠢ����� k===== ',k:10:10);
writeln(' ���� ����� ��⮤� ��५�....');
strelba;
writeln('������ H ᮮ⢥�����騩 �筮�� = ',endh:10:13);
writeln('Press any key...');
readkey;
graphik;
clrscr;
writeln('������ ������� ࠧ���⥩ :');
print;
readkey;
writeln('������⢮ ⥯�� =====',Simpson(0,1,0.01):10:10);
readkey;
vivod;
end.
Read:
��襭�� ����ਭ樠�쭮�� �ࠢ����� ��稭����� � �ࠥ��� �����.
�����⭮ : �㭪�� � �窥 0 � �㭪�� � �窥 1, ��� �㦭�
��� �襭�� ���. �ࠢ����� �ந������� ��ࢠ� � �窥 0.
��� ⮣� �⮡� �� ���� �ᯮ������ ��⮤ ��५�.
�� �� ��� � ���� ���ਬ�� ��⮤ ����������� �������, ���� ��. �㦭�
�������� ⠪�� ����� �ந������� � �窥 0 �⮡� �� ����⠭���� � ���
�ࠢ����� �㭪�� � �窥 1 �뫠 = 0.5. �� � ������ ��⮤ ��५�.
��⮤ ��५� ����⠢��� ����� �ந������� � �窥 0 � Doublepereschet
����� �����頥� ���祭�� �㭪樨 � ���祭�� �ந������� � �窥 1 �
�ࠢ������ y(1) � 0.5 �.� � ��砫�묨 �᫮��ﬨ.
�� ᭠砫� �㦭� ���� ���ࢠ�, �� ������ SearchInt1;

������� ������ ��⠥� ���祭�� �㭪樨 � �ந������� � 蠣�� h � h/2
�� 0 �� 1 � �ࠢ�������� �� �筮��. ���� ���祭�� � �窠�
������� ������ ��뢠�� ��⮤ Ronge_kutt � ���������� ������ 蠣 �
���஬ ���⨣����� �筮���.
��⮤ ஭�� ���� �뤠�� y y1 � �窥 x+h � ����⠢����묨 ��ࠬ��ࠬ�
x y y1,
��⮤ ஭��-���� �ᯮ���� ���祭�� ��ன �ந�������, ���஥ �뤠��
Difur, �� ���� �ந������� ������ �� �
���⮬� �㭪�� Difur �蠥� ��⮤�� �� �ࠢ�����, ��� �������⭮� ����
���� �ந�������.
� �⮣� ������� ���祭�� �ந������� � �窥 0 � ���஥ �㦭�;
����⠢��� �� ���祭��, ⮥��� ��砫�� ��ࠬ���� � Ronge-Kutt
����砥��� ���祭�� �㭪樨 � ࠧ����� �窠�. ���祭�� �
�窠� i*0.2 ��� i=0..5 ������������ � ���ᨢ� � ����� �ᯮ������
���筠� ���௮���� ���⮭��.
����� ��⠥��� ��⥣ࠫ �� ��㫥 ᨬ�ᮭ�.
�� ᤥ��� �뢮� ���祭�� �㭪樨, �ந�������, � ���⮭ � 蠣�� 0.05.
�� ᤠ� ���ᮢ��� �� ���筮 �ॡ����.