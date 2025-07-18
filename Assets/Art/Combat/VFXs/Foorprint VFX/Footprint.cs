using UnityEngine;

public class Footprint : MonoBehaviour
{
    public Renderer renderer;
    public float fadingSpeed;

    private float fadeProgress;
    // Start is called before the first frame update

    private Material material;

    private void Start()
    {
        this.material = this.renderer.sharedMaterial;
        this.renderer.material = new Material(this.material);
        this.fadeProgress = 0;
    }

    // Update is called once per frame
    private void Update()
    {
        if (this.fadeProgress < 1f)
        {
            this.fadeProgress += this.fadingSpeed;
        }

        this.renderer.material.SetFloat("_FadeProgress", this.fadeProgress);

        if (this.fadeProgress >= 1f)
        {
            Destroy(this.gameObject);
        }
    }
}
