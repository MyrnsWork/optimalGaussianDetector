# Radar : détection optimale dans du bruit gaussien

Projet personnel n° 1 :

Afin d'introduire à la notion de détection optimale selon le critère de Neyman-Pearson, nous nous sommes tout d'abord intéressé à la détection dans du bruit gaussien. Une hypothèse forte du projet est la connaissance parfaite de la matrice de covariance du bruit gaussien. Dans la plupart des cas pratiques, il est nécéssaire d'estimer cette matrice. Ainsi, 4 approches sont étudiées dans ce projet :
  
  1. la cible est parfaitement connue et est déterministe ;
    
  2. la cible est connue et est du type Swerling 1 : l'amplitude complexe de la cible suit une loi normale complexe ou une loi normale multivariée de dimension 2 ;
    
  3. la cible est du type Swerling 0 (ou 5) : le module de l'amplitude complexe est déterministe en revanche sa phase suit une loi uniforme ;
    
  4. la cible est déterministe mais inconnue. Il est nécessaire d'estimer son amplitude complexe : on utilise un estimateur non-biaisé et consistant. 


À noter que le stering vector est parfaitement connu et est déterministe dans cette étude.

On se rend compte que les détecteurs optimaux pour les cas 2, 3 et 4 sont identiques.

*Pour plus de renseignements, l'ensemble de la théorie abordée est disponible sur le site personnel de Maria S. Greco ([lien1](http://www.iet.unipi.it/m.greco/esami_lab/Radar/Gauss_det.pdf) et [lien2](http://www.iet.unipi.it/m.greco/esami_lab/Radar/Detection_in_Gaussian_clutter.pdf)).*
