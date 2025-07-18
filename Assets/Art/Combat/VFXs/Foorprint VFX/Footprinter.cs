using UnityEngine;

public class Footprinter : MonoBehaviour
{
    public GameObject footprintPrefab; // The prefab for the footprint


    private void Start()
    {
        Debug.unityLogger.logEnabled = true;
        Debug.Log("start");
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log("collided with " + other.name);

        if (other.CompareTag("Floor"))
        {
            Debug.Log("collided with " + other.name);
            // Get the floor transform
            var floorTransform = other.transform;

            // Calculate the footprint position
            var footprintPosition = new Vector3(this.transform.position.x, floorTransform.position.y + .01f,
                this.transform.position.z);

            // Instantiate the footprint at the calculated position
            var footprint = Instantiate(this.footprintPrefab, footprintPosition, Quaternion.identity);

            // Align the footprint's rotation
            // Create a rotation that aligns the footprint's right and up vectors with the floor's right and up vectors
            var footprintRotation = Quaternion.LookRotation(this.transform.forward, floorTransform.up);

            // Apply the rotation to the footprint
            footprint.transform.rotation = footprintRotation;
        }
    }
}
