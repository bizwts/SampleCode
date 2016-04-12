package com.wings.wApp.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.wings.wApp.R;
import com.wings.wApp.globals.Constant;

public class ImageAdapter extends BaseAdapter {

	Context act;
	public String typeoflist;

	public ImageAdapter(Context context, String type) {

		this.act = context;
		this.typeoflist = type;
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return Constant.IMAGES.length;
	}

	@Override
	public Object getItem(int position) {
		// TODO Auto-generated method stub
		return Constant.IMAGES[position];
	}

	@Override
	public long getItemId(int position) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		// TODO Auto-generated method stub
		if (convertView == null) {
			LayoutInflater mInflater = (LayoutInflater) act
					.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
			if (typeoflist.equals("list")) {
				convertView = mInflater.inflate(R.layout.image_row_list, null);

			} else if (typeoflist.equals("grid")) {
				convertView = mInflater.inflate(R.layout.image_row_grid, null);

			}

			ImageView iv_viewimage = (ImageView) convertView
					.findViewById(R.id.iv_viewimage);
			iv_viewimage.setImageResource(Constant.IMAGES[position]);
			TextView tv_text = (TextView) convertView
					.findViewById(R.id.tv_itemname);
			tv_text.setText("Item" + position);
		}
		return convertView;
	}
}
