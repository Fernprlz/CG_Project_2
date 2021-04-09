#include "colors.inc"
#include "textures.inc"    
#include "transforms.inc"

///////////////////////////////
// Variables
///////////////////////////////

// Total side length
#declare tlength=50;

// Distance to move each sub-triangle
#declare ytranslate = tlength/(2*sqrt(3));

///////////////////////////////
// Camera
///////////////////////////////

    location <0,20,-tlength*2>
    //location <0,90,0>
    look_at <0,0,0>
}

///////////////////////////////
// Light
///////////////////////////////

light_source {
    <0,10,-30>
    color rgb<1,1,1>
    shadowless
}

///////////////////////////////
// Objects
///////////////////////////////

#declare base_color = 1;   
#declare step = 10;


// Original shape that will be copied and translated
#declare triangleBase=
prism {
    -.1, // Grosor inicio
    .1,  // Grosor final
    3,  // Número de puntos formando el prisma
    <-tlength/2, -ytranslate>, // Arista 1 = mitad del lado pa la izq, 
    <tlength/2,-ytranslate>,   // Arista 2 
    <0,tlength/sqrt(3)>        // Arista 3
    
    
    pigment {color rgb<base_color,base_color,base_color>}
}

#declare serpinskiBase =
difference{  
    object{triangleBase}
    object{triangleBase scale<0.5,1.01,0.5> rotate <0,180,0>}
}


#macro serpinski(s,side,xpos,zpos,counter)
    //0 iterations
    #if (counter=0)
        object{triangleBase scale <s,1,s> translate <xpos,0,zpos>} 
        #end   
        
    //only draw object at the lowest recursive level
    #if (counter=1)
        difference{
            object{triangleBase scale <s,1,s> translate <xpos,0,zpos>}
            object{triangleBase scale <0.5*s,1.001,0.5*s> rotate<0,180,0>}
        }
        #end 
    #if (counter>1)
        //left
        serpinski(s/2,side/2,xpos-side/4,zpos-side/(4*sqrt(3)),counter-1)
        //right
        serpinski(s/2,side/2,xpos+side/4,zpos-side/(4*sqrt(3)),counter-1) 
        //top
        serpinski(s/2,side/2,xpos,zpos+side*sqrt(3)/6,counter-1)    
        #end
#end     


///

#macro cheerful_serpinski(s,side,xpos,zpos,counter, col)
    //0 iterations
    #if (counter=0)
        object{triangleBase scale <s,1,s> translate <xpos,0,zpos> pigment{color rgb <col, col, col>}} 
        #end   
        
    //only draw object at the lowest recursive level
    #if (counter=1)
        difference{
            object{triangleBase scale <s,1,s> translate <xpos,0,zpos> pigment{color rgb <col-(step/255), col, col-(step/255)>}}
            object{triangleBase scale <0.5*s,1.001,0.5*s> rotate<0,180,0> pigment{color rgb <col-(step/255), col, col-(step/255)>}}
        }
        #end 
    #if (counter>1)
        //left
        cheerful_serpinski(s/2,side/2,xpos-side/4,zpos-side/(4*sqrt(3)),counter-1, col-(step/255))
        //right
        cheerful_serpinski(s/2,side/2,xpos+side/4,zpos-side/(4*sqrt(3)),counter-1, col-(step/255)) 
        //top
        cheerful_serpinski(s/2,side/2,xpos,zpos+side*sqrt(3)/6,counter-1, col-(step/255))    
        #end
#end

//#declare final = union{serpinski(1,tlength,0,0,8)}
 #declare final = union{cheerful_serpinski(1,tlength,0,0,8, base_color)}
// Sur
object{
    final            
    
    finish { ambient .9}
    
    scale <0, 0, 0>
    rotate <-60, 0, 0>
    translate <0, 0, -tlength/2>
}

// Norte
object{
    final            
    
    finish { ambient .9}
    
    scale <0, 0, 0>
    rotate <-30, 0, 0>
    translate <0, 0, +tlength/2>
}            

// Oeste
object{
    final            
    
    finish { ambient .9}
    
    scale <0, 0, 0>
    rotate <-90, 90, -30>
    translate <-tlength/2, 0, 0>
}

// Este        
object{
    final            
    
    finish { ambient .9}
    
    scale <0, 0, 0>
    rotate <-90, 90, 30>
    translate <+tlength/2, 0, 0>          
    
}
      

   