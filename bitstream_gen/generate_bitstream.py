# for pyeda see:
# https://pyeda.readthedocs.io/en/latest/boolalg.html
# https://stackoverflow.com/questions/27312328/disjunctive-normal-form-in-python

from pyeda.inter import *

# shape of the PAL device
INPUT_NUM = 4 # N
INTERMED_SIG_NUM = 3 # P
OUTPUT_NUM = 3 # M

#---
# Variables

# Inputs
I0 = exprvar('I0')
I1 = exprvar('I1')
I2 = exprvar('I2')
I3 = exprvar('I3')

Inputs = [I0, I1, I2, I3]
# Outputs
#O0 = exprvar('O0')
#O1 = exprvar('O1')
#O2 = exprvar('O2')

#---

#---
# Equations (one for each output)
# You can use these operators (probably even more -> check the website of PyEDA):
# ~: NOT
# |: OR
# ^: XOR
# &: AND 

# For now: There should only be one equation
O0 = I0 ^ I1 & I2 & I3 
#O1 = I0 & I1 ^ I2 & I3
#O2 = I0 ^ I1 & I2 & I3

Equations = [O0] #, O1, O2]
#---

# Display Truth table
# just for fun :)
a = expr2truthtable(O0)
print(a)

print("Converting equations to DNF for PAL mapping")
Eq_DNF = []
for eq in Equations:
    print(eq.to_dnf())
    Eq_DNF.append(eq.to_dnf())
    #print(type(str(eq.to_dnf())))

# Limitations:
# You can only have as many ORs as there are outputs
# You can only have as many ANDs as you have inputs
# PER TERM IN DNF

# Term reuse is possible if multiple equations are desired
    
# Algo:
# Start with first equation (maybe naive... even simpler: for now only have only equation)
# Look at first TERM -> configure column accordingly
# Look at second TERM -> configure column accordingly
# ...

# convert DNF to string
Eq_DNF_str = str(eq.to_dnf())

# march through string - char by char!
# If you encounter an "AND("-substring take everything until the closing parenthasis
# -> this is one term
# Set the current column accordingly
print(Eq_DNF_str)
pattern_and = "And("
pattern_cl_brckt_ = ")"
and_indices = [i for i in range(len(Eq_DNF_str)) if Eq_DNF_str.startswith(pattern_and, i)]
cl_brckt_indices = [i for i in range(len(Eq_DNF_str)) if Eq_DNF_str.startswith(pattern_cl_brckt_, i)]

print(and_indices)
print(cl_brckt_indices)

terms = []
for i, a_idx in enumerate(and_indices):
    terms.append(Eq_DNF_str[and_indices[i]+len(pattern_and):cl_brckt_indices[i]])

# Terms: Here we only have the operands that are 'and'ed together
print(terms)

# Now go through each terms operands and set the bitstream accordingly!
bitstream =  "x" * (2*INPUT_NUM*INTERMED_SIG_NUM + INTERMED_SIG_NUM*OUTPUT_NUM)
print(f"Length of bitstream: {len(bitstream)}")

for term in terms:
    # split string at commas!
    # and remove trailing spaces
    operands = term.split(', ')
    print(operands)

    # check if there are more operands than there are inputs?
    # this check should probably be done earlier... :D

    # check if there is a '~' -> this means we need to take the inverted version of the input

    # read the operand (naming convention expects this naming: I0, I1, I2, ...)


# Statically set all bits for the first output
# there is no risk if too many are enabled
# the Verilog code might yield 'X' values for AND gates that are not connected to inputs -> for those we need a pull-down of the inputs!


# Visualize the configuration
# maybe PyGame would be a good fit for that...
# https://pythonprogramming.net/pygame-drawing-shapes-objects/

# draw as many horizontal input wires as we have inputs
# draw as many intermediate stages as we have intermediate stages
# draw as many outputs as we have outputs
# according to the bitstream: Draw a dot over the crossing of two wires