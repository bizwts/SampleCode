package com.wings.wApp;

import android.app.Activity;
import android.os.Bundle;
import android.support.v4.view.ViewPager;
import android.view.View;
import android.view.Window;
import android.view.View.OnClickListener;
import android.widget.ImageView;
import android.widget.Toast;

import com.wings.wApp.adapter.CustomPagerAdapter;

public class ImagePager extends Activity {

	private CustomPagerAdapter mCustomPagerAdapter;
	private ViewPager mViewPager;
	int position;
	ImageView image_back;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		this.requestWindowFeature(Window.FEATURE_NO_TITLE);

		setContentView(R.layout.image_pager);
		position = (getIntent().getExtras().getInt("position"));
		image_back = (ImageView) findViewById(R.id.image_back);
		mCustomPagerAdapter = new CustomPagerAdapter(this);

		mViewPager = (ViewPager) findViewById(R.id.pager);
		mViewPager.setAdapter(mCustomPagerAdapter);
		Toast.makeText(getApplicationContext(), position + "",
				Toast.LENGTH_LONG).show();

		mViewPager.setCurrentItem(position);
		image_back.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				finish();
			}
		});
	}

}
