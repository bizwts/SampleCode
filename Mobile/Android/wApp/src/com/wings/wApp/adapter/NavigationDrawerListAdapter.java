package com.wings.wApp.adapter;

import android.app.Activity;
import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.wings.wApp.R;

public class NavigationDrawerListAdapter extends BaseAdapter {

	private Context context;
	private int[] navDrawerIcons;
	private String[] navDrawerItems;
	private ListView mDrawerList;
	private int[] valueshovericons;

	public NavigationDrawerListAdapter(Context context, ListView mDrawerList,
			int[] navDrawerIcons, int[] valueshovericons,
			String[] navDrawerItems) {
		this.context = context;
		this.navDrawerIcons = navDrawerIcons;
		this.valueshovericons = valueshovericons;
		this.mDrawerList = mDrawerList;
		this.navDrawerItems = navDrawerItems;
	}

	@Override
	public int getCount() {
		return navDrawerItems.length;
	}

	@Override
	public Object getItem(int position) {
		return navDrawerItems[position];
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
			convertView = mInflater.inflate(R.layout.drawer_list_item, null);
		}

		ImageView imgIcon = (ImageView) convertView
				.findViewById(R.id.ic_drawerlist);
		TextView txtTitle = (TextView) convertView
				.findViewById(R.id.tv_drawerlist);

		if (mDrawerList.isItemChecked(position)) {
			imgIcon.setImageResource(valueshovericons[position]);
			txtTitle.setTextColor(Color.parseColor("#4268e4"));
		} else {
			imgIcon.setImageResource(navDrawerIcons[position]);
			txtTitle.setTextColor(Color.parseColor("#a4a4a4"));
		}

		txtTitle.setText(navDrawerItems[position]);

		return convertView;
	}
}
