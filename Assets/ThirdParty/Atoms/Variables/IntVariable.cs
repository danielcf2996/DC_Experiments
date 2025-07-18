using UnityEngine;

namespace ObitusGames.Atoms
{
    [CreateAssetMenu(menuName = "ScriptableObjects/IntVariable", fileName = "IntVariable")]
    public class IntVariable : ScriptableObject
    {

        public int value;

        public IntEvent onValueChanged;

        public void SetValue(int value)
        {
            this.value = value;
            onValueChanged?.Raise(value);
        }

        [ContextMenu("Raise Event")]
        public void RaiseEvent()
        {
            onValueChanged?.Raise(value);
        }
    }
}