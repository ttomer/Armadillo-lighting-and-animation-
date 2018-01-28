
// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 eyePosition;
uniform vec3 lightPosition;


#define MAX_EYE_DEPTH 0.05

void main() {
  // simple way to color the pupil where there is a concavity in the sphere
  // position is in local space, assuming radius 1
  float d = min(1.0 - length(position), MAX_EYE_DEPTH);
  color = mix(vec3(1.0), vec3(0.0), d * 1.0 / MAX_EYE_DEPTH);

  //vec4 column0 = vec3(0.2, 0.0, 0.0, 0.0);
  //vec4 column1 = vec3(0.0, 0.5, 0.0, 0.0);
  //vec4 column2 = vec3(0.0, 0.0, 2.5, 0.0);
  //vec4 column3 = vec3(0.0, 0.0, 0.0, 1.0);
  //mat4 n = mat3(column0, column1, column2, column3);

  vec3 moveVector;

  if(length(eyePosition) == 1.0){
	 moveVector= vec3(0.1425, 2.44, -0.64);
  } else {
 	 moveVector= vec3(-0.1357,2.44, -0.645);
}

		mat4 moveMat = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(moveVector.x, moveVector.y, moveVector.z, 1.0)
    );


   mat4 scale = mat4(
        vec4(0.06, 0.0, 0.0, 0.0),
        vec4(0.0, 0.06, 0.0, 0.0),
        vec4(0.0, 0.0, 0.06, 0.0),
        vec4(0.0, 0.0, 0.0, 1.0)
    );

  //  vec3 up = vec3(0.0, 1.0, 0.0);
  //  vec3 lightDir = vec3(0.0, 0.0, 0.0) - lightPosition;
  //  float x = acos(dot(normalize(up), normalize(lightDir)));

     
    	float angle1 = 6.28;
    mat4 rotat2 = mat4(
         1.0, 0.0, 0.0, 0.0,
         0.0, cos(angle1), sin(angle1), 0.0, 
         0.0, -sin(angle1), cos(angle1), 0.0,
         0.0, 0.0, 0.0, 1.0
    );

    

   // mat4 rotation = mat4(xaxis, 0.0,
   // 					chanangle, 0.0,
   // 					z, 0.0,
   // 					0.0 ,0.0 ,0.0 ,1.0 );
 	

 	float angle2 = -1.57;
    mat4 rotatz = mat4(
         cos(angle2), sin(angle2), 0.0, 0.0,
         -sin(angle2), cos(angle2), 0.0, 0.0, 
         		0.0, 0.0, 1.0, 0.0,
         		0.0, 0.0, 0.0, 1.0
    );

    vec3 ran = normalize(lightPosition - eyePosition);
    vec3 z = normalize(ran);
    vec3 up = vec3(1.0, 0.0, 0.0);
    vec3 x = normalize(cross(up, z));
    vec3 y = cross(z, x);
	 float angle3 = acos(dot(up, ran));

	float angle5 = 1.57;
	 mat4 rotatx = mat4(1.0, 0.0, 0.0, 0.0,
                     0.0, cos(angle5), -sin(angle5), 0.0,
                     0.0, sin(angle5), cos(angle5), 0.0,
                     0.0, 0.0, 0.0, 1.0);
    
 	
    // mat4 rotat = mat4(
    //    cos(angle3), 0.0, -sin(angle3), 0.0,
     //  0.0, 1.0, 0.0, 0.0,
    //   sin(angle3), 0.0, cos(angle3), 0.0,
    //    0.0, 0.0, 0.0, 1.0
    //);
    //float angle3 =1.57;
    
    mat4 look = mat4(
        cos(angle3), 0.0, -sin(angle3), 0.0,
      0.0, 1.0, 0.0, 0.0,
       sin(angle3), 0.0, cos(angle3), 0.0,
        0.0, 0.0, 0.0, 1.0
    );

		mat4 rotat = mat4(x[0], x[1], x[2], 0.0,
						  y[0], y[1], y[2], 0.0,
						  z[0], z[1], z[2], 0.0,
						  0.0, 0.0, 0.0, 1.0 
		); 

  // Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
  gl_Position = projectionMatrix * viewMatrix * moveMat * look * rotatz * scale * (vec4(position, 1.0));
}
