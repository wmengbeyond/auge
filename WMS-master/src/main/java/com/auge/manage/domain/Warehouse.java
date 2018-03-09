package com.auge.manage.domain;

/**
 * 中心仓库信息
 * @author Ken
 *
 */
public class Warehouse {

	private Integer id;

	private String 	code; 		//编号

	private String 	name; 		//名称

	private String 	addr; 		//地址

	private String 	tel; 		//电话

	private String 	contact; 	//联系人

	private String 	phone; 		//手机号

	private Integer mtime; 		//修改时间

	private Integer ctime; 	//创建时间

	public Integer getId() { return id; }

	public void setId(Integer id) { this.id = id; }

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getContact() {
		return contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Integer getMtime() {
		return mtime;
	}

	public void setMtime(Integer mtime) {
		this.mtime = mtime;
	}

	public Integer getCtime() {
		return ctime;
	}

	public void setCtime(Integer ctime) {
		this.ctime = ctime;
	}

	@Override
	public String toString() {
		return "Warehouse{" +
				"code='" + code + '\'' +
				", name='" + name + '\'' +
				", addr='" + addr + '\'' +
				", tel='" + tel + '\'' +
				", contact='" + contact + '\'' +
				", phone='" + phone + '\'' +
				", mtime=" + mtime +
				", ctime=" + ctime +
				'}';
	}

}
