 
  lui sp, 0x1000 # Initialize sp

  sw x0, 4(x0)   #initialize IO
  sw x0, 8(x0)
  addi s1, x0, 4 #Bitmask
  addi t1, x0, 1

  sw x0, 0x100(x0) #Init input buffer pointer

welcome:
  
  call clear_screen

  addi a0, x0, ' '
  call put_char
  
  addi a0, x0, 'S'
  call put_char
  
  addi a0, x0, 'p'
  call put_char
  
  addi a0, x0, 'u'
  call put_char
  
  addi a0, x0, 'r'
  call put_char
  
  addi a0, x0, ' ' 
  call put_char

  addi a0, x0, 'v'
  call put_char

  addi a0, x0, '0'
  call put_char

  addi a0, x0, '.'
  call put_char

  addi a0, x0, '0'
  call put_char

  addi a0, x0, '.'
  call put_char  

  addi a0, x0, '1'
  call put_char

  addi a0, x0, 0x0D #carriage return
  call put_char

  addi a0, x0, 0x0A #line feed
  call put_char

  addi a0, x0, 0x0A #another one
  call put_char

  addi a0, x0, ' '
  call put_char

  addi a0, x0, '>'
  call put_char

  addi a0, x0, ' '
  call put_char
   

  
polling_loop:
  lw t2, 12(x0) #if is_recv()
  andi t2, t2, 4
  bne t2, s1, polling_loop

wait_loop:
  lw t2, 12(x0) #if is_not_recv()
  andi t2, t2, 4
  beq t2, s1, wait_loop
  
  lw t0, 0(x0) #grab_rx
  lw s2, 0x100(x0) #Grab input buffer pointer

  addi t3, x0 0x0D
  beq t0, t3, parse_command  

  sw t0, 0(s2)     #save input
  addi s2, x0, 4   #increment pointer
  sw s2, 0x100(x0) #store pointer
  
      
 
  sw t0, 4(x0) #mov rx to tx
  sw t1, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  j polling_loop

parse_command:
  addi a0, x0, 0x0A #line feed
  call put_char

  #Testing purposes 
 addi a0, x0, 'T'
 call put_char


put_char: #Assumes printing char is in a0
  sw a0, 4(x0)
  ori t0, x0, 1
  sw t0, 8(x0)
  sw x0, 8(x0)
  ret 

clear_screen:
  addi a0, x0, 0x1B #Escape
  call put_char 
 
  addi a0, x0, 'c' #Reset terminal DOES HAVE SIDE EFFECTS FIX LATER
  call put_char
  ret



