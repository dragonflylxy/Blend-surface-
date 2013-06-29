Blend-surface-
==============
This matlab code define a system of linear equations from a surface and a curve,
to solve this equation,obtained a implicite surface Interpolated the curve and 
the part of the surface boundary.

LX1.m is the main program to solve the equation,LX2.m use iso surface to display,
and project points to the surface for output.
cv*.txt file define the control points of bezier surface.each file include a surface or curve.
MUMA1.mat define the constrains of the boundary,same as define the conunity ofrunbezier surface.
To G0 conunity,make all the first line to 1,to G1 make the second line to 1,

First run LX1.m,then run LX2.m. In LX2.m,let tests=1 to display the surface in iso mode,
tests=0 to make a project surface on the implicit surface,and savrfls=1 to output the surface in rhino3d
command form,then you can open it by import the command file in rhino3d.
The a1.3dm is a example in rhino3d.



