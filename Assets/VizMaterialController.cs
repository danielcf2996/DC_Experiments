using UnityEngine;
using UnityEngine.UI; // For referencing the Slider UI element

public class VizMaterialController : MonoBehaviour
{
    // Reference to the UI Slider
    public Slider slider;

    // The name of the global shader property
    public string shaderPropertyName = "_CutOutPosRef";

    void Start()
    {
        // Check if the slider is assigned in the Inspector
        if (slider != null)
        {
            // Add a listener to detect slider value changes
            slider.onValueChanged.AddListener(UpdateShaderProperty);
        }
        else
        {
            Debug.LogWarning("Slider reference not set in the VizMaterialController.");
        }

        SetShaderPropertyToZero();
    }

    // Method to update the global shader property based on slider value
    void UpdateShaderProperty(float sliderValue)
    {
        // Set the global shader property using the slider's value
        Debug.Log("Update shader?");
        Shader.SetGlobalFloat(shaderPropertyName, sliderValue);
    }

    [ContextMenu("SetShaderPropertyToOne")]
    public void SetShaderPropertyToOne()
    {
        // Set the global shader property using the slider's value
        Debug.Log("Update shader?");
        Shader.SetGlobalFloat(shaderPropertyName, 1);
    }

    [ContextMenu("SetShaderPropertyToZero")]
    public void SetShaderPropertyToZero()
    {
        // Set the global shader property using the slider's value
        Debug.Log("Update shader?");
        Shader.SetGlobalFloat(shaderPropertyName, 0);
    }

    // Optionally, you can remove the listener when the object is destroyed
    void OnDestroy()
    {
        if (slider != null)
        {
            slider.onValueChanged.RemoveListener(UpdateShaderProperty);
        }
    }
}
