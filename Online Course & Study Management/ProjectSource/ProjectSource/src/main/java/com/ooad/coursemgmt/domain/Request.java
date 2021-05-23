package com.ooad.coursemgmt.domain;

import java.io.Serializable;

public class Request implements Serializable {
	 
	 private static final long serialVersionUID = -5527566248023296042L;
	  
	 private Integer requestId;
	 private String studentId;
	 private String advisorId;
	 private Integer courseNumber;
	 private String requestDescription;
	 private String requestStatus;
	 
	 public Integer getRequestId() {
		 return requestId;
	 }
	 
	 public void setRequestId(Integer requestId) {
		 this.requestId = requestId;
	 }
	 
	 public String getStudentId() {
		  return studentId;
	 }
		 
	 public void setStudentId(String studentId) {
		  this.studentId = studentId;
	 }
		 
	 public String getAdvisorId() {
		  return advisorId;
	 }
			 
	 public void setAdvisorId(String advisorId) {
		this.advisorId = advisorId;
	 }
	 
	 public Integer getCourseNumber() {
		  return courseNumber;
	 }
			 
	 public void setCourseNumber(Integer courseNumber) {
		this.courseNumber = courseNumber;
	 }
	 
	 public String getRequestDescription() {
	  return requestDescription;
	 }
	 
	 public void setRequestDescription(String requestDescription) {
	  this.requestDescription = requestDescription;
	 }
	 
	 public String getRequestStatus() {
		  return requestStatus;
	 }
		 
	 public void setRequestStatus(String requestStatus) {
		  this.requestStatus = requestStatus;
	 }
}
