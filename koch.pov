#include "colors.inc"
#include "textures.inc"
#include "glass.inc"
#include "metals.inc"
#include "golds.inc"
#include "stones.inc"
#include "woods.inc"
#include "shapes.inc"
#include "shapes2.inc"
#include "functions.inc"
#include "math.inc"
#include "transforms.inc"   

camera {
    location <0,50,0>
    look_at <0,0,0>
}

light_source {
    <0,30,0>
    color rgb<1,1,1>
    shadowless
}
    
plane {
    y,0
    pigment {color rgb<1,1,1>} 
    finish { ambient 0.25 diffuse 0}
}
             
///////////////////////////////
// Variables
///////////////////////////////

// Triangle length
#declare tlength=20;

#declare ytranslate=tlength/(2*sqrt(3));

#declare triangleBase=
prism {
    -1, 1, 3,
    <-tlength/2, -ytranslate>,<tlength/2,-ytranslate>,<0,tlength/sqrt(3)>
    pigment {
           color rgb<0.094, 0.847, 0.905>
        }
} 

#declare kochBase=
union {
    object{triangleBase}
    object{triangleBase rotate<0,180,0> pigment {color rgb<0.094, 0.847, 0.905>}
    }
}


#macro koch(s,counter)
    //0 iterations
    #if (counter=0)
        object {triangleBase scale <s,1,s>}
    #end
        
    //lowest recursive level
    #if (counter=1)
        union {
            object{triangleBase scale <s,1,s>}
            object{triangleBase rotate<0,180,0> pigment {color rgb<0.094, 0.847, 0.905>}
        }
    }
    #end    
     
    //recursive 
    #if (counter>1)
        koch(s/2, counter-1)   
    #end
#end  

koch(1, 1)