* -------------------------------------------------------
* Tecnológico de Costa Rica

* Escuela de Ingeniería en Electrónica

* Introducción al Diseño de Circuitos Integrados
* Profesor: Alfonso Chacon Quesada

* Tarea 2. Punto 3.
* Verificación de funcionalidad y tiempos de propagación
* para la solución por varias etapas de compuertas simples.

* Realizado por: Alexander Castro Lara, 2017153854
* correo: alexander@estudiantec.cr

* I Semestre, 2024
* -------------------------------------------------------



*----------------------------------------------------------------------
* Parameters and models
*----------------------------------------------------------------------
.param SUPPLY=1.8

.temp 70

.option scale=90n
.option post
.option search='/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Castro_Lara_I_2024_vlsi/tarea2/Hspice/lpmos'

.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Hspice/lp5mos/xt018.lib' tm
.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Hspice/lp5mos/param.lib' 3s
.lib '/mnt/vol_NFS_rh003/Est_VLSI_I_2024/Hspice/lp5mos/config.lib' default
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* Circuito
*----------------------------------------------------------------------
.param nnor=6 //Ancho de los transistores NMOS de la NOR2
.param pnor=24   //Ancho de los transistores PMOS de la NOR2
.param nnot2=14 //Ancho de los transistores NMOS del NOT2
.param pnot2=29   //Ancho de los transistores PMOS del NOT2
.param nnand=55 //Ancho de los transistores NMOS de la NAND2
.param pnand=55   //Ancho de los transistores PMOS de la NAND2
.param nnot1=68 //Ancho de los transistores NMOS del NOT1
.param pnot1=135   //Ancho de los transistores PMOS del NOT1


***__NOR__***

xm1 n1 A 0 0 ne w=nnor l=2 //Entrada n de A
+ as='nnor*5' ad='nnor*5' ps='2*nnor+10' pd='2*nnor+10'
xm2 n1 B 0 0 ne w=nnor l=2 //Entrada n de B
+ as='nnor*5' ad='nnor*5' ps='2*nnor+10' pd='2*nnor+10'
xm3 n2 A vdd vdd pe w=pnor l=2 //Entrada p de A
+ as='pnor*5' ad='pnor*5' ps='2*pnor+10' pd='2*pnor+10'
xm4 n1 B n2 vdd pe w=pnor l=2 //Entrada p de B
+ as='pnor*5' ad='pnor*5' ps='2*pnor+10' pd='2*pnor+10'

xm5 n3 C 0 0 ne w=nnor l=2 //Entrada n de C
+ as='nnor*5' ad='nnor*5' ps='2*nnor+10' pd='2*nnor+10'
xm6 n3 D 0 0 ne w=nnor l=2 //Entrada n de D
+ as='nnor*5' ad='nnor*5' ps='2*nnor+10' pd='2*nnor+10'
xm7 n4 C vdd vdd pe w=pnor l=2 //Entrada p de C
+ as='pnor*5' ad='pnor*5' ps='2*pnor+10' pd='2*pnor+10'
xm8 n3 D n4 vdd pe w=pnor l=2 //Entrada p de D
+ as='pnor*5' ad='pnor*5' ps='2*pnor+10' pd='2*pnor+10'


***__NOT2__***

xm9 n5 n1 0 0 ne w=nnot2 l=2 //Pull-down
+ as='nnot2*5' ad='nnot2*5' ps='2*nnot2+10' pd='2*nnot2+10'
xm10 n5 n1 vdd vdd pe w=pnot2 l=2 //Pull-up
+ as='pnot2*5' ad='pnot2*5' ps='2*pnot2+10' pd='2*pnot2+10'

xm11 n6 n3 0 0 ne w=nnot2 l=2 //Pull-down
+ as='nnot2*5' ad='nnot2*5' ps='2*nnot2+10' pd='2*nnot2+10'
xm12 n6 n3 vdd vdd pe w=pnot2 l=2 //Pull-up
+ as='pnot2*5' ad='pnot2*5' ps='2*pnot2+10' pd='2*pnot2+10'


***__NAND__***

xm13 n8 n5 n7 0 ne w=nnand l=2 //Pull-down
+ as='nnand*5' ad='nnand*5' ps='2*nnand+10' pd='2*nnand+10'
xm14 n7 n6 0 0 ne w=nnand l=2
+ as='nnand*5' ad='nnand*5' ps='2*nnand+10' pd='2*nnand+10'
xm15 n8 n5 vdd vdd pe w=pnand l=2 //Pull-up
+ as='pnand*5' ad='pnand*5' ps='2*pnand+10' pd='2*pnand+10'
xm16 n8 n6 vdd vdd pe w=pnand l=2
+ as='pnand*5' ad='pnand*5' ps='2*pnand+10' pd='2*pnand+10'


***__NOT1__***

xm17 F n8 0 0 ne w=nnot1 l=2 //Pull-down
+ as='nnot1*5' ad='nnot1*5' ps='2*nnot1+10' pd='2*nnot1+10'
xm18 F n8 vdd vdd pe w=pnot1 l=2 //Pull-up
+ as='pnot1*5' ad='pnot1*5' ps='2*pnot1+10' pd='2*pnot1+10'


***__Capacitancia de Carga__***
C1 F 0 125f
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* Stimulus
*----------------------------------------------------------------------
***__Alimentación_***
Vdd vdd 0 'SUPPLY'


***__Entradas binarias A, B, C y D_***

* DESCOMENTAR ESTA SECCION PARA PRUEBA DE FUNCIOANLIDAD
*VA A 0 PULSE(0 'SUPPLY' 500p 50p 50p 400p 1000p)
*VB B 0 PULSE(0 'SUPPLY' 1000p 50p 50p 900p 2000p)
*VC C 0 PULSE(0 'SUPPLY' 2000p 50p 50p 1900p 4000p)
*VD D 0 PULSE(0 'SUPPLY' 4000p 50p 50p 3900p 8000p)

* DESCOMENTAR ESTA SECCION PARA OBTENER TPD
VA A 0 'SUPPLY'
VB B 0 PULSE('SUPPLY' 0 2500p 50p 50p 2900p 6000p)
VC C 0 PULSE(0 'SUPPLY' 2500p 50p 50p 2900p 6000p)
VD D 0 0
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* Stimulus
*----------------------------------------------------------------------
.tran 500ps 8000ps

.measure tpdr * rising prop delay
+ TRIG v(B) VAL='SUPPLY/2' FALL=1
+ TARG v(F) VAL='SUPPLY/2' RISE=1

.measure tpdf * falling prop delay
+ TRIG v(B) VAL='SUPPLY/2' RISE=1
+ TARG v(F) VAL='SUPPLY/2' FALL=1

.measure tpd param='(tpdr+tpdf)/2' * average prop delay
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* End program
*----------------------------------------------------------------------
.end
*----------------------------------------------------------------------
