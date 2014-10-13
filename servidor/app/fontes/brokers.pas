unit Brokers;

{$mode objfpc}{$H+}

interface

uses
  BrookFCLHttpAppBroker, BrookUtils, BrookFCLEventLogBroker;

implementation

initialization
  BrookSettings.Port := 8080;
  BrookSettings.LogActive:=true;
  BrookSettings.LogFile:= './logbrook.txt';

end.
