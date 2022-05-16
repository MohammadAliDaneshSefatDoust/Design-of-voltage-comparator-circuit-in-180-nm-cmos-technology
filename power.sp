*Name: MohammadAli Daneshsefatdost
*____________________________________library @ [90nm CMOS]____________________________________________

.lib './TSMC_90nm.l' tt
*_______________________________Operating Temperature @ [25.C]________________________________________
.temp 25
*__________________sources @[(Vdd=1V) , (Vss=0V) ____________________________________________________
VDD	dd	0	dc=1
VSS	ss	0	dc=0
*__________________________________Sinusoidal input source___________________________________________

vi+	vin+	0	sin(0.5	0.5	80meg	0	0	0)
vi-	vin-	0	sin(0.5	0.5	80meg	0	0	180)

*_______Vph number@pulse=[(V1),(V2),(Td:"delay"),(Tr:"rise"),(Tf:"fall"),(Width),(Period)]___________

Vph+	ph+	0	pulse(0		1	0	0.1n	0.1n	2n	4n)
Vph-	ph-	0	pulse(1		0	0	0.1n	0.1n	2n	4n)
	
*________________ COMP CIRCUIT@[(Drain),(Gate),(source),(balk),(Model_channel),(W),(L),(M)]___________
M1	1	vin+	ss	ss	nch	W=0.556u	L=0.1u	M=2
M2	2	vin-	ss	ss	nch	W=0.556u	L=0.1u	M=2	
M3	1	2	ss	ss	nch	W=0.553u	L=0.1u	M=1
M4	2	1	ss	ss	nch	W=0.553u	L=0.1u	M=1
M5	out-	ph+	1	ss	nch	W=5.3456u	L=0.1u	M=5
M6	out+	ph+	2	ss	nch	W=5.3456u	L=0.1u	M=5
M7	out-	out+	dd	dd	pch	W=6.682u	L=0.1u	M=4
M8	out+	out-	dd	dd	pch	W=6.682u	L=0.1u	M=4
M9	out-	ph+	dd	dd	pch	W=6.682u	L=0.1u	M=8
M10	out+	ph+	dd	dd	pch	W=6.682u	L=0.1u	M=8
M11	2	ph-	1	ss	nch	W=3.2075u	L=0.1u	M=2
*___________________________________SR LACH WITH NAND CIRCUIT________________________________________
MP1	p	out+	dd	dd	pch	W=0.2u		L=0.1u	M=2
MP2	p	q	dd	dd	pch	W=0.2u		L=0.1u	M=2
MN1	n1	out+	ss	ss	nch	W=0.2u		L=0.1u	M=2
MN2	p	q	n1	ss	nch	W=0.2u		L=0.1u	M=2
MP11	q	p	dd	dd	pch	W=0.2u		L=0.1u	M=2
MP22	q	out-	dd	dd	pch	W=0.2u		L=0.1u	M=2
MN11	n2	out-	ss	ss	nch	W=0.2u		L=0.1u	M=2
MN22	q	p	n2	ss	nch	W=0.2u		L=0.1u	M=2

*__________________________________________simulation________________________________________________
.op 	all
.tran	0.0001n	200n
.measure 	tran	ivdd	avg i(vdd)	from=0	to=200n    
.probe
.probe 	v(out+,out-)
.probe 	v(vin+,vin-)
.option accurate=1
.op
.end