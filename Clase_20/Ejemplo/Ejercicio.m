
%

data = readtable("Datos_1200_V2.xls");

Y = table2array(data( : , 2:4));

Zt = table2array(data( : , 6:7 ));

M_GARCH_M_V1(Y,Zt)

