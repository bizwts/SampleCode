package com.wings.wApp;

import com.wings.wApp.adapter.Product_Description_Adapter;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.view.ViewPager;

public class ProductDesc_Activity extends Activity {

	private int imageProduct[] = { R.drawable.product_one,
			R.drawable.product_five, R.drawable.product_six,
			R.drawable.product_four, };

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		setContentView(R.layout.productdesc_act);

		Product_Description_Adapter adapter = new Product_Description_Adapter(
				this, imageProduct);
		ViewPager myPager = (ViewPager) findViewById(R.id.productpager);
		myPager.setAdapter(adapter);
		myPager.setCurrentItem(0);
	}
}
