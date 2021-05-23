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

import com.ooad.coursemgmt.domain.CourseActivity;
import com.ooad.coursemgmt.domain.Request;
import com.ooad.coursemgmt.service.RequestService;

/**
 * Handles requests for the advisor home page.
 */
@Controller
public class AdvisorHomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdvisorHomeController.class);
	 @Resource(name="requestService")
	 private RequestService requestService;
	
	@RequestMapping(value = "/rejectRequest", method = RequestMethod.GET)
	public String rejectRequest(@RequestParam String semester, @RequestParam String advisorId, @RequestParam String studentId, @RequestParam String courseNumber, Model model) {
		logger.debug("Received request to reject a student request");
		
		System.out.println("In Controller::" + advisorId + " " + studentId + "  "+courseNumber);
		boolean result = requestService.updateRequestStatus(studentId, Integer.parseInt(courseNumber), "Rejected");
		System.out.println("Rejection result:" + result);
		model.addAttribute("rejectResult", result);
	     List<Request> requests = requestService.getRequest(advisorId);
	     model.addAttribute("requests", requests);
	     model.addAttribute("userId", advisorId);
	     model.addAttribute("semester", semester);
		return "AdvisorHome";
	}
	
	@RequestMapping(value = "/acceptRequest", method = RequestMethod.GET)
	public String acceptRequest(@RequestParam String semester, @RequestParam String advisorId, @RequestParam String studentId, @RequestParam String courseNumber, Model model) {
		logger.debug("Received request to accept a student request");
		
		System.out.println("In Controller::" + studentId + "  "+courseNumber);
		boolean result = requestService.updateRequestStatus(studentId, Integer.parseInt(courseNumber), "Accepted");
		System.out.println("Acceptance result:" + result);
		model.addAttribute("acceptResult", result);
	     List<Request> requests = requestService.getRequest(advisorId);
	     model.addAttribute("requests", requests);
	     model.addAttribute("userId", advisorId);
	     model.addAttribute("semester", semester);
		return "AdvisorHome";
	}	
}
