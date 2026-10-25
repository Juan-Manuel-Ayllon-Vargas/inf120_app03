unit uventana;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ucadena;

type
  tform1 = class(tform)
    button1: tbutton;
    button10: tbutton;
    button11: tbutton;
    button12: tbutton;
    button13: tbutton;
    button14: tbutton;
    button15: tbutton;
    button16: tbutton;
    button17: tbutton;
    button18: tbutton;
    button19: tbutton;
    button2: tbutton;
    button3: tbutton;
    button4: tbutton;
    button5: tbutton;
    button6: tbutton;
    button7: tbutton;
    button8: tbutton;
    button9: tbutton;
    ele: tedit;
    pos: tedit;
    label1: tlabel;
    sg: tstringgrid;
    procedure button1click(sender: tobject);
    procedure button2click(sender: tobject);
    procedure button3click(sender: tobject);
    procedure button4click(sender: tobject);
    procedure button5click(sender: tobject);
    procedure button6click(sender: tobject);
    procedure button7click(sender: tobject);
    procedure button8click(sender: tobject);
    procedure button9click(sender: tobject);
    procedure button10click(sender: tobject);
    procedure button11click(sender: tobject);
    procedure button12click(sender: tobject);
    procedure button13click(sender: tobject);
    procedure button14click(sender: tobject);
    procedure button15click(sender: tobject);
    procedure button16click(sender: tobject);
    procedure button17click(sender: tobject);
    procedure button18click(sender: tobject);
  private
    cad:tcadena;
    procedure updatesg();
  public

  end;

var
  form1: tform1;

implementation

{$R *.lfm}

procedure tform1.updatesg();
var
  des:integer;
begin
  sg.colcount:=cad.getdim();
  for des:=1 to cad.getdim() do
    sg.cells[des-1,0]:= cad.getchar(des);
end;

procedure tform1.button1click(sender: tobject);
begin
  cad:=tcadena.crear();
  updatesg();
  showmessage('Cadenas de Caracteres Inicializada . . .');
end;

procedure tform1.button15click(sender: tobject);
begin
  close();
end;

procedure tform1.button3click(sender: tobject);
begin
  pos.text:=inttostr(cad.getdim());
end;

procedure tform1.button2click(sender: tobject);
begin
  cad.setdim(strtoint(pos.text));
  updatesg();
  pos.text:='';
end;

procedure tform1.button5click(sender: tobject);
begin
  ele.text:=cad.getchar(strtoint(pos.text));
  pos.text:='';
end;

procedure tform1.button4click(sender: tobject);
begin
  cad.setchar(strtoint(pos.text),ele.text[1]);
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.button6click(sender: tobject);
begin
  cad.addchar(ele.text[1]);
  updatesg();
  ele.text:='';
end;

procedure tform1.button7click(sender: tobject);
begin
  cad.inschar(strtoint(pos.text),ele.text[1]);
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.button8click(sender: tobject);
begin
  cad.elimchar(strtoint(pos.text));
  updatesg();
  pos.text:='';
end;

procedure tform1.button9click(sender: tobject);
begin
  pos.text:=inttostr(cad.cantpal());
end;

procedure tform1.button10click(sender: tobject);
begin
  pos.text:=inttostr(cad.busqpal(ele.text));
  ele.text:='';
end;

procedure tform1.button11click(sender: tobject);
begin
  cad.addpal(ele.text);
  updatesg();
  ele.text:='';
end;

procedure tform1.button13click(sender: tobject);
begin
  cad.elimpal(ele.text);
  updatesg();
  ele.text:='';
end;

procedure tform1.button12click(sender: tobject);
begin
  cad.inspal(strtoint(pos.text),ele.text);
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.button14click(sender: tobject);
begin
  cad.campal(pos.text,ele.text);
  updatesg();
  pos.text:='';
  ele.text:='';
end;

procedure tform1.button16click(sender: tobject);
begin
  cad.invertir();
  updatesg();
end;

procedure tform1.button18click(sender: tobject);
begin
  cad.minusculas();
  updatesg();
end;

procedure tform1.button17click(sender: tobject);
begin
  cad.mayusculas();
  updatesg();
end;

end.
