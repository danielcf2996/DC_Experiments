using UnityEngine;
using UnityEngine.VFX;

[ExecuteInEditMode]
public class laserVFXCOntroller : MonoBehaviour
{
    [Header("Reference")] public Transform origin;

    public Transform destination;
    public float time;

    [Header("Objects")] public GameObject spawnPrefab;

    public Transform projectile;
    public GameObject explosionPrefab;

    public VisualEffect vfx;


    private void Start()
    {
    }

    // Update is called once per frame
    private void Update()
    {
        this.projectile.position = this.origin.position;
        this.projectile.LookAt(this.destination.position);
        var distance = Vector3.Distance(this.origin.position, this.destination.position);
        //projectile.localScale = new Vector3(1, 1, distance);


        this.vfx.SetFloat("Size", distance);
        this.vfx.SetVector3("CollisionPosition", this.destination.position);
    }

    [ContextMenu("shoot")]
    public void Shoot()
    {
        this.vfx.Play();
    }

    private void ShowExplosion()
    {
        var start = Instantiate(this.explosionPrefab, this.transform);
        start.transform.position = this.destination.position;
    }

    private void ShoeSpawnner()
    {
        var explosion = Instantiate(this.spawnPrefab, this.transform);
        explosion.transform.position = this.origin.position;
    }
}
