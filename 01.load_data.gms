Sets
  t 'Years';
Parameters
  y(t) 
  x1(t)
  x2(t)
  ;
$callTool win32.msappavail Excel
$if errorlevel 1 $abort.noError "No Excel available"

$onEcho > Taskin.txt
dSet=Time       rng=sets!A2:A16  rDim=1
par =Outcome    rng=para!A2:B17  rDim=1
par =Variable01 rng=para!D2:E17  rDim=1
par =Variable02 rng=para!G2:H17  rDim=1
par =Year       rng=para!J2:K17  rDim=1
$offEcho

$call gdxxrw.exe "./data/test_data.xlsx" o="./gdx/test_data_import.gdx" @Taskin.txt trace=3 log=import_error_log.txt

* load data from gdx
$gdxIn "./gdx/test_data_import.gdx"
$load t=Time y=Outcome x1=Variable01 x2=Variable02
$gdxIn
display t,y,x1,x2;