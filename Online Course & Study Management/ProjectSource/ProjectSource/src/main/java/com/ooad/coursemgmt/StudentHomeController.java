package com.ooad.coursemgmt;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.ooad.coursemgmt.domain.StudyPlan;
import com.ooad.coursemgmt.domain.Task;
import com.ooad.coursemgmt.service.CourseService;
import com.ooad.coursemgmt.service.StudyPlannerService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class StudentHomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(StudentHomeController.class);
	 @Resource(name="courseService")
	 private CourseService courseService;
	 
	 @Resource(name="studyPlannerService")
	 private StudyPlannerService studyPlannerService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		return "home";
	}
	
	@RequestMapping(value = "/courses", method = RequestMethod.GET)
    public String getCourses(Model model) {    
	     logger.debug("Received request to show all courses");
	     List<Course> courses = courseService.getAll();
	     model.addAttribute("courses", courses);
	     return "courses";
	 }
	
	@RequestMapping(value = "/deleteRegCourse", method = RequestMethod.GET)
	public String deleteRegisteredCourse(@RequestParam String semester, @RequestParam String userId, @RequestParam String courseNumber, Model model) {
		logger.debug("Received request to delete a registered course.");
		System.out.println("In Controller::" + userId + "  "+courseNumber);
		boolean result = courseService.deleteRegdCourse(userId, Integer.parseInt(courseNumber));
		System.out.println("Deletion result:" + result);
		model.addAttribute("delRes", result+"");
	    List<Course> courses = courseService.getRegisteredCourses(userId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", userId);
		List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(userId);
		model.addAttribute("courseActivities", regCourseActivity);
		model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("courses", courses);
		model.addAttribute("diplayResults", "None");
	    model.addAttribute("userId", userId);
	    model.addAttribute("semester", semester);
		return "StudentHome";
	}
	
	@RequestMapping(value = "/studentHome", method = RequestMethod.GET)
    public String getStudentHome(Model model) {      
	     logger.debug("Received request to show student home.");	      
	     return "StudentHome";
	 }
	
	@RequestMapping(value = "/CourseMgmt", method = RequestMethod.GET)
    public String courseMgmt(Model model) {   
	     logger.debug("Received request to show CourseMgmt");	      
	     return "CourseMgmt";
	 }
	
	@RequestMapping(value = "/searchCourses", method = RequestMethod.GET)
	public String searchCourses(@RequestParam String semester, @RequestParam String uId, @RequestParam String cPrefix,
			@RequestParam String cNum, @RequestParam String cName, @RequestParam String instructor,
				@RequestParam String cStatus, @RequestParam String cLevel, Model model) {
		
		logger.debug("Received request to search courses.");
		System.out.println("In Controller::" + uId + "  num" + cNum + " Prefix:" + cPrefix);
		Course courseDetails = new Course();
		if (!cNum.equals(""))
			courseDetails.setCourseNumber(Integer.parseInt(cNum));
		else
			courseDetails.setCourseNumber(-99);
		courseDetails.setCourseName(cName);
		courseDetails.setCoursePrefix(cPrefix);
		courseDetails.setInstructor(instructor);
		courseDetails.setCourseStatus(cStatus);
		courseDetails.setCourseLevel(cLevel);
		List<Course> searchedCourses = null;
		if(cNum.equals("") && cName.equals("") && cPrefix.equals("") && instructor.equals("") &&
				cStatus.equals("") && cLevel.equals("")){
			    System.out.println("Getting all the courses.");
			    searchedCourses = courseService.getAll();
		}
		else{
			System.out.println("Getting restricted courses.");
			searchedCourses = courseService.searchCourses(courseDetails);
		}
		model.addAttribute("diplayResults", "display");
		model.addAttribute("searchedCourses", searchedCourses);
	    List<Course> courses = courseService.getRegisteredCourses(uId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", uId);
	    List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(uId);
	    model.addAttribute("courses", courses);
	    model.addAttribute("userId", uId);
	    model.addAttribute("courseActivities", regCourseActivity);
	    model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("semester", semester);
		return "StudentHome";
	}
	
	@RequestMapping(value = "/registerCourses", method = RequestMethod.GET)
	public String registerCourses(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum1, Model model){
		logger.debug("Received request to register courses.");
		System.out.println("In Controller::" + uId + "  num" + courseNum1);
		model.addAttribute("diplayResults", "None");
		String registerResults = courseService.registerCourses(uId, Integer.parseInt(courseNum1));
		model.addAttribute("registerResults", registerResults);
	    List<Course> courses = courseService.getRegisteredCourses(uId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", uId);
	    List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(uId);
	    model.addAttribute("courseActivities", regCourseActivity);
	    model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("courses", courses);
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "StudentHome";
	}
	
	@RequestMapping(value = "/swapCourses", method = RequestMethod.GET)
	public String swapCourses(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum1,
			@RequestParam String courseNum2, Model model){
		logger.debug("Received request to swap courses.");
		System.out.println("In Controller::" + uId + "  num" + courseNum1);
		model.addAttribute("diplayResults", "None");
		String swapResults = courseService.swapCourses(uId, Integer.parseInt(courseNum1), Integer.parseInt(courseNum2));
		model.addAttribute("swapResults", swapResults);
	    List<Course> courses = courseService.getRegisteredCourses(uId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", uId);
	    List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(uId);
	    model.addAttribute("courseActivities", regCourseActivity);
	    model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("courses", courses);
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "StudentHome";
	}
	
	@RequestMapping(value = "/savePlan", method = RequestMethod.GET)
	public String savePlan(@RequestParam String semester, @RequestParam String userId, @RequestParam Integer planId, @RequestParam String planName,
			               @RequestParam String taskName1, @RequestParam String stDt1, @RequestParam String enDt1, 
			               @RequestParam String taskName2, @RequestParam String stDt2, @RequestParam String enDt2,
			               @RequestParam String taskName3, @RequestParam String stDt3, @RequestParam String enDt3, Model model){

		List<Task> taskDetails = new ArrayList<Task>();
		Task task1 = new Task();
		task1.setTaskName(taskName1);
		task1.setTaskId(1);
		task1.setTaskPriority(0);
		try {
			System.out.println(stDt1);
			task1.setStartDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(stDt1));
			System.out.println(task1.getStartDate());
			task1.setEndDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(enDt1));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		taskDetails.add(task1);
		System.out.println("task Name"+taskName2);
		Task task2 = new Task();
		if(!taskName2.equals("''")){
			task2.setTaskName(taskName2);
			task2.setTaskId(2);
			task2.setTaskPriority(0);
			try {
				task2.setStartDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(stDt2));
				task2.setEndDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(enDt2));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			taskDetails.add(task2);
		}
		Task task3 = new Task();
		if(!taskName3.equals("''")){
			task3.setTaskName(taskName3);
			task3.setTaskId(3);
			task3.setTaskPriority(0);
			try{
				task3.setStartDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(stDt3));
				task3.setEndDate(new SimpleDateFormat("MM-dd-yyyy", Locale.US).parse(enDt3));
			}catch(Exception e){
				e.printStackTrace();
			}
			taskDetails.add(task3);
		}
		boolean saveResult = studyPlannerService.saveStudyPlan(userId, planId, planName, taskDetails);
		List<Course> courses = courseService.getRegisteredCourses(userId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", userId);
	    List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(userId);
	    model.addAttribute("userId", userId);
	    model.addAttribute("saveRes", saveResult);
	    model.addAttribute("diplayResults", "None");
	    model.addAttribute("courses", courses);
	    model.addAttribute("courseActivities", regCourseActivity);
	    model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("semester", semester);
		return "StudentHome";
	}
	
	@RequestMapping(value = "/deletePlan", method = RequestMethod.GET)
	public String deletePlan(@RequestParam String semester, @RequestParam String userId, @RequestParam Integer planId, Model model){
		boolean delPlanRes = studyPlannerService.deleteStudyPlan(userId, planId);
		List<Course> courses = courseService.getRegisteredCourses(userId);
	    List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", userId);
	    List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(userId);
	    // Attach persons to the Model
	    model.addAttribute("userId", userId);
	    model.addAttribute("diplayResults", "None");
	    model.addAttribute("courses", courses);
	    model.addAttribute("courseActivities", regCourseActivity);
	    model.addAttribute("studyPlans", studyPlans);
	    model.addAttribute("delPlanRes", delPlanRes);
	    model.addAttribute("semester", semester);
	    System.out.println("# of activities retrieved" + regCourseActivity.size());
		return "StudentHome";
	}
}
