package com.wings.wApp.globals;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.drawable.Drawable;
import android.location.LocationListener;
import android.location.LocationManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

public class GlobalMethods {
	private static LocationManager locationManager;
	static LocationListener locationListener;
	private static String latlong;
	private static SharedPreferences sharedpreferences;

	public static final String md5(final String s) {
		final String MD5 = "MD5";
		try {
			// Create MD5 Hash
			MessageDigest digest = java.security.MessageDigest.getInstance(MD5);
			digest.update(s.getBytes());
			byte messageDigest[] = digest.digest();

			// Create Hex String
			StringBuilder hexString = new StringBuilder();
			for (byte aMessageDigest : messageDigest) {
				String h = Integer.toHexString(0xFF & aMessageDigest);
				while (h.length() < 2)
					h = "0" + h;
				hexString.append(h);
			}
			return hexString.toString();

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return "";
	}

	public static final Drawable setCompoundDrawable(Activity activity,
			int drawable) {
		Drawable img = activity.getResources().getDrawable(drawable);
		img.setBounds(0, 0, 35, 35);
		return img;
	}

	public static final String SendCode(String code) {
		if (code.equals("1111")) {
			return "Invalid API Key, Please Provide Valid key.";
		} else if (code.equals("999")) {
			return "User Already Registered";
		} else if (code.equals("998")) {
			return "Email Already Registered";
		} else if (code.equals("997")) {
			return "Invalid Password. Atleast 6 Characters needed";
		} else if (code.equals("996")) {
			return "Invalid Email Address";
		} else if (code.equals("995")) {
			return "Incorrect Email or Password";
		} else if (code.equals("994")) {
			return "No User Found";
		} else if (code.equals("660")) {
			return "Welcome to wApp";
		} else if (code.equals("661")) {
			return "Registration Success";
		}
		return code;
	}

	// for check internet connection in device
	public static final boolean isNetworkConnection(final Activity activity) {
		ConnectivityManager connectivity = (ConnectivityManager) activity
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		if (connectivity != null) {
			NetworkInfo[] info = connectivity.getAllNetworkInfo();
			if (info != null)
				for (int i = 0; i < info.length; i++)
					if (info[i].getState() == NetworkInfo.State.CONNECTED) {
						return true;
					}
		}
		/*
		 * else {
		 */
		AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
				activity);
		alertDialogBuilder
				.setMessage(
						"Internet Connection is Disabled, Would you like to Enable it?")
				.setCancelable(false)
				.setPositiveButton("Enable Wifi",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog, int id) {
								Intent callWifiSettingIntent = new Intent(
										android.provider.Settings.ACTION_WIFI_SETTINGS);
								activity.startActivity(callWifiSettingIntent);
							}
						});
		alertDialogBuilder.setNeutralButton("Enable Data Connection",
				new DialogInterface.OnClickListener() {

					@Override
					public void onClick(DialogInterface dialog, int which) {
						// TODO Auto-generated method stub

						Intent callDataConnectionSettingIntent = new Intent(
								Intent.ACTION_MAIN);
						callDataConnectionSettingIntent
								.setComponent(new ComponentName(
										"com.android.settings",
										"com.android.settings.Settings$DataUsageSummaryActivity"));
						callDataConnectionSettingIntent
								.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK
										| Intent.FLAG_ACTIVITY_CLEAR_TOP);
						activity.startActivity(callDataConnectionSettingIntent);
					}
				});
		alertDialogBuilder.setNegativeButton("Cancel",
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int id) {
						dialog.cancel();
					}
				});
		AlertDialog alert = alertDialogBuilder.create();
		alert.show();
		/*
		 * return false; }
		 */
		return false;

	}

	// check for GPS is enaable or not
	public static boolean showGPSConnection(final Activity activity) {
		locationManager = (LocationManager) activity.getApplicationContext()
				.getSystemService(Context.LOCATION_SERVICE);
		if (locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
			return true;
		} else {

			AlertDialog.Builder alertDialogBuilder = new AlertDialog.Builder(
					activity);
			alertDialogBuilder
					.setMessage("GPS is Disabled, Would you like to Enable it?")
					.setCancelable(false)
					.setPositiveButton("Goto Settings and Enable GPS",
							new DialogInterface.OnClickListener() {
								public void onClick(DialogInterface dialog,
										int id) {
									Intent callGPSSettingIntent = new Intent(
											android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS);
									activity.startActivity(callGPSSettingIntent);
								}
							});
			alertDialogBuilder.setNegativeButton("Cancel",
					new DialogInterface.OnClickListener() {
						public void onClick(DialogInterface dialog, int id) {
							dialog.cancel();
						}
					});
			AlertDialog alert = alertDialogBuilder.create();
			alert.show();
			return false;
		}

	}

	public static String getCurrentLocation(Activity activity) {
		sharedpreferences = activity.getSharedPreferences("preference", 0);
		String latitude = sharedpreferences.getString("latitude", "");
		String longitude = sharedpreferences.getString("longitude", "");
		return latitude + "," + longitude;
	}
}
