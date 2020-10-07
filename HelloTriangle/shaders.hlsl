//*********************************************************
//
// Copyright (c) Microsoft. All rights reserved.
// This code is licensed under the MIT License (MIT).
// THIS CODE IS PROVIDED *AS IS* WITHOUT WARRANTY OF
// ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY
// IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR
// PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.
//
//*********************************************************

struct PSInput
{
    float4 position : SV_POSITION;
    float4 color : COLOR;
};

PSInput VSMain(float4 position : POSITION, float4 color : COLOR)
{
    PSInput result;

    float xDistance = 0.0f;
    float yDistance = 0.0f;
    float zDistance = 0.5f;
    float scale = 1.5f;

    float4x4 m_translation =
    {
        1.0,        0.0f,       0.0f,       0.0f,
        0.0,        1.0f,       0.0f,       0.0f,
        0.0,        0.0f,       1.0f,       0.0f,
        xDistance,  yDistance,  zDistance,  1.0f
    };

    float4x4 m_scale =
    {
		scale, 0.0f, 0.0f, 0.0f,
        0.0f, scale, 0.0f, 0.0f,
        0.0f, 0.0f, scale, 0.0f,
        0.0f, 0.0f, 0.0f, 1.0f
	};
    
	const float tau = 6.283185307f; //Tau == 2 x PI, aka a full turn
	float angle = tau / 12.0f;      
    
	float4x4 m_rotateYZ =
	{
		1.0f, 0.0f, 0.0f,   0.0f,
        0.0f, cos(angle),   sin(angle), 0.0f,
        0.0f, -sin(angle),  cos(angle), 0.0f,
        0.0f, 0.0f, 0.0f,   1.0f
	};
    
	float4x4 finalTransform = mul(m_rotateYZ, m_translation);

	float4 newPos = mul(position, finalTransform);

    result.position = newPos;
    result.color = color;

    return result;
}

float4 PSMain(PSInput input) : SV_TARGET
{
    return input.color;
}
