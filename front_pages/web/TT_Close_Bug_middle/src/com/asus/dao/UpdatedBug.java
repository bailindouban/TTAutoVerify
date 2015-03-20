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
	public UpdatedBug(UserInfoAll userInfoAll, Integer updatedBug) {
		super(userInfoAll, updatedBug);
	}

}
