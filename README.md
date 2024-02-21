# Easy_pal

easy_pal is a simple and naive PAL implementation that can be (re)programmed via a shift-register chain.
The PAL is fully parametric and thus number of inputs (N), number of intermediate stages (P) and the number of outputs (M) can be configured in a flexible way in the verilog sources.

<img src="/Images/example_n4_p4_o3_no_connections.png" alt="drawing" width="600"/>

## Example configuration
To generate a bitstream the python script has to be run.
In the top of the file the logic function and the size of the PAL-device has to be provided.
After displaying the truth table the script generates the following output:

<img src="/Images/example_python_output.png" alt="drawing" width="200"/>

The logic function was given in the following way in the Python code:
"O0 = ~I0 | I1 & ~(I2 & I3) "

Looking at the following waveform we can see that it does indeed work! :)

<img src="/Images/example_waveform.png" alt="drawing" width="400"/>

## Files
There is only a hand-full of important files.
Files used for hardware:
- PAL.v
- crosspoint.v
- reduce.v
- stride.v
- sr.v

There are testbenches for some of the sub-components. If the oss-cad tools are installed these can be run via the scripts in the run-folder.
The testbench.v is the general testbench. Here bitstreams that were generated via the python script "generate_bitstream.py" can be inserted and tested.

## Limitations / Ideas for further expansion
There are plenty of limitations with the current implementation.
### Bitstream generation
The generation of the bitstream currently is very naive.
The python script to generate the bitstream currently does the folloing
1. Take the arbitrary boolean expression and convert it to DNF form
2. Verify that the number of terms that are connected by ORs are <= P (number of intermediate stages)
3. AND Matrix: Generate a bitstream based on that by using one column per set of AND-connected variables.
4. OR Matrix: Set all bits to 1 (only 1 output is supported!)

Ideas for expansions are obvious:
First of all the current bitstream generation is very wasteful. Techniques like reuse of terms could benefit the amount of logic that can be mounted on the device.
Another obvious improvement is the support of multiple outputs.

### Hardware optimizations
A flipflop chain for configuration is simple but also costly in terms of hardware. 
A row/column based frame-based configuration like it is used in FPGAs could benefit the design.

