unit uTela;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, ppDB,
  ppEndUsr, ppParameter, ppDesignLayer, ppPrnabl, ppClass, ppCtrls, ppCache,
  ppBands, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, uEncontro,
  DBXJSON, REST.Json, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Cert: TClientDataSet;
    CertMARCA_MOD_ANO_NRO: TStringField;
    CertC_NUM_FICHA: TStringField;
    CertC_LETRA: TStringField;
    CertNOME: TStringField;
    CertMODELO: TStringField;
    CertANO: TIntegerField;
    CertPLACA: TStringField;
    CertDESCRICAO: TStringField;
    CertNUM_FICHA: TIntegerField;
    dsCert: TDataSource;
    dbCert: TppDBPipeline;
    Rel: TppReport;
    ppParameterList1: TppParameterList;
    designe: TppDesigner;
    btnConfig: TButton;
    ppDetailBand1: TppDetailBand;
    ppDBText1: TppDBText;
    ppDBText3: TppDBText;
    ppDBText6: TppDBText;
    ppDBText2: TppDBText;
    ppDesignLayers1: TppDesignLayers;
    ppLabel1: TppLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnConfigClick(Sender: TObject);
  private
    { Private declarations }
    FConfig: Boolean;
    procedure Impressao;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnConfigClick(Sender: TObject);
begin
  designe.Show;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FConfig := False;
  if ParamCount > 0 then
  begin
    if ParamStr(1) = '-conf' then
      FConfig := True;
  end;
  Cert.CreateDataSet;
  Impressao;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if FConfig = False then
    Close;
end;

procedure TForm1.Impressao;
var
  encontro: TImpressaoEncontro;
  arq: TextFile;
  linha: string;
begin
  if FConfig = True then
    Exit;

  if FileExists('impressao.txt') then
  begin
    try
      Rel.Template.FileName := 'Certificado.rtm';
      Rel.Template.LoadFromFile;

      AssignFile(arq, 'impressao.txt');
      Reset(arq);
      Readln(arq, linha);
      encontro :=  TJson.JsonToObject<TImpressaoEncontro>(linha);
      CloseFile(arq);


      Cert.Append;
      CertC_LETRA.AsString := encontro.Letra;
      CertNOME.AsString := encontro.NomePessoa;
      CertMODELO.AsString := encontro.Modelo;
      CertANO.AsInteger := encontro.Ano;
      CertC_NUM_FICHA.AsInteger := encontro.NumeroFicha;

      CertMARCA_MOD_ANO_NRO.AsString := CertMODELO.AsString + '    ' + CertANO.AsString;
      Cert.Post;


      Rel.Print;
    finally
      FreeAndNil(encontro);
    end;
  end;
end;

end.
