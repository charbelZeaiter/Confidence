<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login Portal</title>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	
	<!-- To be moved to stylesheet.css -->
	<style>
		html {
			background: url(images/lecture.jpg) no-repeat center center fixed; 
			-webkit-background-size: cover;
			-moz-background-size: cover;
			-o-background-size: cover;
			background-size: cover;
		}

		body {
			padding-top: 20px;
			font-size: 16px;
			font-family: "Open Sans",serif;
			background: transparent;
		}

		/* Override B3 .panel adding a subtly transparent background */
		.panel {
			background-color: rgba(255, 255, 255, 0.9);
			text-align: center;
			width: 500px;
			height: 300px;
			position:absolute;
			margin-top:-150px;
			margin-left:-210px;
			top:50%;
			left:50%;
		}

		.margin-vertical-large {
			margin: 50px 0;
		}
		
		.margin-vertical-mid {
			margin: 35px 0;
		}
		
		.margin-vertical-small {
			margin: 20px 0;
		}
		
		.margin-top-vertical-mid {
			margin-top: 35px;
		}
		
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<c:choose>
	      		<c:when test="${ !empty loginType }">
	      			<jsp:include page="${loginType}.jsp"/>
	      		</c:when>
	      		<c:otherwise>
	      			<jsp:include page="portal.jsp"/>
	      		</c:otherwise>
			</c:choose>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>

</body>
</html>