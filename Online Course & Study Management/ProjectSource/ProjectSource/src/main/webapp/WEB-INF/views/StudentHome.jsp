<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
  <title>Course Management</title>
  <link rel="stylesheet" href="resources/uilibs/css/uikit.min.css" />
  <script src="resources/uilibs/date.js"></script>
  <script src="resources/uilibs/jquery-2.1.1.js"></script>
  <script src="resources/uilibs/js/uikit.min.js"></script>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.2/jquery-ui.js"></script>
   <link rel="stylesheet" type="text/css" href="resources/uilibs/css/jquery.jqChart.css" />
    <link rel="stylesheet" type="text/css" href="resources/uilibs/css/jquery.jqRangeSlider.css" />
    <link rel="stylesheet" type="text/css" href="resources/uilibs/css/jquery-ui-1.10.4.css" />
    <script src="resources/uilibs/js/jquery.mousewheel.js" type="text/javascript"></script>
    <script src="resources/uilibs/js/jquery.jqChart.min.js" type="text/javascript"></script>
    <script src="resources/uilibs/js/jquery.jqRangeSlider.min.js" type="text/javascript"></script>
  <link rel="stylesheet" href="resources/uilibs/demos/style.css">
  <style>
	  .userDetails {
	  	color: #0099FF;
	  }
  </style>
  <script>
  var MAX_COURSES = 4;
  $(function() {
    $( "#tabs" ).tabs();
  });
  $(function() {
	    $( "#planTabs" ).tabs();
  });
  var semester = '${semester}';
  function deletePlan(planId){
	  result = confirm("Are you sure, you want to delete the plan?");
	  if (result== true){
		  delUrl = "http://localhost:8085/coursemgmt/deletePlan?semester="+semester+"&userId=${userId}&planId="+planId;
		  window.location.href = delUrl;
	  }
  }
  
  function myGetDate(myDate){
	  dd = myDate.getDate();
	  mm = myDate.getMonth() + 1;
	  yyyy = myDate.getFullYear();
	  return mm+"-"+dd+"-"+yyyy;
  }
  
  function savePlan(planId){ 
	  saveUrl = "http://localhost:8085/coursemgmt/savePlan?semester="+semester+"&userId=${userId}&planId="+planId+"&planName="+planNameGiven;
	  
	  if(activityDetails[0].taskName != ""){
		  saveUrl = saveUrl + "&taskName1=" + activityDetails[0].taskName+"&stDt1="+myGetDate(activityDetails[0].startDate)+"&enDt1="+myGetDate(activityDetails[0].endDate);
	  }
	  if((activityDetails.length == 3)||(activityDetails.length == 2)){
		  saveUrl = saveUrl + "&taskName2=" + activityDetails[1].taskName+"&stDt2="+myGetDate(activityDetails[1].startDate)+"'&enDt2="+myGetDate(activityDetails[1].endDate)+"";
	  }
	  else{
		  saveUrl = saveUrl + "&taskName2=''&stDt2=''&enDt2=''";
	  }
	  if(activityDetails.length == 3){
		  saveUrl = saveUrl + "&taskName3=" + activityDetails[2].taskName+"&stDt3="+myGetDate(activityDetails[2].startDate)+"'&enDt3="+myGetDate(activityDetails[2].endDate);
	  }
	  else{
		  saveUrl = saveUrl + "&taskName3=''&stDt3=''&enDt3=''";
	  }
	  alert(saveUrl);
	  window.location.href = saveUrl;
	  
  }
  
  function dropCourse(courseNumber, userId){
	  result = confirm("Are you sure, you want to drop the course?");
	  if (result== true){
		  delUrl = "http://localhost:8085/coursemgmt/deleteRegCourse?semester="+semester+"&userId="+userId+"&courseNumber="+courseNumber;
		  window.location.href = delUrl;
	  }
  }
  
  function swapCourse(courseNumber, noOfCoursesRegd, userId){
	  result = confirm("Are you sure, you want to swap the course?");
	  if (result== true){
		  swapUrl = "http://localhost:8085/coursemgmt/swapCourses?semester="+semester+"&uId="+userId+"&courseNum1="+courseNumber;
		  selectedCourses = getCheckedBoxes("searchedCourses");
		  if(selectedCourses == null){
			  alert("Error:Please select one course for swapping.");
			  return;
		  }
		  var allowed = MAX_COURSES - noOfCoursesRegd;
		  //alert(allowed + "   " + selectedCourses.length);
		  if((MAX_COURSES - noOfCoursesRegd) < selectedCourses.length){
			  alert("Error:Trying to register for more than four courses.");
			  return;
		  }
		  var swapCourseNum = selectedCourses[0].id;
		  if(courseNumber == swapCourseNum){
			  alert("Not allowed to swap with the same course.");
			  return;
		  }
		  swapUrl = swapUrl + "&courseNum2=" + selectedCourses[0].id;
		  //alert(swapUrl);
		  window.location.href = swapUrl;
	  }
  }
  
  function searchCourse(userId){
	  searchUrl = "http://localhost:8085/coursemgmt/searchCourses?semester="+semester+"&uId=" + userId;
	  coursePrefix = document.getElementById("cPrefix").value;
	  courseName = document.getElementById("cName").value;
      courseNum = document.getElementById("cNum").value;
      courseLevel = document.getElementById("cLevel").value;
      instructor = document.getElementById("instructor").value;
      courseStatus = document.getElementById("cStatus").value;
      searchUrl = searchUrl + "&cPrefix=" + coursePrefix + "&cName=" + courseName + "&cNum=" + courseNum;
      searchUrl = searchUrl + "&cLevel=" + courseLevel + "&instructor=" + instructor + "&cStatus=" + courseStatus;
      window.location.href = searchUrl;
  }
  
  function registerCourse(userId, noOfCoursesRegd){

	  registerUrl = "http://localhost:8085/coursemgmt/registerCourses?semester="+semester+"&uId=" + userId;
	  
	  selectedCourses = getCheckedBoxes("searchedCourses");
	  
	  if(selectedCourses == null){
		  alert("Error:Please select one course for registration.");
		  return;
	  }
	  var allowed = MAX_COURSES - noOfCoursesRegd;
      //alert(allowed + "   " + selectedCourses.length);
	  if((MAX_COURSES - noOfCoursesRegd) < selectedCourses.length){
		  alert("Error:Trying to register for more than four courses.");
		  return;
	  }
	  <c:forEach items="${courses}" var="course">
	  		var regdCourse = '${course.courseNumber}';
	  		if(selectedCourses[0].id == regdCourse){
	  			alert("Error: Already registered for the course!");
	  			return;
	  		}
	  </c:forEach>
	  registerUrl = registerUrl + "&courseNum1=" + selectedCourses[0].id;
	  //alert(registerUrl);
	  window.location.href = registerUrl;	  
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
  function alertResult(registerResult, swapResult, delRes){
	  if (registerResult != ""){
		  alert(registerResult);
	  }
	  if (swapResult != ""){
		  alert(swapResult);
	  }
	  if (delRes == "true"){
		  alert("Successfully dropped the course.");
	  }
	  if (delRes == "false"){
		  alert("Couldn't dropped the course. Please try again later.");
	  }
  }
  function compareActs(a, b){
	  return a.priority - b.priority;
  }
  function addDays(myDate, days){
	  noOfDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	  dd = myDate.getDate();
	  mm = myDate.getMonth();
	  yyyy = myDate.getFullYear();
	  console.log("Given date:"+mm+"/"+dd+"/"+yyyy);
	  dd = dd + days;
	  if(dd > noOfDays[mm]){
		  dd = dd - noOfDays[mm];
		  mm = mm + 1;
		  if(mm == 12){
			  mm = mm % 12;
			  yyyy = yyyy + 1;
		  }
	  }
	  console.log("Added "+days+"days to "+ myDate);
	  //myDate.setDate(dd);
	  //myDate.setMonth(mm);
	  //myDate.setFullYear(yyyy);
	  console.log("Given date:"+mm+"/"+dd+"/"+yyyy);
	  return new Date(yyyy, mm, dd);
  }
  
  function subtractDays(myDate, days){
	  noOfDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
	  dd = myDate.getDate();
	  mm = myDate.getMonth();
	  yyyy = myDate.getFullYear();
	  console.log("Given date:"+mm+"/"+dd+"/"+yyyy);
	  dd = dd - days;
	  if(dd < 0){
		  mm = mm - 1;
		  if(mm < 0){
			  mm = 0;
			  yyyy = yyyy - 1;
		  }
		  dd = dd + noOfDays[mm];
	  }
	  console.log("Deducted "+days+"days to "+ myDate);
	  //myDate.setDate(dd);
	  //myDate.setMonth(mm);
	  //myDate.setFullYear(yyyy);
	  console.log("Result:"+mm+"/"+dd+"/"+yyyy);
	  return new Date(yyyy, mm, dd);
  }
  
  function generateStudyPlan(createButton){
	  
	  
	  // Get all the checked boxes.
	  selectedActivities = getCheckedBoxes("selAct");
	  
	  // Check if the value is null, and return error if yes.
	  if(selectedActivities == null){
		  alert("Error:Please select activities for plan creation.");
		  return;
	  }
	  
	  if(selectedActivities.length > 3){
		  alert("Error: Sorry right now we support only 3 tasks per plan.");
		  return;
	  }
	  
	  // Get the values of plan name and hours put in a day.
	  planNameGiven = (document.getElementById("newPlanName")).value;
	  hoursPerDay = (document.getElementById("hpd")).value;

	  if((planNameGiven == "") || (planNameGiven == null)){
		  alert("Error: Please provide a plan name.");
		  return;
	  }
	  
	  if((hoursPerDay == "") || (hoursPerDay == null)){
		  alert("Error: Please provide number of hours you can work per day.");
		  return;
	  }
	  
	  
	  difficultyHours = 3;  // Constant, difficulty to work hour conversion value.
	  activityDetails = []; // Array to hold values for display in chart.
	  activityIds = [];     // Activity Ids of the course activities selected.
      courseNums = [];		// Course number of course activities selected.
	  difficulties = [];    // Difficulty value as entered by student.
	  priorities = [];		// Priority of the course activity, calculated.
	  daysReqd = [];        // Days required to complete course activity, calculated.
	  // Loop through the activities and extract the activityIds, courseNumbers and difficulties.
	  var today = new Date();
	  for(i=0; i<selectedActivities.length; i++){
		  var myact = selectedActivities[i].id;
		  var parts = myact.split("act");
		  var diffId = parts[0] + "diff" + parts[1];
		  var difficulty = document.getElementById(diffId).value;
		  activityIds.push(parts[1]);
		  courseNums.push(parts[0]);
		  difficulties.push(difficulty);
	  }
	  // Loop through the activity details session variables, to get daysLeft, deadline, activityName, activityDescription values for the selected course activities.
	  i = 0;
	  <c:forEach items="${courseActivities}" var="myactivities">
	  		if((activityIds[i] == '${myactivities.activityId}') && (courseNums[i] == '${myactivities.courseNumber}')){
	  			activityDetails.push({activityId: '${myactivities.activityId}', courseNum: '${myactivities.courseNumber}', daysLeft: '${myactivities.daysLeft}', deadline: '${myactivities.deadline}', actName: '${myactivities.activityName}', actDesc: '${myactivities.activityDescription}'});
	  			i++;
	  		}
	  </c:forEach>
	  	  
	  for(i=0; i<selectedActivities.length; i++){
		  priority = difficulties[i] / activityDetails[i].daysLeft;
		  priorities.push(priority);
		  activityDetails[i].priority = priority;
		  days = (difficulties[i] * difficultyHours)/hoursPerDay;
		  daysReqd.push(days);
		  activityDetails[i].daysReqd = Math.ceil(days);
		  console.log(activityDetails[i].activityId+":"+activityDetails[i].courseNum+":"+activityDetails[i].priority+":"+activityDetails[i].daysReqd);
	  }
	  	  
	  activityDetails.sort(compareActs);
	  console.log("Activities selected::"+activityDetails.length);
	  //console.log(activityDetails[0].activityId+":"+activityDetails[0].courseNum+":"+activityDetails[0].priority+":"+activityDetails[0].daysReqd);
	  //console.log(activityDetails[1].activityId+":"+activityDetails[1].courseNum+":"+activityDetails[1].priority+":"+activityDetails[1].daysReqd);
	  //console.log(activityDetails[2].activityId+":"+activityDetails[2].courseNum+":"+activityDetails[2].priority+":"+activityDetails[2].daysReqd);
	  
	  var colorFills = [];
	  var myTaskDetails = [];
	  var salen = selectedActivities.length - 1;
	  for(i=selectedActivities.length - 1; i > -1; i--){
		  deadline = new Date(activityDetails[i].deadline);
		  estCompDate = addDays(today, parseInt(activityDetails[i].daysReqd));
		  //estCompDate.setDate(today.getDate() + parseInt(activityDetails[i].daysReqd));
		  console.log("Days required - " + activityDetails[i].daysReqd);
		  console.log("Available start date:"+ today + " :: Estimated:" + estCompDate + "::Deadline" + deadline);
		  if(estCompDate > deadline){
			  console.log("if");
			  activityDetails[i].note = "Need to put in more hours per day than "+hoursPerDay+"hours.";
			  activityDetails[i].startDate = subtractDays(deadline, parseInt(activityDetails[i].daysReqd));
			  //activityDetails[i].startDate.setDate(deadline.getDate() - activityDetails[i].daysReqd);
			  activityDetails[i].endDate = new Date(activityDetails[i].deadline);
			  
		  }
		  else{
			  console.log("else");
			  activityDetails[i].startDate = new Date(today.toString());
			  //activityDetails[i].startDate.setDate(today.getDate());
			  activityDetails[i].endDate = new Date(estCompDate.toString());
		  }
		  today = new Date((activityDetails[i].endDate).toString());
		  colorFills.push("#506381");
		  yAxis = activityDetails[i].courseNum + " " + activityDetails[i].actName;
		  activityDetails[i].taskName = yAxis;
		  console.log("Start date:" + activityDetails[i].startDate + ", End date:" + activityDetails[i].endDate);
		  myTaskDetails.push([yAxis, activityDetails[i].startDate, activityDetails[i].endDate]);
		  console.log(myTaskDetails[salen-i][0]+"::"+myTaskDetails[salen-i][1]+"::"+myTaskDetails[salen - i][2]);
	  }
	  //console.log(myTaskDetails[0][0]+"::"+myTaskDetails[0][1]+"::"+myTaskDetails[0][2]);
	  //console.log(myTaskDetails[1][0]+"::"+myTaskDetails[1][1]+"::"+myTaskDetails[1][2]);
	  //console.log(myTaskDetails[2][0]+"::"+myTaskDetails[2][1]+"::"+myTaskDetails[2][2]);
	  var newPlanId = parseInt(nextPlanId);
	  newPlanId = newPlanId + 1;
      var tabTemplate = "<li><a href='#planTabs"+newPlanId+"'>"+planNameGiven+"</a><span class='ui-icon ui-icon-close' role='presentation'>Remove Tab</span></li>";
      var tabContent = "<div id='planTabs" + newPlanId+ "'>" +
							"<div id='jqChart" + newPlanId + "'} style='width: 500px; height: 300px;' align='center'></div>" + 
							"<div align='right'><button class='uk-button' type='button' onclick='savePlan("+ newPlanId +");'>Save</button></div>" +
					   "</div>";
	
      var tabs = $( "#planTabs" ).tabs();
      tabs.find( ".ui-tabs-nav" ).append( tabTemplate );
      tabs.append( tabContent);
      tabs.tabs( "refresh" );
      
      tabs.delegate( "span.ui-icon-close", "click", function() {
    	  var panelId = $( this ).closest( "li" ).remove().attr( "aria-controls" );
    	  $( "#" + panelId ).remove();
    	  tabs.tabs( "refresh" );
    	  createButton.disabled = false;
    	  });
      chartId = "#jqChart" + newPlanId;
      $(chartId).jqChart({
          title: { text: planNameGiven },
          animation: { duration: 5 },
          shadows: {
              enabled: true
          },
          legend: {
              visible: false
          },
          series: [
              {
                  type: 'gantt',
                  fillStyles: colorFills,
                  data: myTaskDetails
              }
          ]
      });
      createButton.disabled = true;
  }
  $(document).ready(function () {
	  nextPlanId=0;
	  <c:forEach items="${studyPlans}" var="plans">
	     var i = 0;
	     var myFillStyle = [];
	     var taskDetails = [];
	  	 <c:forEach items="${plans.taskList}" var="taskList">
	  	 	myFillStyle.push("#506381");
	  	 	taskDetails.push(["${taskList.taskName}", new Date("'${taskList.startDate}'"), new Date("'${taskList.endDate}'")])
	  	 </c:forEach>
	      $('#jqChart${plans.planId}').jqChart({
	          title: { text: '${plans.planName}' },
	          animation: { duration: 5 },
	          shadows: {
	              enabled: true
	          },
	          legend: {
	              visible: false
	          },
	          series: [
	              {
	                  type: 'gantt',
	                  fillStyles: myFillStyle,
	                  data: taskDetails
	              }
	          ]
	      });
	      nextPlanId = '${plans.planId}';
      </c:forEach>
  });
  
  </script>
  <script src="resources/uilibs/js/projJs/autoComplete.js"></script>
</head>
<body >
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
		    <li><a href="#tabs-1">Course Management</a></li>
		    <li><a href="#tabs-2">Study Planner</a></li>
		  </ul>
		  <div id="tabs-1">
		  <div class="uk-grid" >
		    <div class="uk-width-medium-1-2" style="background: url(&#39;data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiPz4NCjwhLS0gR2VuZXJhdG9yOiBBZG9iZSBJbGx1c3RyYXRvciAxNi4wLjQsIFNWRyBFeHBvcnQgUGx1Zy1JbiAuIFNWRyBWZXJzaW9uOiA2LjAwIEJ1aWxkIDApICAtLT4NCjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+DQo8c3ZnIHZlcnNpb249IjEuMSIgaWQ9IkViZW5lXzEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHg9IjBweCIgeT0iMHB4Ig0KCSB3aWR0aD0iMTEzMHB4IiBoZWlnaHQ9IjQ1MHB4IiB2aWV3Qm94PSIwIDAgMTEzMCA0NTAiIGVuYWJsZS1iYWNrZ3JvdW5kPSJuZXcgMCAwIDExMzAgNDUwIiB4bWw6c3BhY2U9InByZXNlcnZlIj4NCjxyZWN0IGZpbGw9IiNGNUY1RjUiIHdpZHRoPSIxMTMwIiBoZWlnaHQ9IjQ1MCIvPg0KPC9zdmc+DQo=&#39;) 50% 0 no-repeat;">
		        <div class="uk-panel">
		        	<h2>Search</h2>
		        	<table class="uk-table uk-table-hover uk-table-condensed">
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
		        			Class Name:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="cName">
							</div>
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
		        			Class Level:
		        		</td>
		        		<td>
							<div class="ui-widget">
								 <input id="cLevel">
							</div>
						</td>
						</tr>
						<tr>
						<td></td>
						<td align="right"><button class="uk-button" type="button" style="background-color:grey;color:black" onclick="searchCourse('${userId}')">Search</button></td>
						</tr>
					</table>					
				</div>
		    </div>
		    <div class="uk-width-medium-1-2">
		        <div class="uk-panel">
					<h2>Registered Courses</h2>
					<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
					<tr>
						<td width="50">Course Number</td>
						<td width="150">Course Name</td>
						<td width="150">Status</td>
						<td width="50">Grade</td>
					</tr>
					<c:forEach items="${courses}" var="course">
						<tr>
							<td><c:out value="${course.courseNumber}" /></td>
							<td><c:out value="${course.courseName}" /></td>
							<td><c:out value="${course.regStatus}" /></td>
							<td><c:out value="${course.grade}" /></td>
							<td><button class="uk-button" type="button" onclick="dropCourse(${course.courseNumber}, '${userId}')">Drop</button></td>
							<td><button class="uk-button" type="button" onclick="swapCourse(${course.courseNumber}, ${fn:length(courses)}, '${userId}')">Swap</button></td>
						</tr>
					</c:forEach>
					</table>
				</div>
		    </div>
		  </div>
  		  </div>
	     <div id="tabs-2">
	    	<div class="uk-grid" >
	    		<div class="uk-width-medium-1-2">
			    	<div class="uk-panel">
						<h2>Course Activities</h2>
						<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
							<tr>
								<td> Select</td>
								<td width="200">Activity Name</td>
								<td width="400">Activity Description</td>
								<td width="200">Days Left</td>
								<td width="200">Deadline</td>
								<td width="50"> Difficulty</td>
								
							</tr>
							<c:forEach items="${courseActivities}" var="activity">
								<c:if test="${activity.daysLeft > 0}">
									<tr>
										<td><input name="selAct" type="checkbox" id="${activity.courseNumber}act${activity.activityId}"><label for="act${activity.activityId}">${activity.courseNumber}</label></td>
										<td><c:out value="${activity.activityName}" /></td>
										<td><c:out value="${activity.activityDescription}" /></td>
										<td><c:out value="${activity.daysLeft}" /></td>
										<td><c:out value="${activity.deadline}" /></td>
										<td><select name="difficulty" id="${activity.courseNumber}diff${activity.activityId}">
											<option value="1" selected>1</option><option value="2" >2</option><option value="3" >3</option><option value="4" >4</option><option value="5" >5</option>
										    </select>
										</td>
									</tr>
								</c:if>
							</c:forEach>
							<tr>
								<td colspan="5">Enter the number of hours you could work per day</td>
								<td><input id="hpd" size="3" name="hoursPd" type="text"></input></td>
							</tr>
						
							<tr>
								<td colspan="4"> Enter a plan name </td>
								<td><input id="newPlanName" name="npn" type="text"></input></td>
								<td>
									<div align="right"><button class="uk-button" type="button" id="createBut" onclick="generateStudyPlan(this)">Create</button></div>
								</td>
							</tr>
						</table>
					</div>
				</div>
    
			<div class="uk-width-medium-1-2">
		    	<div class="uk-panel">
		    		<h2>Study Plans</h2>
					<div id="planTabs">
						<ul>
							<c:forEach items="${studyPlans}" var="studyplans">
								<li><a href="#planTabs${studyplans.planId}"><c:out value="${studyplans.planName}" /></a></li>
							</c:forEach>
						</ul>
						<c:forEach items="${studyPlans}" var="mysp">
							<div id="planTabs${mysp.planId}">
								<div id="jqChart${mysp.planId}" style="width: 500px; height: 300px;" align="center">
								</div>
								<div align="right"><button class="uk-button" type="button" onclick="deletePlan('${mysp.planId}');">Delete</button></div>
							</div>
						</c:forEach>
					</div>
		    	</div>
	    	</div>
    	</div>
   	</div>
</div>
<div class="uk-width-1-1" style="display: ${diplayResults}" >
	<div class="uk-panel">
		<h2>Search Results</h2>
		<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
			<tr>
				<td colspan=11></td>
				<td align="right"><button class="uk-button" type="button" onclick="registerCourse('${userId}', ${fn:length(courses)})">Register</button></td>
			</tr>
			<tr>

				<td width="100"> Course Number </td>
				<td width="100"> Course Prefix </td>
				<td width="100"> Course Name </td>
				<td width="100"> Credits </td>
				<td width="100"> Course Level </td>
				<td width="100"> Course Instructor </td>
				<td width="100"> Instruction Method </td>
				<td width="100"> Course Timing </td>
				<td width="100"> Course Location </td>
				<td width="100"> Seats Available </td>
				<td width="100"> Maximum Seats </td>
				<td width="100"> Course Status </td>
			</tr>
			<c:forEach items="${searchedCourses}" var="course">
				<tr>
					<td><input name="searchedCourses" type="checkbox" id="${course.courseNumber}"><label for="${course.courseNumber}">${course.courseNumber}</label></td>
					<td><c:out value="${course.coursePrefix}" /></td>
					<td><c:out value="${course.courseName}" /></td>
					<td><c:out value="${course.courseCredits}" /></td>
					<td><c:out value="${course.courseLevel}" /></td>
					<td><c:out value="${course.instructor}" /></td>
					<td><c:out value="${course.instructionMethod}" /></td>					
					<td><c:out value="${course.courseTiming}" /></td>
					<td><c:out value="${course.courseLocation}" /></td>
					<td><c:out value="${course.seatsAvailable}" /></td>
					<td><c:out value="${course.maximumSeats}" /></td>
					<td><c:out value="${course.courseStatus}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</div>
 
 
</body>
</html>