using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpookyStuff : MonoBehaviour {
    public enum Effects {none, jostle, eject}
    [SerializeField] Effects selected;
    [SerializeField] float duration = 1f;
    [SerializeField] float power = 1f;
    [SerializeField] float intensity =0.3f;
    Rigidbody me;
    Vector3 up;
    Vector3 transverse;

	// Use this for initialization
	void Start () {
        Transform tempTransform = this.gameObject.GetComponent<Transform>();
        me = this.gameObject.GetComponent<Rigidbody>();
        up = tempTransform.up;
        transverse = tempTransform.forward + tempTransform.right;
        StartCoroutine(Jostle());
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    IEnumerator Jostle(){
        float timer = 0f;
        float angle = 0f;
        while (timer < duration){
            angle = Random.Range(-1.0f, 1.0f);
            bonk(angle);
            yield return new WaitForSeconds(intensity);
            timer += intensity;
        }

    }

    void bonk(float angle){
        me.AddForce(power * up + angle * transverse,ForceMode.Impulse);
    }
}
