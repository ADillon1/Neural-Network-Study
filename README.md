# Simple Neural Net Project
Author: Andrew Dillon

This is a simple Neural Network study for a simple 1 input 1 output 

# How to run

With the project directory open, simply click and drag the subdirectory "/game" onto the lovec.exe file.
This tells Love2D to import the lua files and assets into the engine and run it.

NOTE: You can also run it with love.exe (instead of lovec.exe) but it won't display vital console info.

# About

For my neural network, I chose to approximate the function x^2. This of course can be changed in code.

Upon loading the window, you should see a simple graph displaying two lines. The curved
line represents the approximated values of the func x^2 in the range of R(0 - 1). The
second line represents the default output appromiations from the simple neural network
with 10 neurons.

While Stepping or running the application, 1024 iterations on the learning algorithm 
are performed. These, along with the number of neurons, and the function to approximate
is commented towards the top of main.lua and can be edited.

Controls are also explained in the console, but I will also place them here as well.

Controls:
- R     = reset simulation
- S     = Step one (*number of iterations)
- Space = Toggle Run forever.

Every "step", the application will print the current learning iteration and calculated
Error between the neural net's output and the expected output for the given input.
