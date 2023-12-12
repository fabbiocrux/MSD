TITLE
"Essai de Traction"
SELECT
errlim=4e-5											{Précision de l'erreur limite}
 ! painted

VARIABLES											{Inconnues du problème}
u				
v

DEFINITIONS

! Geometrie
larg=0.03	 {Dimensions de l’éprouvette : largeur}
Long=0.3	 {Dimensions de l’éprouvette : longueur}
s=larg*larg   {Surface de l’éprouvette}
separation=2*larg {Surface de l’éprouvette}


! Matériaux
E=69e9		{Caractéristique du matériau : Module de Young}
nu=0.33		{Caractéristique du matériau : Coefficient de Poisson}
rho=2700   {Caractéristique du matériau : Densité}
g=9.81     {Gravité}


! Contraintes
sigma0=10e6		{Valeur de la contrainte imposée}
sigma2=(3/2)*sigma0 {Valeur de la contrainte imposée }

! Coeficients de Lamé
lamb= nu*E/(1+nu)/(1-2*nu)  
mu=E/2/(1+nu)				

! Matrice de Déformation
exx=dx(u)					{Deformation normale XX}
eyy=dy(v)					{Deformation normale selon YY}
ezz= -lamb/(lamb + 2*mu)*(exx + eyy)  {Deformation normale selon ZZ}
exy=0.5*(dy(u)+dx(v))		{Deformation tangentielle XY}

! Matrice de Contraintes Seon Loi de Hooke


sxx=(lamb+2*mu)*exx+lamb*(eyy+ezz) {Contrainte normale XX}
sxy=2*mu*exy	{Contrainte tangentielle XY}
syy=(lamb+2*mu)*eyy+lamb*(exx+ezz) 	{Contrainte normale YY}


EQUATIONS
u:dx(sxx)+ dy(sxy)=0		{Equation d'équilibre local pour le déplacement u}
v:dx(sxy)+ dy(syy)=0		{Equation d'équilibre local pour le déplacement v}

BOUNDARIES

! Définition de la géométrie de l'éprouvette 1
! A --> B
region 1 "contrainte_1"	
start(-larg/2,0)
Value(u)=0  {Valur de deplacement en sens U}
Value(v)=0  {Valur de deplacement en sens V}
line to (larg/2,0)

! B --> C
Natural(u)=0  {Valur de contrainte en sens U}
Natural(v)=0  {Valur de contrainte en sens V}
line to (larg/2,-Long)

! C --> D
Natural(u)=0
Natural(v)=-sigma0
line to (-larg/2,-Long)

! D --> A
Natural(u)=0
Natural(v)=0
line to close


! Géométrie de l'éprouvette 2
! A --> B
region 1 "contrainte_2"	
start(-larg/2 + separation,0)
Value(u)=0  {Valur de deplacement en sens U}
Value(v)=0  {Valur de deplacement en sens V}
line to (larg/2+separation,0)

! B --> C
Natural(u)=0  {Valur de contrainte en sens U}
Natural(v)=0  {Valur de contrainte en sens V}
line to (larg/2 + separation,-Long)

! C --> D*
Natural(u)=0
Natural(v)=-sigma2
line to (larg/6+separation,-Long)

! D* --> D**
Natural(u)=0
Natural(v)=0
line to (-larg/6 + separation, -Long)

! D** --> D***
Natural(u)=0
Natural(v)=-sigma2
line to (-larg/2+separation,-Long)

! D*** --> A
Natural(u)=0
Natural(v)=0
line to close



! Géométrie de l'éprouvette 3
{region 3 "contrainte_3"

start(-larg/2-separation,0)
value(u)=0
value(v)=0
line to (larg/2-separation,0)

Natural(u)=0
Natural(v)=0


line to (larg/2-separation,-Long)
Natural(u)=0
Natural(v)=-8*sigma0/3


line to (-larg/6-separation,-Long)
Natural(u)=0
Natural(v)=0


line to (larg/6-separation,-Long)
Natural(u)=0
Natural(v)=-sigma0/3


line to (-larg/2-separation,-Long)
Natural(u)=0
Natural(v)=0
line to close }


PLOTS

! Visualisation de l'éprouvette déformée avec un facteur d'accentuation		
grid(x+1e3*u,y+1e3*v)	

! Vector Graphique
vector(u,v) as "Vecteur deplacement"					

! Contour
contour(u)		
contour(v)
contour(sxx)
contour(syy)

! Elevation
elevation(v) from (0,0) to (0,-Long)	
elevation(sxx) from (0,0) to (0,-Long) 
elevation(syy) from (0,0) to (0,-Long) 
elevation(exx) from (-Larg/2,-Long/2) to (Larg/2,-Long/2) 
elevation(eyy) from (0,0) to (0,-Long) 
elevation(syy) from (-larg/2,0) to (larg/2,0)

END