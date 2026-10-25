unit uconjunto;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

const
  max_ele=256;
type
  tconjunto=Class
    private
      dim:integer;
      elem:array[1..max_ele]of char;
    public
      constructor crear();
      function getdim():integer;
      procedure setdim(dime:integer);
      function getelem(pos:integer):char;
      procedure setelem(pos:integer;ele:char);
      function pertenece(ele:char):boolean;
      procedure agregar(ele:char);
      procedure remover(ele:char);
      procedure mostrar();
      procedure interseccion(a,b:tconjunto);
      procedure union(a,b:tconjunto);
  end;

implementation

constructor tconjunto.crear();
var
  pos:integer;
begin
  dim:=0;
  for pos:=1 to max_ele do
    elem[pos]:=char(0);
end;

function tconjunto.getdim(): integer;
begin
  result:=dim;
end;

procedure tconjunto.setdim(dime: integer);
begin
  if(dime>=0)and(dime<=max_ele) then
    dim:=dime
  else
    writeln('Dimension Fuera de Rango . . .');
end;

function tconjunto.getelem(pos: integer): char;
begin
  if(pos>=1)and(pos<=dim)then
    result:=elem[pos]
  else
    result:=char(0);
end;

procedure tconjunto.setelem(pos: integer; ele: char);
begin
  if(pos>=1)and(pos<=dim)then
    elem[pos]:=ele
  else
    writeln('Posicion Fuera de Rango . . .');
end;

function tconjunto.pertenece(ele: char): boolean;
var
  sw:boolean;
  pos:integer;
begin
  sw:=false;
  pos:=1;
  while(pos<=dim)and(not sw) do
  begin
    if(elem[pos]=ele) then
      sw:=true
    else
      pos:=pos+1;
  end;
  result:=sw;
end;

procedure tconjunto.agregar(ele: char);
begin
  if(dim<max_ele) then
  begin
    if(not pertenece(ele)) then
    begin
      dim:=dim+1;
      elem[dim]:=ele;
    end;
  end;
end;

procedure tconjunto.remover(ele: char);
var
  sw:boolean;
  pos,des:integer;
begin
  if(pertenece(ele)) then
  begin
    sw:=false;
    pos:=1;
    while (pos<=dim)and(not sw) do
    begin
      if(elem[pos]=ele) then
        sw:=true
      else
        pos:=pos+1;
    end;
    for des:=pos to dim-1 do
      elem[des]:= elem[des+1];
    dim:=dim-1;
  end;
end;

procedure tconjunto.mostrar();
var
  pos:integer;
begin
  write('{');
  for pos:=1 to dim do
    write(elem[pos],',');
  write('}');
end;

procedure tconjunto.interseccion(a, b: tconjunto);
var
  pos:integer;
begin
  dim:=0;
  for pos:=1 to a.getdim() do
    if(b.pertenece(a.getelem(pos)))then
      agregar(a.getelem(pos));
end;

procedure tconjunto.union(a, b: tconjunto);
var
  pos: integer;
begin
  dim := 0;
  for pos:=1 to a.getdim() do
    agregar(a.getelem(pos));
  for pos:=1 to b.getdim() do
    if(not a.pertenece(b.getelem(pos))) then
      agregar(b.getelem(pos));
end;

end.
