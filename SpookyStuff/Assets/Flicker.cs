using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Flicker : MonoBehaviour {
    struct Douple { public float intensity; public float range; }
    Light me;
    [SerializeField] [Range (0.001f, 1f)]float minFrequency;
    [SerializeField] [Range(0.001f, 1f)] float maxFrequency;
    [SerializeField] [Range(-1f, 1f)] float frequencyBias =0f;
    [SerializeField] float minIntensity;
    [SerializeField] float maxIntensity;
    [SerializeField] [Range(-1f, 1f)] float intensityBias = 0f;
    [SerializeField] float minRange;
    [SerializeField] float maxRange;
    [SerializeField] [Range(-1f, 1f)] float rangeBias = 0f;
    [SerializeField] List<Light> children;

    public bool on;
	// Use this for initialization
	void Start () {
        me = this.gameObject.GetComponent<Light>();
        StartCoroutine(Flick());
	}


    Douple Randomize(){
        Douple output;
        output.intensity = Random.Range(minIntensity, maxIntensity);
        output.intensity += (output.intensity * intensityBias);
        if (output.intensity > maxIntensity)
            output.intensity = maxIntensity;
        else if (output.intensity < minIntensity)
            output.intensity = minIntensity;
        output.range = Random.Range(minRange, maxRange);
        output.range += (output.range * intensityBias);
        if (output.range > maxRange)
            output.range = maxRange;
        else if (output.range < minRange)
            output.range = minRange;
        return output;
    }

    void SetAttributes(Light spookyLight, Douple input){
        spookyLight.intensity = input.intensity;
        spookyLight.range = input.range;
    }

    IEnumerator Flick(){
        float nextInterval;
        while (on){
            nextInterval = RandomInterval();
            Douple douple = Randomize();
            SetAttributes(me, douple);
            if (children.Count > 0){
                foreach (Light spookyLight in children){
                    SetAttributes(spookyLight, douple);
                }
            }
            yield return new WaitForSeconds(nextInterval);
        }
    }

    float RandomInterval(){
        float output = Random.Range(minFrequency, maxFrequency);
        output += output * frequencyBias;
        return output;
    }

}
