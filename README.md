# FALCONS: a FAst conversion tooL between CONstrainS 

# What is FALCONS ?
This is a open-software tool to update contrains from given any given SINEX files, i.e. a) conversion between minimum constrains (MC) and over constrains (OC), b) change different set of fiducial site (modification on .FIX file) for a given MC or OC solution. c) change the strength of the constrains at an existing solution. d) more, accroding to your imagination.

# Why should one use FALCONS ?
This tool can save significant time if one want to update or apply certain popular constrains onto a global/regional reference frame solution, by updating the constrains at the solution level instead inverting the covariance matrix to obtain the normal equation then apply constrain onto the normal equation (classical approach). This new approach is capterable to apply new constrain >10 times faster for a network including 100 stations and >140 times faster for a network including 5 000 stations (details refer to our paper).


# How to use FALCONS?
This tool is consist of  
1. I/O with SINEX files
2. convert between types of constrains

For the mathematical discription please refer to the paper "Revisiting the transformation ..." in submission, the corresponding scripts and this tool will be open-accessed as soon as the paper is accepted.

The major scope of this program is to avoid the re-production of the normal equaiton and computation with heavy computational effort to convert constrains, instead, by inverting a small matrix.

# Problem, suggestion or complains?
Any comments and suggestion is welcome, we will be very happy to hear either anything need to be improve or this tool provided a bit help to your great mind or projects.

# Keywords: 
Geodesy, TRF, constrain, inversion, NNT, NNR, NNS，Reference Frame, S-transformation

# Citation

Ampatzidis D, Wang L, Mouratidis A, Balidakis K (2022) Rigorous and fast constraints transformations at the solution level: case studies for regional and global GNSS networks. GPS Solut 26(2):44. https://doi.org/10.1007/s10291-022-01225-3

