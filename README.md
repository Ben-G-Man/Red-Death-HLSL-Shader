# Red-Death-HLSL-Shader

This HLSL shader reads from the Animation Coefficient value to reduce the blue and green colour channels to zero simultaniously before draining the red channel to create a gnarly 'fade-to-death' transition. 

NOTE: The animation coefficient should be increased from 0 to 64 linearly to produce a smooth transition. A coefficient of 32 will leave only the red colour components of an image.
