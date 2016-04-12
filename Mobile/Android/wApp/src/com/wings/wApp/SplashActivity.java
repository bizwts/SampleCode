package com.wings.wApp;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.location.Location;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.Window;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.common.api.GoogleApiClient.ConnectionCallbacks;
import com.google.android.gms.common.api.GoogleApiClient.OnConnectionFailedListener;
import com.google.android.gms.location.LocationListener;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationServices;

public class SplashActivity extends Activity implements ConnectionCallbacks,
		OnConnectionFailedListener, LocationListener {

	ProgressBar progressBar;
	int progressStatus = 0;
	Handler handler = new Handler();
	private SharedPreferences sharedpreferences;
	private String userid;
	private GoogleApiClient mGoogleApiClient;
	private LocationRequest mLocationRequest;
	private Location mLastLocation;
	private static int UPDATE_INTERVAL = 10000; // 10 sec
	private static int FATEST_INTERVAL = 5000; // 5 sec
	private static int DISPLACEMENT = 10; // 10 meters
	private final static int PLAY_SERVICES_RESOLUTION_REQUEST = 1000;
	private boolean mRequestingLocationUpdates = false;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);

		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);

		if (checkPlayServices()) {

			// Building the GoogleApi client
			buildGoogleApiClient();

			createLocationRequest();
		}

		sharedpreferences = getApplicationContext().getSharedPreferences(
				"preference", 0);
		userid = sharedpreferences.getString("userid", "");

		displayLocation();

		if (userid != null && !userid.equals("")) {
			Intent i = new Intent(SplashActivity.this, HomeActivity.class);
			startActivity(i);
			finish();
		} else {
			progressBar = (ProgressBar) findViewById(R.id.splash_loader);

			new Thread(new Runnable() {
				public void run() {
					while (progressStatus < 100) {
						progressStatus += 50;
						handler.post(new Runnable() {
							public void run() {
								progressBar.setProgress(progressStatus);
							}
						});
						try {
							Thread.sleep(1000);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
					}
					if (progressStatus >= 100) {
						Intent i = new Intent(SplashActivity.this,
								Login_Screen1.class);
						startActivity(i);
						finish();
					}
				}
			}).start();
		}
	}

	private void displayLocation() {

		mLastLocation = LocationServices.FusedLocationApi
				.getLastLocation(mGoogleApiClient);

		if (mLastLocation != null) {
			double latitude = mLastLocation.getLatitude();
			double longitude = mLastLocation.getLongitude();

			// Toast.makeText(SplashActivity.this, latitude + " " + longitude,
			// Toast.LENGTH_LONG).show();
			SharedPreferences.Editor editor = sharedpreferences.edit();
			editor.putString("latitude", String.valueOf(latitude));
			editor.putString("longitude", String.valueOf(longitude));
			editor.commit();
			// lblLocation.setText(latitude + ", " + longitude);

		} else {

			SharedPreferences.Editor editor = sharedpreferences.edit();
			editor.putString("latitude", String.valueOf(0.0));
			editor.putString("longitude", String.valueOf(0.0));
			editor.commit();
			// lblLocation
			// .setText("(Couldn't get the location. Make sure location is enabled on the device)");
		}
	}

	protected synchronized void buildGoogleApiClient() {
		mGoogleApiClient = new GoogleApiClient.Builder(this)
				.addConnectionCallbacks(this)
				.addOnConnectionFailedListener(this)
				.addApi(LocationServices.API).build();
	}

	protected void startLocationUpdates() {
		LocationServices.FusedLocationApi.requestLocationUpdates(
				mGoogleApiClient, mLocationRequest, this);
	}

	protected void stopLocationUpdates() {
		LocationServices.FusedLocationApi.removeLocationUpdates(
				mGoogleApiClient, this);
	}

	protected void createLocationRequest() {
		mLocationRequest = new LocationRequest();
		mLocationRequest.setInterval(UPDATE_INTERVAL);
		mLocationRequest.setFastestInterval(FATEST_INTERVAL);
		mLocationRequest.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
		mLocationRequest.setSmallestDisplacement(DISPLACEMENT);
	}

	private boolean checkPlayServices() {
		int resultCode = GooglePlayServicesUtil
				.isGooglePlayServicesAvailable(this);
		if (resultCode != ConnectionResult.SUCCESS) {
			if (GooglePlayServicesUtil.isUserRecoverableError(resultCode)) {
				GooglePlayServicesUtil.getErrorDialog(resultCode, this,
						PLAY_SERVICES_RESOLUTION_REQUEST).show();
			} else {
				Toast.makeText(getApplicationContext(), "No GPS Supported",
						Toast.LENGTH_LONG).show();

				// finish();
			}
			return false;
		}
		return true;
	}

	@Override
	protected void onStart() {
		super.onStart();
		if (mGoogleApiClient != null) {
			mGoogleApiClient.connect();
		}
	}

	@Override
	protected void onResume() {
		super.onResume();
		checkPlayServices();
	}

	@Override
	protected void onStop() {
		super.onStop();
		if (mGoogleApiClient.isConnected()) {
			mGoogleApiClient.disconnect();
		}
	}

	@Override
	protected void onPause() {
		super.onPause();
	}

	@Override
	public void onLocationChanged(Location arg0) {
		// TODO Auto-generated method stub
		mLastLocation = arg0;

		// Toast.makeText(getApplicationContext(), "Location changed!",
		// Toast.LENGTH_SHORT).show();

		Log.e("Location", "Location changed!");

		// Displaying the new location on UI
		displayLocation();
	}

	@Override
	public void onConnectionFailed(ConnectionResult arg0) {
		// TODO Auto-generated method stub
		Log.i("splash", "Connection failed: ConnectionResult.getErrorCode() = "
				+ arg0.getErrorCode());
	}

	@Override
	public void onConnected(Bundle arg0) {
		// TODO Auto-generated method stub
		displayLocation();

		if (mRequestingLocationUpdates) {
			startLocationUpdates();
		}
	}

	@Override
	public void onConnectionSuspended(int arg0) {
		// TODO Auto-generated method stub
		mGoogleApiClient.connect();
	}
}
