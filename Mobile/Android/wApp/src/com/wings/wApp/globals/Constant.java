package com.wings.wApp.globals;

import com.wings.wApp.R;

public class Constant {

	public static final String Hostname = "http://192.168.1.28/";
	// public static final String Hostname = "http://192.168.43.17/";

	public static final String APIKey = GlobalMethods.md5("jikOuxnegjoxguk6");

	public static final String userSignIn = Hostname
			+ "wapp/api/public/user/signin";
	public static final String userSignUp = Hostname
			+ "wapp/api/public/user/signup";

	public static final int[] IMAGES = new int[] { R.drawable.image1,
			R.drawable.image2, R.drawable.image3, R.drawable.image4,
			R.drawable.image5 };

	public static class Extra {
		public static final int FRAGMENT_INDEX = R.drawable.image1;
		public static final int IMAGE_POSITION = R.drawable.image2;
	}
}