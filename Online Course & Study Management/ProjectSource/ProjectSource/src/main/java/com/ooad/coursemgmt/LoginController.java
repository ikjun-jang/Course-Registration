package com.ooad.coursemgmt;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ooad.coursemgmt.domain.Course;
import com.ooad.coursemgmt.domain.Request;
import com.ooad.coursemgmt.domain.StudyPlan;
import com.ooad.coursemgmt.domain.User;
import com.ooad.coursemgmt.domain.CourseActivity;
import com.ooad.coursemgmt.service.AdminService;
import com.ooad.coursemgmt.service.RequestService;
import com.ooad.coursemgmt.service.StudyPlannerService;
import com.ooad.coursemgmt.service.UserService;
import com.ooad.coursemgmt.service.CourseService;
import com.ooad.coursemgmt.service.CourseActivityService;
import com.ooad.coursemgmt.service.ProfessorService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LoginController {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);
	 @Resource(name="userService")
	 private UserService userService;
	 
	 @Resource(name="courseService")
	 private CourseService courseService;
	 
	 @Resource(name="professorService")
	 private ProfessorService professorService;
	 
	 @Resource(name="requestService")
	 private RequestService requestService;
	 
	 @Resource(name="studyPlannerService")
	 private StudyPlannerService studyPlannerService;
	 
	 @Resource(name="adminService")
	 private AdminService adminService;
	 
	 private String scramble = "blakeadeGRadedgDfefgAHbalkdaieseSGdgHsASwdfsdasZkabanGZXaffDgsADfdAD";
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/verifyUser", method = RequestMethod.GET)
	public String userAuth(@RequestParam String userId,@RequestParam String userPwd, Model model) {	
		String newPwd = getPwd(userPwd);
		System.out.println(userPwd);
		String user_role = userService.verifyUser(userId, newPwd);
		String semester = userService.getCurrentSemester();
		System.out.println("User role::" + user_role);
	    if (user_role != null){
	    	model.addAttribute("userId", userId);
	    	model.addAttribute("semester", semester);
			if (user_role.equalsIgnoreCase("student")){
			     // Retrieve all persons by delegating the call to PersonService
			     List<Course> courses = courseService.getRegisteredCourses(userId);
			     List<CourseActivity> regCourseActivity = studyPlannerService.getRegCourseActivities("Fall 2014", userId);
			     List<StudyPlan> studyPlans = studyPlannerService.getStudyPlans(userId);
			     // Attach persons to the Model
			     model.addAttribute("diplayResults", "None");
			     model.addAttribute("courses", courses);
			     model.addAttribute("courseActivities", regCourseActivity);
			     model.addAttribute("studyPlans", studyPlans);
			     System.out.println("# of activities retrieved" + regCourseActivity.size());
				return "StudentHome";
			}
			if (user_role.equalsIgnoreCase("professor")){
				List<Course> offeredCourses = professorService.getOfferedCourses(userId, "Fall 2014");
				model.addAttribute("offeredCourses", offeredCourses);
				model.addAttribute("dispActivity", "None");
				return "ProfessorHome";
			}
			if(user_role.equalsIgnoreCase("advisor")){
				List<Request> requests = requestService.getRequest(userId);			      
			    //model.addAttribute("diplayResults", "None");
				model.addAttribute("requests", requests);
				return "AdvisorHome";
			}
			if (user_role.equalsIgnoreCase("admin")){
				List<User> professorId = adminService.getProfessorIds();
				model.addAttribute("professorIds", professorId);
			    model.addAttribute("diplayResults", "None");
				return "AdminHome";
			}
	    }
		model.addAttribute("loginRes", "0");		
		return "home";
	}
	private String getPwd(String pwd){
		String newpwd = "";
		int scramblelen = this.scramble.length();
		int i = scramblelen;
		while(i<pwd.length()){
			newpwd = newpwd + pwd.charAt(i);
			i = i + scramblelen + 1;
		}
		System.out.println("Extracted password"+newpwd);
		return newpwd;
	}
}