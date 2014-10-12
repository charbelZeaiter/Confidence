<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
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

		h1 {
			font-family: "Open Sans",serif;
			font-weight: 400;
			font-size: 40px;
		}

		/* Override B3 .panel adding a subtly transparent background */
		.panel {
			background-color: rgba(255, 255, 255, 0.9);
			text-align: center;
			width: 420px;
			height: 300px;
			position:absolute;
			margin-top:-150px;
			margin-left:-210px;
			top:50%;
			left:50%;
		}

		.margin-base-vertical {
			margin: 50px 0;
		}
		
		.margin-base-vertical-small {
			margin: 20px 0;
		}
	</style>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3 panel panel-default">				
				<h1 class="margin-base-vertical">Confidence</h1>
				<div class="margin-base-vertical">
				<a class="btn btn-large btn-primary" href="Controller?aAction=navigation&amp;page=sittingAccess">I'm a Student</a>
					&nbsp;&nbsp;&nbsp;
				<a class="btn btn-large btn-primary" href="FacilitatorController">I'm a Lecturer</a>
				</div>
				<div class="margin-base-vertical-small">
					<small class="text-muted">COMP4920 Project ~ Confidence ©</small>
				</div>
			</div>
		</div>
	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>

</body>
</html>