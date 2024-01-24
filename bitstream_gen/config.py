# the shape of the PAL has to be specified here

# shape of the PAL device
INPUT_NUM = 4 # N
INTERMED_SIG_NUM = 3 # P
OUTPUT_NUM = 3 # M

# desired logic function 
# (see shape for max possible in/interm/out ports)
# 
# IMPORTANT
#length of list has to be precisely M!
# each equation cannot use more than N variables!
OUTPUT_EQUATIONS=["I1 and I2 and I3 and I4", "I1", "I3"]