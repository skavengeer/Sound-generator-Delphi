{======================================
Tone Generator
=======================================}
unit UfrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, StdCtrls, ComCtrls,uToneGenerator, ExtCtrls;


type
  TForm1 = class(TForm)
    btnGenerate: TButton;
    edFrequency: TEdit;
    lblFrequency: TLabel;
    edDuration: TEdit;
    lblDuration: TLabel;
    lblHz: TLabel;
    lblMSec: TLabel;
    trckbrVolume: TTrackBar;
    lblVolume: TLabel;
    cmbxSampleRate: TComboBox;
    lblSampleRate: TLabel;
    rdgrpChannel: TRadioGroup;
    procedure btnGenerateClick(Sender: TObject);

  private
    tone:TBasicToneGenerator;
    { Private declarations }
  public
    constructor Create(AOwner:TComponent);override;
    destructor destroy;override;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.btnGenerateClick(Sender: TObject);

begin
  tone.Frequency:=strToInt(edFrequency.Text);
  tone.Duration:=strToInt(edDuration.Text);
  tone.Volume:=TVolumeLevel(trckBrVolume.Position);
  tone.SampleRate:=TSampleRate(cmbxSampleRate.ItemIndex);
  if rdgrpChannel.ItemIndex=0 then
    tone.Channel:=chMono
  else
    tone.Channel:=chStereo;

  tone.Generate;
  tone.Play;

end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
  edFrequency.Text := '1000';
  edDuration.Text := '300';
  cmbxSampleRate.ItemIndex := 0 ;
  rdgrpChannel.ItemIndex := 0;
  tone:=TBasicToneGenerator.Create;
end;

destructor TForm1.destroy;
begin
  tone.Free;
  inherited;
end;


end.
