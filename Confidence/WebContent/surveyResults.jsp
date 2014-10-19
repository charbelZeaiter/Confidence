<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Survey Results</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Bootstrap -->
<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class = "jumbotron">
		<h1> Survey Results </h1>
	</div>
	
	<div class="row">
		<div class="col-md-4">
			<button class="btn btn-primary" data-toggle="modal"
				data-target="#feedbackForm">Launch survey!</button>
		</div>
		<div class="col-md-4"></div>
		<div class="col-md-4"></div>
	</div>

	<!-- Modal Dialog -->
	<div class="modal fade" id="feedbackForm" tabindex="-1" role="dialog"
		aria-labelledby="feedbackFormLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="feedbackFormLabel">Lecture
						Feedback</h4>
				</div>
				<div id="wrap">
					<br />
					<c:forEach items="${questions}" var="question">
						<div class="row">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div class="panel panel-default">
									<div class="panel-body">
										<table>
											<tr>
												<td class="col-md-9">${question.question}</td>
											</tr>
										</table>
									</div>
									
									<table>
									
										<tr><td><input type="radio" name="${question.id}" value="1">1</td>
										<td><input type="radio" name="${question.id}" value="2">2</td>
										<td><input type="radio" name="${question.id}" value="3">3</td>
										<td><input type="radio" name="${question.id}" value="4">4</td>
										<td><input type="radio" name="${question.id}" value="5">5</td> </tr>
										
									</table>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary">Save</button>
					<input type="hidden" id="aAction" value="post_response" /> 
					<button type="button" class="btn btn-primary" data-dismiss = "modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	
	<div id="wrap">
		<br />
		<c:forEach items="${responses}" var="response">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="panel panel-default question">
						<div class="panel-body">
							<table>
								<tr>
									<td class="col-md-9">${response.question}</td>
									<td class="col-md-9">${response.response}</td>
									<td class="col-md-9">${response.response_count}</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>

	</div>

	<jsp:include page="footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"
		type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- Include some javascript stuff -->
	<script src="JavaScript/surveyResults.js" type="text/javascript"></script>
</body>
</html>