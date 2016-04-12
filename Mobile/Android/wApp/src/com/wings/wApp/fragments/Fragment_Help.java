package com.wings.wApp.fragments;

import com.wings.wApp.R;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class Fragment_Help extends Fragment {
	TextView tv_welcometext;

	public Fragment_Help() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_help, container,
				false);
		tv_welcometext = (TextView) rootView.findViewById(R.id.tv_welcometext);
		tv_welcometext.setText("Hello this is Help screen");
		return rootView;
	}
}
