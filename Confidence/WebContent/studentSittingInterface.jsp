<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Student Interface</title>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    
        $(document).ready(function() {
            setInterval(function() {
        		$.get("Controller?aAction=studentAJAX", function(responseText) { $('#dynamicBox').html(responseText); });
            }, 10000);
        });
    </script>
    
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Student Interface</h1>
			</div>
		</div>
		<div class="row">
			<!-- Nav include -->
			<jsp:include page="nav.jsp" />
		</div>
		<br>
		<div class="col-md-4">
			<c:if test="${ !empty questionError }">
				<p style="color:red;"> ${questionError} </p>
			</c:if>
		</div>
		<div class="col-md-4">
			<div class="row">

				<form method="post" action="Controller?aAction=postque&amp;page=studentSittingInterface">
					<input type="hidden" id="aAction" value="post_text" />
					<div class="input-group">
						<input class="form-control" type="text" id="aText" name="questionText" /> <span class="input-group-btn">
						    <INPUT TYPE="HIDDEN" NAME="sorted" VALUE="${sorted}">
							<button class="btn btn-primary" type="submit">Post!</button>
						</span>
					</div>
				</form>
				
				<br>
				
				<c:if test="${ !empty questions }">
					<p> </p>
					<form method="post" action="Controller?aAction=sort">
						<div class="col-xs-3"></div>
						<div class="col-xs-6">
							<select class="form-control" name="sortby" onchange='this.form.submit()'">
								<option value="upvote" <c:if test="${sorted =='upvote'}"> selected </c:if>>Up Votes</option>
								<option value="date" <c:if test="${sorted =='date'}"> selected </c:if>>Most Recent</option>
							</select>
						</div>						
					</form>
				</c:if>
				
				<br><br><br>
				
				<div id="dynamicBox" name="dynamicBox">
					<!-- AJAX Content here -->
				</div>
			
			</div>
		</div>
		<div class="col-md-4" style="text-align: right;">
			<form method="post" action="Controller?aAction=refresh">
				<input type="hidden" id="aAction" value="refresh" />
				<input type="HIDDEN" name="sorted" value="${sorted}"> 
				<button class="btn btn-primary" type="submit">Refresh!</button>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"	type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>