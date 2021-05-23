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
  function rejectRequest(advisorId, studentId, courseNumber){
	  semester = '${semester}';
	  result = confirm("Are you sure, you want to reject the request?");
	  if (result== true){
		  rejectUrl = "http://localhost:8085/coursemgmt/rejectRequest?semester="+semester+"&advisorId="+advisorId+"&studentId="+studentId+"&courseNumber="+courseNumber;
		  window.location.href = rejectUrl;
	  }
  }
  function acceptRequest(advisorId, studentId, courseNumber){
	  semester = '${semester}';
	  result = confirm("Are you sure, you want to accept the request?");
	  if (result== true){
	  	acceptUrl = "http://localhost:8085/coursemgmt/acceptRequest?semester="+semester+"&advisorId="+advisorId+"&studentId="+studentId+"&courseNumber="+courseNumber;  
	  	window.location.href = acceptUrl;
	  }
  }
  function alertResult(acceptResult, rejectResult){
	  if (acceptResult == "true"){
		  alert("Successfully accepted the request");
	  }
	  if (acceptResult == "false"){
		  alert("Failed to accept the request. Please try again");
	  }
	  if (rejectResult == "true"){
		  alert("Successfully rejected the request");
	  }
	  if (rejectResult == "false"){
		  alert("Failed to reject the request. Please try again");
	  }
  }
  </script>
  <script src="resources/uilibs/js/projJs/autoComplete.js"></script>
</head>
<body onload="alertResult('${acceptResult}', '${rejectResult}')">
	<div class="uk-grid">
	    <div class="uk-width-1-1"><img class="uk-width-1-1" height="50" src="resources/uilibs/images/Header.JPG" alt=""></div>
    </div>
    
    <div class="userDetails" align="right">
        <span> Semester: ${semester} &nbsp &nbsp &nbsp &nbsp</span>
	    <span> User name: ${userId} &nbsp &nbsp &nbsp &nbsp</span>
	    <a href="http://localhost:8085/coursemgmt"> logout </a>
    </div>
    <br/>
    <div class="uk-grid" >
	<div class="uk-width-medium-1-2">
		<div class="uk-panel">
			<h2>Student Requests</h2>
			<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
			<tr>
				<td width="50">Request ID</td>
				<td width="100">Student ID</td>
				<td width="50">Course Number</td>
				<td width="300">Description</td>
				<td width="100">Status</td>
			</tr>
				<c:forEach items="${requests}" var="request">
					<tr>
						<td><c:out value="${request.requestId}" /></td>
						<td><c:out value="${request.studentId}" /></td>
						<td><c:out value="${request.courseNumber}" /></td>
						<td><c:out value="${request.requestDescription}" /></td>
						<td><c:out value="${request.requestStatus}" /></td>
						<td><button class="uk-button" type="button" onclick="rejectRequest('${request.advisorId}', '${request.studentId}', ${request.courseNumber})">Reject</button></td>
						<td><button class="uk-button" type="button" onclick="acceptRequest('${request.advisorId}', '${request.studentId}', ${request.courseNumber})">Accept</button></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	</div>
</body>
</html>
    