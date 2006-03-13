unit UDataNetwork;

interface

type
  TNetworkStatistics =
    (nsNetIPAddress, nsNetAdapter, nsNetDownK, nsNetUpK, nsNetDownM, nsNetUpM,
     nsNetDownG, nsNetUpG, nsNetErrDown, nsNetErrUp, nsNetErrTot, nsNetUniDown,
     nsNetUniUp, nsNetUniTot, nsNetNuniDown, nsNetNuniUp, nsNetNuniTot,
     nsNetPackTot, nsNetDiscDown, nsNetDiscUp, nsNetDiscTot, nsNetSpDownK,
     nsNetSpUpK, nsNetSpDownM, nsNetSpUpM);

const
  NetKeyPrefix = '$Net';
  NetIPAddressKey = NetKeyPrefix + 'IPaddress';
  NetAdapterKey = NetKeyPrefix + 'Adapter';
  NetDownKKey = NetKeyPrefix + 'DownK';
  NetUpKKey = NetKeyPrefix + 'UpK';
  NetDownMKey = NetKeyPrefix + 'DownM';
  NetUpMKey = NetKeyPrefix + 'UpM';
  NetDownGKey = NetKeyPrefix + 'DownG';
  NetUpGKey = NetKeyPrefix + 'UpG';
  NetErrDownKey = NetKeyPrefix + 'ErrDown';
  NetErrUpKey = NetKeyPrefix + 'ErrUp';
  NetErrTotKey = NetKeyPrefix + 'ErrTot';
  NetUniDownKey = NetKeyPrefix + 'UniDown';
  NetUniUpKey = NetKeyPrefix + 'UniUp';
  NetUniTotKey = NetKeyPrefix + 'UniTot';
  NetNuniDownKey = NetKeyPrefix + 'NuniDown';
  NetNuniUpKey = NetKeyPrefix + 'NuniUp';
  NetNuniTotKey = NetKeyPrefix + 'NuniTot';
  NetPackTotKey = NetKeyPrefix + 'PackTot';
  NetDiscDownKey = NetKeyPrefix + 'DiscDown';
  NetDiscUpKey = NetKeyPrefix + 'DiscUp';
  NetDiscTotKey = NetKeyPrefix + 'DiscTot';
  NetSpDownKKey = NetKeyPrefix + 'SpDownK';
  NetSpUpKKey = NetKeyPrefix + 'SpUpK';
  NetSpDownMKey = NetKeyPrefix + 'SpDownM';
  NetSpUpMKey = NetKeyPrefix + 'SpUpM';

  NetworkUserHints : array[TNetworkStatistics] of string = (
    'IP address',
    'Adapter name (adapterNr)',
    'Total Down (adapterNr)  (KB)',
    'Total up (adapterNr)  (KB)',
    'Total Down (adapterNr)  (MB)',
    'Total up (adapterNr)  (MB)',
    'Total Down (adapterNr)  (GB)',
    'Total up (adapterNr)  (GB)',
    'Errors down (adapterNr)',
    'Errors up (adapterNr)',
    'Total Errors (adapterNr)',
    'Unicast Packets down (adapterNr)',
    'Unicast Packets up (adapterNr)',
    'Total Uni. Packets (adapterNr)',
    'Non-Uni. Packets down (adapterNr)',
    'Non-Uni. Packets up (adapterNr)',
    'Total Non-Uni. Packets (adapterNr)',
    'Total nr of Packets (adapterNr)',
    'Discards down (adapterNr)',
    'Discards up (adapterNr)',
    'Total Discards (adapterNr)',
    'Speed Down (adapterNr)  (KB)',
    'Speed Up (adapterNr)  (KB)',
    'Speed Down (adapterNr)  (MB)',
    'Speed Up (adapterNr)  (MB)');

  NetworkStatisticsKeys : array[TNetworkStatistics] of string =
    (NetIPAddressKey, NetAdapterKey, NetDownKKey, NetUpKKey, NetDownMKey, NetUpMKey,
     NetDownGKey, NetUpGKey, NetErrDownKey, NetErrUpKey, NetErrTotKey, NetUniDownKey,
     NetUniUpKey, NetUniTotKey, NetNuniDownKey, NetNuniUpKey, NetNuniTotKey,
     NetPackTotKey, NetDiscDownKey, NetDiscUpKey, NetDiscTotKey, NetSpDownKKey,
     NetSpUpKKey, NetSpDownMKey, NetSpUpMKey);

  FirstNetworkStat = nsNetIPAddress;
  LastNetworkStat = nsNetSpUpM;

const
  MAXNETSTATS = 10;

implementation

end.
