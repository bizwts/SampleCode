package com.wings.wApp.adapter;

import com.wings.wApp.R;

import android.app.Activity;
import android.content.Context;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroup.LayoutParams;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.LinearLayout;

public class Product_Description_Adapter extends PagerAdapter {

	Activity myActivity;
	LayoutInflater mLayoutInflater;
	int product_image[];

	public Product_Description_Adapter(Activity activity, int[] product_img) {
		myActivity = activity;
		mLayoutInflater = (LayoutInflater) myActivity
				.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
		product_image = product_img;
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return product_image.length;
	}

	@Override
	public boolean isViewFromObject(View view, Object object) {
		// TODO Auto-generated method stub
		return view == ((LinearLayout) object);
	}

	@Override
	public Object instantiateItem(ViewGroup collection, int position) {
		/*
		 * ImageView view = new ImageView(myActivity); view.setLayoutParams(new
		 * LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.WRAP_CONTENT));
		 * view.setScaleType(ScaleType.FIT_XY);
		 * view.setBackgroundResource(product_image[position]); ((ViewPager)
		 * collection).addView(view, 0);
		 */
		View itemView = mLayoutInflater.inflate(R.layout.product_description_image_item,
				collection, false);

		ImageView imageView = (ImageView) itemView
				.findViewById(R.id.product_img);
		imageView.setImageResource(product_image[position]);

		collection.addView(itemView);

		return itemView;
	}
	
	@Override
	  public void destroyItem(ViewGroup container, int position, Object object) {
	   container.removeView((LinearLayout)object);
	  }
}
