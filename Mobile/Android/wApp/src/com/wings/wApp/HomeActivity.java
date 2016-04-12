package com.wings.wApp;

import android.annotation.SuppressLint;
import android.app.ActionBar;
import android.app.Activity;
import android.app.FragmentManager;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.res.Configuration;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.widget.DrawerLayout;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;
import android.widget.SearchView;
import android.widget.SearchView.OnQueryTextListener;

import com.ikimuhendis.ldrawer.ActionBarDrawerToggle;
import com.ikimuhendis.ldrawer.DrawerArrowDrawable;
import com.wings.wApp.adapter.NavigationDrawerListAdapter;
import com.wings.wApp.fragments.Fragment_About;
import com.wings.wApp.fragments.Fragment_Contactus;
import com.wings.wApp.fragments.Fragment_Gallery;
import com.wings.wApp.fragments.Fragment_Help;
import com.wings.wApp.fragments.Fragment_Location;
import com.wings.wApp.fragments.Fragment_Profile;
import com.wings.wApp.fragments.TabLayout;

public class HomeActivity extends FragmentActivity implements
		OnQueryTextListener {

	private SharedPreferences sharedpreferences;

	private DrawerLayout mDrawerLayout;
	private String username;

	private ListView mDrawerList;
	private ActionBarDrawerToggle mDrawerToggle;
	private DrawerArrowDrawable drawerArrow;
	private boolean drawerArrowColor;

	private NavigationDrawerListAdapter adapter;

	@SuppressLint("ResourceAsColor")
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home_screen);
		ActionBar ab = getActionBar();

		ab.setDisplayHomeAsUpEnabled(true);
		ab.setHomeButtonEnabled(true);
		ab.setDisplayShowHomeEnabled(false);
		ab.setDisplayShowCustomEnabled(true);

		ab.setIcon(R.drawable.ic_logo);
		// ab.setTitle("wApp");
		// ab.setIcon(null);
		ab.setTitle(null);
		ab.setCustomView(R.layout.custome_header);

		sharedpreferences = getSharedPreferences("preference", 0);
		username = sharedpreferences.getString("username", "");

		mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
		mDrawerList = (ListView) findViewById(R.id.navdrawer);

		drawerArrow = new DrawerArrowDrawable(this) {
			@Override
			public boolean isLayoutRtl() {
				return false;
			}
		};
		mDrawerToggle = new ActionBarDrawerToggle(this, mDrawerLayout,
				drawerArrow, R.string.drawer_open, R.string.drawer_close) {

			public void onDrawerClosed(View view) {
				super.onDrawerClosed(view);
				invalidateOptionsMenu();
			}

			public void onDrawerOpened(View drawerView) {
				super.onDrawerOpened(drawerView);
				invalidateOptionsMenu();
			}
		};

		mDrawerLayout.setDrawerListener(mDrawerToggle);
		mDrawerToggle.syncState();

		String[] values = new String[] { "Home", "Profile", "Location",
				"Gallery", "About", "Contact Us", "Help" };
		int[] valuesicons = new int[] { R.drawable.ic_home,
				R.drawable.ic_username, R.drawable.ic_location,
				R.drawable.ic_gallary, R.drawable.ic_about,
				R.drawable.ic_contact, R.drawable.ic_help };
		int[] valueshovericons = new int[] { R.drawable.ic_home_hover,
				R.drawable.ic_username_hover, R.drawable.ic_location_hover,
				R.drawable.ic_gallery_hover, R.drawable.ic_about_hover,
				R.drawable.ic_contact_hover, R.drawable.ic_help_hover };
		adapter = new NavigationDrawerListAdapter(getApplicationContext(),
				mDrawerList, valuesicons, valueshovericons, values);
		// ArrayAdapter<String> adapter = new ArrayAdapter<String>(this,
		// android.R.layout.simple_list_item_1, android.R.id.text1, values);
		mDrawerList.setChoiceMode(ListView.CHOICE_MODE_SINGLE);
		mDrawerList.setAdapter(adapter);
		mDrawerList
				.setOnItemClickListener(new AdapterView.OnItemClickListener() {
					@Override
					public void onItemClick(AdapterView<?> parent, View view,
							int position, long id) {

						displayView(position);
					}
				});

		if (savedInstanceState == null) {
			// on first time display view for first nav item
			displayView(0);
		}
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {

		MenuInflater inflater = getMenuInflater();
		inflater.inflate(R.menu.main, menu);
		SearchView searchView = (SearchView) menu.findItem(
				R.id.action_websearch).getActionView();
		searchView.setOnQueryTextListener(this);

		return super.onCreateOptionsMenu(menu);
	}

	/* Called whenever we call invalidateOptionsMenu() */
	@Override
	public boolean onPrepareOptionsMenu(Menu menu) {
		// If the nav drawer is open, hide action items related to the content
		// view
		boolean drawerOpen = mDrawerLayout.isDrawerOpen(mDrawerList);
		menu.findItem(R.id.action_websearch).setVisible(!drawerOpen);
		return super.onPrepareOptionsMenu(menu);
	}

	@Override
	protected void onPostCreate(Bundle savedInstanceState) {
		super.onPostCreate(savedInstanceState);
		mDrawerToggle.syncState();
	}

	@Override
	public void onConfigurationChanged(Configuration newConfig) {
		super.onConfigurationChanged(newConfig);
		mDrawerToggle.onConfigurationChanged(newConfig);
	}

	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		// The action bar home/up action should open or close the drawer.
		// ActionBarDrawerToggle will take care of this.
		if (mDrawerToggle.onOptionsItemSelected(item)) {
			return true;
		}
		// Handle action buttons
		if (item.getItemId() == android.R.id.home) {
			if (mDrawerLayout.isDrawerOpen(mDrawerList)) {
				mDrawerLayout.closeDrawer(mDrawerList);
			} else {
				mDrawerLayout.openDrawer(mDrawerList);
			}
		}

		switch (item.getItemId()) {
		case R.id.action_websearch:
			// create intent to perform web search for this planet

			return true;

		case R.id.action_logout:
			// create intent to perform web search for this planet
			SharedPreferences.Editor editor = sharedpreferences.edit();
			editor.clear();
			editor.commit();
			Intent i = new Intent(HomeActivity.this, Login_Screen1.class);
			startActivity(i);
			finish();
			return true;
		default:
			return super.onOptionsItemSelected(item);
		}
	}

	@Override
	public boolean onQueryTextSubmit(String query) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean onQueryTextChange(String newText) {
		// TODO Auto-generated method stub
		return false;
	}

	private void displayView(int position) {
		// update the main content by replacing fragments
		Fragment fragment = null;
		switch (position) {
		case 0:
			fragment = new TabLayout();
			break;
		case 1:
			fragment = new Fragment_Profile();
			break;
		case 2:
			fragment = new Fragment_Location();
			break;
		case 3:
			fragment = new Fragment_Gallery();
			break;
		case 4:
			fragment = new Fragment_About();
			break;
		case 5:
			fragment = new Fragment_Contactus();
			break;
		case 6:
			fragment = new Fragment_Help();
			break;

		default:
			break;
		}

		if (fragment != null) {
			FragmentManager fragmentManager = getFragmentManager();

			getSupportFragmentManager().beginTransaction()
					.replace(R.id.frame_container, fragment).commit();

			/*
			 * fragmentManager.beginTransaction() .replace(R.id.frame_container,
			 * fragment).commit();
			 */
			// update selected item and title, then close the drawer
			mDrawerList.setItemChecked(position, true);
			mDrawerList.setSelection(position);
			mDrawerLayout.closeDrawer(mDrawerList);
		} else {
			// error in creating fragment
			Log.e("MainActivity", "Error in creating fragment");
		}
	}
}
