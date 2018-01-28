
// Shared variable passed to the fragment shader

uniform vec3 laserPos;
uniform vec3 lightPosition;


void main() {

  vec3 moveVector;

  if(length(laserPos) == 1.0){
   moveVector= vec3(0.1425, 2.44, -0.64);
  } else {
   moveVector= vec3(-0.1357,2.44, -0.645);

   }

    vec3 dist = moveVector - lightPosition;
    vec3 z = normalize(dist);
    vec3 x = normalize(cross(vec3(0.0, 1.0, 0.0), z));
   vec3 y = cross(x, z); 

 mat4 moveMat = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(moveVector.x, moveVector.y, moveVector.z, 1.0)
    );

    mat4 scale = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 0.5, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(0.0, 0.0, 0.0, 1.0)
    );

    
    mat4 scale2 = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, length(dist), 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(0.0, 0.0, 0.0, 1.0)
    );    

    float angle1 = -1.5708;
    mat4 rotatx = mat4(
                1.0, 0.0, 0.0, 0.0,
         0.0, cos(angle1), sin(angle1), 0.0, 
         0.0, -sin(angle1), cos(angle1), 0.0,
               0.0, 0.0, 0.0, 1.0
    );

    mat4 rotat = mat4(
              x.x, x.y, x.z, 0.0,
             y.x, y.y, y.z, 0.0,
              z.x, z.y, z.z, 0.0,
              0.0, 0.0, 0.0, 1.0 
    ); 



  
  gl_Position = projectionMatrix * modelViewMatrix * moveMat*rotat*rotatx*scale2*scale*(vec4(position, 1.0));

}
