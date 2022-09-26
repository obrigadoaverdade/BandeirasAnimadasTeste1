Shader "Unlit/ShaderLaos"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}

    }
        SubShader
    {
        Tags { "RenderType" = "Opaque" }
        LOD 100

        Pass
        {
            HLSLPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include  "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

                struct Attributes
                {
                    float4 position :POSITION;
                    float2 uv       :TEXCOORD0;
                };

                struct Varyings
                {
                    float4 positionVAR :SV_POSITION;
                    float2 uvVAR       : TEXCOORD0;
                };

                Varyings vert(Attributes Input)
                {
                    Varyings Output;

                    Output.positionVAR = TransformObjectToHClip(Input.position.xyz);
                    Output.uvVAR = Input.uv;

                    //Output.positionVAR = Input.position;

                    return Output;
                }
                float4 frag(Varyings Input) :SV_TARGET
                {
                    float wiggle = sin(_Time.y * 2.0 + Input.uvVAR.x) * 0.10;

                    float x = length(float2(Input.uvVAR.x * 1.73,Input.uvVAR.y) - float2(0.85, 0.5 + wiggle));

                    float4 color = float4(0.8,0,0,0);

                    if (Input.uvVAR.y > 0.75 + wiggle)
                    {
                         color = float4(0.8,0,0,0);
                    }
                    else
                    {
                        color = float4(0, 0, 0.5, 1);
                    }
                    if (Input.uvVAR.y < 0.25 + wiggle)
                    {
                        color = float4(0.8, 0, 0,0);
                    }
                    if (x < 0.2)
                        color = float4(1, 1, 1, 1);

                    return color;
                }



            ENDHLSL
        }
    }
}