unit UDataGame;

interface

const
  UnrealKey = '$Unreal';
  Quake2Key = '$QuakeII';
  Quake3Key = '$QuakeIII';
  HalfLifeKey = '$Half-life';

type
  TGameType = (gtUnreal,gtQuake2,gtQuake3,gtHalfLife);

const
  GameKeys : array[TGameType] of string = (UnrealKey,Quake2Key,Quake3Key,HalfLifeKey);
  GameCommandLineParams : array[TGameType] of string = ('-uns','-q2s','-q3s','-hls');

  MinGame = gtUnreal;
  MaxGame = gtHalfLife;

implementation

end.
 