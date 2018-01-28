// Shared variable passed to the fragment shader
varying vec3 color;
uniform vec3 headAngle;

// Constant set via your javascript code
uniform vec3 lightPosition;

void main() {
	// No lightbulb, but we still want to see the armadillo!
	vec3 l = vec3(0.0, 0.0, -1.0);
	color = vec3(1.0) * dot(l, normal);
	vec3 pos = vec3(0.0, 0.0, 0.0);
	float headAngle1 = length(vec3(0.0, 0.0, 0.0));

	// Identifying the head
	if (position.z < -0.33 && abs(position.x) < 0.46){
		//color = vec3(1.0, 0.0, 1.0);
		pos = vec3(0.0 ,2.5 ,-0.4);
		headAngle1 = length(headAngle);
		}

		mat4 moveMat1 = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(-pos.x, -pos.y, -pos.z, 1.0)
    );

    	  mat4 rotatx = mat4(
                1.0, 0.0, 0.0, 0.0,
         0.0, cos(headAngle1), sin(headAngle1), 0.0, 
         0.0, -sin(headAngle1), cos(headAngle1), 0.0,
               0.0, 0.0, 0.0, 1.0
    );


    	mat4 moveMat2 = mat4(
        vec4(1.0, 0.0, 0.0, 0.0),
        vec4(0.0, 1.0, 0.0, 0.0),
        vec4(0.0, 0.0, 1.0, 0.0),
        vec4(pos.x, pos.y, pos.z, 1.0)
    );

		 
   

	// Multiply each vertex by the model-view matrix and the projection matrix to get final vertex position
	gl_Position = projectionMatrix * modelViewMatrix * moveMat2 * rotatx * moveMat1 * vec4(position, 1.0);
}
