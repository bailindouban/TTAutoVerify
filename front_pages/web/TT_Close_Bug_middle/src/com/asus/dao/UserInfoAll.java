package com.asus.dao;

import java.util.Set;

/**
 * UserInfoAll entity. @author MyEclipse Persistence Tools
 */
public class UserInfoAll extends AbstractUserInfoAll implements
		java.io.Serializable {

	// Constructors

	/** default constructor */
	public UserInfoAll() {
	}

	/** minimal constructor */
	public UserInfoAll(UserInfoAllId id) {
		super(id);
	}

	/** full constructor */
	public UserInfoAll(UserInfoAllId id, String password, String rdManager,
			String developer, Set updatedBugs, Set closedBugs) {
		super(id, password, rdManager, developer, updatedBugs, closedBugs);
	}

}
