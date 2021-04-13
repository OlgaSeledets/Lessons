; c0d3d by EdelWeiSS7277
; DAY: 18.02
; CMP: MASM 6.12+
; SKP: troll16lol
.686p
		.mmx
		.model flat, stdcall
		option casemap: none
		
		;эту директиву тебе не положено видеть ; все метки глобальные
		
		ASSUME FS:NOTHING
		
		include \masm32\include\windows.inc
		include \masm32\include\user32.inc
		include \masm32\include\kernel32.inc
		include \masm32\include\gdi32.inc
		include \masm32\include\msvcrt.inc
		
		includelib \masm32\lib\kernel32.lib
		includelib \masm32\lib\user32.lib
		includelib \masm32\lib\advapi32.lib
		includelib \masm32\lib\gdi32.lib
		includelib \masm32\lib\wsock32.lib
		includelib \masm32\lib\msvcrt.lib

      szText MACRO Name, Text:VARARG
        LOCAL lbl
          jmp lbl
            Name db Text,0
          lbl:
        ENDM
		
.data
R dd 50
dva dd 2 ; никто ей не пользуется, можешь забрать

.data?
Desktop dd ?
Canvas dd ?
Razmer RECT<?,?,?,?>
pt POINT<?,?>
X dd ?
Y dd ?
X1 dd ?
Y1 dd ?
X2 dd ?
Y2 dd ?
temp dd ?

.code

ConMain proc argc     :DWORD,
             argv     :DWORD
			 
			call GetDesktopWindow
			mov Desktop, eax
			invoke GetWindowRect, Desktop, offset Razmer
			invoke GetWindowDC, Desktop
			mov Canvas, eax
			
			mov eax, Razmer.left
			add eax, Razmer.right
			; шифт на 1 бит вправо зануляет половину
			shr eax, 1
			mov X, eax
			mov eax, Razmer.top
			add eax, Razmer.bottom
			shr eax, 1
			mov Y, eax
			
			.while 1
			; добро пожаловать в цикл, первый и единственный рабочий
			; дальше без комментариев
			mov eax, X
			sub eax, R
			mov X1, eax
			mov eax, Y
			sub eax, R
			mov Y1, eax
			mov eax, X
			add eax, R
			mov X2, eax
			mov eax, Y
			add eax, R
			mov Y2, eax
			invoke Ellipse, Canvas, X1, Y1, X2, Y2
			invoke MoveToEx, Canvas, X1, Y, addr pt
			mov eax, Y
			sub eax, 200
			mov temp, eax
			invoke LineTo, Canvas, X1, eax
			invoke LineTo, Canvas, X2, temp
			invoke LineTo, Canvas, X2, Y2
			mov eax, Y
			sub eax, 130
			mov temp, eax
			invoke MoveToEx, Canvas, X2, temp, addr pt
			mov eax, X2
			add eax, 200
			mov edx, R
			add eax, edx
			invoke LineTo, Canvas, eax, temp
			
			mov eax, X
			mov X1, eax
			add X1, 200
			mov eax, R
			add X1, eax
			add X1, eax
			mov eax, X1
			
			mov eax, Y
			mov Y1, eax
			sub Y1, 130
			mov eax, R
			add Y1, eax
			invoke MoveToEx, Canvas, X1, Y1, addr pt
			
			mov eax, X1
			sub eax, R
			mov ebx, Y1
			sub ebx, R
			mov ecx, X1
			add ecx, R
			mov edx, Y1
			add edx, R
			
			invoke Ellipse, Canvas, eax, ebx, ecx, edx
			
			mov eax, X1
			mov ebx, Y1
			add ebx, R
			
			invoke MoveToEx, Canvas, eax, ebx, addr pt
			
			mov eax, X
			add eax, R
			mov ebx, Y1
			add ebx, R
			
			invoke LineTo, Canvas, eax, ebx
			
			mov eax, X
			add eax, R
			add eax, R
			add eax, 200
			mov ebx, Y
			sub ebx, 130
			add ebx, R
			add ebx, R
			
			invoke MoveToEx, Canvas, eax, ebx, addr pt
			
			mov eax, X
			mov ecx, R
			lea eax, [eax+ecx*2]
			add eax, 200
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 100
			invoke LineTo, Canvas, eax, ebx
			
			mov eax, X
			mov ecx, R
			add eax, ecx
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 100
			
			invoke LineTo, Canvas, eax, ebx
			
			mov eax, X
			mov ebx, Y
			mov ecx, R
			
			lea edx, [eax+ecx]
			mov X1, edx
			mov Y1, ebx
			lea edx, [edx+60]			
			mov X2, edx
			lea edx, [ebx+60]
			mov Y2, edx
			invoke Ellipse, Canvas, X1, Y1, X2, Y2
			
			add X1, 60
			add X2, 60
			invoke Ellipse, Canvas, X1, Y1, X2, Y2
			add X1, 60
			add X2, 60
			invoke Ellipse, Canvas, X1, Y1, X2, Y2
			add X1, 60
			add X2, 60
			invoke Ellipse, Canvas, X1, Y1, X2, Y2
			
			add X1, 20
			mov ecx, R
			add X1, ecx
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 130
			invoke MoveToEx, Canvas, X1, ebx, addr pt
			mov ecx, R
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 40
			invoke LineTo, Canvas, X1, ebx
			mov ecx, R
			add X1, ecx
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 40
			invoke LineTo, Canvas, X1, ebx
			mov ecx, R
			sub X1, ecx
			mov ebx, Y
			lea ebx, [ebx+ecx*2]
			sub ebx, 130
			invoke LineTo, Canvas, X1, ebx
			mov ebx, Y
			sub ebx, 130
			invoke MoveToEx, Canvas, X1, ebx, addr pt
			
			mov eax, X
			mov ecx, R
			lea eax, [eax+ecx*2]
			add eax, 200
			mov ebx, Y
			sub ebx, 160
			mov X1, eax
			mov Y1, ebx
			invoke LineTo, Canvas, X1, Y1
			sub X1, 80
			invoke LineTo, Canvas, X1, Y1
			add Y1, 30
			invoke LineTo, Canvas, X1, Y1
			add X1, 80
			invoke LineTo, Canvas, X1, Y1
			sub Y1, 30
			invoke MoveToEx, Canvas, X1, Y1, addr pt
			add X1, 20
			sub Y1, 20
			invoke LineTo, Canvas, X1, Y1
			sub X1, 120
			invoke LineTo, Canvas, X1, Y1
			add X1, 20
			add Y1, 20
			invoke LineTo, Canvas, X1, Y1
			
			.endw
			 
			; вопрос, а нахуя!? цикл не позволит дойти до этого момента
			szText pauseText,"pause", 0
			invoke crt_system, offset pauseText
			
			; и из процесса ты тоже не выйдешь :D
			invoke ExitProcess, 7277
			
			xor eax, eax
			ret

ConMain endp

end ConMain