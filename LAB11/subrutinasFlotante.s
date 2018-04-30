/*subrutinas flotante*/
.global sumatoria
sumatoria:
	VLDR S0,[R0]
	VLDR S1,[R1]
	VADD.F32 S0,S0,S1
	VSTR S0,[R2]
	MOV R0,R2
	MOV PC,LR
