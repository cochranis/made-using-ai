section .data
    clicks db 0        ; Total clicks
    clickValue db 1    ; Value per click
    upgradeCost db 10  ; Cost to upgrade click value

section .text
    global _start

_start:
    ; Display initial status
    call displayStatus

gameLoop:
    ; Display menu
    call displayMenu

    ; Read user input
    call readInput

    ; Process user choice
    cmp al, '1'
    je click
    cmp al, '2'
    je upgradeClickValue
    cmp al, '3'
    je quit
    jmp gameLoop

click:
    ; Increment clicks
    inc byte [clicks]
    call displayStatus
    jmp gameLoop

upgradeClickValue:
    ; Check if there are enough clicks to upgrade
    mov al, [clicks]
    cmp al, [upgradeCost]
    jl notEnoughClicks

    ; Upgrade click value
    inc byte [clickValue]
    sub byte [clicks], [upgradeCost]
    call displayStatus
    jmp gameLoop

notEnoughClicks:
    ; Display message
    mov edx, notEnoughMsg
    call displayMsg
    jmp gameLoop

quit:
    ; Exit program
    mov eax, 60         ; syscall number for exit
    xor edi, edi        ; exit code 0
    syscall

displayStatus:
    ; Display total clicks and click value
    mov eax, 4          ; syscall number for sys_write
    mov edi, 1          ; file descriptor 1 (stdout)
    mov rsi, statusMsg  ; message to print
    mov edx, statusLen  ; message length
    syscall
    ret

displayMenu:
    ; Display menu options
    mov eax, 4          ; syscall number for sys_write
    mov edi, 1          ; file descriptor 1 (stdout)
    mov rsi, menuMsg    ; message to print
    mov edx, menuLen    ; message length
    syscall
    ret

displayMsg:
    ; Display a message
    mov eax, 4          ; syscall number for sys_write
    mov edi, 1          ; file descriptor 1 (stdout)
    mov edx, 30         ; message length
    syscall
    ret

readInput:
    ; Read user input
    mov eax, 0          ; syscall number for sys_read
    mov edi, 0          ; file descriptor 0 (stdin)
    mov rsi, choice     ; buffer to store input
    mov edx, 1          ; buffer size
    syscall
    ret

section .data
    menuMsg db "1. Click", 10, "2. Upgrade Click Value", 10, "3. Quit", 10, "Choose an option: ", 0
    menuLen equ $ - menuMsg
    statusMsg db "Total Clicks: ", 0
    statusLen equ $ - statusMsg
    notEnoughMsg db "Not enough clicks to upgrade click value!", 10, 0
    choice db 0

section .bss
    upgradeCost resb 1
