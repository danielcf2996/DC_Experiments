using UnityEngine;
using DG.Tweening; // Make sure to import DOTween

public class Turntable : MonoBehaviour
{
    [SerializeField] private float speed = 10f;
    [SerializeField] private bool rotateX = false;
    [SerializeField] private bool rotateY = true;
    [SerializeField] private bool rotateZ = false;

    private float currentSpeed;  // Variable to store the current speed

    void Start()
    {
        currentSpeed = speed; // Store the initial speed
    }

    void Update()
    {
        float deltaSpeed = speed * Time.deltaTime;
        Vector3 rotation = new Vector3(
            rotateX ? deltaSpeed : 0f,
            rotateY ? deltaSpeed : 0f,
            rotateZ ? deltaSpeed : 0f
        );
        transform.Rotate(rotation);
    }

    // Method to tween the speed to zero in one second
    [ContextMenu("TweenSpeedToZero")]
    public void TweenSpeedToZero()
    {
        // Tween the current speed to zero over 1 second
        DOTween.To(() => speed, x => speed = x, 0f, 1f).OnStart(() => currentSpeed = speed); // Store current speed
    }

    // Method to restore the speed back to its original value in one second
    [ContextMenu("TweenSpeedToOne")]
    public void RestoreSpeed()
    {
        // Tween the speed back to the stored value (currentSpeed) over 1 second
        DOTween.To(() => speed, x => speed = x, currentSpeed, 1f);
    }
}
