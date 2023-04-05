# Quake 1 Ending Fix

This simple mod for Quake 1 updates the final scene so that:

 - The song "Quake Theme" is triggered instead of "Aftermath"
 - The player model is shown holding the correct weapon based on what you were using when you entered the slipgate, instead of always holding the axe
 - The player model is shown in a standing pose instead of a running pose
 - The player model is shown doing the correct idle animation, instead of standing perfectly still

The development of this mod can be seen in this video - https://youtu.be/DEkjDkr0Qmc

_Note:_ In the video I miscounted the number of frames in the axe stand animation, missing the last few frames. The files here fix that and use all the axe stand frames.

## Installation and running

Create a directory in your Quake directory called `endfix`, and add the `progs.dat` file to the `endfix` directory.

Then run quake from the command line with the following command:

```dos
quake -game endfix
```
