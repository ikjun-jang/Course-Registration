<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Course Management</title>
  <link rel="stylesheet" href="resources/uilibs/css/uikit.min.css" />
  <script src="resources/uilibs/jquery-2.1.1.js"></script>
  <script src="resources/uilibs/js/uikit.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
  <link rel="stylesheet" href="resources/uilibs/demos/style.css">
  <style>
	  .userDetails {
	  	color: #0099FF;
	  }
  </style>
  <script>
  $(function() {
    $( "#tabs" ).tabs();
  });
  function searchOfferedCourse(userId){
	  semester = '${semester}';
	  searchUrl = "http://localhost:8085/coursemgmt/searchOfferedCourses?semester="+semester+"&uId=" + userId;
	  coursePrefix = document.getElementById("cPrefix").value;
      courseNum = document.getElementById("cNum").value;
      courseLevel = document.getElementById("cLevel").value;
      instructor = document.getElementById("instructor").value;
      courseStatus = document.getElementById("cStatus").value;
      searchUrl = searchUrl + "&cPrefix=" + coursePrefix + "&cNum=" + courseNum;
      searchUrl = searchUrl + "&cLevel=" + courseLevel + "&instructor=" + instructor + "&cStatus=" + courseStatus;
      window.location.href = searchUrl;
  }
 function searchCourseByAdmin(userId){
	 semester = '${semester}';
	  seUrl = "http://localhost:8085/coursemgmt/searchCoursesByAdmin?semester="+semester+"&uId=" + userId;
	  clsName = document.getElementById("crsName").value;
      clsNum = document.getElementById("cNumber").value;
      seUrl = seUrl + "&crsName=" + clsName + "&cNumber=" + clsNum;
      window.location.href = seUrl;
  }
  function saveOfferedCourse(userId) {
	  semester = '${semester}';
	  result = confirm("Are you sure, you want to save the course?");
	  if (result== true){
		  saveUrl = "http://localhost:8085/coursemgmt/saveOfferedCourse?semester="+semester+"&uId=" + userId;
		  prefix = document.getElementById("pre").value;
		  crsNum = document.getElementById("num").value;
		  semester = document.getElementById("sem").value;
		  stat = document.getElementById("stat").value;
		  inst = document.getElementById("inst").value;
		  level = document.getElementById("level").value;
		  method = document.getElementById("method").value;
		  timing = document.getElementById("time").value;
		  loc = document.getElementById("loc").value;
		  seatsAvail = document.getElementById("avail").value;
		  maxSeats = document.getElementById("max").value;
		  elem = document.getElementById("pid");
		  pid = elem.options[elem.selectedIndex].value;
		  if((prefix == "")||(crsNum == "")||(semester == "")||(stat == "")||(inst == "")||(level == "") || (method == "")||(timing=="")||(loc=="")||(seatsAvail=="")||(maxSeats=="")||(pid=="Select")){
			  alert("Please enter all the details.");
			  return;
		  }
		  saveUrl = saveUrl + "&pre=" + prefix + "&num=" + crsNum + "&sem=" + semester + "&stat=" + stat + "&inst=" + inst + "&level=" + level
		  			+ "&method=" + method + "&time=" + timing + "&loc=" + loc + "&avail=" + seatsAvail + "&max=" + maxSeats + "&pid=" + pid;
		  window.location.href = saveUrl;
	  }
  }
  function saveCourse(userId) {
	  semester = '${semester}';
	  result = confirm("Are you sure, you want to save the course?");
	  if (result== true){
		  saveUrl = "http://localhost:8085/coursemgmt/saveCourse?semester="+semester+"&uId=" + userId;
		  className = document.getElementById("className").value;
		  classNumber = document.getElementById("classNum").value;
		  credits = document.getElementById("credits").value;
		  saveUrl = saveUrl + "&className=" + className + "&classNum=" + classNumber + "&credits=" + credits; 
		  window.location.href = saveUrl;
	  }
  }
  function editOfferedCourse(userId){
	  semester = '${semester}';
	  editUrl = "http://localhost:8085/coursemgmt/editOfferedCourse?semester="+semester+"&uId=" + userId;
	  
	  selectedOfferedCourse = getCheckedBoxes("searchedOfferedCourses");
	  
	  if(selectedOfferedCourse == null){
		  alert("Error:Please select one course for edit");
		  return;
	  }
	  
	  editUrl = editUrl + "&courseNum=" + selectedOfferedCourse[0].id;
	  window.location.href = editUrl;	  
  }
  function editCourse(userId){
	  semester = '${semester}';
	  editUrl = "http://localhost:8085/coursemgmt/semester="+semester+"&editCourse?uId=" + userId;
	  
	  selectedCourse = getCheckedBoxes("searchedCourses");
	  
	  if(selectedCourse == null){
		  alert("Error:Please select one course for edit");
		  return;
	  }
	  
	  editUrl = editUrl + "&courseNum=" + selectedCourse[0].id;
	  window.location.href = editUrl;	  
  }
  function getCheckedBoxes(chkboxName) {
	  var checkboxes = document.getElementsByName(chkboxName);
	  var checkboxesChecked = [];
	  for (var i=0; i<checkboxes.length; i++) {
	     if (checkboxes[i].checked) {
	        checkboxesChecked.push(checkboxes[i]);
	     }
	  }
	  return checkboxesChecked.length > 0 ? checkboxesChecked : null;
	}
  function deleteOfferedCourse(userId) {
	  semester = '${semester}';
	  delUrl = "http://localhost:8085/coursemgmt/deleteOfferedCourse?semester="+semester+"&uId=" + userId;
	  
	  selectedOfferedCourse = getCheckedBoxes("searchedOfferedCourses");
	  
	  if(selectedOfferedCourse == null){
		alert("Error:Please select one course for remove");
		return;
	  }
	  
	  result = confirm("Are you sure, you want to remove the course?");
	  
	  if (result== true){
	  	delUrl = delUrl + "&courseNum=" + selectedOfferedCourse[0].id;
	  	window.location.href = delUrl;
	  }
  }
  function deleteCourse(userId) {
	  semester = '${semester}';
	  delUrl = "http://localhost:8085/coursemgmt/deleteCourse?semester="+semester+"&uId=" + userId;
	  
	  selectedCourse = getCheckedBoxes("searchedCourses");
	  
	  if(selectedCourse == null){
		alert("Error:Please select one course for remove");
		return;
	  }
	  
	  result = confirm("Are you sure, you want to remove the course?");
	  
	  if (result== true){
	  	delUrl = delUrl + "&courseNum=" + selectedCourse[0].id;
	  	window.location.href = delUrl;
	  }
  }
  function alertResult(editing, delRes, saveResult){
	  if (saveResult == "true"){
		  alert("Successfully saved the course");
	  }
	  if (saveResult == "false"){
		  alert("Couldn't save the course. Please try again later.");
	  }
	  if (delRes == "true"){
		  alert("Successfully removed the course.");
	  }
	  if (delRes == "false"){
		  alert("Couldn't remove the course. Please try again later.");
	  }
	  if (editing == "true"){
		  activeTab = $("#tabs").tabs("option", "active");
		  activeTab = activeTab + 1;
		  $("#tabs").tabs("option", "active", activeTab);
	  }
  }
  </script>
  <script src="resources/uilibs/js/projJs/autoComplete.js"></script>
</head>
<body onload="alertResult('${editing}', '${delRes}', '${saveResult}')">
	<div class="uk-grid">
	    <div class="uk-width-1-1"><img class="uk-width-1-1" height="50" src="resources/uilibs/images/Header.JPG" alt=""></div>
    </div>
    
    <div class="userDetails" align="right">
        <span> Semester: ${semester} &nbsp &nbsp &nbsp &nbsp</span>
	    <span> User name: ${userId} &nbsp &nbsp &nbsp &nbsp</span>
	    <a href="http://localhost:8085/coursemgmt"> logout </a>
    </div>
    <br/>
	<div id="tabs">
		  <ul>
		    <li><a href="#tabs-1">Offered Courses Admin Page</a></li>
		    <li><a href="#tabs-2">General Courses Admin Page</a></li>
		  </ul>
		  <div id="tabs-1">
		  <div class="uk-grid" >
		    <div class="uk-width-medium-1-2" style="background: url(&#39;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjQsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkViZW5lXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iMTEzMHB4IiBoZWlnaHQ9IjQ1MHB4IiB2aWV3Qm94PSIwIDAgMTEzMCA0NTAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDExMzAgNDUwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxyZWN0IGZpbGw9IiNGNUY1RjUiIHdpZHRoPSIxMTMwIiBoZWlnaHQ9IjQ1MCIvPg0KPC9zdmc+DQo=&#39;) 50% 0 no-repeat;">
		        <div class="uk-panel">
		        	<h2>Search</h2>
		        	<table class="uk-table uk-table-hover uk-table-condensed">
		        		<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<td>
						
						</td>
						</tr>
		        		<tr>
		        		<td>
		        			Class Prefix:
		        		</td>
		        		<td>
				        	<div class="ui-widget">
								 <input id="cPrefix">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<td>
		        			Class Number:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="cNum">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
		        			Class Status:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="cStatus">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
		        			Instructor:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="instructor">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
		        			Class Level:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="cLevel">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td></td>
						<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="searchOfferedCourse('${userId}')">Search</button></td>
						</tr>
					</table>					
				</div>
		    </div>
		    <div class="uk-width-medium-1-2" style="background: url(&#39;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjQsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkViZW5lXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iMTEzMHB4IiBoZWlnaHQ9IjQ1MHB4IiB2aWV3Qm94PSIwIDAgMTEzMCA0NTAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDExMzAgNDUwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxyZWN0IGZpbGw9IiNGNUY1RjUiIHdpZHRoPSIxMTMwIiBoZWlnaHQ9IjQ1MCIvPg0KPC9zdmc+DQo=&#39;) 50% 0 no-repeat;">
		        <div class="uk-panel">
		        	<h2>Add & Edit</h2>
		        	<table class="uk-table uk-table-hover uk-table-condensed">
		        		<tr>
		        		<td>
		        			Class Prefix:
		        		</td>
		        		<td>
				        	<div class="ui-widget">
								 <input id="pre" value='${prefix}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Number:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="num" value='${crsNum}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Semester:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="sem" value='${sem}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Status:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="stat" value='${status}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Instructor:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="inst" value='${inst}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Level:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="level" value='${level}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Instruction Method:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="method" value='${method}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Timing:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="time" value='${timing}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Location:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="loc" value='${location}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Seats Available:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="avail" value='${seatsAvail}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Maximum Seats:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="max" value='${maxSeats}'>
							</div>
						</td>
						</tr>
						<tr>
						<tr>
						<td>
		        			Professor ID:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <select name="professorid" id="pid">
						         	<option value="-99" selected>Select</option>
						         	<c:forEach items="${professorIds}" var="profId">
										<option value="${profId.userId}"><c:out value="${profId.userId}"/></option>
									</c:forEach>
								 </select>
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td></td>
						<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="saveOfferedCourse('${userId}')">Save</button></td>
						</tr>
					</table>					
				</div>
		    </div>
		    <div class="uk-width-1-1" style="display: ${diplayResults}" >
	<div class="uk-panel">
		<h2>Search Results</h2>
		<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
			<tr>
				<td colspan=10></td>
				<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="editOfferedCourse('${userId}')">Edit</button></td>
				<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="deleteOfferedCourse('${userId}')">Delete</button></td>
			</tr>
			<tr>
				<td width="100"> Course Number </td>
				<td width="100"> Semester </td>
				<td width="100"> Course Prefix </td>
				<td width="100"> Course Level </td>
				<td width="100"> Course Instructor </td>
				<td width="100"> Professor ID </td>
				<td width="100"> Instruction Method </td>
				<td width="100"> Course Timing </td>
				<td width="100"> Course Location </td>
				<td width="100"> Seats Available </td>
				<td width="100"> Maximum Seats </td>
				<td width="100"> Course Status </td>
			</tr>
			<c:forEach items="${searchedOfferedCourses}" var="course">
				<tr>
					<td><input name="searchedOfferedCourses" type="checkbox" id="${course.courseNumber}"><label for="${course.courseNumber}">${course.courseNumber}</label></td>
					<td><c:out value="${course.semester}" /></td>
					<td><c:out value="${course.coursePrefix}" /></td>
					<td><c:out value="${course.courseLevel}" /></td>
					<td><c:out value="${course.instructor}" /></td>
					<td><c:out value="${course.professorId}" /></td>
					<td><c:out value="${course.instructionMethod}" /></td>					
					<td><c:out value="${course.courseTiming}" /></td>
					<td><c:out value="${course.courseLocation}" /></td>
					<td><c:out value="${course.seatsAvailable}" /></td>
					<td><c:out value="${course.maximumSeats}" /></td>
					<td><c:out value="${course.status}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
		  </div>
  		  </div>
    <div id="tabs-2">
<div class="uk-width-medium-1-2" style="background: url(&#39;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjQsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkViZW5lXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iMTEzMHB4IiBoZWlnaHQ9IjQ1MHB4IiB2aWV3Qm94PSIwIDAgMTEzMCA0NTAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDExMzAgNDUwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxyZWN0IGZpbGw9IiNGNUY1RjUiIHdpZHRoPSIxMTMwIiBoZWlnaHQ9IjQ1MCIvPg0KPC9zdmc+DQo=&#39;) 50% 0 no-repeat;">
		        <div class="uk-panel">
		        	<h2>Search</h2>
		        	<table class="uk-table uk-table-hover uk-table-condensed">
		        		<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<td>
						
						</td>
						</tr>
		        		<tr>
		        		<td>
		        			Class Number:
		        		</td>
		        		<td>
				        	<div class="ui-widget">
								 <input id="cNumber">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<td>
		        			Class Name:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="crsName">
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td></td>
						<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="searchCourseByAdmin('${userId}')">Search</button></td>
						</tr>
					</table>					
				</div>
		    </div>
		    <div class="uk-width-medium-1-2" style="background: url(&#39;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjQsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkViZW5lXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iMTEzMHB4IiBoZWlnaHQ9IjQ1MHB4IiB2aWV3Qm94PSIwIDAgMTEzMCA0NTAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDExMzAgNDUwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxyZWN0IGZpbGw9IiNGNUY1RjUiIHdpZHRoPSIxMTMwIiBoZWlnaHQ9IjQ1MCIvPg0KPC9zdmc+DQo=&#39;) 50% 0 no-repeat;">
		        <div class="uk-panel">
		        	<h2>Add & Edit</h2>
		        	<table class="uk-table uk-table-hover uk-table-condensed">
		        		<tr>
		        		<td>
		        			Class Number:
		        		</td>
		        		<td>
				        	<div class="ui-widget">
								 <input id="classNum" value='${classNum}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Class Name:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="className" value='${className}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
		        			Credits:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="credits" value='${credits}'>
							</div>
						</td>
						</tr>
						<tr>
						<td>
						
						</td>
						</tr>
						<tr>
						<td>
						<tr>
						<td></td>
						<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="saveCourse('${userId}')">Save</button></td>
						</tr>
						</td>
						</tr>
					</table>					
				</div>
		    </div>
	<div class="uk-width-1-1" style="display: ${diplayResult}" >
	<div class="uk-panel">
		<h2>Search Results</h2>
		<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
			<tr>
				<td colspan=5></td>
				<td align="left"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="editCourse('${userId}')">Edit</button></td>
				<td align="left"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="deleteCourse('${userId}')">Delete</button></td>
			</tr>
			<tr>
				<td width="300"> Course Number </td>
				<td width="300"> Course Name </td>
				<td width="300"> Credits </td>
			</tr>
			<c:forEach items="${searchedCourses}" var="course">
				<tr>
					<td><input name="searchedCourses" type="checkbox" id="${course.courseNumber}"><label for="${course.courseNumber}">${course.courseNumber}</label></td>
					<td><c:out value="${course.courseName}" /></td>
					<td><c:out value="${course.courseCredits}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div> 
    </div>
</div>

 
 
</body>
</html>