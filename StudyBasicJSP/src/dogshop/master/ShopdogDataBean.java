package dogshop.master;

import java.sql.Timestamp;

public class ShopdogDataBean {
	private int goods_id;
	private String goods_kind;
	private String goods_name;
	private int goods_price;
	private short goods_count;
	private String goods_com;
	private String goods_date;
	private String goods_country;
	private String goods_image;
	private String goods_content;
	private byte discount_rate;
	private Timestamp reg_date;

	public int getGoods_id() {
		return goods_id;
	}

	public void setGoods_id(int goods_id) {
		this.goods_id = goods_id;
	}

	public String getGoods_kind() {
		return goods_kind;
	}

	public void setGoods_kind(String goods_kind) {
		this.goods_kind = goods_kind;
	}

	public String getGoods_name() {
		return goods_name;
	}

	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}

	public int getGoods_price() {
		return goods_price;
	}

	public void setGoods_price(int goods_price) {
		this.goods_price = goods_price;
	}

	public short getGoods_count() {
		return goods_count;
	}

	public void setGoods_count(short goods_count) {
		this.goods_count = goods_count;
	}

	public String getGoods_com() {
		return goods_com;
	}

	public void setGoods_com(String goods_com) {
		this.goods_com = goods_com;
	}

	public String getGoods_date() {
		return goods_date;
	}

	public void setGoods_date(String goods_date) {
		this.goods_date = goods_date;
	}

	public String getGoods_country() {
		return goods_country;
	}

	public void setGoods_country(String goods_country) {
		this.goods_country = goods_country;
	}

	public String getGoods_image() {
		return goods_image;
	}

	public void setGoods_image(String goods_image) {
		this.goods_image = goods_image;
	}

	public String getGoods_content() {
		return goods_content;
	}

	public void setGoods_content(String goods_content) {
		this.goods_content = goods_content;
	}

	public byte getDiscount_rate() {
		return discount_rate;
	}

	public void setDiscount_rate(byte discount_rate) {
		this.discount_rate = discount_rate;
	}

	public Timestamp getReg_date() {
		return reg_date;
	}

	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
}
