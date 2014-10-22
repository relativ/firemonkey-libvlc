unit VLCInstance;

interface

uses
  System.SysUtils, System.Classes, PasLibVlcUnit;

type
  TVLCInstance = class(TComponent)
  private
    bInitSuccedd: boolean;
  protected
    { Protected declarations }
  public
    VLCInstance: libvlc_instance_t_ptr;
    procedure initVLC;
    procedure destroyVLC;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('VLCMonkey', [TVLCInstance]);
end;

procedure TVLCInstance.initVLC;
var
  vlcargs : array[0..0] of PAnsiChar;
begin
  if VLCInstance <> nil then exit;
  if not bInitSuccedd then
  begin
    libvlc_dynamic_dll_init();
    vlcargs[0] := PAnsiChar(libvlc_dynamic_dll_path);
  //  args[2] := nil;
    VLCInstance := libvlc_new(Length(vlcargs), @vlcargs);
    bInitSuccedd := true;
  end;
end;

procedure TVLCInstance.destroyVLC;
begin
  if (Assigned(libvlc_release)) then
  begin
    if (VLCInstance <> NIL) then
    begin
      libvlc_release(VLCInstance);
    end;
  end;
  libvlc_dynamic_dll_done();
end;

end.
