package com.wings.wApp.model;

public class ProductModel {

	public int product_id;
	public String product_name;
	public int product_icon;
	public String product_description;
	public String product_model;
	public String product_expirydate;
	public String manfacture_date;
	public int product_price;

	
	
	
	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_icon() {
		return product_icon;
	}

	public void setProduct_icon(int product_icon) {
		this.product_icon = product_icon;
	}

	public String getProduct_description() {
		return product_description;
	}

	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}

	public String getProduct_model() {
		return product_model;
	}

	public void setProduct_model(String product_model) {
		this.product_model = product_model;
	}

	public String getProduct_expirydate() {
		return product_expirydate;
	}

	public void setProduct_expirydate(String product_expirydate) {
		this.product_expirydate = product_expirydate;
	}

	public String getManfacture_date() {
		return manfacture_date;
	}

	public void setManfacture_date(String manfacture_date) {
		this.manfacture_date = manfacture_date;
	}

	public int getProduct_price() {
		return product_price;
	}

	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	public void setProductModel(int product_id, String product_name,
			int product_icon) {

		this.product_id = product_id;
		this.product_name = product_name;
		this.product_icon = product_icon;
	}

	public ProductModel(String product_name, int product_icon) {
		this.product_name = product_name;
		this.product_icon = product_icon;
	}

	public int getProductId() {
		return product_id;
	}

	public void setProductId(int product_id) {
		this.product_id = product_id;
	}

	public String getProductName() {
		return product_name;
	}

	public void setProductName(String product_name) {
		this.product_name = product_name;
	}

	public int getProductIcon() {
		return product_icon;
	}

	public void setProductIcon(int product_icon) {
		this.product_icon = product_icon;
	}
}
