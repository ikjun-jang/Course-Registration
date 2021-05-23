package com.ooad.coursemgmt.domain;

import java.util.Date;
import java.util.List;

public class StudyPlan {
	private static final long serialVersionUID = -5527566244444296042L;	
	private int planId;
	private String planName;
	private String userId;
	private List<Task> taskList;

	public Integer getPlanId() {
		return planId;
	}	 
	public void setPlanId(Integer planId) {
		this.planId = planId;
	}
	 
	public String getPlanName() {
		return planName;
	} 
	public void setPlanName(String planName) {
		this.planName = planName;
	}
	
	public String getUserId() {
		return userId;
	}	 
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public List<Task> getTaskList() {
		return taskList;
	}	 
	public void setTaskList(List<Task> taskList) {
		this.taskList = taskList;
	}
}
