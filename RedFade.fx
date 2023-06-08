/*  RED DEATH EFFECT
        Description:    This HLSL shader reads from the Animation Coefficient value to 
                        reduce the blue and green colour channels to zero simultaniously 
                        before draining the red channel to create a gnarly 'fade-to-death' 
                        transition. 
        Author:         Benjamin Hume */

struct PS_INPUT
{
    float4 Position   : POSITION;
    float2 Texture    : TEXCOORD0;
};

struct PS_OUTPUT
{
    float4 Color   : COLOR0;
};

/*  VARIABLES
        img:                A reference to the 2D area that is being processed
        bkd:                A reference to the overlapping background of the area being processed
        animCoeff:          An integer value representing how far through the animation is 
                            (0 = no effect, 32 = only red left in image, 64 = total darkness) */

sampler2D img;
sampler2D bkd : register(s1);

int animCoeff;

PS_OUTPUT ps_main(in PS_INPUT In)
{
    PS_OUTPUT pixelOut;

    pixelOut.Color = tex2D(bkd, In.Texture);
    
    if (animCoeff <= 32) {
        pixelOut.Color.g = (pixelOut.Color.g - ((pixelOut.Color.g / 32.0) * animCoeff));
        pixelOut.Color.b = (pixelOut.Color.b - ((pixelOut.Color.b / 32.0) * animCoeff));
    }

    else if ((animCoeff > 32) && (animCoeff < 64)) {
        pixelOut.Color.r = (pixelOut.Color.r - ((pixelOut.Color.g / 32.0) * (animCoeff - 32)));
        pixelOut.Color.g = 0.0;
        pixelOut.Color.b = 0.0;
    }

    else {
        pixelOut.Color.r = 0.0;
        pixelOut.Color.g = 0.0;
        pixelOut.Color.b = 0.0;
    }


    return pixelOut;
}

technique tech_main { pass P0 { PixelShader = compile ps_2_0 ps_main(); } }
