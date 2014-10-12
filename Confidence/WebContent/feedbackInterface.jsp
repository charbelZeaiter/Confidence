<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Lecturer Interface</title>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js"type="text/javascript"></script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	
	<script>
		$(document).ready(function() {
			$(".tick").click(function() {
				$(this).parentsUntil(".questionPanel").fadeOut();
			});
		});
	</script>
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Lecturer Interface</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs" role="tablist">
					<li><a href="Controller?aAction=navigation&amp;page=home">Home</a></li>
					<li><a href="Controller?aAction=navigation&amp;page=studentInterface">Student Interface</a></li>
					<li><a href="Controller?aAction=navigation&amp;page=lecturerInterface">Lecturer Interface</a></li>
					<li class="active"><a href="Controller?aAction=navigation&amp;page=feedbackInterface">Feedback Interface (Temp)</a></li>
				</ul>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
				<button class="btn btn-primary" data-toggle="modal" data-target="#feedbackForm">Launch feedback form</button>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-4"></div>
		</div>

		<!-- Modal Dialog -->
		<div class="modal fade" id="feedbackForm" tabindex="-1" role="dialog" aria-labelledby="feedbackFormLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title" id="feedbackFormLabel">Lecture Feedback</h4>
					</div>
					<div class="modal-body">Questions!</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary">Save</button>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

</body>
</html>