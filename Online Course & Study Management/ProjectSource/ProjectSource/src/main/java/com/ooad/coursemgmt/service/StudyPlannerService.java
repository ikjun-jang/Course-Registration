package com.ooad.coursemgmt.service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ooad.coursemgmt.domain.CourseActivity;
import com.ooad.coursemgmt.domain.StudyPlan;
import com.ooad.coursemgmt.domain.Task;

@Service("studyPlannerService")
@Transactional
public class StudyPlannerService {
	protected static Logger logger = Logger.getLogger("service");
	  
	 @SuppressWarnings("deprecation")
	 private SimpleJdbcTemplate jdbcTemplate;
	  
	 @Resource(name="dataSource")
	 public void setDataSource(DataSource dataSource) {
	     this.jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	 }

	 public List<CourseActivity> getRegCourseActivities(String semester, String studentId) {
		  // Prepare our SQL statement
		  String sql = "select * from courseactivities ca, registeredcourses rc where ca.course_number = rc.course_number and ca.semester = '" + semester + "' and rc.student_id = '" + studentId + "';";
		  System.out.println("Sql query::" + sql); 
		  // Maps a SQL result to a Java object
		  RowMapper<CourseActivity> mapper = new RowMapper<CourseActivity>() { 
		         public CourseActivity mapRow(ResultSet rs, int rowNum) throws SQLException {
			         CourseActivity courseActivity = new CourseActivity();
			         courseActivity.setCourseNumber(rs.getInt("course_number"));
			         courseActivity.setActivityId(rs.getInt("activity_id"));
			         courseActivity.setActivityName(rs.getString("activity_name"));
			         courseActivity.setActivityDescription(rs.getString("activity_description"));
			         courseActivity.setPostDate(rs.getDate("posted_on"));
			         courseActivity.setDeadline(rs.getDate("deadline"));
			         Date today = new Date();
			         long diff = rs.getDate("deadline").getTime() - today.getTime();
			         long diffdays = diff / (24 * 60 * 60 * 1000);
			         courseActivity.setDaysLeft(diffdays);
			         return courseActivity;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	 }
	 
	 public List<StudyPlan> getStudyPlans(String studentId) {
		 String sql = "select * from studyplans where student_id = '" + studentId + "';";
		  System.out.println("Sql query::" + sql); 
		  // Maps a SQL result to a Java object
		  RowMapper<StudyPlan> mapper = new RowMapper<StudyPlan>() { 
		         public StudyPlan mapRow(ResultSet rs, int rowNum) throws SQLException {
			         StudyPlan plan = new StudyPlan();
			         plan.setPlanId(rs.getInt("plan_id"));
			         plan.setPlanName(rs.getString("plan_name"));
			         plan.setUserId(rs.getString("student_id"));
			         List<Task> tasks = getPlanTasks(rs.getString("student_id"), rs.getInt("plan_id"));
			         plan.setTaskList(tasks);
			         return plan;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	 }
	 
	 public List<Task> getPlanTasks(String studentId, Integer planId){
		 String sql = "select * from tasks where student_id = '" + studentId + "' and plan_id = "+ planId + ";";
		  System.out.println("Sql query::" + sql); 
		  // Maps a SQL result to a Java object
		  RowMapper<Task> mapper = new RowMapper<Task>() { 
		         public Task mapRow(ResultSet rs, int rowNum) throws SQLException {
			         Task task = new Task();
			         task.setTaskId(rs.getInt("task_id"));
			         task.setTaskName(rs.getString("task_name"));
			         task.setTaskPriority(rs.getInt("task_priority"));
			         task.setStartDate(rs.getDate("start_time"));
			         task.setEndDate(rs.getDate("end_time"));
			         return task;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	 }
	 
	 public boolean saveStudyPlan(String userId, Integer planId, String planName, List<Task> taskList){
		 boolean saveResult = true;
		 try{
			 String sql = "insert into studyplans values ("+planId+",'"+planName+"', '"+userId+"')";
			 System.out.println("Student plan insertion sql:" + sql);
			 jdbcTemplate.update(sql);
			 
			 for(int i=0; i<taskList.size(); i++){
				 sql = "insert into tasks values ("+planId+", '"+userId+"', "+taskList.get(i).getTaskId()+", '"+taskList.get(i).getTaskName()+"', "+taskList.get(i).getTaskPriority()+", :startDate, :endDate)";
				 System.out.println("Task insertion sql:" + sql);
				 Map<String, Object> parameters = new HashMap<String, Object>();
				  parameters.put("startDate", taskList.get(i).getStartDate());
				  System.out.println("Service: startdate"+taskList.get(i).getStartDate());
				  parameters.put("endDate", taskList.get(i).getEndDate());
				 jdbcTemplate.update(sql,parameters);
			 }
			 
		 }catch(Exception e){
			 System.out.println(e);
			 saveResult = false;
			 String sql = "delete from studyplans where plan_id = "+planId+" and student_id = '"+userId+"'";
			 jdbcTemplate.update(sql);
			 sql = "delete from tasks where plan_id = "+planId+" and student_id = '"+userId+"'";
			 jdbcTemplate.update(sql);
		 }
		 return saveResult;
	 }
	 
	 public boolean deleteStudyPlan(String userId, Integer planId){
		 boolean deleteResult = true;
		 try{
			 String sql = "delete from studyplans where student_id = :studentId and plan_id = :planId ";
			  System.out.println("Query::" + sql); 
			  // Assign values to parameters
			  Map<String, Object> parameters = new HashMap<String, Object>();
			  parameters.put("studentId", userId);
			  parameters.put("planId", planId);		   
			  // Edit
			  jdbcTemplate.update(sql, parameters);
			  
			  sql = "delete from tasks where student_id = :studentId and plan_id = :planId ";
			  System.out.println("Query::" + sql); 
			   
			  // Edit
			  jdbcTemplate.update(sql, parameters);
		 } catch(Exception e){
			 System.out.println(e);
			 deleteResult = false;
		 }
		 return deleteResult;
	 }
}
