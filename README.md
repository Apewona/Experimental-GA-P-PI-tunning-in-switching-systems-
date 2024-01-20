<h3>Experimental GA, P, PI tunning in switching systems (power converters)</h3>
<p>----------------------------------</p>
Experimental method of tunning P, PI regulator using genetic programming in raw form without librares.
It's main purpose is to verify how genetic programming method can solve stochastic problem of tunning regulator
in switching systems like Buck or Boost converters. Method is based on state space eq. of Buck converter circuit.
<p>----------------------------------</p>
Program operates on physical equations in state space of Buck converter whick block diagram is shown below.

<img src="https://github.com/Apewona/Experimental-GA-P-PI-tunning-in-switching-systems-/blob/main/figures/blokowy_reg.png?raw=true" alt="blockdiagram"/>

The main purpose of my project is to explore the problem space of tuning P (Proportional), PI (Proportional-Integral) regulators in a hysteresis control system. This project is a part of my bachelor's degree in electrical engineering. Structure of population is given by figure below.

<img src="https://github.com/Apewona/Experimental-GA-P-PI-tunning-in-switching-systems-/blob/main/figures/struktura_populacji.jpg?raw=true" alt="population_structure"/>

Population consist genotypes. Each genotype is divided to smaller parts called nucleotides to obtain distributed genotype strategy. Example results of searching are shown below.

<img src="https://github.com/Apewona/Experimental-GA-P-PI-tunning-in-switching-systems-/blob/main/figures/buck3d_w3.jpg?raw=true" alt="population_structure"/>
