  #initialize IO
  sw x0, 4(x0)
  sw x0, 8(x0)
  addi x2, x0, 4
  addi x4, x0, 1

welcome:
  addi x3, x0, 0x48 #H
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  
  addi x3, x0, 0x49 #I
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  
  addi x3, x0, 0x21 #!
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  
  addi x3, x0, 0x21 #!
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  
  addi x3, x0, 0x21 #!
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  
polling_loop:
  lw x1, 12(x0) #if is_recv()
  andi x1, x1, 4
  bne x1, x2, polling_loop

wait_loop:
  lw x1, 12(x0) #if is_not_recv()
  andi x1, x1, 4
  beq x1, x2, wait_loop
  
  lw x3, 0(x0) #grab_rx
  #do stuff
  sw x3, 4(x0) #mov rx to tx
  sw x4, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  j polling_loop


