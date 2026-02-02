import os, sys
import math
from math import sqrt,asin,pi,sin,tan,cos,atan
from scipy.optimize import fsolve
import warnings
warnings.simplefilter("ignore", category=RuntimeWarning)


a = 3.8
b = 4.8
for n in range(10,30):  # n = strands
  for shear in range(n,(n*2)+1): # shear
    if shear%2 == 0:
      # cylinder radius based on barrel parameters
      r = math.sqrt((shear*3.8)**2+(n*4.8)**2)/(2*n*math.sin(math.pi/n))   # cylinder radius

      if r > 13 and r < 21:   # sample radii range likely to fit core sidechains w/ good packing

        for nres in range(6,20):   # nres per strand

          # coil angle
          theta=asin(shear*3.8/(2*math.pi*r))
          def disNextRes(x):
              return sqrt(r**2*(2-2*cos(x[0]))+(r*x[0]/tan(theta))**2)-a
          def disNextStrand(x):
              return sqrt(r**2*(2-2*cos(x[0]+2*math.pi/n))+(r*x[0]/tan(theta))**2)-b
          delta_t1 = fsolve(disNextRes,0)[0]
          delta_t2 = fsolve(disNextStrand,0)[0]
          def dis(x,y):
            s=0
            for i in range(len(x)):s += (x[i]-y[i])**2
            return sqrt(s)
          for ns in range(1,n+1):
            phi = (ns-1)*2*math.pi/n
            dt2 = (delta_t2)*(ns-1)

          heighta = []
          n0 = 0 #number of residues at the strand
          for j in range(800):
            dt1 = (delta_t1)*j
            dt = dt1+dt2
            x=r*cos(dt+phi)
            y=r*sin(dt+phi)
            z=r*dt/tan(theta)
            if z<0:continue
            n0 += 1
            if n0>nres: break # +4: break #jump out of the loop
            sign = 1 if j%2 == 0 else -1
            heighta.append(z)
          h = heighta[-1]-heighta[0]

          if h < 35 and h > 19:  # cylinder height in range to cover lipid bilayer interacting sidechains

              print(f'python ../submodules/parametric_barrels/barrels.py --n {n} --S {shear} --nres {nres} --terminilen 2 --looplen 3 # radius {r} height {h}')
 


