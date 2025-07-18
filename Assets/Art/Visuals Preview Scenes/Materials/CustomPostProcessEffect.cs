using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class CustomPostProcessEffect : ScriptableRendererFeature
{
    public Material material;
    public Mesh mesh;

    private LensFlarePass _lensFlarePass;

    public override void Create()
    {
        this._lensFlarePass = new LensFlarePass(this.material, this.mesh);
        this._lensFlarePass.renderPassEvent = RenderPassEvent.AfterRenderingSkybox;
    }

    public override void AddRenderPasses(ScriptableRenderer renderer,
        ref RenderingData renderingData)
    {
        if (this.material != null && this.mesh != null)
        {
            renderer.EnqueuePass(this._lensFlarePass);
        }
    }

    private class LensFlarePass : ScriptableRenderPass
    {
        private readonly Material _material;
        private readonly Mesh _mesh;

        public LensFlarePass(Material material, Mesh mesh)
        {
            this._material = material;
            this._mesh = mesh;
        }

        public override void Execute(ScriptableRenderContext context,
            ref RenderingData renderingData)
        {
            var cmd = CommandBufferPool.Get("LensFlarePass");
            // Get the Camera data from the renderingData argument.
            var camera = renderingData.cameraData.camera;
            // Set the projection matrix so that Unity draws the quad in screen space
            cmd.SetViewProjectionMatrices(Matrix4x4.identity, Matrix4x4.identity);
            //cmd.DrawMesh(_mesh, Matrix4x4.identity, _material);
            cmd.DrawMesh(this._mesh, Matrix4x4.identity, this._material, 0, 0);

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
        }
    }
}
