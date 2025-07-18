void RecalculateNormals(float3 DisplacedPosition, float3 OriginalPosition, float3 TangentSpaceNormal, out float3 RecalculatedNormal)
{
    // Calculate the displacement vector
    float3 displacement = DisplacedPosition - OriginalPosition;

    // Approximate tangent and bitangent
    float3 tangent = normalize(displacement);
    float3 bitangent = cross(TangentSpaceNormal, tangent);

    // Recalculate normal using cross product
    RecalculatedNormal = cross(tangent, bitangent);

    // Ensure the recalculated normal is normalized
    RecalculatedNormal = normalize(RecalculatedNormal);
}
