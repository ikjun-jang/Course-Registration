<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Available Courses</title>
    <link rel="stylesheet" href="resources/uilibs/css/uikit.min.css" />
    <script src="resources/uilibs/jquery-2.1.1.js"></script>
    <script src="resources/uilibs/js/uikit.min.js"></script>
</head>
<body>
	<div class="uk-overflow-container">
		<h1>Courses</h1>
		<table class="uk-table uk-table-hover uk-table-striped uk-table-condensed">
			<tr>
				<td width="50">Number</td>
				<td width="150">Course Name</td>
				<td width="150">Credits</td>
				<td width="50">Course Level</td>
			</tr>
			<c:forEach items="${courses}" var="course">
				<tr>
					<td><c:out value="${course.courseNumber}" /></td>
					<td><c:out value="${course.courseName}" /></td>
					<td><c:out value="${course.courseCredits}" /></td>
					<td><c:out value="${course.courseLevel}" /></td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>