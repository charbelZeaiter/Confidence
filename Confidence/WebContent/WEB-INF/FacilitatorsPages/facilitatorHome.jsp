<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Facilitator Home</title>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"	type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Facilitator Home</h1>
			</div>
		</div>
		<div class="row">
			<!-- Nav include -->
			<jsp:include page="nav.jsp" />
		</div>
		<br>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<a class="btn btn-large btn-primary" href="FacilitatorController?aAction=navigation&amp;page=createSitting">Create A New Sitting</a>
			</div>
			<div class="col-md-4"></div>	
		</div>
		<c:choose>
			<c:when test="${ !empty message }">
				<p></p>
	   			<p style="color: green;">${message}</p>
	   		</c:when>
	   		<c:otherwise>
	   			<br>
	   		</c:otherwise>
   		</c:choose>
		<div class="row">
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<c:choose>
				  <c:when test="${sittingListSize > 0}">
				    <table width="100%" border="1">
				    	<tr>
				    		<th colspan="4">My Sittings</th>
				    	</tr>
				    	<tr>
				    		<th>ID</th>
				    		<th>Name</th>
				    		<th>Password</th>
				    		<th> </th>
				    	</tr>
				    	<c:forEach items="${sittingList}" var="sitting"> 
						  <tr>
						    <td>${sitting.id}</td>
				    		<td>${sitting.name}</td>
				    		<td>${sitting.pwd}</td>
				    		<td><a href="FacilitatorController?aAction=navigation&amp;page=facilitatorInterface&sittingId=${sitting.id}&sittingName=${sitting.name}&qwerty=${sitting.pwd}&sorted=upvote">Access</a></td>
						   </tr>
						</c:forEach>
				    </table>
				  </c:when>
				  <c:otherwise>
				    <p>No Sittings...</p>
				  </c:otherwise>
			</c:choose>
			</div>
			<div class="col-md-4"></div>	
		</div>			
	</div>
	<jsp:include page="footer.jsp" />

</body>
</html>