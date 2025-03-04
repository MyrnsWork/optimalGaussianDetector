% Maël Laviec
% mlaviec@enseirb-matmeca.fr
% ENSEIRB-MATMECA
% Juin, 2022


%% Initialisation
clc; 
close all;
clear;
dbstop if error;


%% Chargement des données et des fonctions
addpath(genpath( "./functions" ));


%% Options du script
displayFigures   = true;                                                   % affichage des figures, 1x1
isCovarianceKown = false;                                                  % connaissance de la matrice de covariance du bruit thermique, 1x1


%% Hyperparamètres
kB  = 1.38e-23;                                                            % constante de Boltzmann, 1x1 [m2 kg s-2 K-1]
c   = 3e8;                                                                 % célérité de la lumière, 1x1 [m/s]
Pfa = 1e-4;                                                                % probabilité de fausse alarme, 1x1


%% Paramètres
% géométrie des cartes
Nrec  = 128;                                                               % nombre de récurrences, 1x1
Ncd   = 150;                                                               % nombre de cases distance, 1x1
Ncell = Nrec * Ncd;                                                        % nombre de cellules, 1x1

% radar
fe     = 10e9;                                                             % fréquence de la porteuse, 1x1 [Hz]
lambda = c/fe;                                                             % longueur d'onde de la porteuse, 1x1 [m]
Bp     = 200e6;                                                            % bande passante, 1x1 [m]
Li     = 1/Bp;                                                             % longueur d'impulsion, 1x1 [s]  
PRF    = 2000;                                                             % fréquence de récurrence, 1x1 [Hz]

% caractérisation du bruit thermique
T_degCel = 20;                                                             % température en degrés Celsus, 1x1 [°C]
T_K      = 273.15 + T_degCel;                                              % température en degrés Kelvin, 1x1 [°K]
F_dB     = 6;                                                              % facteur de bruit de l'électronique analogique, 1x1
F_lin    = 10^( F_dB/10 );                                                 
Pbth_lin = kB * T_K * Bp * F_lin;                                          % puissance du bruit thermique, 1x1 [W]                                                                                                   
Pbth_dB  = 10*log10( Pbth_lin );                                           
R        = Pbth_lin * eye(Nrec);                                           % matrice de covariance du bruit thermique, Nrec x Nrec

% caractéristiques de la cible
SNR_dB          = 15;                                                       % rapport signal sur bruit, 1x1                                                                          
SNR_lin         = 10^( SNR_dB/10 );
typeTarget      = "swerling1";                                             % type de fluctuations de la cible, 1x1   
speedTarget     = 5;                                                       % vitesse radiale de la cible, 1x1 [m/s]   
targetFrequency = 2 * speedTarget / lambda;                                % fréquence Doppler de la cible, 1x1 [Hz]   



%% Imagette de bruit blanc complexe (channels I et Q)
[ imagetteChannelIQ_lin,...
  imagetteAmplitude_lin,...
  imagettePuissance_lin    ] = createImagette( Pbth_lin,...
                                               Ncd,...
                                               Nrec        );
    


%% Création de la cible 
[ targetIQ,...
  targetAmplitude,...
  steringVector      ] = createTarget( SNR_lin,...
                                       Pbth_lin,...
                                       targetFrequency,...
                                       PRF,...
                                       typeTarget,...
                                       Nrec               );



%% Ajout de la cible
[ imagetteChannelIQWithTarget_lin,...
  imagetteAmplitudeWithTarget_lin,...
  imagettePuissanceWithTarget_lin,...
  rangeIndex                         ] = addTarget( imagetteChannelIQ_lin,...
                                                    targetIQ,...
                                                    1                        );



%% Calcul de la matrice de covariance
scmR = calcCovarianceMatrix( imagetteChannelIQ_lin,...
                             R,...
                             isCovarianceKown,...
                             2                        );



%% Détecteur optimal
[ logLRT_lin,...
  detectionMap,...
  gammaLogLRT_dB  ] = optimalDetector( imagetteChannelIQWithTarget_lin,...
                                       scmR,...
                                       Pfa,...
                                       targetIQ,...
                                       steringVector,...
                                       typeTarget,...
                                       1                                  ) ;    



%% Figures
if displayFigures
    fig1 = displayImagettes( imagettePuissance_lin,...
                             imagettePuissanceWithTarget_lin,...
                             detectionMap,...
                             rangeIndex,...
                             Nrec,...
                             1                                  );     
    
    
    fig2 = displayHistogram( imagetteAmplitude_lin,...
                             imagettePuissance_lin,...
                             Pbth_lin,...
                             2                        );
                         
    
    
    fig3 = displayLogLRT( logLRT_lin,...
                          gammaLogLRT_dB,...
                          Ncd,...
                          3                 );                 

end
                      




