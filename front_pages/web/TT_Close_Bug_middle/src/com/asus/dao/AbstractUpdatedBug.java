package com.asus.dao;

/**
 * AbstractUpdatedBug entity provides the base persistence definition of the
 * UpdatedBug entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractUpdatedBug implements java.io.Serializable {

	// Fields

	private Integer id;
	private UserInfoAll userInfoAll;
	private Integer updatedBug;

	// Constructors

	/** default constructor */
	public AbstractUpdatedBug() {
	}

	/** full constructor */
	public AbstractUpdatedBug(UserInfoAll userInfoAll, Integer updatedBug) {
		this.userInfoAll = userInfoAll;
		this.updatedBug = updatedBug;
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

	public Integer getUpdatedBug() {
		return this.updatedBug;
	}

	public void setUpdatedBug(Integer updatedBug) {
		this.updatedBug = updatedBug;
	}

}