unit Funcionario;

{$mode objfpc}{$H+}

interface

Uses
    SysUtils;

type

  EFuncionario = class(Exception);

  { TFuncionario }

  TFuncionario = class
    private
      Fid: Int64;
      FNome: string;
    public
    published
      property Id: Int64 read fid write FId;
      property Nome: string read fnome write FNome;

  end;

  EMotorista = class(Exception);

  TMotorista = class(TFuncionario)
    private
      FCnh: string;
      FCnhClasse: string;
    public
    published
      property Cnh: String read FCnh write FCnh;
      property cnhclasse: string read FCnhClasse write FCnhClasse;

  end;

  EOperador = class(Exception);

    TOperador = class(TFuncionario)
    private
      FSenha: string;
    public
    published
      property Senha: string read FSenha write FSenha;

  end;

  implementation

end.

