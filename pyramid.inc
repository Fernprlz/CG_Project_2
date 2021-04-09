#include "colors.inc"
#include "glass.inc" 
#include "textures.inc"
#include "stars.inc" 
 
 
///////////////////////////////
// Macros
/////////////////////////////// 

#macro sierpinski(pyramid_size, base_center, iteration)
    #if (iteration > 0)
        union {       
            sierpinski(pyramid_size / 2, base_center + pyramid_size/2*y,      iteration - 1)
            sierpinski(pyramid_size / 2, base_center - pyramid_size/2*(x+z),  iteration - 1)
            sierpinski(pyramid_size / 2, base_center - pyramid_size/2*(x-z),  iteration - 1)
            sierpinski(pyramid_size / 2, base_center - pyramid_size/2*(-x+z), iteration - 1)
            sierpinski(pyramid_size / 2, base_center - pyramid_size/2*(-x-z), iteration - 1)
        }
    #else
        difference{
            box { <1,1,1>, <-1,0,-1> }
            plane{ x-y,  -sqrt(2)/2 pigment { Gold }}
            plane{ -x-y, -sqrt(2)/2 pigment { Gold }}
            plane{ z-y,  -sqrt(2)/2 pigment { Black } finish {ambient .4}}
            plane{ -z-y, -sqrt(2)/2 pigment { Black } finish {ambient .4}}
            scale pyramid_size*1.0
            translate base_center            
        }    
    #end
#end 

///////////////////////////////
// Objects
///////////////////////////////

#declare pyramid = union{sierpinski(15,0,6)}      



