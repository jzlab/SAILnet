# SAILnet

## Project Description
The Sparse And Independent Local network (SAILnet) is a network of leaky integrate-and-fire neurons that uses synaptically local plasticity rules to learn sparse representations of natural images

SAILnet is a putative model of the mammalian visual cortex, and improves over (previously) existing models by being more biophysically realistic.

The model, and its relevance to neurobiology, are described in our 2011 PLoS Computational Biology paper
[A Sparse Coding Model with Synaptically Local Plasticity and Spiking Neurons Can Account for the Diverse Shapes of V1 Simple Cell Receptive Fields](http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1002250).

We also used the model to explore how sparseness changes during development (in model systems), in our 2013 PLoS Computational Biology paper [Sparse Coding Models Can Exhibit Decreasing Sparseness while Learning Sparse Codes for Natural Images](http://www.ploscompbiol.org/article/info:doi/10.1371/journal.pcbi.1003182).

Paul King, Mike DeWeese, and I published a follow-up, in which the model was expanded to include a separate population of inhibitory neurons, to make the model more biophysically realistic. We then asked how many inhibitory cells were needed for the model to "work" properly, and used those results to help understand the relative numbers of excitatory and inhibitory cells in the mammalian visual cortex.

This work was published in a 2013 Journal of Neuroscience paper [Inhibitory Interneurons Decorrelate Excitatory Cells to Drive Sparse Code Formation in a Spiking Model of V1](http://jzlab.org/king_zylberberg_deweese_JNeuro_Dale_SAILnet_2013.pdf)
The code associated with that work is available from [Paul King's website](http://www.pking.org/research/EINet/)


Engineers from the University of Michigan recently constructed my SAILnet architecture on a chip for massively parallel low-power signal processing applications.
You can read more about their work [here](http://web.eecs.umich.edu/~zhengya/papers/kim%20tsp%202014.pdf).

## Installation

```bash
$ git clone https://github.com/jzlab/SAILnet

$ cd SAILnet/
```

## Usage

To run SAILnet in matlab:

```matlab
>> init
>> SAILnet
```

You can then hit ctrl+c at any time to stop the simulation (the network parameters at that time will still be accessible from memory).
Alternatively, after a time defined by num_trials (a parameter in the init.m file), the simulation will end.

### File Descriptions

- The IMAGES.mat file contains 10 whitened natural images, from Olshausen and Field (1996), and is loaded by init.m
- The init.m file initializes all of the simulation parameters. NOTE: this script contains a "clear all" command, so save your work before running it (or comment out that line).
- the SAILnet.m file runs the SAILnet simulation, calling activities.m to get neuronal activities in response to randomly selected image patches, updating network parameters, etc.
- SAILnet.m also calls show_network.m, which displays network statistics periodically, so you can see the solution converging. 
- activities.m solves numerically the differential equation for leaky integrate-and-fire neuron dynamics, and returns spike counts 
- show_network.m calls showrfs.m, which displays just the neuronal receptive fields. 
