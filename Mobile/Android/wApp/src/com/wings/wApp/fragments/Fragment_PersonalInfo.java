package com.wings.wApp.fragments;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.ViewPager;
import android.support.v4.view.ViewPager.OnPageChangeListener;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.wings.wApp.PersonalInfoActivity;
import com.wings.wApp.R;

public class Fragment_PersonalInfo extends Fragment{

	Context context;
	EditText et_firstname,et_lastname,et_email,et_address,et_contact,et_pincode;
	Button btn_next;
	SharedPreferences sharedpreferences;
	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_personal_info, container,
				false);
		context=getActivity();
		et_firstname=(EditText)rootView.findViewById(R.id.et_userfirstname);
		et_lastname=(EditText)rootView.findViewById(R.id.et_userlastname);
		et_email=(EditText)rootView.findViewById(R.id.et_useremail);
		et_address=(EditText)rootView.findViewById(R.id.et_useraddress);
		et_contact=(EditText)rootView.findViewById(R.id.et_userphoneno);
		et_pincode=(EditText)rootView.findViewById(R.id.et_userpincode);
		final ViewPager pager = (ViewPager)rootView.findViewById(R.id.viewpager);
		btn_next=(Button)rootView.findViewById(R.id.btn_user_next);
		
		sharedpreferences = context.getSharedPreferences("PF_UserDetail", context.MODE_PRIVATE);
		
		btn_next.setOnClickListener(new OnClickListener() {
			
			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub
				
				if (checkEditText(et_firstname) && checkEditText(et_lastname)
						&& checkEditText(et_email)&& checkEditText(et_address)&& checkEditText(et_contact)&& checkEditText(et_pincode))
				{
			
				 SharedPreferences.Editor editor = sharedpreferences.edit();
				 editor.putString("PF_UserDetail_FirstName", et_firstname.getText().toString());
				 editor.putString("PF_UserDetail_LastName", et_lastname.getText().toString());
				 editor.putString("PF_UserDetail_Email", et_email.getText().toString());
				 editor.putString("PF_UserDetail_Address", et_address.getText().toString());
				 editor.putString("PF_UserDetail_Contact", et_contact.getText().toString());
				 editor.putString("PF_UserDetail_PinCode", et_pincode.getText().toString());
				 editor.commit();
				 Toast.makeText(context,"User Detail Updated Successfuly",Toast.LENGTH_LONG).show();
				/* Fragment_PersonalInfo thisFrag = null;
				 Fragment_BankingInfo nextFrag = new Fragment_BankingInfo();
				 ((FragmentActivity) context).getSupportFragmentManager().beginTransaction()
				 .replace(R.id.personal_layout, nextFrag)
				  .hide(thisFrag)
				 .addToBackStack(null).commit();*/
			
				}
				else {
					Toast.makeText(context, "Please enter details",
							Toast.LENGTH_LONG).show();
				}
			}
		});
		return rootView;
	}
	public static boolean checkEditText(EditText edittext) {
		if (edittext.getText().toString().matches("")) {
			return false;
		}
		return true;
	}
}
