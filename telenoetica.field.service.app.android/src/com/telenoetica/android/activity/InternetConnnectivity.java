package com.telenoetica.android.activity;

import android.app.Activity;
import android.content.Context;
import android.net.ConnectivityManager;
import android.widget.Toast;

public class InternetConnnectivity extends Activity {
	
	public void  checkNetworkStatus(){

	    final ConnectivityManager connMgr = (ConnectivityManager)
	     this.getSystemService(Context.CONNECTIVITY_SERVICE);

	     final android.net.NetworkInfo wifi =
	     connMgr.getNetworkInfo(ConnectivityManager.TYPE_WIFI);

	     final android.net.NetworkInfo mobile =
	     connMgr.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);

	     if( wifi.isAvailable() ){

	     Toast.makeText(this, "Wifi" , Toast.LENGTH_LONG).show();
	     }
	     else if( mobile.isAvailable() ){

	     Toast.makeText(this, "Mobile 3G " , Toast.LENGTH_LONG).show();
	     }
	     else
	     {

	         Toast.makeText(this, "No Network " , Toast.LENGTH_LONG).show();
	     }

	}
}