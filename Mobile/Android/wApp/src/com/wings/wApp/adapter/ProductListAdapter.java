package com.wings.wApp.adapter;

import java.util.ArrayList;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.wings.wApp.R;
import com.wings.wApp.model.ProductModel;

public class ProductListAdapter extends BaseAdapter {

	private Context context;
	private ArrayList<ProductModel> arlstProductModel;

	public ProductListAdapter(Context context,
			ArrayList<ProductModel> arlstProductModel) {
		this.context = context;
		this.arlstProductModel = arlstProductModel;
	}

	@Override
	public int getCount() {
		return arlstProductModel.size();
	}

	@Override
	public Object getItem(int position) {
		return arlstProductModel.get(position);
	}

	@Override
	public long getItemId(int position) {
		return position;
	}

	@Override
	public View getView(int position, View convertView, ViewGroup parent) {
		if (convertView == null) {
			LayoutInflater mInflater = (LayoutInflater) context
					.getSystemService(Activity.LAYOUT_INFLATER_SERVICE);
			convertView = mInflater.inflate(R.layout.productlist_row, null);
		}

		ImageView imgIcon = (ImageView) convertView
				.findViewById(R.id.iv_product_icon);
		TextView txtTitle = (TextView) convertView
				.findViewById(R.id.tv_product_name);

		imgIcon.setImageResource(arlstProductModel.get(position)
				.getProductIcon());
		txtTitle.setText(arlstProductModel.get(position).getProductName());
		return convertView;
	}
}
