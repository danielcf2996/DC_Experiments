using UnityEngine;
using UnityEngine.Events;

namespace ObitusGames.Atoms
{
    public class IntEventListener : MonoBehaviour
    {
        public IntEvent intEvent;
        public UnityEvent<int> onEventRaised;

        private void OnEnable()
        {
            intEvent.RegisterListener(this);
        }

        private void OnDisable()
        {
            intEvent.UnregisterListener(this);
        }

        public void OnEventRaised(int value)
        {
            onEventRaised.Invoke(value);
        }
    }
}