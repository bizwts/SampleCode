package com.wings.wApp.fragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.wings.wApp.R;

public class Fragment_Contactus extends Fragment {
	TextView tv_welcometext;

	public Fragment_Contactus() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_contactus,
				container, false);
		tv_welcometext = (TextView) rootView.findViewById(R.id.tv_welcometext);
		tv_welcometext.setText("Hello this is Contact Us screen");

		return rootView;
	}
}
