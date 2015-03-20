package com.asus.dao;

/**
 * AbstractClosedBug entity provides the base persistence definition of the
 * ClosedBug entity. @author MyEclipse Persistence Tools
 */

public abstract class AbstractClosedBug implements java.io.Serializable {

	// Fields

	private Integer id;
	private UserInfoAll userInfoAll;
	private Integer closedBug;

	// Constructors

	/** default constructor */
	public AbstractClosedBug() {
	}

	/** full constructor */
	public AbstractClosedBug(UserInfoAll userInfoAll, Integer closedBug) {
		this.userInfoAll = userInfoAll;
		this.closedBug = closedBug;
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

	public Integer getClosedBug() {
		return this.closedBug;
	}

	public void setClosedBug(Integer closedBug) {
		this.closedBug = closedBug;
	}

}