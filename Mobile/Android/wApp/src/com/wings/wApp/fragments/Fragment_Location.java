package com.wings.wApp.fragments;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.MarkerOptions;
import com.wings.wApp.R;
import com.wings.wApp.globals.GlobalMethods;

public class Fragment_Location extends Fragment {

	private MapView mMapView;
	private GoogleMap googleMap;
	private String latlong;

	public Fragment_Location() {
	}

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_location, container,
				false);
		mMapView = (MapView) rootView.findViewById(R.id.mapView);
		mMapView.onCreate(savedInstanceState);

		mMapView.onResume();

		try {
			MapsInitializer.initialize(getActivity().getApplicationContext());
		} catch (Exception e) {
			e.printStackTrace();
		}

		latlong = GlobalMethods.getCurrentLocation(getActivity());
		Log.e("latlong", latlong);

		String[] latlongarr = latlong.split(",");

		googleMap = mMapView.getMap();

		// create marker
		MarkerOptions marker = new MarkerOptions().position(
				new LatLng(Double.valueOf(latlongarr[0]), Double
						.valueOf(latlongarr[1]))).title("Hello");

		// Changing marker icon
		marker.icon(BitmapDescriptorFactory
				.defaultMarker(BitmapDescriptorFactory.HUE_ROSE));

		// adding marker
		googleMap.addMarker(marker);
		CameraPosition cameraPosition = new CameraPosition.Builder()
				.target(new LatLng(Double.valueOf(latlongarr[0]), Double
						.valueOf(latlongarr[1]))).zoom(13).build();
		googleMap.animateCamera(CameraUpdateFactory
				.newCameraPosition(cameraPosition));

		googleMap.moveCamera(CameraUpdateFactory.newLatLngZoom(new LatLng(
				Double.valueOf(latlongarr[0]), Double.valueOf(latlongarr[1])),
				18));
		return rootView;

	}

	@Override
	public void onResume() {
		super.onResume();
		mMapView.onResume();
	}
}

