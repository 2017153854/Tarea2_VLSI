* -------------------------------------------------------
* Tecnológico de Costa Rica

* Escuela de Ingeniería en Electrónica

* Introducción al Diseño de Circuitos Integrados
* Profesor: Alfonso Chacon Quesada

* Tarea 2. Punto 3.
* Verificación de funcionalidad y tiempos de propagación para
* la solución por compuerta compleja.

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
.param rncc=6 //Ancho de los transistores NMOS de la compuerta compleja
.param rpcc=24   //Ancho de los transistores PMOS de la compuerta compleja
.param rninv=12.91 //Ancho de los transistores NMOS del inversor
.param rpinv=25.82   //Ancho de los transistores PMOS del inversor

***__Compuerta Compleja__***

*Pull-down
xm0 y A n1 0 ne w=rncc l=2 //Entrada n de A
+ as='rncc*5' ad='rncc*5' ps='2*rncc+10' pd='2*rncc+10'
xm1 y B n1 0 ne w=rncc l=2 //Entrada n de B
+ as='rncc*5' ad='rncc*5' ps='2*rncc+10' pd='2*rncc+10'
xm2 n1 C 0 0 ne w=rncc l=2 //Entrada n de C
+ as='rncc*5' ad='rncc*5' ps='2*rncc+10' pd='2*rncc+10'
xm3 n1 D 0 0 ne w=rncc l=2 //Entrada n de D
+ as='rncc*5' ad='rncc*5' ps='2*rncc+10' pd='2*rncc+10'

*Pull-up
xm4 n2 A vdd vdd pe w=rpcc l=2 //Entrada p de A
+ as='rpcc*5' ad='rpcc*5' ps='2*rpcc+10' pd='2*rpcc+10'
xm5 y B n2 vdd pe w=rpcc l=2 //Entrada p de B
+ as='rpcc*5' ad='rpcc*5' ps='2*rpcc+10' pd='2*rpcc+10'
xm6 n3 C vdd vdd pe w=rpcc l=2 //Entrada p de C
+ as='rpcc*5' ad='rpcc*5' ps='2*rpcc+10' pd='2*rpcc+10'
xm7 y D n3 vdd pe w=rpcc l=2 //Entrada p de A
+ as='rpcc*5' ad='rpcc*5' ps='2*rpcc+10' pd='2*rpcc+10'


***__Inversor__***
xm8 F y 0 0 ne w=rninv l=2 //y:salida de la compuerta compleja
+ as='rninv*5' ad='rninv*5' ps='2*rninv+10' pd='2*rninv+10'
xm9 F y vdd vdd pe w=rpinv l=2 //F:salida del inversor
+ as='rpinv*5' ad='rpinv*5' ps='2*rpinv+10' pd='2*rpinv+10'


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

* DESCOMENTAR ESTA SECCION PARA OBTENER TRPD
VA A 0 'SUPPLY'
VB B 0 PULSE('SUPPLY' 0 2500p 50p 50p 2900p 6000p)
VC C 0 PULSE(0 'SUPPLY' 2500p 50p 50p 2900p 6000p)
VD D 0 0
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* Measures
*----------------------------------------------------------------------
.tran 500ps 8000ps

.measure tpdr * rising prop delay
+ TRIG v(B) VAL='SUPPLY/2' FALL=1
+ TARG v(F) VAL='SUPPLY/2' RISE=1

.measure tpdf * falling prop delay
+ TRIG v(B) VAL='SUPPLY/2' RISE=1
+ TARG v(F) VAL='SUPPLY/2' FALL=1

.measure tpd param='(tpdr+tpdf)/2' * average prop delay

*Para la potencia promedio
.measure pwr AVG P(vdd) FROM=0ns TO=10ns
*----------------------------------------------------------------------



*----------------------------------------------------------------------
* End program
*----------------------------------------------------------------------
.end
*----------------------------------------------------------------------
