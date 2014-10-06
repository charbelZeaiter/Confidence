<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Student Interface</title>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Student Interface</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs" role="tablist">
					<li><a href="Controller?aAction=navigation&amp;page=home">Home</a></li>
					<li class="active"><a href="Controller?aAction=navigation&amp;page=studentInterface">Student Interface</a></li>
					<li><a href="Controller?aAction=navigation&amp;page=home">Etc...</a></li>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<br />
				<form method="post"
					action="Controller?aAction=postque&amp;page=studentInterface">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<input type="hidden" id="aAction" value="post_text" />
							<div class="input-group">
								<input class="form-control" type="text" id="aText"
									name="questionText" /> <span class="input-group-btn">
									<button class="btn btn-primary" type="submit">Post!</button>
								</span>
							</div>
							<!-- /input-group -->
						</div>
						<div class="col-md-4"></div>
					</div>
				</form>
			</div>
		</div>
		<br />
		<c:forEach items="${questions}" var="question" >
		<div class="row">
			<div class="col-md-4">
				<div class="panel panel-default">
					<div class="panel-body">
						<table>
							<tr>
								<td class="col-md-1">
									<FORM NAME="form1" METHOD="POST" action="Controller?aAction=upvote">
										<INPUT TYPE="HIDDEN" NAME="que_id" VALUE="${question.id}"> 
										<input type="image" src="images/upvote-small.png" value="Upvote" style="width: 40px;"/>
									</FORM>
								</td>
								<td class="col-md-9">[ID${question.id}] ${question.description}</td>
								<td class="col-md-2" style="text-align:center;">${question.num_votes}</td>
							</tr>
						</table>
					</div>
				</div>
			</div>
		</div>
		</c:forEach>
		<table></table>
	
		<!-- Content Here -->
	
	</div>
	
	<jsp:include page="footer.jsp" />
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
</body>
</html>