using UnityEngine;
using UnityEditor;
using System.Collections.Generic;
using System.Linq;

public class VertexColorReader : MonoBehaviour
{
    [SerializeField] private bool sRGB = false;
    [SerializeField] private float colorThreshold = 0.05f; // Merging sensitivity
    [SerializeField] private Color[] uniqueVertexColors;

    // Public integers to store the vertex, triangle, and UV counts
    public int totalVertices = 0;
    public int totalTriangles = 0;
    public int totalUVs = 0;

    [ContextMenu("Read Vertex Color")]
    private void ReadVertexColors()
    {
        HashSet<Color> colorSet = new HashSet<Color>();

        foreach (var meshRenderer in GetComponentsInChildren<MeshRenderer>())
        {
            AddVertexColors(meshRenderer.GetComponent<MeshFilter>()?.sharedMesh, colorSet);
        }

        foreach (var skinnedMeshRenderer in GetComponentsInChildren<SkinnedMeshRenderer>())
        {
            AddVertexColors(skinnedMeshRenderer.sharedMesh, colorSet);
        }

        uniqueVertexColors = QuantizeColors(colorSet.ToList(), colorThreshold).ToArray();
        SortColorsByHueAndLuminance();
        Debug.Log("Vertex colors read, quantized, and sorted: " + uniqueVertexColors.Length);
    }

    private void AddVertexColors(Mesh mesh, HashSet<Color> colorSet)
    {
        if (mesh == null || !mesh.HasVertexAttribute(UnityEngine.Rendering.VertexAttribute.Color))
            return;

        Color[] colors = mesh.colors;
        if (colors == null || colors.Length == 0)
            return;

        foreach (Color col in colors)
        {
            Color finalColor = sRGB ? col.linear : col;
            colorSet.Add(finalColor);
        }
    }

    private List<Color> QuantizeColors(List<Color> colors, float threshold)
    {
        List<Color> quantizedColors = new List<Color>();

        foreach (Color c in colors)
        {
            bool merged = false;

            for (int i = 0; i < quantizedColors.Count; i++)
            {
                if (ColorDistance(c, quantizedColors[i]) < threshold)
                {
                    // Take the more saturated color
                    quantizedColors[i] = GetMostSaturatedColor(quantizedColors[i], c);
                    merged = true;
                    break;
                }
            }

            if (!merged)
            {
                quantizedColors.Add(c);
            }
        }

        return quantizedColors;
    }

    private Color GetMostSaturatedColor(Color c1, Color c2)
    {
        var hsl1 = RGBToHSL(c1);
        var hsl2 = RGBToHSL(c2);

        // Compare saturation and pick the more saturated color
        return hsl1.S > hsl2.S ? c1 : c2;
    }

    private float ColorDistance(Color c1, Color c2)
    {
        return Mathf.Sqrt(
            Mathf.Pow(c1.r - c2.r, 2) +
            Mathf.Pow(c1.g - c2.g, 2) +
            Mathf.Pow(c1.b - c2.b, 2)
        );
    }

    private void SortColorsByHueAndLuminance()
    {
        uniqueVertexColors = uniqueVertexColors
            .Select(c => new { Color = c, HSL = RGBToHSL(c) })
            .OrderBy(c => c.HSL.H)
            .ThenBy(c => c.HSL.L)
            .ThenBy(c => c.HSL.S)
            .Select(c => c.Color)
            .ToArray();
    }

    private (float H, float S, float L) RGBToHSL(Color color)
    {
        float r = color.r, g = color.g, b = color.b;
        float max = Mathf.Max(r, g, b);
        float min = Mathf.Min(r, g, b);
        float h = 0, s, l = (max + min) / 2f;

        if (max == min)
        {
            h = 0; // No hue
            s = 0; // No saturation
        }
        else
        {
            float d = max - min;
            s = l > 0.5f ? d / (2f - max - min) : d / (max + min);

            if (max == r)
                h = (g - b) / d + (g < b ? 6f : 0f);
            else if (max == g)
                h = (b - r) / d + 2f;
            else if (max == b)
                h = (r - g) / d + 4f;

            h /= 6f;
        }

        return (h, s, l);
    }

    private Color HSLToRGB(float h, float s, float l)
    {
        float r, g, b;

        if (s == 0)
        {
            r = g = b = l; // Achromatic case
        }
        else
        {
            float q = l < 0.5f ? l * (1f + s) : l + s - l * s;
            float p = 2f * l - q;
            r = HueToRGB(p, q, h + 1f / 3f);
            g = HueToRGB(p, q, h);
            b = HueToRGB(p, q, h - 1f / 3f);
        }

        return new Color(r, g, b);
    }

    private float HueToRGB(float p, float q, float t)
    {
        if (t < 0f)
            t += 1f;
        if (t > 1f)
            t -= 1f;
        if (t < 1f / 6f)
            return p + (q - p) * 6f * t;
        if (t < 1f / 2f)
            return q;
        if (t < 2f / 3f)
            return p + (q - p) * (2f / 3f - t) * 6f;
        return p;
    }

    // New method to calculate vertices, triangles, and UVs count
    [ContextMenu("Calculate Mesh Stats")]
    public void CalculateMeshStats()
    {
        totalVertices = 0;
        totalTriangles = 0;
        totalUVs = 0;

        foreach (var meshRenderer in GetComponentsInChildren<MeshRenderer>())
        {
            var mesh = meshRenderer.GetComponent<MeshFilter>()?.sharedMesh;
            if (mesh != null)
            {
                totalVertices += mesh.vertexCount;
                totalTriangles += mesh.triangles.Length / 3;
                totalUVs += mesh.uv.Length;
            }
        }

        foreach (var skinnedMeshRenderer in GetComponentsInChildren<SkinnedMeshRenderer>())
        {
            var mesh = skinnedMeshRenderer.sharedMesh;
            if (mesh != null)
            {
                totalVertices += mesh.vertexCount;
                totalTriangles += mesh.triangles.Length / 3;
                totalUVs += mesh.uv.Length;
            }
        }

        Debug.Log($"Total Vertices: {totalVertices}");
        Debug.Log($"Total Triangles: {totalTriangles}");
        Debug.Log($"Total UVs: {totalUVs}");
    }
}
