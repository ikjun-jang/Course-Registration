package com.ooad.coursemgmt.service;

import java.sql.ResultSet;
import java.sql.SQLException;
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

@Service("courseActivityService")
@Transactional
public class CourseActivityService {
	protected static Logger logger = Logger.getLogger("service");
	  
	 @SuppressWarnings("deprecation")
	 private SimpleJdbcTemplate jdbcTemplate;
	  
	 @Resource(name="dataSource")
	 public void setDataSource(DataSource dataSource) {
	     this.jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	 }
	 
	 /**
	  * Retrieves all course activities related to a course offered by a particular professor.
	  *
	  * @return a list of course activities.
	  */
	 public List<CourseActivity> getCourseActivities(Integer courseNum, String semester, String professorId) {
		  logger.debug("Retrieving all courses");
		   
		  // Prepare our SQL statement
		  String sql = "select * from courseactivities where course_number = " + courseNum + " and semester = '"+ semester
				  		+ "' and professor_id = '" + professorId + "'";
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
			         return courseActivity;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	 }
	 
	 public boolean deleteCourseActivity(Integer courseNum, String professorId, String semester, Integer activityId){
		 boolean return_value = true;
		 try{
		 logger.debug("Deleting course activities.");
		   
		 String sql = "delete from courseactivities where course_number = :courseNum" +
				    " and professor_id = :professorId and semester = :semester and activity_id = :activityId";
				   
				  // Assign values to parameters
				  Map<String, Object> parameters = new HashMap<String, Object>();
				  parameters.put("courseNum", courseNum);
				  parameters.put("professorId", professorId);
				  parameters.put("semester", semester);
				  parameters.put("activityId", activityId);
				  // Save
				  
				  int rowsAffected = jdbcTemplate.update(sql, parameters);
				  if(rowsAffected == 0){
					  return false;
				  }
				
		 }catch(Exception e){
			 logger.debug(e);
			 return_value = false;
		 }
		 return return_value;
	 }
	 
	 public boolean addCourseActivity( CourseActivity courseActivityDetails ){
		 boolean result = true;
		 try{
			 logger.debug("Adding course activities.");
			 System.out.println("Trying to get activity id");
			 int courseNum = courseActivityDetails.getCourseNumber();
			 String semester = courseActivityDetails.getSemester();
			 String professorId = courseActivityDetails.getProfessorId();
			 String idSql = "select max(activity_id) from courseactivities where course_number = "+ courseNum + " and semester = '"+ semester + "' and professor_id = '" + professorId + "'";
			 System.out.println("Sql" + idSql);
			 RowMapper<CourseActivity> mapper = new RowMapper<CourseActivity>() { 
		         public CourseActivity mapRow(ResultSet rs, int rowNum) throws SQLException {
			         CourseActivity courseActivity = new CourseActivity();
			         courseActivity.setActivityId((rs.getInt(1) + 1));
			         return courseActivity;
		         }
		     };
		     
		     List<CourseActivity>courseActivity = jdbcTemplate.query(idSql, mapper);
		     
		     int nextActivityId = courseActivity.get(0).getActivityId();
		     
			 String sql = "insert into courseactivities values (:courseNum, :semester, :activityName, :activityDescription, now(), :deadline," +
					      		" :professorId, :activityId)";
					   
					  // Assign values to parameters
					  Map<String, Object> parameters = new HashMap<String, Object>();
					  parameters.put("courseNum", courseNum);
					  parameters.put("professorId", professorId);
					  parameters.put("semester", semester);
					  parameters.put("activityId", nextActivityId);
					  parameters.put("activityName", courseActivityDetails.getActivityName());
					  parameters.put("activityDescription", courseActivityDetails.getActivityDescription());
					  parameters.put("deadline", courseActivityDetails.getDeadline());
					  // Save
					  
					  int rowsAffected = jdbcTemplate.update(sql, parameters);
					  if(rowsAffected == 0){
						  return false;
					  }
					
			 }catch(Exception e){
				 System.out.println(e);
				 result = false;
			 }
		 return result;
	 }
	 
	 public boolean editCourseActivity( CourseActivity courseActivityDetails ){
		 boolean result = true;
		 try{
			 logger.debug("Editing course activities.");
			 System.out.println("Trying to get activity id");
			 int courseNum = courseActivityDetails.getCourseNumber();
			 String semester = courseActivityDetails.getSemester();
			 String professorId = courseActivityDetails.getProfessorId();
			 int activityId = courseActivityDetails.getActivityId();
			 
			 String sql = "update courseactivities set activity_name = :activityName, activity_description = :activityDesc, deadline = :deadLine " +
					 		"where course_number = :courseNum and activity_id = :activityId";
					   
					  // Assign values to parameters
					  Map<String, Object> parameters = new HashMap<String, Object>();
					  parameters.put("courseNum", courseNum);
					  parameters.put("semester", semester);
					  parameters.put("activityId", activityId);
					  parameters.put("activityName", courseActivityDetails.getActivityName());
					  parameters.put("activityDesc", courseActivityDetails.getActivityDescription());
					  parameters.put("deadLine", courseActivityDetails.getDeadline());
					  // Save
					  
					  int rowsAffected = jdbcTemplate.update(sql, parameters);
					  if(rowsAffected == 0){
						  return false;
					  }
					
			 }catch(Exception e){
				 System.out.println(e);
				 result = false;
			 }
		 return result;
	 }
}
