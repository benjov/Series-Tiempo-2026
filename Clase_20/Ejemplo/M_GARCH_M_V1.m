%   Rutina que permite la estimacion del modelo GARCH-M y M-GARCH-M
%   tetravariado basado en Bollerslev (1990) y en el modelo VEC Diagonal.
%   Elaborado por Benjamin Oliva Vazquez
%   Ultima actualizacion: 3 de Mayo de 2010
%   Modelamos tasas de crecimiento mensuales del IP, INPP, TC y PPI
%   el periodo es de 1993:01 a 2009:12
%   Argumentos: Y = Matriz de variables dependientes; nombres = nombres de
%   las variables, y Z = matriz de variables exogenas
% 

function [] = M_GARCH_M_V1(Y,Zt)%, nombres)
%tic;
%clear all;
%clc;
% Cambios porcentuales anualizados d(log(Variable))*1200

% Numero de rezagos empleados Criterio de Schwarz (Criterio de Akaike)
L = 3;%(SC: 3; AK: 7)
T = size(Y,1); %[T,N] = size(Y);

% Matrices rezagadas 1:L
Yt = Y((L+1):T,:);
%Zt = Zt((L+1):T,:);
Zt = Zt(L:(T-1),:);
Yt_1 = Y(L:(T-1),:);
Yt_2 = Y((L-1):(T-2),:);
Yt_3 = Y((L-2):(T-3),:);

%***********************************************************************
%   Yt = B0 + B1*Yt-1 + B1*Yt-2 + B1*Yt-3 + Theta*Sig2t + Omega*EXt
%   Sig2t = Alpha0 + Alpha1*U2t-1 + Alpha2*Sig2t-1 + Etha*Yt-1
%   COVt = Rhoij*Sigit*Sigjt (Borllevslev, 1990)
%       Valores iniciales empleados:
%   Se estimo individualmente cada una de las ecuaciones como GARCH(1,1)
%   y se tomaron como valores iniciales los parametros estimados.
%   Para la matriz de correlaciones se emplearon los residuales de las
%   estimaciones.
%***********************************************************************

B1 = [-4.59; -4.00; 1.32]; %Constantes de la media condicional
B11 = [-0.10; -0.24; -0.03;...       
       -0.01; 0.02; -0.06;...
       -0.06; 0.12; -0.02]; %Betas de las variable rezagada 1
B12 = [0.00; 0.29; 0.05;...       
       0.02; -0.12; -0.03;...
       0.00; 0.14; 0.01]; %Betas de las variable rezagada 2
B13 = [-0.22; 0.01; 0.12;...       
       -0.04; 0.31; -0.16;...
       0.01; -0.33; 0.03]; %Betas de las variable rezagada 3
Theta = [0.62; -0.5; -0.5;...%+,-,-,
         0.5; 1.19; 0;... %+;+;
         0; 0; 0.17];
Alpha = [111.68; 24.60; 639.08;...
         0.39; 0.71; 0.35;...
         0.05; 0.21; 0.12;
         0.13; 3.40; 24.56]; %Alphas en ecuaciones de las varianzas
Corr = [0.13; -0.04;...
        0.56]; %Parte triangular superior de la matriz de correlaciones
Psi = [0.46; 0.17; 0.21; 0.01; -0.00; -0.03];
B0 = [B1; B11; B12; B13; Theta; Alpha; Corr; Psi];
%***********************************************************************

L =@(B) llk_M_Garch_M_V1(B,Yt,Yt_1,Yt_2,Yt_3,Zt); 
    options = optimset('MaxFunEvals',1000*size(B0,1),'MaxIter',...
    1000*size(B0,1),'TolFun',1e-10,'TolX',1e-10,'LargeScale','Off',...
    'Display','Off');

[BetaGARCH llk xx yy grad hessian] = fminunc(L, B0, options);

VarGARCH = inv(hessian);              %   Matriz de Varianzas y Covarianzas
seGARCH = sqrt((diag(VarGARCH)));         %   Vector de Desviaciones Estandar

B = [BetaGARCH seGARCH BetaGARCH./seGARCH 2*(1-normcdf(abs(BetaGARCH./seGARCH)))];
l = -llk;
e = eig(hessian);
%min_eig = min(eig(hessian))
 
% %se=sqrt(diag(pinv(hessian)));
SalGARCH = -llk;
SalGARCH = num2str(SalGARCH, '%15.5f');

%Ponemos nombresitos provisionales
k =size(BetaGARCH,1);
nombres = ["B01"; "B02"; "B03";...
           "B11"; "B12"; "B13";...       
           "B21"; "B22"; "B23";...
           "B31"; "B32"; "B33";...
           "C11"; "C12"; "C13";...       
           "C21"; "C22"; "C23";...
           "C31"; "C32"; "C33";...
           "D11"; "D12"; "D13";...       
           "D21"; "D22"; "D23";...
           "D31"; "D32"; "D33";...
           "T11"; "T12"; "T13";...       
           "T21"; "T22"; "T23";...
           "T31"; "T32"; "T33";...
           "A01"; "A02"; "A03";...
           "A11"; "A12"; "A13";...       
           "A21"; "A22"; "A23";...
           "A31"; "A32"; "A33";...
           "Corr1"; "Corr2"; "Corr3";...
           "Psi1"; "Psi2"; "Psi3";...
           "Psi4"; "Psi5"; "Psi6"];
nombresGARCH = char(nombres);
 
SalidaGARCH = [BetaGARCH seGARCH BetaGARCH./seGARCH ...
    2*(1-normcdf(abs(BetaGARCH./seGARCH)))];
                                     %   Matriz de resultados
SalidaGARCH = num2str(SalidaGARCH, '%15.5f %15.5f %15.5f %15.5f');
                                     %   Convierte la matriz de resultados en caracteres 
fprintf(' \n');
fprintf('  **    M�XIMA VEROSIMILITUD MODELO GARCHM MULTIVARIADO**\n\n');
fprintf('      Variable         Coefficient      Std. Error         Z-Stat.           Prob.\n');
fprintf('_______________________________________________________________________________________\n');
display([repmat(blanks(k)',1,5) nombresGARCH repmat(blanks(k)',1,8) SalidaGARCH]);      
%   Muestra el vector de nombres, espacios en blanco y los resultados de la estimacion
fprintf('_______________________________________________________________________________________\n');
fprintf('         Log likelihood');
display([(blanks(5)) SalGARCH]);      
fprintf('_______________________________________________________________________________________\n');
fprintf('\n');

% save('C:\Users\Benjamin\Desktop\Tesina_CIDE\MATLAB_GARCH\GARCH_M.out',...
%     'llk','BetaGARCH','seGARCH','-ASCII');
toc;