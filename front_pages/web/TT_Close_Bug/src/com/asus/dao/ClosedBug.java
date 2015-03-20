package com.asus.dao;

/**
 * ClosedBug entity. @author MyEclipse Persistence Tools
 */
public class ClosedBug extends AbstractClosedBug implements
		java.io.Serializable {

	// Constructors

	/** default constructor */
	public ClosedBug() {
	}

	/** full constructor */
	public ClosedBug(UserInfoAll userInfoAll, Integer ttBug, String tag,
			String apkVersion, String changeLink, String device, String branch) {
		super(userInfoAll, ttBug, tag, apkVersion, changeLink, device, branch);
	}

}
