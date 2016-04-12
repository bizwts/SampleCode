package com.wings.wApp;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.DatePickerDialog.OnDateSetListener;
import android.app.ProgressDialog;
import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
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
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.wings.wApp.globals.Constant;
import com.wings.wApp.globals.Function;
import com.wings.wApp.globals.GlobalMethods;

public class Register_Screen extends Activity {

	private ImageView registerback;
	private EditText et_bday;
	private DatePickerDialog BirthDatePickerDialog;
	private SimpleDateFormat dateFormatter;
	private Button buttonregister;
	private EditText et_username;
	private EditText et_emailaddress;
	private EditText et_password;
	private ProgressDialog pd;
	private String APIKeymd5;
	private SharedPreferences sharedpreferences;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.register_screen);

		sharedpreferences = getSharedPreferences("preference", 0);

		APIKeymd5 = Constant.APIKey;
		dateFormatter = new SimpleDateFormat("dd-MM-yyyy");

		registerback = (ImageView) findViewById(R.id.registerback);
		registerback.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				finish();
			}
		});

		et_username = (EditText) findViewById(R.id.et_username);
		et_emailaddress = (EditText) findViewById(R.id.et_emailaddress);
		et_password = (EditText) findViewById(R.id.et_password);

		et_bday = (EditText) findViewById(R.id.et_bday);
		et_bday.setInputType(InputType.TYPE_NULL);

		et_username.setCompoundDrawables(GlobalMethods.setCompoundDrawable(
				this, R.drawable.usernamehover), null, null, null);
		et_emailaddress.setCompoundDrawables(
				GlobalMethods.setCompoundDrawable(this, R.drawable.emailhover),
				null, null, null);
		et_password.setCompoundDrawables(GlobalMethods.setCompoundDrawable(
				this, R.drawable.passworhover), null, null, null);
		et_bday.setCompoundDrawables(GlobalMethods.setCompoundDrawable(this,
				R.drawable.calenderhover), null, null, null);

		et_username.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_username.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_username.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_emailaddress.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_emailaddress.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_emailaddress.setTextColor(Color.parseColor("#a4a4a4"));
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

		et_bday.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_bday.setTextColor(Color.parseColor("#4268e4"));
					BirthDatePickerDialog.show();
				} else {
					et_bday.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_bday.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				BirthDatePickerDialog.show();
			}
		});

		Calendar newCalendar = Calendar.getInstance();

		BirthDatePickerDialog = new DatePickerDialog(this,
				new OnDateSetListener() {

					public void onDateSet(DatePicker view, int year,
							int monthOfYear, int dayOfMonth) {
						Calendar newDate = Calendar.getInstance();
						newDate.set(year, monthOfYear, dayOfMonth);
						et_bday.setText(dateFormatter.format(newDate.getTime()));
					}

				}, newCalendar.get(Calendar.YEAR), newCalendar
						.get(Calendar.MONTH), newCalendar
						.get(Calendar.DAY_OF_MONTH));

		buttonregister = (Button) findViewById(R.id.buttonregister);
		buttonregister.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (checkEditText(et_username) && checkEditText(et_password)
						&& checkEditText(et_emailaddress)) {
					if (isNetworkAvailable()) {
						showProgress();
						new WsPass(et_username.getText().toString(),
								et_emailaddress.getText().toString(),
								et_password.getText().toString()).execute(null,
								null, null);
						Log.e("Api", APIKeymd5);
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
	}

	private boolean isNetworkAvailable() {
		ConnectivityManager connectivityManager = (ConnectivityManager) getSystemService(this.CONNECTIVITY_SERVICE);
		NetworkInfo activeNetworkInfo = connectivityManager
				.getActiveNetworkInfo();
		return activeNetworkInfo != null && activeNetworkInfo.isConnected();
	}

	public void showProgress() {
		pd = new ProgressDialog(this);
		pd.setMessage("Registering User..");
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

	class WsPass extends AsyncTask<Void, Void, String> {

		private String name;
		private String email;
		private String password;

		public WsPass(String name, String email, String password) {
			// TODO Auto-generated constructor stub
			this.name = name;
			this.email = email;
			this.password = password;
		}

		@Override
		protected String doInBackground(Void... params) {

			// return callPass();
			String data = "";

			JSONObject json = new JSONObject();
			try {
				json.put("userid", name);
				json.put("email", email);
				json.put("password", password);
				json.put("apikey", APIKeymd5);

				Log.e("json object", String.valueOf(json.toString()));

				data = Function.postJson(Constant.userSignUp, json);
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

				Toast.makeText(Register_Screen.this,
						GlobalMethods.SendCode(code), Toast.LENGTH_LONG).show();

				dismissProgress();
				if (code.equals("661")) {
					JSONObject userObject = jsonObject.getJSONObject("user");
					SharedPreferences.Editor editor = sharedpreferences.edit();
					editor.putString("userid",
							String.valueOf(userObject.getString("id")));
					editor.putString("username",
							String.valueOf(userObject.getString("userid")));
					editor.commit();
					Intent i = new Intent(Register_Screen.this,
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
}
