package com.wings.wApp.fragments;

import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTabHost;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TabHost.OnTabChangeListener;
import android.widget.TextView;

import com.wings.wApp.R;
import com.wings.wApp.adapter.TabsPagerAdapter;

public class TabLayout extends Fragment {

	private FragmentTabHost mTabHost;
	private ViewPager viewPager;
	private TabsPagerAdapter mAdapter;

	// Mandatory Constructor
	public TabLayout() {
		// TODO Auto-generated constructor stub
	}

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

	}

	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.tablayout, container, false);

		mTabHost = (FragmentTabHost) rootView
				.findViewById(android.R.id.tabhost);
		mTabHost.setup(getActivity().getApplicationContext(),
				getChildFragmentManager(), R.id.realtabcontent);

		View tabView = createTabView(getActivity().getApplicationContext(),
				"Clothes");

		mTabHost.addTab(mTabHost.newTabSpec("Clothes").setIndicator(tabView),
				Fragment_Clothies.class, null);
		View tabView1 = createTabView(getActivity().getApplicationContext(),
				"Shoes");

		mTabHost.addTab(mTabHost.newTabSpec("Shoes").setIndicator(tabView1),
				Fragment_Shoes.class, null);
		View tabView2 = createTabView(getActivity().getApplicationContext(),
				"Accessories");

		mTabHost.addTab(
				mTabHost.newTabSpec("Accessories").setIndicator(tabView2),

				Fragment_Accesories.class, null);
		mTabHost.setCurrentTabByTag("Clothes");

		mTabHost.setOnTabChangedListener(new OnTabChangeListener() {

			@Override
			public void onTabChanged(String tabId) {
				// TODO Auto-generated method stub

				if (tabId.equals("Clothes")) {

					viewPager.setCurrentItem(0);

				} else if (tabId.equals("Shoes")) {
					viewPager.setCurrentItem(1);

				} else if (tabId.equals("Accessories")) {
					// setCurrentTab(2);

					viewPager.setCurrentItem(2);

				}

			}
		});

		viewPager = (ViewPager) rootView.findViewById(R.id.pager);

		mAdapter = new TabsPagerAdapter(getActivity()
				.getSupportFragmentManager());
		viewPager.setAdapter(mAdapter);

		viewPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {

			@Override
			public void onPageSelected(int position) {
				// on changing the page
				// make respected tab selected
				setCurrentTab(position);

			}

			@Override
			public void onPageScrolled(int arg0, float arg1, int arg2) {
			}

			@Override
			public void onPageScrollStateChanged(int arg0) {
			}
		});

		return rootView;
	}

	public void setCurrentTab(int tab_index) {
		mTabHost = (FragmentTabHost) getActivity().findViewById(
				android.R.id.tabhost);
		mTabHost.setCurrentTab(tab_index);
	}

	public static View createTabView(Context context, String tabText) {
		View view = LayoutInflater.from(context).inflate(R.layout.custome_tab,
				null, false);
		TextView tv = (TextView) view.findViewById(R.id.tabTitleText);
		tv.setText(tabText);
		return view;
	}
}
