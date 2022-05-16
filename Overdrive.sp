*Name: MohammadAli Daneshsefatdost
*____________________________________library @ [90nm CMOS]____________________________________________

.lib './TSMC_90nm.l' tt
*_______________________________Operating Temperature @ [25.C]________________________________________
.temp 25
*__________________sources @[(Vdd=1V) , (Vss=0V) ____________________________________________________
VDD	dd	0	dc=1
VSS	ss	0	dc=0
*__________________________________Sinusoidal input source___________________________________________

Vin+	vin+	0	PWL	0	1	20n	1	25n	1

Vin-	vin-	0	PWL	0	0	2n	0	2.001n	1.001	6n	1.001
+6.001n	0	10n	0	10.01n	0.999	13.5n	0.999	13.501n	1.001	16.5n	1.001
+16.501n	0	20n	0	20.001n	1.001	22.5n	1.001	22.501n	0	23n
+0	r

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
.tran	0.00001n	100n
.probe	v(vin+,vin-)	v(out+,out-)	v(p,q)
.print	v(vin+,vin-)	v(out+,out-)	v(p,q)
.option accurate=1
.option ingold=2
.option	post 
.probe
.end
