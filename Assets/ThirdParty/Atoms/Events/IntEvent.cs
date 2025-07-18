using System.Collections.Generic;
using UnityEngine;

namespace ObitusGames.Atoms
{
    [CreateAssetMenu(menuName = "ScriptableObjects/GameEventInt", fileName = "GameEventInt")]
    public class IntEvent : ScriptableObject
    {
        private readonly List<IntEventListener> listeners = new List<IntEventListener>();

        public void Raise(int value)
        {
            for (var i = listeners.Count - 1; i >= 0; i--)
                listeners[i].OnEventRaised(value);
        }

        public void RegisterListener(IntEventListener listener)
        {
            if (!listeners.Contains(listener))
                listeners.Add(listener);
        }

        public void UnregisterListener(IntEventListener listener)
        {
            if (listeners.Contains(listener))
                listeners.Remove(listener);
        }
    }
}