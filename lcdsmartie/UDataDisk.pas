unit UDataDisk;

interface

const
  HDKey = '$HD';
  HDFreeKey = HDKey + 'Free';
  HDUsedKey = HDKey + 'Used';
  HDTotalKey = HDKey + 'Total';
  HDFreePercentKey = HDKey + 'F%';
  HDUsedPercentKey = HDKey + 'U%';
  HDFreeGigaBytesKey = HDKey + 'Freg';
  HDUsedGigaBytesKey = HDKey + 'Useg';
  HDTotalGigaBytesKey = HDKey + 'Totag';

  FirstDrive = ord('A');
  LastDrive = ord('Z');

type
  THardDriveStats = (dsHDFree,dsHDUsed,dsHDTotal,dsHDFreePercent,dsHDUsedPercent,
                     dsHDFreeGigaBytes,dsHDUsedGigaBytes,dsHDTotalGigaBytes);

const
  HDKeys : array[THardDriveStats] of string = (
    HDFreeKey,HDUsedKey,HDTotalKey,HDFreePercentKey,HDUsedPercentKey,
    HDFreeGigaBytesKey,HDUsedGigaBytesKey,HDTotalGigaBytesKey);

  FirstHDStat = dsHDFree;
  LastHDStat = dsHDTotalGigaBytes;

implementation

end.
 