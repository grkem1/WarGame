# WarGame
A simple FPGA game

Initially developed by Görkem Kılınç and Najmush Sakib Khan for EE314 Digital Electronics Lab course in 2015 Spring. Originally coded in Verilog. The goal of the game is to hit the target that cycles around the middle of the screen by shooting a bullet in vertical direction.  

__war_top:__ Top level module

__war_graph:__ The objects are defined by their coordinates and sizes. Their motions with each refresh of screen are defined.

__vga_sync:__ The game is printed on a 640 x 480 screen. For this purpose, necessary parameters and clocks are defined.

[Short demonstration video](https://youtu.be/pJ1odB_tE9E) is available.
