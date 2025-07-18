using UnityEngine;
using UnityEngine.EventSystems;

public class MouseDragRotate : MonoBehaviour
{
    public bool isDragging = false;
    public Vector3 initialMousePosition;
    public float initialRotationY;

    [SerializeField] private float rotationSpeed = 0.1f; // Speed of rotation
    [SerializeField] private float smoothFactor = 0.1f;  // Smoothing factor for the slerp (0 = no smoothing, 1 = full smoothing)

    public float mouseDeltaX;
    void Update()
    {
        // Check if mouse is pressed and dragging, but not over UI
        if (Input.GetMouseButtonDown(0) && !IsPointerOverUIObject())
        {
            StartDrag();
        }

        if (Input.GetMouseButton(0) && isDragging)
        {
            DragRotate();
        }

        if (Input.GetMouseButtonUp(0))
        {
            EndDrag();
        }
    }

    private void StartDrag()
    {
        Debug.Log("StartDrag");

        isDragging = true;
        initialMousePosition = Input.mousePosition; // Capture initial mouse position only once
        initialRotationY = transform.eulerAngles.y; // Store the initial Y rotation of the object
    }

    private void DragRotate()
    {
        // Calculate the difference in mouse position from the initial start position
         mouseDeltaX = Input.mousePosition.x - initialMousePosition.x;

        // Calculate the new Y rotation based on the mouse delta and the rotation speed
        float targetRotationY = (initialRotationY - mouseDeltaX) * rotationSpeed;

        // Smooth the rotation using Slerp for a fluid transition
        Quaternion targetRotation = Quaternion.Euler(0f, targetRotationY, 0f);
        //transform.rotation = Quaternion.Slerp(transform.rotation, targetRotation, smoothFactor);
        transform.rotation = targetRotation;


        // Optional: You can make this more fluid by compensating for mouse distance traveled and frame rate.
    }

    private void EndDrag()
    {
        Debug.Log("EndDrag");
        isDragging = false;
    }

    // Helper method to check if the mouse is over a UI element
    private bool IsPointerOverUIObject()
    {
        Debug.Log($"EventSystem.current.IsPointerOverGameObject = {EventSystem.current.IsPointerOverGameObject()}");
        return EventSystem.current.IsPointerOverGameObject();
    }
}
