  sw x0, 4(x0)   #initialize IO
  sw x0, 8(x0)
  addi s1, x0, 4 #Bitmask
  addi t1, x0, 1
  
polling_loop:
  lw t2, 12(x0) #if is_recv()
  andi t2, t2, 4
  bne t2, s1, polling_loop

wait_loop:
  lw t2, 12(x0) #if is_not_recv()
  andi t2, t2, 4
  beq t2, s1, wait_loop
  
  lb t0, 0(x0) #grab_rx   
  sw t0, 4(x0) #mov rx to tx
  sw t1, 8(x0) #transmit high
  sw x0, 8(x0) #transmit low
  j polling_loop
