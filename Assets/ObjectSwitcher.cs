using UnityEngine;
using TMPro;
using System.Collections.Generic;

public class ObjectSwitcher : MonoBehaviour
{
    // List of GameObjects to switch between
    public List<GameObject> gameObjects;

    // Public property for selecting the index
    public int index;

    // Reference to the TMP Dropdown
    public TMP_Dropdown dropdown;

    void Start()
    {
        PopulateDropdown();
        SetObject(index); // Ensure initial object is set
    }

    // Populates the TMP_Dropdown with GameObject names
    private void PopulateDropdown()
    {
        if (dropdown == null)
            return; // Exit if no dropdown is assigned

        dropdown.ClearOptions(); // Clear existing options

        List<string> options = new List<string>();
        foreach (GameObject go in gameObjects)
        {
            options.Add(go.name);
        }

        dropdown.AddOptions(options);
        dropdown.value = index; // Set dropdown to match current index
        dropdown.onValueChanged.AddListener(SetObject); // Listen for selection changes
    }

    // Method to set the object by index
    public void SetObject(int newIndex)
    {
        if (newIndex >= 0 && newIndex < gameObjects.Count)
        {
            // Disable all GameObjects
            foreach (GameObject go in gameObjects)
            {
                go.SetActive(false);
            }

            // Enable the selected GameObject
            gameObjects[newIndex].SetActive(true);

            // Update the index
            index = newIndex;

            // Sync dropdown selection
            if (dropdown != null && dropdown.value != index)
            {
                dropdown.value = index;
            }
        }
        else
        {
            Debug.LogWarning("Index out of bounds: " + newIndex);
        }
    }

    // Overloaded method to set the object using the public 'index' property
    [ContextMenu("SetObject to Index")]
    public void SetObject()
    {
        SetObject(index);
    }
}
