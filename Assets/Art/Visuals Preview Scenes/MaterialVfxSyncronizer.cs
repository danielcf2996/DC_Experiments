using UnityEngine;
using UnityEngine.VFX;

[ExecuteInEditMode]
public class MaterialVfxSyncronizer : MonoBehaviour
{
    public float value;
    public Material material;
    public VisualEffect vfx;

    public string materialPropertyKey;

    public string vfxPropertyKey;

    // Start is called before the first frame update
    private void Start()
    {
    }

    // Update is called once per frame
    private void Update()
    {
        this.material.SetFloat(this.materialPropertyKey, this.value);
        this.vfx.SetFloat(this.vfxPropertyKey, this.value);
    }
}
