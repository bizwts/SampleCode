package com.wings.wApp;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.drawable.Drawable;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.InputType;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.Window;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.wings.wApp.globals.Constant;
import com.wings.wApp.globals.Function;
import com.wings.wApp.globals.GlobalMethods;

public class Login_Screen1 extends Activity {

	private TextView tv_register;
	private String APIKeymd5;
	private EditText et_password;
	private Button buttonlogin;
	private ProgressDialog pd;
	private EditText et_useremail;
	private SharedPreferences sharedpreferences;
	private TextView tv_password;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);

		super.onCreate(savedInstanceState);
		setContentView(R.layout.login_screen1);
		sharedpreferences = getSharedPreferences("preference", 0);

		APIKeymd5 = Constant.APIKey;

		et_useremail = (EditText) findViewById(R.id.et_useremail);
		et_password = (EditText) findViewById(R.id.et_password);
		tv_password = (TextView) findViewById(R.id.tv_password);

		et_useremail.setCompoundDrawables(
				GlobalMethods.setCompoundDrawable(this, R.drawable.emailhover),
				null, null, null);

		et_password.setCompoundDrawables(GlobalMethods.setCompoundDrawable(
				this, R.drawable.passworhover), null, null, null);

		et_useremail.setText("siraj.s@wings.com");
		et_password.setText("sirajwings");

		et_useremail.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_useremail.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_useremail.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_password.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_password.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_password.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		tv_password.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				// String latlong = GlobalMethods
				// .getCurrentLocation(Login_Screen1.this);
				//
				// if (latlong.equals("0.0,0.0") || latlong.equals("")) {
				// Toast.makeText(Login_Screen1.this, "No Location Available",
				// Toast.LENGTH_LONG).show();
				// } else {
				// Toast.makeText(Login_Screen1.this, latlong,
				// Toast.LENGTH_LONG).show();
				// }

			}
		});

		buttonlogin = (Button) findViewById(R.id.buttonlogin);
		tv_register = (TextView) findViewById(R.id.tv_register);
		buttonlogin.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

				if (checkEditText(et_useremail) && checkEditText(et_password)) {
					if (isNetworkAvailable()) {
						showProgress();
						new WsPass(et_useremail.getText().toString(),
								et_password.getText().toString()).execute(null,
								null, null);
						// Log.e("Api", APIKeymd5);
					} else {
						Toast.makeText(getApplicationContext(),
								"No Internet Connection", Toast.LENGTH_LONG)
								.show();
					}
				} else {
					Toast.makeText(getApplicationContext(),
							"Please enter details", Toast.LENGTH_LONG).show();
				}
			}
		});

		tv_register.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent i = new Intent(Login_Screen1.this, Register_Screen.class);
				startActivity(i);
			}
		});
	}

	private boolean isNetworkAvailable() {
		ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(this.CONNECTIVITY_SERVICE);
		NetworkInfo activeNetworkInfo = connectivityManager
				.getActiveNetworkInfo();
		return activeNetworkInfo != null && activeNetworkInfo.isConnected();
	}

	class WsPass extends AsyncTask<Void, Void, String> {

		private String email;
		private String password;

		public WsPass(String email, String password) {
			// TODO Auto-generated constructor stub
			this.email = email;
			this.password = password;
		}

		@Override
		protected String doInBackground(Void... params) {

			// return callPass();
			String data = "";

			JSONObject json = new JSONObject();
			try {

				json.put("email", email);
				json.put("password", password);
				json.put("apikey", APIKeymd5);

				Log.e("json object", String.valueOf(json.toString()));

				data = Function.postJson(Constant.userSignIn, json);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return data;
		}

		@Override
		protected void onPreExecute() {
			// showProgress();
			super.onPreExecute();
		}

		@Override
		protected void onPostExecute(String result) {

			super.onPostExecute(result);
			// dismissProgress();

			try {
				JSONObject jsonObject = new JSONObject(result);
				boolean resultFav = jsonObject.getBoolean("success");

				JSONObject errorObject = jsonObject.getJSONObject("error");
				String message = errorObject.getString("message");
				String code = errorObject.getString("code");

				Toast.makeText(Login_Screen1.this,
						GlobalMethods.SendCode(code), Toast.LENGTH_LONG).show();

				dismissProgress();

				if (code.equals("660")) {
					JSONObject userObject = jsonObject.getJSONObject("user");
					SharedPreferences.Editor editor = sharedpreferences.edit();
					editor.putString("userid",
							String.valueOf(userObject.getString("id")));
					editor.putString("username",
							String.valueOf(userObject.getString("userid")));
					editor.commit();
					Intent i = new Intent(Login_Screen1.this,
							HomeActivity.class);
					startActivity(i);
					finish();
				} else {
					// do nothing
				}

			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public void showProgress() {
		pd = new ProgressDialog(this);
		pd.setMessage("Logging User In..");
		pd.setCancelable(false);
		pd.show();
	}

	public void dismissProgress() {
		pd.dismiss();
	}

	public static boolean checkEditText(EditText edittext) {
		if (edittext.getText().toString().matches("")) {
			return false;
		}
		return true;
	}
}
