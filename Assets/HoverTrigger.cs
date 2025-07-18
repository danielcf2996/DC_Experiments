using UnityEngine;

[RequireComponent(typeof(Collider))]
public class HoverTrigger : MonoBehaviour
{
    public Animator animator;
    public string hoveTriggerKey;
    public string unHoveTriggerKey;

    private void OnMouseEnter()
    {
        OnHover();
    }

    private void OnMouseExit()
    {
        OnHoverExit();
    }

    private void OnHover()
    {
        Debug.Log($"Hover with Key: {hoveTriggerKey}");
        if (animator != null)
        {
            animator.SetTrigger(hoveTriggerKey);
        }
    }

    private void OnHoverExit()
    {
        Debug.Log($"UnHover with Key: {unHoveTriggerKey}");
        if (animator != null)
        {
            animator.SetTrigger(unHoveTriggerKey);
        }
    }
}
