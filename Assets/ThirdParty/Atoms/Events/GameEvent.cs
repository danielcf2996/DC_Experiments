using System.Collections.Generic;
using UnityEngine;

namespace ObitusGames.Atoms
{
    [CreateAssetMenu(menuName = "ScriptableObjects/GameEvent", fileName = "GameEvent")]
    public class GameEvent : ScriptableObject
    {
        private List<GameEventListener> listeners = new List<GameEventListener>();
        
        [ContextMenu("Raise")]
        public void Raise()
        {
            for (var i = listeners.Count - 1; i >= 0; i--)
                listeners[i].OnEventRaised();
        }

        public void RegisterListener(GameEventListener listener)
        {
            if (!listeners.Contains(listener))
                listeners.Add(listener);
        }

        public void UnregisterListener(GameEventListener listener)
        {
            if (listeners.Contains(listener))
                listeners.Remove(listener);
        }
    }
}