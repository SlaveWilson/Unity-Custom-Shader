using System;
using System.Collections;
using UnityEngine;
using Random = UnityEngine.Random;

public class HologramGlitcher : MonoBehaviour
{
    public float glitchChance = .1f;

    private Renderer _renderer;
    private WaitForSeconds _glitchLoopWait = new WaitForSeconds(.1f);
    private WaitForSeconds _glitchDuration = new WaitForSeconds(.1f);

    private void Awake()
    {
        _renderer = GetComponent<Renderer>();
    }

    private IEnumerator Start()
    {
        while (true)
        {
            float glitchTest = Random.Range(0f, 1f);

            if (glitchTest <= glitchChance)
            {
                StartCoroutine(Glitch());
            }
            yield return _glitchLoopWait;
        }
    }

    private IEnumerator Glitch()
    {
        _glitchDuration = new WaitForSeconds(Random.Range(.05f, .25f));
        _renderer.material.SetFloat("_Amount", 1f);
        _renderer.material.SetFloat("_CutoutThresh", .29f);
        _renderer.material.SetFloat("_Amplitude", Random.Range(20, 50));
        _renderer.material.SetFloat("_Speed", Random.Range(1, 10));
        yield return _glitchDuration;
        _renderer.material.SetFloat("_Amount", 0f);
        _renderer.material.SetFloat("_CutoutThresh", 0f);
    }
}
