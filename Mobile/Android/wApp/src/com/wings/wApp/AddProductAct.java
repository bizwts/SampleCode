package com.wings.wApp;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.DatePickerDialog.OnDateSetListener;
import android.graphics.Color;
import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnFocusChangeListener;
import android.view.Window;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.Toast;

import com.wings.wApp.adapter.ProductListAdapter;
import com.wings.wApp.fragments.Fragment_Clothies;
import com.wings.wApp.globals.GlobalMethods;
import com.wings.wApp.model.ProductModel;

public class AddProductAct extends Activity {

	private EditText et_expiredate;
	private EditText et_manufacturedate;
	private SimpleDateFormat dateFormatter;
	private EditText et_product_name;
	private EditText et_product_description;
	private EditText et_product_model;
	private EditText et_product_price;
	private ImageView registerback;
	private DatePickerDialog ExpiredPickerDialog;
	Calendar newCalendar = Calendar.getInstance();
	private DatePickerDialog ManufacturePickerDialog;
	Button btnsend;
	// ArrayList<ProductModel> productModelList;
	private ProductListAdapter adapter;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);
		super.onCreate(savedInstanceState);
		setContentView(R.layout.add_product_screen);

		et_expiredate = (EditText) findViewById(R.id.et_expiredate);
		et_manufacturedate = (EditText) findViewById(R.id.et_manufacturedate);
		et_product_name = (EditText) findViewById(R.id.et_product_name);
		et_product_description = (EditText) findViewById(R.id.et_product_description);
		et_product_model = (EditText) findViewById(R.id.et_product_model);
		et_product_price = (EditText) findViewById(R.id.et_product_price);
		registerback = (ImageView) findViewById(R.id.registerback);

		btnsend = (Button) findViewById(R.id.buttonsend);
		// productModelList = new ArrayList<ProductModel>();

		dateFormatter = new SimpleDateFormat("dd-MM-yyyy");

		et_expiredate.setCompoundDrawables(GlobalMethods.setCompoundDrawable(
				this, R.drawable.calenderhover), null, null, null);
		et_manufacturedate.setCompoundDrawables(GlobalMethods
				.setCompoundDrawable(this, R.drawable.calenderhover), null,
				null, null);
		et_product_name.setCompoundDrawables(GlobalMethods.setCompoundDrawable(
				this, R.drawable.producthover), null, null, null);
		et_product_description.setCompoundDrawables(GlobalMethods
				.setCompoundDrawable(this, R.drawable.producthover), null,
				null, null);
		et_product_model.setCompoundDrawables(GlobalMethods
				.setCompoundDrawable(this, R.drawable.producthover), null,
				null, null);
		et_product_price.setCompoundDrawables(GlobalMethods
				.setCompoundDrawable(this, R.drawable.producthover), null,
				null, null);

		et_expiredate.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_expiredate.setTextColor(Color.parseColor("#4268e4"));
					ExpiredPickerDialog.show();
				} else {
					et_expiredate.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_manufacturedate
				.setOnFocusChangeListener(new OnFocusChangeListener() {

					@Override
					public void onFocusChange(View v, boolean hasFocus) {
						// TODO Auto-generated method stub
						if (hasFocus) {
							et_manufacturedate.setTextColor(Color
									.parseColor("#4268e4"));
							ManufacturePickerDialog.show();
						} else {
							et_manufacturedate.setTextColor(Color
									.parseColor("#a4a4a4"));
						}
					}
				});

		et_product_name.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_product_name.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_product_name.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_product_description
				.setOnFocusChangeListener(new OnFocusChangeListener() {

					@Override
					public void onFocusChange(View v, boolean hasFocus) {
						// TODO Auto-generated method stub
						if (hasFocus) {
							et_product_description.setTextColor(Color
									.parseColor("#4268e4"));
						} else {
							et_product_description.setTextColor(Color
									.parseColor("#a4a4a4"));
						}
					}
				});

		et_product_model.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_product_model.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_product_model.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		et_product_price.setOnFocusChangeListener(new OnFocusChangeListener() {

			@Override
			public void onFocusChange(View v, boolean hasFocus) {
				// TODO Auto-generated method stub
				if (hasFocus) {
					et_product_price.setTextColor(Color.parseColor("#4268e4"));
				} else {
					et_product_price.setTextColor(Color.parseColor("#a4a4a4"));
				}
			}
		});

		registerback.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				finish();
			}
		});

		et_expiredate.setInputType(InputType.TYPE_NULL);
		et_manufacturedate.setInputType(InputType.TYPE_NULL);

		et_expiredate.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				ExpiredPickerDialog.show();
			}
		});

		et_manufacturedate.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				ManufacturePickerDialog.show();
			}
		});

		ExpiredPickerDialog = new DatePickerDialog(this,
				new OnDateSetListener() {

					public void onDateSet(DatePicker view, int year,
							int monthOfYear, int dayOfMonth) {
						Calendar newDate = Calendar.getInstance();
						newDate.set(year, monthOfYear, dayOfMonth);
						et_expiredate.setText(dateFormatter.format(newDate
								.getTime()));
					}

				}, newCalendar.get(Calendar.YEAR),
				newCalendar.get(Calendar.MONTH),
				newCalendar.get(Calendar.DAY_OF_MONTH));

		ManufacturePickerDialog = new DatePickerDialog(this,
				new OnDateSetListener() {

					public void onDateSet(DatePicker view, int year,
							int monthOfYear, int dayOfMonth) {
						Calendar newDate = Calendar.getInstance();
						newDate.set(year, monthOfYear, dayOfMonth);
						et_manufacturedate.setText(dateFormatter.format(newDate
								.getTime()));
					}

				}, newCalendar.get(Calendar.YEAR),
				newCalendar.get(Calendar.MONTH),
				newCalendar.get(Calendar.DAY_OF_MONTH));
		btnsend.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				if (checkEditText(et_product_name)
						&& checkEditText(et_product_description)
						&& checkEditText(et_product_model)
						&& checkEditText(et_expiredate)
						&& checkEditText(et_manufacturedate)
						&& checkEditText(et_product_price)) {

					ProductModel productModel = new ProductModel(
							et_product_name.getText().toString(),
							R.drawable.ic_prodeuct_hover);

					productModel.setProduct_name(et_product_name.getText()
							.toString());
					productModel.setProduct_icon(R.drawable.ic_prodeuct_hover);
					productModel.setProduct_description(et_product_description
							.getText().toString());
					productModel.setProduct_model(et_product_model.getText()
							.toString());
					productModel.setProduct_expirydate(et_expiredate.getText()
							.toString());
					productModel.setManfacture_date(et_manufacturedate
							.getText().toString());
					productModel.setProduct_price(Integer
							.parseInt(et_product_price.getText().toString()));

					Fragment_Clothies.productModelList.add(productModel);

					Fragment_Clothies.adapter.notifyDataSetChanged();
					et_product_name.setText("");
					et_product_description.setText("");
					et_product_model.setText("");
					et_expiredate.setText("");
					et_manufacturedate.setText("");
					et_product_price.setText("");

					Toast.makeText(getApplicationContext(),
							"Product Added Successfully", Toast.LENGTH_SHORT)
							.show();
					finish();

				} else {
					Toast.makeText(getApplicationContext(),
							"Please enter details", Toast.LENGTH_LONG).show();
				}
			}
		});
	}

	public static boolean checkEditText(EditText edittext) {
		if (edittext.getText().toString().matches("")) {
			return false;
		}
		return true;
	}
}
