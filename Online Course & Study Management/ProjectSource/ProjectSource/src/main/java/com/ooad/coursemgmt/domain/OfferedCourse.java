package com.ooad.coursemgmt.domain;

import java.io.Serializable;

public class OfferedCourse implements Serializable {
	 
	 private static final long serialVersionUID = -5527566248002296042L;
	  
	 private Integer courseNumber;
	 private String semester;
	 private String instructor;
	 private String intsructionMethod;
	 private String coursePrefix;
	 private String courseTiming;
	 private String courseLocation;
	 private int seatsAvailable;
	 private int maximumSeats;
	 private String status;
	 private String professorId;
	 private String courseLevel;
	 
	 public void setInstructor(String instructor) {
		 this.instructor = instructor;
	 }	
	 public String getInstructor() {
		 return instructor;
	 }
	 public void setProfessorId(String professorId) {
		 this.professorId = professorId;
	 }	
	 public String getProfessorId() {
		 return professorId;
	 }
	 public void setInstructionMethod(String intsructionMethod) {
		 this.intsructionMethod = intsructionMethod;
	 }	
	 public String getInstructionMethod() {
		 return intsructionMethod;
	 }
	 
	 public void setCoursePrefix(String coursePrefix) {
		 this.coursePrefix = coursePrefix;
	 }	
	 public String getCoursePrefix() {
		 return coursePrefix;
	 }
	 
	 public void setCourseLocation(String courseLocation) {
		 this.courseLocation = courseLocation;
	 }	
	 
	 public String getCourseLocation() {
		return courseLocation;
	 }
	 
	 public void setCourseTiming(String courseTiming) {
		 this.courseTiming = courseTiming;
	 }	
	 
	 public String getCourseTiming() {
		return courseTiming;
	 }
	 
	 public Integer getSeatsAvailable() {
		 return seatsAvailable;
	 }
	 
	 public void setSeatsAvailable(Integer seatsAvailable) {
		 this.seatsAvailable = seatsAvailable;
	 }
	 
	 public Integer getMaximumSeats() {
		 return maximumSeats;
	 }
	 
	 public void setMaximumSeats(Integer maximumSeats) {
		 this.maximumSeats = maximumSeats;
	 }
	 
	 public Integer getCourseNumber() {
		 return courseNumber;
	 }
	 
	 public void setCourseNumber(Integer courseNumber) {
		 this.courseNumber = courseNumber;
	 }
	 
	 public String getSemester() {
		 return semester;
	 }
	 
	 public void setSemester(String semester) {
		 this.semester = semester;
	 }
	 
	 public void setStatus(String status) {
		 this.status = status;
	 }	
	 public String getStatus() {
		 return status;
	 }
	 
	 public void setCourseLevel(String courseLevel) {
		 this.courseLevel = courseLevel;
	 }
	 
	 public String getCourseLevel() {
		 return courseLevel;
	 }
}

