program Project1;

uses
  Vcl.Forms,
  UfrmMain in 'UfrmMain.pas' {Form1},
  uToneGenerator in 'uToneGenerator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
