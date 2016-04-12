package com.wings.wApp.fragments;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.wings.wApp.R;

public class Fragment_BankingInfo extends Fragment {

	EditText et_accountname, et_accounttype, et_accountno, et_accountbranch;
	Button btnsubmit;
	SharedPreferences sharedpreferences;
	Context context;

	@Override
	public View onCreateView(LayoutInflater inflater, ViewGroup container,
			Bundle savedInstanceState) {

		View rootView = inflater.inflate(R.layout.fragment_banking_info,
				container, false);
		context = getActivity();
		et_accountname = (EditText) rootView
				.findViewById(R.id.et_bankinginfo_acountname);
		et_accounttype = (EditText) rootView
				.findViewById(R.id.et_bankinginfo_acounttype);
		et_accountno = (EditText) rootView
				.findViewById(R.id.et_bankinginfo_acountno);
		et_accountbranch = (EditText) rootView
				.findViewById(R.id.et_bankinginfo_branchname);
		btnsubmit = (Button) rootView.findViewById(R.id.btn_bankinginfo_submit);

		sharedpreferences = context.getSharedPreferences("PF_BankingDetail",
				context.MODE_PRIVATE);
		btnsubmit.setOnClickListener(new OnClickListener() {

			@Override
			public void onClick(View v) {
				// TODO Auto-generated method stub

				if (checkEditText(et_accountno)
						&& checkEditText(et_accountname)
						&& checkEditText(et_accounttype)
						&& checkEditText(et_accountbranch)) {

					SharedPreferences.Editor editor = sharedpreferences.edit();
					editor.putString("PF_BankingDetail_AccountName",
							et_accountname.getText().toString());
					editor.putString("PF_BankingDetail_AccountType",
							et_accounttype.getText().toString());
					editor.putString("PF_BankingDetail_AccountNo", et_accountno
							.getText().toString());
					editor.putString("PF_BankingDetail_AccountBranch",
							et_accountbranch.getText().toString());
					editor.commit();
					Toast.makeText(context,
							"Banking Detail Updated Successfuly",
							Toast.LENGTH_LONG).show();
				} else {
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
