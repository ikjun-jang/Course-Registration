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

import com.ooad.coursemgmt.domain.Course;
import com.ooad.coursemgmt.domain.OfferedCourse;
import com.ooad.coursemgmt.domain.User;

@Service("adminService")
@Transactional
public class AdminService {
	 protected static Logger logger = Logger.getLogger("service");
	  
	 @SuppressWarnings("deprecation")
	 private SimpleJdbcTemplate jdbcTemplate;
	  
	 @Resource(name="dataSource")
	 public void setDataSource(DataSource dataSource) {
	     this.jdbcTemplate = new SimpleJdbcTemplate(dataSource);
	 }
	 
	public boolean saveOfferedCourse(String prefix, Integer crsNum, String semester, String status, String inst, 
			String level, String method, String timing, String location, Integer seatsAvail, Integer maxSeats, String pid) {
		
		boolean return_value = true;
		
		try {
		  
			  String sql = "select * from offeredcourses where course_number = "+crsNum;
			   
			  // Maps a SQL result to a Java object
			  RowMapper<OfferedCourse> mapper = new RowMapper<OfferedCourse>() { 
			         public OfferedCourse mapRow(ResultSet rs, int rowNum) throws SQLException {
			          OfferedCourse oc = new OfferedCourse();
			          oc.setCourseNumber(rs.getInt("course_number"));
			          return oc;
			         }
			  };
			   
			  // Retrieve all
			  List<OfferedCourse>offeredCourseList = jdbcTemplate.query(sql, mapper);
			  System.out.println("Size::" + offeredCourseList.size());
			  if(offeredCourseList.size() == 1){
				  sql = "update offeredcourses set course_prefix=:prefix, course_number=:crsNum, semester=:semester, status=:status, "
				  		+ "course_instructor=:inst, course_level=:level, instruction_method=:method, course_timing=:timing, course_location=:location, "
				  		+ "seats_available=:seatsAvail, maximum_seats=:maxSeats, professor_id=:pid where course_number=" + crsNum;
			  }
			  else
				  sql = "insert into OfferedCourses values(:crsNum, :semester, :inst, :method, :prefix, :timing, :location, :seatsAvail, :maxSeats, :status, :pid, :level)";
	       
			 Map<String, Object> parameters = new HashMap<String, Object>();
			 parameters.put("crsNum", crsNum);
			 parameters.put("semester", semester);
			 parameters.put("inst", inst);
			 parameters.put("method", method);
			 parameters.put("prefix", prefix);
			 parameters.put("timing", timing);
			 parameters.put("location", location);
			 parameters.put("seatsAvail", seatsAvail);
			 parameters.put("maxSeats", maxSeats);
			 parameters.put("status", status);
			 parameters.put("level", level);
			 parameters.put("pid", pid);
			 
			 int rowsAffected = jdbcTemplate.update(sql, parameters);
			  if(rowsAffected == 0){
				  return false;
			  } 
		 
		}catch(Exception e){
			System.out.println(e);
			 return_value = false;
		 }
		 return return_value;
     }
	
	public boolean saveCourse(String cName, Integer cNum, Integer credits) {
		
		boolean return_value = true;
		
		try {
		  
			  String sql = "select * from courses where course_number = "+cNum;
			   
			  // Maps a SQL result to a Java object
			  RowMapper<Course> mapper = new RowMapper<Course>() { 
			         public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
			          Course c = new Course();
			          c.setCourseNumber(rs.getInt("course_number"));
			          return c;
			         }
			  };
			   
			  // Retrieve all
			  List<Course>courseList = jdbcTemplate.query(sql, mapper);
			  System.out.println("Size::" + courseList.size());
			  if(courseList.size() == 1){
				  sql = "update courses set course_number=:cNum, course_name=:cName, credits=:credits where course_number=" + cNum;
			  }
			  else
				  sql = "insert into courses values(:cNum, :cName, :credits)";
	       
			 Map<String, Object> parameters = new HashMap<String, Object>();
			 parameters.put("cNum", cNum);
			 parameters.put("cName", cName);
			 parameters.put("credits", credits);
			 
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

	public List<OfferedCourse> displayAllOfferedCourse() {
		  logger.debug("offered course display");
		   
		  // Prepare our SQL statement
		  String sql = "select * from offeredcourses";
				  RowMapper<OfferedCourse> mapper = new RowMapper<OfferedCourse>() { 
		         public OfferedCourse mapRow(ResultSet rs, int rowNum) throws SQLException {
		          OfferedCourse course = new OfferedCourse();
		          course.setCourseNumber(rs.getInt(1));
		          course.setSemester(rs.getString(2));
		          course.setInstructor(rs.getString(3));
		          course.setInstructionMethod(rs.getString(4));
		          course.setCoursePrefix(rs.getString(5));
		          course.setCourseTiming(rs.getString(6));
		          course.setCourseLocation(rs.getString(7));
		          course.setSeatsAvailable(rs.getInt(8));
		          course.setMaximumSeats(rs.getInt(9));
		          course.setStatus(rs.getString(10));
		          course.setCourseLevel(rs.getString(12));
		          course.setProfessorId(rs.getString(11));

		          return course;
		          }};
		  // Edit
		  return jdbcTemplate.query(sql, mapper);
	 }
	
	public List<Course> displayAllCourse() {
		  logger.debug("course display");
		   
		  // Prepare our SQL statement
		  String sql = "select * from courses";
				  RowMapper<Course> mapper = new RowMapper<Course>() { 
		         public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
		          Course course = new Course();
		          course.setCourseNumber(rs.getInt(1));
		          course.setCourseName(rs.getString(2));
		          course.setCourseCredits(rs.getInt(3));
		          
		          return course;
		          }};
		  // Edit
		  return jdbcTemplate.query(sql, mapper);
	 }
	
	 public List<OfferedCourse> searchOfferedCourses(OfferedCourse offeredCourseFilter) {
		  logger.debug("Retrieving offered courses");
		   
		  // Prepare our SQL statement
		  String sql = "select * from offeredcourses where ";
		  if (! offeredCourseFilter.getCoursePrefix().equals("")){
			  sql = sql + "course_prefix = '" + offeredCourseFilter.getCoursePrefix() + "'";
		  }
		  if (! (offeredCourseFilter.getCourseNumber() == -99)){
			  sql = sql + "course_number = " + offeredCourseFilter.getCourseNumber();
		  }
		  if (! offeredCourseFilter.getCourseLevel().equals("")){
			  sql = sql + "course_level = '" + offeredCourseFilter.getCourseLevel() + "'";
		  }
		  if (! offeredCourseFilter.getStatus().equals("")){
			  sql = sql + "status = '" + offeredCourseFilter.getStatus() + "'";
		  }
		  if (! offeredCourseFilter.getInstructor().equals("")){
			  sql = sql + "course_instructor = '" + offeredCourseFilter.getInstructor() + "'";
		  }
		  System.out.println("Sql query is "+sql);
		  // Maps a SQL result to a Java object
		  RowMapper<OfferedCourse> mapper = new RowMapper<OfferedCourse>() { 
		         public OfferedCourse mapRow(ResultSet rs, int rowNum) throws SQLException {
			         OfferedCourse offeredCourse = new OfferedCourse();
			         offeredCourse.setCourseNumber(rs.getInt("course_number"));
			         offeredCourse.setCourseLevel(rs.getString("course_level"));
			         offeredCourse.setCourseLocation(rs.getString("course_location"));
			         offeredCourse.setCoursePrefix(rs.getString("course_prefix"));
			         offeredCourse.setInstructionMethod(rs.getString("instruction_method"));
			         offeredCourse.setInstructor(rs.getString("course_instructor"));
			         offeredCourse.setSeatsAvailable(rs.getInt("seats_available"));
			         offeredCourse.setMaximumSeats(rs.getInt("maximum_seats"));
			         offeredCourse.setStatus(rs.getString("status"));
			         offeredCourse.setProfessorId(rs.getString("professor_id"));
			         offeredCourse.setSemester(rs.getString("semester"));
			         offeredCourse.setCourseTiming(rs.getString("course_timing"));
			         return offeredCourse;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	}
	 
	public List<Course> searchCourses(Course courseFilter) {
		  logger.debug("Retrieving courses");
		   
		  // Prepare our SQL statement
		  String sql = "select * from courses where ";
		  System.out.println("Sql query is "+sql);
		  if (! courseFilter.getCourseName().equals("")){
			  sql = sql + "course_name = '" + courseFilter.getCourseName() + "'";
		  }
		  if (! (courseFilter.getCourseNumber() == -99)){
			  sql = sql + "course_number = " + courseFilter.getCourseNumber();
		  }
		  System.out.println("Sql query is "+sql);
		  // Maps a SQL result to a Java object
		  RowMapper<Course> mapper = new RowMapper<Course>() { 
		         public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
			         Course course = new Course();
			         course.setCourseNumber(rs.getInt("course_number"));
			         course.setCourseName(rs.getString("course_name"));
			         course.setCourseCredits(rs.getInt("credits"));
			         return course;
		         }
		     };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	}
	 
	 public List<OfferedCourse> editOfferedCourse(Integer CourseNum) {
		  logger.debug("Retrieving an offered course");
		   
		  // Prepare our SQL statement
		  String sql = "select * from offeredcourses where course_number=" + CourseNum;
		  System.out.println("Sql query is "+sql);
		  // Maps a SQL result to a Java object
		  RowMapper<OfferedCourse> mapper = new RowMapper<OfferedCourse>() { 
		         public OfferedCourse mapRow(ResultSet rs, int rowNum) throws SQLException {
			         OfferedCourse offeredCourse = new OfferedCourse();
			         offeredCourse.setCourseNumber(rs.getInt("course_number"));
			         offeredCourse.setCourseLevel(rs.getString("course_level"));
			         offeredCourse.setCourseLocation(rs.getString("course_location"));
			         offeredCourse.setCoursePrefix(rs.getString("course_prefix"));
			         offeredCourse.setInstructionMethod(rs.getString("instruction_method"));
			         offeredCourse.setInstructor(rs.getString("course_instructor"));
			         offeredCourse.setSeatsAvailable(rs.getInt("seats_available"));
			         offeredCourse.setMaximumSeats(rs.getInt("maximum_seats"));
			         offeredCourse.setStatus(rs.getString("status"));
			         offeredCourse.setProfessorId(rs.getString("professor_id"));
			         offeredCourse.setSemester(rs.getString("semester"));
			         offeredCourse.setCourseTiming(rs.getString("course_timing"));
			         return offeredCourse;
		         }
		  };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	}
	
	 public List<Course> editCourse(Integer CourseNum) {
		  logger.debug("Retrieving a course");
		   
		  // Prepare our SQL statement
		  String sql = "select * from courses where course_number=" + CourseNum;
		  System.out.println("Sql query is "+sql);
		  // Maps a SQL result to a Java object
		  RowMapper<Course> mapper = new RowMapper<Course>() { 
		         public Course mapRow(ResultSet rs, int rowNum) throws SQLException {
			         Course course = new Course();
			         course.setCourseNumber(rs.getInt("course_number"));
			         course.setCourseName(rs.getString("course_name"));
			         course.setCourseCredits(rs.getInt("credits"));
			         return course;
		         }
		  };
		   
		  // Retrieve all
		  return jdbcTemplate.query(sql, mapper);
	}
	 
	public boolean deleteOfferedCourse(Integer courseNumber) {
		  logger.debug("Deleting existing course");
		  try {
			  // Prepare our SQL statement using Unnamed Parameters style
			  String sql = "delete from OfferedCourses where course_number = " + courseNumber;
			   System.out.println("Delete Query read");
			  jdbcTemplate.update(sql);
			  System.out.println("Deleted and updated");
		  
		  }catch(Exception e){
			  logger.debug(e);
			  return false;
		  }
		  return true;
	}
	
	public boolean deleteCourse(Integer courseNumber) {
		  logger.debug("Deleting existing course");
		  try {
			  // Prepare our SQL statement using Unnamed Parameters style
			  String sql = "delete from courses where course_number = " + courseNumber;
			   System.out.println("Delete Query read");
			  jdbcTemplate.update(sql);
			  System.out.println("Deleted and updated");
		  
		  }catch(Exception e){
			  logger.debug(e);
			  return false;
		  }
		  return true;
	}
	
	public List<User> getProfessorIds(){
		String sql = "select user_id from user where user_role = 'professor'";
		  RowMapper<User> mapper = new RowMapper<User>() { 
		    public User mapRow(ResultSet rs, int rowNum) throws SQLException {
		        User user = new User();
		        user.setUserId(rs.getString("user_id"));
		        
		        return user;
		   }};
// Edit
        	return jdbcTemplate.query(sql, mapper);
	}
}
