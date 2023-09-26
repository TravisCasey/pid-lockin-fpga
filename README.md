# PID controller and lock-in amplifier FPGA toolkit
This repository comprises the code, development enviroment, documentation, and interface for a PID controller, a lock-in amplifier, and other supporting modules designed to be deployed on a Red Pitaya STEMlab 125-14 FPGA/microprocessor board. The PID controller and the lock-in amplifier are commonly employed by themselves, but this combination is intended to be employed in tandem in the Pound-Drever-Hall (PDH) technique. This is used for very precisely locking (i.e. holding) a laser frequency at the frequency at which it is most absorbed by a medium. For a full write-up detailing the theory, implementation, testing, and instructions on use, see the [included pdf](Red_Pitaya_Lock.pdf).

My Verilog code can be found in [this folder](fpga/prj/v0.94/project/redpitaya.srcs/sources_1/new). The rest of the repository is the development environment for the Red Pitaya line of boards.

## Features

The current implementation offered can match the level of several dedicated instruments (particularly the PID controller and lock-in amplifier, but also function generators, filters, and more) while only requiring an inexpensive board and this software. The FPGA is programmed by the Hardware Definition Language (HDL) Verilog, and can be edited using the provided development environment; see section 5 of the [provided write-up](Red_Pitaya_Lock.pdf) for instructions on installing the requisite software, opening the project, compiling it, and deploying it on the board.

There is also a [provided interface](RPInterface.py) written in Python intended to be run on a computer that connects to the board through secure shell (SSH). It accesses the onboard microprocessor, which can update parameters on the board in real-time, without needing to recompile and redeploy the code.

## Further Development

There is much room for further development and testing; some PID controllers offer automatic tuning programs or re-locking protocols that could be recreated. A variety of other lab features could also be implemented on the board. Finally, an onboard interface using a screen connected to the microprocessor would reduce the need to connect the board to a computer to control it. The strength of this board with its FPGA and microprocessor setup is its versatility - this is only one example of what is possible.

## Acknowledgements

Developed in collaboration with the University of Oklahoma Center for Quantum Research and Technology.
