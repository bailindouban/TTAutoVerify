package com.asus.model;

public class BugTotal {
	private String device;
	private Integer number;
	
	// Constructor
	public BugTotal(String device, Integer number) {
		super();
		this.device = device;
		this.number = number;
	}
	
	// Getters and Setters
	public String getDevice() {
		return device;
	}
	
	public void setDevice(String device) {
		this.device = device;
	}
	
	public Integer getNumber() {
		return number;
	}
	
	public void setNumber(Integer number) {
		this.number = number;
	}	
	
}
