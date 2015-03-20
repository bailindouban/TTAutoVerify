package com.asus.dao;

/**
 * UpdatedBug entity. @author MyEclipse Persistence Tools
 */
public class UpdatedBug extends AbstractUpdatedBug implements
		java.io.Serializable {

	// Constructors

	/** default constructor */
	public UpdatedBug() {
	}

	/** full constructor */
	public UpdatedBug(UserInfoAll userInfoAll, Integer ttBug, String tag,
			String apkVersion, String changeLink, String device, String branch) {
		super(userInfoAll, ttBug, tag, apkVersion, changeLink, device, branch);
	}

}
