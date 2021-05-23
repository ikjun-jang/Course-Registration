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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ooad.coursemgmt.domain.Course;
import com.ooad.coursemgmt.domain.User;
import com.ooad.coursemgmt.service.AdminService;
import com.ooad.coursemgmt.domain.OfferedCourse;
/**
 * Handles requests for the application home page.
 */
@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	 @Resource(name="adminService")
	 
	 private AdminService adminService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/saveOfferedCourse", method = RequestMethod.GET)
	public String saveOfferedCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String pre, @RequestParam String num, @RequestParam String sem, 
			@RequestParam String stat, @RequestParam String inst, @RequestParam String level, @RequestParam String method, @RequestParam String time,
			@RequestParam String loc, @RequestParam String avail, @RequestParam String max, @RequestParam String pid, Model model) {
		
		boolean saveResult = adminService.saveOfferedCourse(pre, Integer.parseInt(num), sem, stat, inst, 
				level, method, time, loc, Integer.parseInt(avail), Integer.parseInt(max), pid);
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("saveResult", saveResult);
		model.addAttribute("diplayResults", "None");
		model.addAttribute("userId", uId);
		model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/saveCourse", method = RequestMethod.GET)
	public String saveCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String className, @RequestParam String classNum, @RequestParam String credits, Model model) {
		
		boolean saveResults = adminService.saveCourse(className, Integer.parseInt(classNum), Integer.parseInt(credits));
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("saveResult", saveResults);
		model.addAttribute("diplayResult", "None");
		model.addAttribute("userId", uId);
		model.addAttribute("editing", true);
		model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/searchOfferedCourses", method = RequestMethod.GET)
	public String searchOfferedCourses(@RequestParam String semester, @RequestParam String uId, @RequestParam String cPrefix,
			@RequestParam String cNum, @RequestParam String instructor,
				@RequestParam String cStatus, @RequestParam String cLevel, Model model) {
		
		logger.debug("Received request to search offered courses.");
		System.out.println("In Controller::" + uId + "  num" + cNum + " Prefix:" + cPrefix);
		
		
		List<OfferedCourse> searchedOfferedCourses = null;
		
		if(cNum.equals("") && cPrefix.equals("") && instructor.equals("") &&
				cStatus.equals("") && cLevel.equals("")){
			    System.out.println("Getting all the offered courses.");
			    searchedOfferedCourses = adminService.displayAllOfferedCourse();
		}
		else{
			OfferedCourse offeredCourseDetails = new OfferedCourse();
			
			if (!cNum.equals(""))
				offeredCourseDetails.setCourseNumber(Integer.parseInt(cNum));
			else
				offeredCourseDetails.setCourseNumber(-99);
			
			offeredCourseDetails.setCoursePrefix(cPrefix);
			offeredCourseDetails.setInstructor(instructor);
			offeredCourseDetails.setStatus(cStatus);
			offeredCourseDetails.setCourseLevel(cLevel);
			
			System.out.println("Getting restricted offered courses.");
			searchedOfferedCourses = adminService.searchOfferedCourses(offeredCourseDetails);
		}
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("diplayResults", "display");
		model.addAttribute("searchedOfferedCourses", searchedOfferedCourses);
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/searchCoursesByAdmin", method = RequestMethod.GET)
	public String searchCoursesByAdmin(@RequestParam String semester, @RequestParam String uId, @RequestParam String crsName, @RequestParam String cNumber, Model model) {
		
		logger.debug("Received request to search courses.");
		System.out.println("In Controller::" + uId + "  num" + cNumber);
		
		Course courseDetails = new Course();
		
		if (!cNumber.equals(""))
			courseDetails.setCourseNumber(Integer.parseInt(cNumber));
		else
			courseDetails.setCourseNumber(-99);
		
		courseDetails.setCourseName(crsName);
		
		List<Course> searchedCourses = null;
		
		if(cNumber.equals("") && crsName.equals("")){
			    System.out.println("Getting all the courses.");
			    searchedCourses = adminService.displayAllCourse();
		}
		else{
			System.out.println("Getting restricted offered courses.");
			searchedCourses = adminService.searchCourses(courseDetails);
		}
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("diplayResult", "display");
		model.addAttribute("searchedCourses", searchedCourses);
	    model.addAttribute("userId", uId);
	    model.addAttribute("editing", true);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/editOfferedCourse", method = RequestMethod.GET)
	public String editOfferedCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum, Model model){
		logger.debug("Received request to edit a course.");
		System.out.println("In Controller::" + uId + "  num" + courseNum);
		model.addAttribute("diplayResults", "None");
		List<OfferedCourse> selectedOfferedCourse = adminService.editOfferedCourse(Integer.parseInt(courseNum));
		
		String prefix = selectedOfferedCourse.get(0).getCoursePrefix();
		int num = selectedOfferedCourse.get(0).getCourseNumber();
		String sem = selectedOfferedCourse.get(0).getSemester();
		String status = selectedOfferedCourse.get(0).getStatus();
		String inst = selectedOfferedCourse.get(0).getInstructor();
		String level = selectedOfferedCourse.get(0).getCourseLevel();
		String method = selectedOfferedCourse.get(0).getInstructionMethod();
		String timing = selectedOfferedCourse.get(0).getCourseTiming();
		String location = selectedOfferedCourse.get(0).getCourseLocation();
		int seatsAvail = selectedOfferedCourse.get(0).getSeatsAvailable();
		int maxSeats = selectedOfferedCourse.get(0).getMaximumSeats();
		String pid = selectedOfferedCourse.get(0).getProfessorId();
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("prefix", prefix);
		model.addAttribute("crsNum", num);
		model.addAttribute("sem", sem);
		model.addAttribute("status", status);
		model.addAttribute("inst", inst);
		model.addAttribute("level", level);
		model.addAttribute("method", method);
		model.addAttribute("timing", timing);
		model.addAttribute("location", location);
		model.addAttribute("seatsAvail", seatsAvail);
		model.addAttribute("maxSeats", maxSeats);
		model.addAttribute("pid", pid);
		
		//model.addAttribute("selectedOfferedCourse", selectedOfferedCourse);
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/editCourse", method = RequestMethod.GET)
	public String editCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum, Model model){
		logger.debug("Received request to edit a course.");
		System.out.println("In Controller::" + uId + "  num" + courseNum);
		model.addAttribute("diplayResult", "None");
		List<Course> selectedCourse = adminService.editCourse(Integer.parseInt(courseNum));
		
		String cName = selectedCourse.get(0).getCourseName();
		int num = selectedCourse.get(0).getCourseNumber();
		int credits = selectedCourse.get(0).getCourseCredits();
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("className", cName);
		model.addAttribute("classNum", num);
		model.addAttribute("credits", credits);
		model.addAttribute("editing", true);
		
		//model.addAttribute("selectedOfferedCourse", selectedOfferedCourse);
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/deleteOfferedCourse", method = RequestMethod.GET)
	public String deleteOfferedCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum, Model model){
		logger.debug("Received request to remove a course.");
		System.out.println("In Controller::" + uId + "  num" + courseNum);
		boolean result = adminService.deleteOfferedCourse(Integer.parseInt(courseNum));
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("delRes", result);
		model.addAttribute("diplayResults", "None");
	    model.addAttribute("userId", uId);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
	
	@RequestMapping(value = "/deleteCourse", method = RequestMethod.GET)
	public String deleteCourse(@RequestParam String semester, @RequestParam String uId, @RequestParam String courseNum, Model model){
		logger.debug("Received request to remove a course.");
		System.out.println("In Controller::" + uId + "  num" + courseNum);
		boolean result = adminService.deleteCourse(Integer.parseInt(courseNum));
		List<User> professorId = adminService.getProfessorIds();
		model.addAttribute("professorIds", professorId);
		model.addAttribute("delRes", result);
		model.addAttribute("diplayResult", "None");
	    model.addAttribute("userId", uId);
	    model.addAttribute("editing", true);
	    model.addAttribute("semester", semester);
		return "AdminHome";
	}
}
	