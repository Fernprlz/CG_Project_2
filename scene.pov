#include "pyramid.inc"

///////////////////////////////
// Camera
///////////////////////////////

camera {
  location <0, 16, -40>
  look_at <0, 16, 0>
}

///////////////////////////////
// Lights
///////////////////////////////

light_source {
  <6, .5, -40>
  White
}   

light_source {
  <-6, .5, -40>
  White
}   

light_source {
  <0, -2, -40>
  White
}  

light_source {
  <0, 35, -50>
  color White
  spotlight
  radius 15
  falloff 20
  tightness 10
  point_at <0, 12, -55>
}     
   
///////////////////////////////
// Ambient
///////////////////////////////   


sphere {  
    <0,0,0>, 1
    texture{ Starfield1 }
    scale 10000
} 
      
///////////////////////////////
// Objects
///////////////////////////////         
      
///////////////// Pyramid Composite
union{
    object {

    pyramid 
 
    finish { ambient .2}
    scale 1 
    }

    object {

    pyramid 
 
    finish { ambient .2}
    scale 1 
    rotate <180, 0, 0>
    }       
    
    translate <0, 15, 0>  
    rotate <0, 45, 0>
}      

///////////////// Shadow Cast Sphere
sphere{
 <0, 16, 0>, 250
 pigment { Gold transmit .85}
 finish { ambient .7 } 
}    