using UnityEngine;
using UnityEngine.Events;

namespace ObitusGames.Atoms
{
    public class GameEventListener : MonoBehaviour
    {
        public GameEvent gameEvent;

        public UnityEvent onEventRaised;

        private void OnEnable()
        {
            gameEvent.RegisterListener(this);
        }

        private void OnDisable()
        {
            gameEvent.UnregisterListener(this);
        }

        public void OnEventRaised()
        {
            onEventRaised.Invoke();
        }
    }
}