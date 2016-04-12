package com.wings.wApp.adapter;

import com.wings.wApp.fragments.Fragment_Accesories;
import com.wings.wApp.fragments.Fragment_Clothies;
import com.wings.wApp.fragments.Fragment_Shoes;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

;

public class TabsPagerAdapter extends FragmentStatePagerAdapter {

	public TabsPagerAdapter(FragmentManager fm) {
		super(fm);
		// TODO Auto-generated constructor stub
	}

	@Override
	public Fragment getItem(int arg0) {
		// TODO Auto-generated method stub

		switch (arg0) {
		case 0:
			// Top Rated fragment activity
			return new Fragment_Clothies();
		case 1:
			// Games fragment activity
			return new Fragment_Shoes();
		case 2:
			// Movies fragment activity
			return new Fragment_Accesories();
		}

		return null;
	}

	@Override
	public CharSequence getPageTitle(int position) {
		return getFragmentTitle(position);
	}

	public String getFragmentTitle(int position) {
		if (position == 0)
			return "CLothes";
		else if (position == 1)
			return "Shoes";
		else
			return "Accessories";
	}

	@Override
	public int getCount() {
		// TODO Auto-generated method stub
		return 3;
	}
}
