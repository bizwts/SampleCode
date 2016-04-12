package com.wings.wApp.fragments;

import java.util.ArrayList;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.GridView;
import android.widget.ListView;
import android.widget.Toast;

import com.wings.wApp.ImagePager;
import com.wings.wApp.R;
import com.wings.wApp.adapter.ImageAdapter;
import com.wings.wApp.globals.Constant;
import com.getbase.floatingactionbutton.FloatingActionButton;

public class Fragment_Gallery extends Fragment {

	private static final String STATE_POSITION = "STATE_POSITION";

	public ListView lst_view;
	public ArrayList<Integer> imagelist = new ArrayList<Integer>();
	public FloatingActionButton a;
	public String flag = "list";
	public GridView grid_view;

	public Fragment_Gallery() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_gallery, container,
				false);
		lst_view = (ListView) rootView.findViewById(R.id.lstview_image);
		grid_view = (GridView) rootView.findViewById(R.id.gridview_image);

		a = (FloatingActionButton) rootView.findViewById(R.id.normal_plus);

		addImage();

		lst_view.setVisibility(View.VISIBLE);
		grid_view.setVisibility(View.INVISIBLE);
		lst_view.setOnItemClickListener(new OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				Intent i = new Intent(getActivity().getApplicationContext(),
						ImagePager.class);
				i.putExtra("position", position);
				startActivity(i);

			}
		});

		grid_view.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> parent, View view,
					int position, long id) {
				// TODO Auto-generated method stub
				Intent i = new Intent(getActivity().getApplicationContext(),
						ImagePager.class);
				i.putExtra("position", position);
				startActivity(i);

			}
		});
		lst_view.setAdapter(new ImageAdapter(getActivity()
				.getApplicationContext(), "list"));
		grid_view.setAdapter(new ImageAdapter(getActivity()
				.getApplicationContext(), "grid"));

		a.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				Toast.makeText(getActivity(), "Hi", Toast.LENGTH_LONG).show();
				if (flag.equals("list")) {

					lst_view.setVisibility(View.VISIBLE);
					grid_view.setVisibility(View.INVISIBLE);
					flag = "grid";
				} else {
					grid_view.setVisibility(View.VISIBLE);
					lst_view.setVisibility(View.INVISIBLE);
					flag = "list";
				}
			}
		});
		return rootView;
	}

	public void addImage() {
		int img[] = Constant.IMAGES;
		for (int i = 0; i < img.length; i++) {
			imagelist.add(img[i]);
		}
	}
}
