package com.ooad.coursemgmt.domain;

import java.util.Date;
import java.util.List;

public class Task {
	private static final long serialVersionUID = -5527566244444296042L;	
	private int taskId;
	private String taskName;
	private int planId;
	private Date startDate;
	private Date endDate;
	private int taskPriority;
	
	
	public Date getEndDate() {
		return endDate;
	}
	 
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public Date getStartDate() {
		return startDate;
	}
	 
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	public Integer getTaskId() {
		return taskId;
	}
	 
	 public void setTaskId(Integer taskId) {
		 this.taskId = taskId;
	 }
	 
	 public Integer getTaskPriority() {
		return taskPriority;
	 }
	 
	 public void setTaskPriority(Integer taskPriority) {
		 this.taskPriority = taskPriority;
	 }
	 
	 public String getTaskName() {
		return taskName;
	 }
	 
	 public void setTaskName(String taskName) {
		 this.taskName = taskName;
	 }
	 
	 public Integer getPlanId() {
		return planId;
	}
	 
	 public void setPlanId(Integer planId) {
		 this.planId = planId;
	 }
	 
}
