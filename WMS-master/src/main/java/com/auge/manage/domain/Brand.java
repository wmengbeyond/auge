package com.auge.manage.domain;

/**
 * 商品品牌信息
 * @author wm
 *
 */
public class Brand {

	private Integer id;

	private String 	code; 		//编号

	private String 	name; 		//名称

	private String 	type; 		//类型

	private String 	changjia; 	//厂家

	private Integer status; 	//状态

	private Long 	mtime; 		//修改时间

	private String 	mperson; 	//修改人

	private Long 	ctime; 		//创建时间

	private String 	cperson; 	//建档人

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

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

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getChangjia() {
		return changjia;
	}

	public void setChangjia(String changjia) {
		this.changjia = changjia;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Long getMtime() {
		return mtime;
	}

	public void setMtime(Long mtime) {
		this.mtime = mtime;
	}

	public String getMperson() {
		return mperson;
	}

	public void setMperson(String mperson) {
		this.mperson = mperson;
	}

	public Long getCtime() {
		return ctime;
	}

	public void setCtime(Long ctime) {
		this.ctime = ctime;
	}

	public String getCperson() {
		return cperson;
	}

	public void setCperson(String cperson) {
		this.cperson = cperson;
	}

	@Override
	public String toString() {
		return "Brand{" +
				"id=" + id +
				", code='" + code + '\'' +
				", name='" + name + '\'' +
				", type='" + type + '\'' +
				", changjia='" + changjia + '\'' +
				", status=" + status +
				", mtime=" + mtime +
				", mperson='" + mperson + '\'' +
				", ctime=" + ctime +
				", cperson='" + cperson + '\'' +
				'}';
	}
}
