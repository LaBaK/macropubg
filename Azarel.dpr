program Azarel;

uses
  Vcl.Forms,
  Windows,
  uPrincipal in 'uPrincipal.pas' {frmPrincipal},
  Vcl.Themes,
  Vcl.Styles,
  hkEndScene in 'hkEndScene.pas';

{$R *.res}



begin
Application.Initialize;

  Application.MainFormOnTaskbar := true;

  Application.Title := 'SoundNix';
  TStyleManager.TrySetStyle('Glossy');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
