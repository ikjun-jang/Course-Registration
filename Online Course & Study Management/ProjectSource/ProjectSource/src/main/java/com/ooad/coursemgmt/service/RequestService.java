package com.ooad.coursemgmt.service;
import java.util.Random;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

import com.ooad.coursemgmt.domain.Course;
import com.ooad.coursemgmt.domain.Request;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("requestService")
@Transactional
public class RequestService {
	 protected static Logger logger = Logger.getLogger("service");
	  
	 @SuppressWarnings("deprecation")
	 private SimpleJdbcTemplate jdbcTemplate;
	  
	 @Resource(name="dataSource")
	 public void setDataSource(DataSource dataSource) {
	     this.jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	 }

	 public List<Request> getRequest(String advisorId) {
		  logger.debug("Retrieving all requests");
		  
		  // Prepare our SQL statement
		  String sql = "select request_id, student_id, advisor_id, course_number, request_description, request_status from studentrequests where advisor_id = '"+advisorId+"';";
		   
		  // Maps a SQL result to a Java object
		  RowMapper<Request> mapper = new RowMapper<Request>() { 
		         public Request mapRow(ResultSet rs, int rowNum) throws SQLException {
		          Request request = new Request();
		          request.setRequestId(rs.getInt("request_id"));
		          request.setStudentId(rs.getString("student_id"));
		          request.setAdvisorId(rs.getString("advisor_id"));
		          request.setCourseNumber(rs.getInt("course_number"));
		          request.setRequestDescription(rs.getString("request_description"));
		          request.setRequestStatus(rs.getString("request_status"));
		          return request;
		         }
		     };
 
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	}
	 
	 public boolean updateRequestStatus (String studentId, Integer courseNumber, String requestStatus){
		 boolean return_value = true;
		 try {
			 
			 String sql = "update studentrequests set request_status=:requestStatus where student_id=:studentId and course_number=" +courseNumber;
		  
			 // Assign values to parameters
			 Map<String, Object> parameters = new HashMap<String, Object>();
			 parameters.put("studentId", studentId);
			 parameters.put("requestStatus", requestStatus);
			 
			 int rowsAffected = jdbcTemplate.update(sql, parameters);
			  rowsAffected = jdbcTemplate.update(sql, parameters);
			  if(rowsAffected == 0){
				  return false;
			  } 

			 if(requestStatus=="Accepted") {
				requestStatus = "Registered";
				sql = "update registeredcourses set reg_status = :requestStatus where student_id = :studentId and course_number = " +courseNumber;
			 }
			 else
			    sql = "update registeredcourses set reg_status = :requestStatus where student_id = :studentId and course_number = " +courseNumber;
				
			 // Assign values to parameters
			Map<String, Object> parameters2 = new HashMap<String, Object>();			 
			parameters2.put("studentId", studentId);
			parameters2.put("requestStatus", requestStatus);

			rowsAffected = jdbcTemplate.update(sql, parameters2);
			System.out.println("rowsAffected::" + rowsAffected);
			if(rowsAffected == 0){
			  return false;
			}
				
		 }catch(Exception e){
			 logger.debug(e);
			 return_value = false;
		 }
		 return return_value;
	 }
}
