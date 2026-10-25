unit ucadena;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, uconjunto, Dialogs;

const
  max_elem=5000;
type
  tcadena=Class
    private
      sep,dig,min,may:tconjunto;
      dim:integer;
      elem:array[1..max_elem]of char;
    public
      constructor crear();
      function getdim():integer;
      procedure setdim(dime:integer);
      function getchar(pos:integer):char;
      procedure setchar(pos:integer;ele:char);
      procedure addchar(ele:char);
      procedure elimchar(pos:integer);
      procedure inschar(pos:integer;ele:char);
      procedure leerpal(var pos:integer; var pal:string);
      function busqpal(palb:string):integer;
      function cantpal():integer;
      procedure addpal(pal:string);
      procedure elimpal(pal:string);
      procedure inspal(pos:integer;pal:string);
      procedure campal(palo, palr:string);
      procedure invertir();
      procedure minusculas();
      procedure mayusculas();
  end;

implementation

constructor tcadena.crear();
var
  pos:integer;
begin
  sep:=tconjunto.crear();
  sep.agregar('-');
  sep.agregar('_');
  sep.agregar(',');
  sep.agregar('.');
  sep.agregar(':');
  sep.agregar(';');
  sep.agregar('#');
  sep.agregar(' ');

  dig:=tconjunto.crear();
  for pos:=0 to 25 do
    dig.agregar(char(48+pos));

  min:=tconjunto.crear();
  for pos:=0 to 25 do
    min.agregar(char(97+pos));

  may:=tconjunto.crear();
  for pos:=0 to 25 do
    may.agregar(char(65+pos));

  dim:=0;
  for pos:=1 to max_elem do
    elem[pos]:=char(0);
end;

function tcadena.getdim(): integer;
begin
  result:=dim;
end;

procedure tcadena.setdim(dime: integer);
begin
  if(dime>=0)and(dime<=max_elem) then
    dim:=dime
  else
    showmessage('Dimension fuera de rango . . .');
end;

function tcadena.getchar(pos: integer): char;
begin
  if(pos>=1)and(pos<=dim) then
    result:=elem[pos]
  else
    result:=char(0);
end;

procedure tcadena.setchar(pos: integer; ele: char);
begin
  if(pos>=1)and(pos<=dim) then
    elem[pos]:=ele
  else
    showmessage('Posicion fuera de rango . . .');
end;

procedure tcadena.addchar(ele: char);
begin
  if(dim<max_elem) then
  begin
    dim:=dim+1;
    elem[dim]:=ele;
  end;
end;

procedure tcadena.elimchar(pos: integer);
var
  des:integer;
begin
  if(pos>=1)and(pos<=dim) then
  begin
    for des:=pos to dim-1 do
      elem[des]:=elem[des+1];
    dim:=dim-1;
  end
  else
    showmessage('Posicion fuera de rango . . .');
end;

procedure tcadena.inschar(pos: integer; ele: char);
var
  des:integer;
begin
  if(pos>=1)and(pos<=dim) then
  begin
    for des:=dim downto pos do
      elem[des+1]:=elem[des];
    elem[pos]:=ele;
    dim:=dim+1;
  end
  else
    showmessage('Posicion fuera de rango . . .');
end;

procedure tcadena.leerpal(var pos: integer; var pal: string);
begin
  pal:='';
  while(pos<=dim)and(not sep.pertenece(elem[pos])) do
  begin
    pal:=pal+elem[pos];
    pos:=pos+1;
  end;
  while(pos<=dim)and(sep.pertenece(elem[pos])) do
  begin
    pos:=pos+1;
  end;
end;

function tcadena.busqpal(palb: string): integer;
var
  pos,posant:integer;
  sw:boolean;
  pal:string;
begin
  sw:=false;
  pos:=1;
  while (pos<=dim)and(not sw) do
  begin
    posant:=pos;
    leerpal(pos,pal);
    if(pal=palb) then
    begin
      sw:=true
    end;
  end;
  if(sw) then
    result:=posant
  else
    result:=-1;
end;

function tcadena.cantpal(): integer;
var
  cp,pos:integer;
  pal:string;
begin
  cp:=0;
  pos:=1;
  while(pos<=dim) do
  begin
    leerpal(pos,pal);
    if(pal<>'')then
      cp:=cp+1;
  end;
  result:=cp;
end;

procedure tcadena.addpal(pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(dim+n+1<max_elem) then
  begin
    addchar(')');
    for des:=1 to n do
      addchar(pal[des]);
  end
  else
    showmessage('Almacenamiento lleno . . .');
end;

procedure tcadena.elimpal(pal: string);
var
  pos,des,n:integer;
begin
  pos:=busqpal(pal);
  if(pos<>-1)then
  begin
    n:=length(pal);
    elimchar(pos-1);
    for des:=1 to n do
      elimchar(pos-1);
    elimchar(pos-1);
  end
  else
    showmessage('La Palabra No Existe . . .');
end;

procedure tcadena.inspal(pos: integer; pal: string);
var
  n,des:integer;
begin
  n:=length(pal);
  if(dim+n+2<max_elem)then
  begin
    inschar(pos,' ');
    for des:=1 to n do
      inschar(pos+des,pal[des]);
    inschar(pos+n+1, ' ');
  end
  else
    showmessage('No hay espacio de almacenamiento');
end;

procedure tcadena.campal(palo, palr: string);
var
  pos:integer;
begin
  pos:=busqpal(palo);
  if(pos<>-1) then
  begin
    elimpal(palo);
    inspal(pos-1,palr);
  end
  else
    showmessage('La palabra No existe . . .');
end;

procedure tcadena.invertir;
var
  pos,ult:integer;
  aux:char;
begin
  pos:=1;
  ult:=dim;
  while pos<ult do
  begin
    aux:=elem[pos];
    elem[pos]:=elem[ult];
    elem[ult]:=aux;
    pos:=pos+1;
    ult:=ult-1;
  end;
end;

procedure tcadena.minusculas;
var
  pos:integer;
begin
  for pos:=1 to dim do
    if (elem[pos]>='A') and (elem[pos]<='Z') then
      elem[pos]:=chr(ord(elem[pos])+32);
end;

procedure tcadena.mayusculas;
var
  pos:integer;
begin
  for pos:=1 to dim do
    if (elem[pos]>='a') and (elem[pos]<='z') then
      elem[pos]:=chr(ord(elem[pos])-32);
end;

end.
