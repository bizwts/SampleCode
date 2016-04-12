package com.wings.wApp;

import java.util.List;
import java.util.Vector;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;

import com.wings.wApp.adapter.PersonalInfoPagerAdapter;
import com.wings.wApp.fragments.Fragment_BankingInfo;
import com.wings.wApp.fragments.Fragment_PersonalInfo;

public class PersonalInfoActivity extends FragmentActivity {
	private PagerAdapter mPagerAdapter;
	private ViewPager pager;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		super.setContentView(R.layout.activity_personalinfo);
		// initialsie the pager
		List<Fragment> fragments = new Vector<Fragment>();
		fragments.add(Fragment.instantiate(this,
				Fragment_PersonalInfo.class.getName()));
		fragments.add(Fragment.instantiate(this,
				Fragment_BankingInfo.class.getName()));

		this.mPagerAdapter = new PersonalInfoPagerAdapter(
				super.getSupportFragmentManager(), fragments);
		//
		ViewPager pager = (ViewPager) super.findViewById(R.id.viewpager);
		pager.setAdapter(this.mPagerAdapter);

	}
}
