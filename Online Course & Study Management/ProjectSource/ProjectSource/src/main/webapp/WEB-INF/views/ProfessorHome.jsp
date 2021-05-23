<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Professor Home</title>
  <link rel="stylesheet" href="resources/uilibs/css/uikit.min.css" />
  <script src="resources/uilibs/jquery-2.1.1.js"></script>
  <script src="resources/uilibs/js/uikit.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <script src="resources/uilibs/js/components/datepicker.js"></script>
  <style>
	  .userDetails {
	  	color: #0099FF;
	  }
  </style>
  <script>
	  $(function() {
	    $( "#tabs" ).tabs();
	  });
	  
	  $(function() {
	    $( "#datepicker" ).datepicker();
	  });
	  
	  function deleteActivity(courseNum, activityId){
		  semester = '${semester}';
		  result = confirm("Are you sure you want to delete the course activity?");
		  if(result == true){
			  deleteUrl = "http://localhost:8085/coursemgmt/deleteActivity?courseNum=" + courseNum + "&activityId=" + activityId + "&professorId="+ '${userId}' + "&semester=Fall 2014";
			  window.location.href = deleteUrl;
		  }
	  }
	  function addEditActivity(){
		  semester = '${semester}';
		  elem = document.getElementById("addEditHead");
		  activityName = document.getElementById("actName").value;
		  activityDescription = document.getElementById("actDesc").value;
		  deadline = document.getElementById("datepicker").value;
		  currDate = new Date();
		  inval = deadline.split("/");
		  givenDeadline = new Date(inval[2], inval[0]-1, inval[1] );
		  if((deadline=="")||(currDate > givenDeadline)){
			  alert("Error: Deadline should be today or later!");
			  return;
		  }
		  if (elem.innerHTML == "Add Activity"){
			  elem = document.getElementById("crsName");
			  courseNum = elem.options[elem.selectedIndex].value;
			  addUrl = "http://localhost:8085/coursemgmt/addActivity?courseNum="+courseNum+ "&professorId="+ '${userId}' +"&activityName="+activityName+"&activityDescription="+activityDescription+"&deadline="+deadline + "&semester=Fall 2014";
			  window.location.href = addUrl;
		  }
		  else{
			  editUrl = "http://localhost:8085/coursemgmt/editActivity?courseNum="+globalCourseNumber + "&activityId=" + globalActivityId + "&professorId="+ '${userId}' +"&activityName="+activityName+"&activityDescription="+activityDescription+"&deadline="+deadline + "&semester=Fall 2014";
			  window.location.href = editUrl;
		  }
	  }
	  function editActivity(courseNum, actId, actName, actDesc, deadline){
		  semester = '${semester}';
		  elem = document.getElementById("addEditHead");
		  elem.innerHTML = "Edit Activity";
		  elem = document.getElementById("addEditButton");
		  elem.innerHTML = "Edit";
		  elem = document.getElementById("courseNameAdd");
		  elem.style = "display:none";
		  //courseNum = elem.options[elem.selectedIndex].value;
		  document.getElementById("actName").value = actName;
		  document.getElementById("actDesc").value = actDesc;
		  document.getElementById("datepicker").value = deadline;
		  globalCourseNumber = courseNum;
		  globalActivityId = actId;
		 // addUrl = "http://localhost:8085/coursemgmt/addActivity?courseNum="+courseNum+ "&professorId="+ '${userId}' +"&activityName="+activityName+"&activityDescription="+activityDescription+"&deadline="+deadline + "&semester=Fall 2014";
		  //window.location.href = addUrl;
	  }
	  function alertResult(delRes){
		  if (delRes == "true"){
			  alert("Successfully deleted the course activity.");
		  }
		  if (delRes == "false"){
			  alert("Couldn't delete the course activity. Please try again later.");
		  }
	  }
  </script>
</head>
<body onload="alertResult('${delResult}')">
	<div class="uk-grid">
	    <div class="uk-width-1-1"><img class="uk-width-1-1" height="50" src="resources/uilibs/images/Header.JPG" alt=""></div>
    </div>
    
    <div class="userDetails" align="right">
        <span> Semester: ${semester} &nbsp &nbsp &nbsp &nbsp</span>
	    <span> User name: ${userId} &nbsp &nbsp &nbsp &nbsp</span>
	    <a href="http://localhost:8085/coursemgmt"> logout </a>
    </div>
    <br/>
    <div style="padding-left:15px">
    	<span>Please select the course whose details are to be displayed:&nbsp &nbsp</span>
	    <div class="uk-button-dropdown" data-uk-dropdown="{mode:'click'}">
	    	<button class="uk-button">
	    		Select Course
	    		<i class="uk-icon-caret-down"></i>
	    	</button>
	    	<div class="uk-dropdown">
		    	<ul class="uk-nav uk-nav-dropdown">
			    	<c:forEach items="${offeredCourses}" var="offeredCourse">
			    		<li><a href="http://localhost:8085/coursemgmt/courseActivities?courseNum=${offeredCourse.courseNumber}&semester=${offeredCourse.semester}&professorId=${userId}"><c:out value="${offeredCourse.courseName}" /></a></li>
			    	</c:forEach>
		    	</ul>
	    	</div>
		</div>
	</div>
	<br/>
	<div class="uk-grid uk-grid-divider" style="padding:15px; border: 2px groove grey;">
		<div class="uk-width-medium-1-2">
	        <div class="uk-panel">
	        	<h2>Course Activities</h2>
	        	<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed" style="display: ${dispActivity}">
					<tr>
						<td width="300">Activity Name</td>
						<td width="400">Activity Description</td>
						<td width="300">Posted On</td>
						<td width="300">Deadline</td>
						<td colspan=2>Action</td>
					</tr>
					<c:forEach items="${courseActivities}" var="activity">
						<tr>
							<td><c:out value="${activity.activityName}" /></td>
							<td><c:out value="${activity.activityDescription}" /></td>
							<td><c:out value="${activity.postDate}" /></td>
							<td><c:out value="${activity.deadline}" /></td>
							<td><button class="uk-button" type="button" onclick="editActivity(${activity.courseNumber}, ${activity.activityId}, '${activity.activityName}', '${activity.activityDescription}', '${activity.deadline}' )">Edit</button></td>
							<td><button class="uk-button" type="button" onclick="deleteActivity(${activity.courseNumber}, ${activity.activityId})">Delete</button></td>
						</tr>
					</c:forEach>
				</table>
	        </div>
	    </div>   
		<div class="uk-width-medium-1-2">
	        <div class="uk-panel">
				<h2 id="addEditHead" >Add Activity</h2>
				<form class="uk-form">
				    <fieldset>
				        <legend>Please enter activity details.</legend>
				        <table>
				        <tr id="courseNameAdd">
					        <td> Course Name </td>
					        <td>
						         <select name="courseName" id="crsName">
						         	<option value="-99" selected>Course Name</option>
						         	<c:forEach items="${offeredCourses}" var="offeredCourse">
										<option value="${offeredCourse.courseNumber}"><c:out value="${offeredCourse.courseName}"/></option>
									</c:forEach>
								 </select>
							</td>
				        </tr>
				        <tr>
				        	<td> Activity Name </td>
				        	<td><input type="text" id="actName" placeholder="Actvity Name"></td>
						</tr>
						<tr>
							<td> Activity Description </td>
							<td><input type="text" id="actDesc" placeholder="Actvity Description"></td>
						</tr>
						<tr>
							<td> Deadline </td>
							<td> <input type="text" id="datepicker" placeholder="Date"> </td>
						</tr>
						
						<tr>
							<td>  </td>
							<td align="right"><button class="uk-button" type="button" id="addEditButton" onclick="addEditActivity()">Add</button></td>
						</tr>
						</table>
				    </fieldset>
				</form>
			</div>
		</div>
	</div>
</body>
</html>