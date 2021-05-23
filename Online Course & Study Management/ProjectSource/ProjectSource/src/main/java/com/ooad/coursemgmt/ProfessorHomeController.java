package com.ooad.coursemgmt;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ooad.coursemgmt.domain.Course;
import com.ooad.coursemgmt.domain.CourseActivity;
import com.ooad.coursemgmt.service.CourseActivityService;
import com.ooad.coursemgmt.service.ProfessorService;

@Controller
public class ProfessorHomeController {
	private static final Logger logger = LoggerFactory.getLogger(StudentHomeController.class);
	 @Resource(name="courseActivityService")
	 private CourseActivityService courseActivityService;
	 
	 @Resource(name="professorService")
	 private ProfessorService professorService;
	 
	 @RequestMapping(value = "/courseActivities", method = RequestMethod.GET)
	    public String getCourseActivities(@RequestParam Integer courseNum, @RequestParam String semester, @RequestParam String professorId, Model model) {    
		     logger.debug("Received request to get course activities.");
		     System.out.println("course num:" + courseNum + " semester:" + semester + " professor Id " + professorId);
		     List<CourseActivity> courseActivities = courseActivityService.getCourseActivities(courseNum, semester, professorId);
		     //System.out.println("Course Activities retrieved:" + courseActivities.size());
		     //System.out.println("Course Actvitiy Description:"+ courseActivities.get(0).getActivityDescription());
		     //System.out.println("Activity id" + courseActivities.get(0).getActivityId());
		     List<Course> offeredCourses = professorService.getOfferedCourses(professorId, "Fall 2014");
			 model.addAttribute("offeredCourses", offeredCourses);
		     model.addAttribute("courseActivities", courseActivities);
		     model.addAttribute("dispActivity", "block");
		     model.addAttribute("userId",professorId);
		     model.addAttribute("semester", semester);
		     return "ProfessorHome";
		 }
	 
	 @RequestMapping(value = "/deleteActivity", method = RequestMethod.GET)
	    public String deleteActivity(@RequestParam Integer courseNum, @RequestParam String semester, @RequestParam String professorId, @RequestParam Integer activityId, Model model) {    
		     logger.debug("Received request to get course activities.");
		     System.out.println("course num:" + courseNum + " semester:" + semester + " professor Id " + professorId);
		     boolean delResult = courseActivityService.deleteCourseActivity(courseNum, professorId, semester, activityId);
		     List<CourseActivity> courseActivities = courseActivityService.getCourseActivities(courseNum, semester, professorId);
		     System.out.println("Course Activities retrieved:" + courseActivities.size());
		     System.out.println("Course Actvitiy Description:"+ courseActivities.get(0).getActivityDescription());
		     List<Course> offeredCourses = professorService.getOfferedCourses(professorId, "Fall 2014");
			 model.addAttribute("offeredCourses", offeredCourses);
		     model.addAttribute("courseActivities", courseActivities);
		     model.addAttribute("dispActivity", "block");
		     model.addAttribute("userId",professorId);
		     model.addAttribute("delResult", delResult);
		     model.addAttribute("semester", semester);
		     return "ProfessorHome";
		 }
	 
	 @RequestMapping(value = "/addActivity", method = RequestMethod.GET)
	    public String addActivity(@RequestParam Integer courseNum, @RequestParam String semester, @RequestParam String professorId, @RequestParam String activityName, @RequestParam String activityDescription, @RequestParam String deadline, Model model) {    
		     logger.debug("Received request to get course activities.");
		     System.out.println("course num:" + courseNum + " semester:" + semester + " professor Id " + professorId);
		     CourseActivity courseActivity = new CourseActivity(); 
		     courseActivity.setCourseNumber(courseNum);
		     courseActivity.setSemester(semester);
		     courseActivity.setProfessorId(professorId);
		     courseActivity.setActivityName(activityName);
		     courseActivity.setActivityDescription(activityDescription);
		     try {
		     courseActivity.setDeadline(new SimpleDateFormat("MM/dd/yyyy", Locale.US).parse(deadline));
		     } catch(Exception e){
		    	 System.out.println(e);
		     }
		     boolean addResult = courseActivityService.addCourseActivity(courseActivity);
		     System.out.println("Add result:" + addResult);
		     List<CourseActivity> courseActivities = courseActivityService.getCourseActivities(courseNum, semester, professorId);
		     System.out.println("Course Activities retrieved:" + courseActivities.size());
		     System.out.println("Course Actvitiy Description:"+ courseActivities.get(0).getActivityDescription());
		     List<Course> offeredCourses = professorService.getOfferedCourses(professorId, "Fall 2014");
			 model.addAttribute("offeredCourses", offeredCourses);
		     model.addAttribute("courseActivities", courseActivities);
		     model.addAttribute("dispActivity", "block");
		     model.addAttribute("userId",professorId);
		     model.addAttribute("addResult", addResult);
		     model.addAttribute("semester", semester);
		     return "ProfessorHome";
		 }
	 
	 @RequestMapping(value = "/editActivity", method = RequestMethod.GET)
	    public String editActivity(@RequestParam Integer courseNum, @RequestParam Integer activityId, @RequestParam String semester, @RequestParam String professorId, @RequestParam String activityName, @RequestParam String activityDescription, @RequestParam String deadline, Model model) {    
		     logger.debug("Received request to get course activities.");
		     System.out.println("course num:" + courseNum + " semester:" + semester + " professor Id " + professorId);
		     CourseActivity courseActivity = new CourseActivity(); 
		     courseActivity.setCourseNumber(courseNum);
		     courseActivity.setSemester(semester);
		     courseActivity.setProfessorId(professorId);
		     courseActivity.setActivityName(activityName);
		     courseActivity.setActivityDescription(activityDescription);
		     courseActivity.setActivityId(activityId);
		     try {
		     courseActivity.setDeadline(new SimpleDateFormat("mm/dd/yyyy", Locale.ENGLISH).parse(deadline));
		     } catch(Exception e){
		    	 System.out.println(e);
		     }
		     boolean editResult = courseActivityService.editCourseActivity(courseActivity);
		     System.out.println("Add result:" + editResult);
		     List<CourseActivity> courseActivities = courseActivityService.getCourseActivities(courseNum, semester, professorId);
		     System.out.println("Course Activities retrieved:" + courseActivities.size());
		     System.out.println("Course Actvitiy Description:"+ courseActivities.get(0).getActivityDescription());
		     List<Course> offeredCourses = professorService.getOfferedCourses(professorId, "Fall 2014");
			 model.addAttribute("offeredCourses", offeredCourses);
		     model.addAttribute("courseActivities", courseActivities);
		     model.addAttribute("dispActivity", "block");
		     model.addAttribute("userId",professorId);
		     model.addAttribute("editResult", editResult);
		     model.addAttribute("semester", semester);
		     return "ProfessorHome";
		 }
	 
}
