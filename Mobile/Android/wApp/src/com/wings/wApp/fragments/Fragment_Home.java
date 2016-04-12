package com.wings.wApp.fragments;

import java.util.ArrayList;

import android.app.Fragment;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

import com.baoyz.swipemenulistview.SwipeMenu;
import com.baoyz.swipemenulistview.SwipeMenuCreator;
import com.baoyz.swipemenulistview.SwipeMenuItem;
import com.baoyz.swipemenulistview.SwipeMenuListView;
import com.baoyz.swipemenulistview.SwipeMenuListView.OnMenuItemClickListener;
import com.baoyz.swipemenulistview.SwipeMenuListView.OnSwipeListener;
import com.wings.wApp.R;
import com.wings.wApp.adapter.ProductListAdapter;
import com.wings.wApp.model.ProductModel;

public class Fragment_Home extends Fragment {
	TextView tv_welcometext;
	private SwipeMenuListView mListView;
	String[] values = new String[] { "Product 1", "Product 2", "Product 3",
			"Product 4", "Product 5", "Product 6", "Product 7", "Product 8" };
	int[] valuesicons = new int[] { R.drawable.ic_product,
			R.drawable.ic_product, R.drawable.ic_product,
			R.drawable.ic_product, R.drawable.ic_product,
			R.drawable.ic_product, R.drawable.ic_product, R.drawable.ic_product };
	ArrayList<ProductModel> productModelList;
	private ProductListAdapter adapter;

	public Fragment_Home() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_home, container,
				false);

		mListView = (SwipeMenuListView) rootView.findViewById(R.id.listView);

		productModelList = new ArrayList<ProductModel>();

		for (int i = 0; i < values.length; i++) {
			productModelList.add(new ProductModel(values[i], valuesicons[i]));
		}

		adapter = new ProductListAdapter(getActivity(), productModelList);
		mListView.setAdapter(adapter);

		SwipeMenuCreator creator = new SwipeMenuCreator() {

			@Override
			public void create(SwipeMenu menu) {
				// create "open" item
				SwipeMenuItem openItem = new SwipeMenuItem(getActivity()
						.getApplicationContext());
				// set item background
				// openItem.setBackground(new ColorDrawable(Color.rgb(0xC9,
				// 0xC9,
				// 0xCE)));
				// // set item width
				// openItem.setWidth(dp2px(90));
				// // set item title
				// openItem.setTitle("Edit");
				// // set item title fontsize
				// openItem.setTitleSize(18);
				// // set item title font color
				// openItem.setTitleColor(Color.BLACK);

				openItem.setBackground(new ColorDrawable(Color.rgb(0xC9, 0xC9,
						0xCE)));
				// set item width
				openItem.setWidth(dp2px(90));
				// set a icon
				openItem.setIcon(R.drawable.ic_home_hover);

				// add to menu
				menu.addMenuItem(openItem);

				// create "delete" item
				SwipeMenuItem deleteItem = new SwipeMenuItem(getActivity()
						.getApplicationContext());
				// set item background
				deleteItem.setBackground(new ColorDrawable(Color.rgb(0xC9,
						0xC9, 0xCE)));
				// set item width
				deleteItem.setWidth(dp2px(90));
				// set a icon
				deleteItem.setIcon(R.drawable.ic_help_hover);
				// add to menu
				menu.addMenuItem(deleteItem);
			}
		};
		// set creator
		mListView.setMenuCreator(creator);

		// step 2. listener item click event
		mListView.setOnMenuItemClickListener(new OnMenuItemClickListener() {
			@Override
			public boolean onMenuItemClick(int position, SwipeMenu menu,
					int index) {
				String item = values[position];
				int itemicon = valuesicons[position];
				switch (index) {
				case 0:
					// open
					// open(item);
					Toast.makeText(getActivity(), "Opened", Toast.LENGTH_LONG)
							.show();
					break;
				case 1:
					// delete
					// delete(item);
					productModelList.remove(position);
					adapter.notifyDataSetChanged();
					break;
				}
				return false;
			}
		});

		// set SwipeListener
		mListView.setOnSwipeListener(new OnSwipeListener() {

			@Override
			public void onSwipeStart(int position) {
				// swipe start
			}

			@Override
			public void onSwipeEnd(int position) {
				// swipe end
			}
		});

		return rootView;
	}

	private int dp2px(int dp) {
		return (int) TypedValue.applyDimension(TypedValue.COMPLEX_UNIT_DIP, dp,
				getResources().getDisplayMetrics());
	}
}