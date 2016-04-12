package com.wings.wApp.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;

import com.wings.wApp.PersonalInfoActivity;
import com.wings.wApp.R;

public class Fragment_Profile extends Fragment {

	private Button buttoneditprofile;

	public Fragment_Profile() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_profile, container,
				false);

		buttoneditprofile = (Button) rootView
				.findViewById(R.id.profile_btn_edit);
		buttoneditprofile.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Intent i = new Intent(getActivity(), PersonalInfoActivity.class);
				startActivity(i);
			}
		});

		return rootView;
	}
}
