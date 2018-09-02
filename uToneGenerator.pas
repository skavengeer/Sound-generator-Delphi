{*************************************
Tone Generator Wrapper class
*************************************}

unit uToneGenerator;

interface

uses classes,windows,sysutils,MMSystem;

type
  TVolumeLevel = 0..127;
  TSampleRate=(sr8KHz,sr11_025KHz,sr22_05KHz,sr44_1KHz);
  TSoundChannel=(chMono,chStereo);
  TBitsPerSample=(bps8Bit,bps16Bit,bps32Bit);

const SampleRates:array[sr8KHz..sr44_1KHz] of integer = (8000,11025,22050,44100);
const Channels:array[chMono..chStereo] of word = (1,2);

//const BitsPerSample:array[bps8Bit..bps32Bit] of word= (8,16,32);

type
  TBasicToneGenerator=class(TPersistent)
  private
    FStream:TMemoryStream;
    FDuration: integer;
    FSampleRate: TSampleRate;
    FVolume: TVolumeLevel;
    FChannel: TSoundChannel;
    FFrequency: integer;
    procedure SetDuration(const Value: integer);
    procedure SetSampleRate(const Value: TSampleRate);
    procedure SetVolume(const Value: TVolumeLevel);
    procedure SetChannel(const Value: TSoundChannel);
    procedure SetFrequency(const Value: integer);
  protected
  public
    constructor Create;virtual;
    destructor Destroy;override;
    procedure Generate;virtual;
    procedure Play;
  published
    property SampleRate:TSampleRate read FSampleRate write SetSampleRate;
    property Duration:integer read FDuration write SetDuration;
    property Volume:TVolumeLevel read FVolume write SetVolume;
    property Channel:TSoundChannel read FChannel write SetChannel;
    property ToneStream:TMemoryStream read FStream;
    property Frequency:integer read FFrequency write SetFrequency;
  end;


procedure GenerateToneToStream(Stream:TStream;const Frequency{Hz}, Duration{mSec}: Integer; const Volume: TVolumeLevel; const nChannel:TSoundChannel; const Sample_Rate:TSampleRate);

function GetSampleRate(SampleRate:TSampleRate):integer;
function GetNumChannels(ch:TSoundChannel):word;


implementation


procedure GenerateToneToStream(Stream:TStream; const Frequency{Hz}, Duration{mSec}: Integer; const Volume: TVolumeLevel;
                                const nChannel:TSoundChannel; const Sample_Rate:TSampleRate);

var
  WaveFormatEx: TWaveFormatEx;
  i, TempInt, DataCount, RiffCount: integer;
  SoundValue: byte;
  w: double;
  SampleRate:integer;

const
  RiffId: ansistring = 'RIFF';
  WaveId: ansistring = 'WAVE';
  FmtId:  ansistring = 'fmt ';
  DataId: ansistring = 'data';

begin
  SampleRate := GetSampleRate(Sample_Rate);// 8000, 11025, 22050, or 44100

  if Frequency > (0.6 * SampleRate) then
    raise Exception.Create(Format('Sample rate of %d is too Low to play a tone of %dHz', [SampleRate, Frequency]) );


  with WaveFormatEx do
  begin
    wFormatTag      := WAVE_FORMAT_PCM;
    nChannels       := GetNumChannels(nChannel);
    nSamplesPerSec  := SampleRate;
    wBitsPerSample  := $0008;                    //const BitsPerSample:array[bps8Bit..bps32Bit] of word= (8,16,32);
    nBlockAlign     := (nChannels * wBitsPerSample) div 8;
    nAvgBytesPerSec := nSamplesPerSec * nBlockAlign;
    cbSize          := 0;
  end;

 with Stream do
 begin
  {Calculate length of sound data and of file data}
  DataCount := (Duration * SampleRate) div 1000; // sound data
  RiffCount := Length(WaveId) + Length(FmtId) + SizeOf(DWORD) +
               SizeOf(TWaveFormatEx) + Length(DataId) + SizeOf(DWORD) + DataCount; // file data
  {write out the wave header}
  WriteBuffer(RiffId[1], 4); // 'RIFF'
  WriteBuffer(RiffCount, SizeOf(DWORD)); // file data size
  WriteBuffer(WaveId[1], Length(WaveId)); // 'WAVE'
  WriteBuffer(FmtId[1], Length(FmtId)); // 'fmt '
  TempInt := SizeOf(TWaveFormatEx);
  WriteBuffer(TempInt, SizeOf(DWORD)); // TWaveFormat data size
  WriteBuffer(WaveFormatEx,SizeOf(TWaveFormatEx)); // WaveFormatEx record
  WriteBuffer(DataId[1], Length(DataId)); // 'data'
  WriteBuffer(DataCount, SizeOf(DWORD)); // sound data size
 {calculate and write out the tone signal} // now the data values
  w := 2 * Pi * Frequency; // omega

  for i := 0 to DataCount - 1 do
  begin
    SoundValue := 127 + trunc(Volume * sin(i * w/SampleRate));
    WriteBuffer(SoundValue, Sizeof(Byte));
  end;
 end;
end;
//-------------------------------------------------------------------------------
constructor TBasicToneGenerator.Create;
begin
   inherited;
end;

destructor TBasicToneGenerator.Destroy;
begin
  FStream.Free;
  inherited;
end;

procedure TBasicToneGenerator.Generate;
begin
  if FStream=nil then
    FStream:=TMemoryStream.Create;
    FStream.Clear;
    GenerateToneToStream(FStream, FFrequency, FDuration, FVolume, FChannel, FSampleRate);

end;

procedure TBasicToneGenerator.Play;
begin
  if FStream.Size<>0 then
    PlaySound(FStream.Memory,0, SND_MEMORY or SND_ASYNC);
   // sndPlaySound(FStream.Memory, SND_MEMORY or SND_ASYNC);
end;

procedure TBasicToneGenerator.SetFrequency(const Value: integer);
begin
  FFrequency := Value;
end;

procedure TBasicToneGenerator.SetDuration(const Value: integer);
begin
  FDuration := Value;
end;

procedure TBasicToneGenerator.SetVolume(const Value: TVolumeLevel);
begin
  FVolume := Value;
end;

procedure TBasicToneGenerator.SetSampleRate(const Value: TSampleRate);
begin
  FSampleRate := Value;
end;

procedure TBasicToneGenerator.SetChannel(const Value: TSoundChannel);
begin
  FChannel := Value;
end;
//-------------------------------------------------------------------------------
{TToneGenerator}

function GetSampleRate(SampleRate:TSampleRate):integer;
begin
  result:= SampleRates[SampleRate];
end;

function GetNumChannels(ch:TSoundChannel):word;
begin
  result:= Channels[ch];
end;

initialization
randomize;

end.
