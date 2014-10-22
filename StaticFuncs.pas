unit StaticFuncs;

interface


  function VLCLock(opaque: Pointer; plane: Pointer): Pointer; cdecl;
  function VLCUnlock(opaque: Pointer; picture: Pointer; plane: Pointer)
  : Pointer; cdecl;
  function VLCdisplay(opaque: Pointer; picture: Pointer): Pointer; cdecl;

implementation

uses VLCVideo;

function VLCLock(opaque: Pointer; plane: Pointer): Pointer; cdecl;
var
  ctx: TCTX;
begin
  ctx := TCTX(opaque);
  Pointer(plane^) := @(ctx.FBuffer.StartLine[0]);
  Result := nil;
end;

function VLCUnlock(opaque: Pointer; picture: Pointer; plane: Pointer)
  : Pointer; cdecl;
begin
  Result := nil;
  if opaque <> nil then
    TCTX(opaque).Parent.InvalidateRect(TCTX(opaque).Parent.ClipRect);
end;

function VLCdisplay(opaque: Pointer; picture: Pointer): Pointer; cdecl;
begin
  Result := nil;
end;

end.
