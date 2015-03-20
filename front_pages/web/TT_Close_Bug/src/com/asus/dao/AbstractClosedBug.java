package com.asus.dao;

/**
 * AbstractClosedBug entity provides the base persistence definition of the
 * ClosedBug entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractClosedBug implements java.io.Serializable {

	// Fields

	private Integer id;
	private UserInfoAll userInfoAll;
	private Integer ttBug;
	private String tag;
	private String apkVersion;
	private String changeLink;
	private String device;
	private String branch;

	// Constructors

	/** default constructor */
	public AbstractClosedBug() {
	}

	/** full constructor */
	public AbstractClosedBug(UserInfoAll userInfoAll, Integer ttBug,
			String tag, String apkVersion, String changeLink, String device,
			String branch) {
		this.userInfoAll = userInfoAll;
		this.ttBug = ttBug;
		this.tag = tag;
		this.apkVersion = apkVersion;
		this.changeLink = changeLink;
		this.device = device;
		this.branch = branch;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public UserInfoAll getUserInfoAll() {
		return this.userInfoAll;
	}

	public void setUserInfoAll(UserInfoAll userInfoAll) {
		this.userInfoAll = userInfoAll;
	}

	public Integer getTtBug() {
		return this.ttBug;
	}

	public void setTtBug(Integer ttBug) {
		this.ttBug = ttBug;
	}

	public String getTag() {
		return this.tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getApkVersion() {
		return this.apkVersion;
	}

	public void setApkVersion(String apkVersion) {
		this.apkVersion = apkVersion;
	}

	public String getChangeLink() {
		return this.changeLink;
	}

	public void setChangeLink(String changeLink) {
		this.changeLink = changeLink;
	}

	public String getDevice() {
		return this.device;
	}

	public void setDevice(String device) {
		this.device = device;
	}

	public String getBranch() {
		return this.branch;
	}

	public void setBranch(String branch) {
		this.branch = branch;
	}

}