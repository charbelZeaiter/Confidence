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
    <link rel="stylesheet" href="bootstrap-theme/css/business-casual.css">	
</head>
<body>

	<div class="brand">Facilitator Home</div>
	
	<!-- Nav include -->
	<jsp:include page="nav.jsp" />
	
	<div class="container">
		<div class="row">
            <div class="box">
                <div class="col-lg-12">
                    <hr><h2 class="intro-text text-center"><strong>Sitting Manager</strong></h2><hr>
                </div>
               	<a class="btn btn-large btn-primary" href="FacilitatorController?aAction=navigation&amp;page=createSitting">Create A New Sitting</a>
				<c:choose>
					<c:when test="${ !empty message }">
						<p></p>
						<p style="color: green;">${message}</p>
					</c:when>
					<c:otherwise>
						<br><br>
					</c:otherwise>
				</c:choose>
				<c:choose>
					<c:when test="${sittingListSize > 0}">
						<div class="col-md-1"></div>
						<div class="col-md-10">
							<table class="table table-bordered table-hover" width="100%">
								<tr>
									<th style="text-align:center;">ID</th>
									<th style="text-align:center;">Name</th>
									<th style="text-align:center;">Password</th>
									<th style="text-align:center;">Status</th>
									<th style="text-align:center;">Access Link</th>
									<th style="text-align:center;">Close Sitting and Launch Survey</th>
								</tr>
								<c:forEach items="${sittingList}" var="sitting"> 
									<tr>
									    <td style="vertical-align:middle">${sitting.id}</td>
							    		<td style="vertical-align:middle">${sitting.name}</td>
							    		<td style="vertical-align:middle">${sitting.pwd}</td>
							    		<td style="vertical-align:middle">${sitting.status}</td>
							    		<td style="vertical-align:middle"><a href="FacilitatorController?aAction=navigation&amp;page=facilitatorInterface&sittingId=${sitting.id}&sittingName=${sitting.name}&qwerty=${sitting.pwd}&sorted=upvote">Access</a></td>
									    <td style="vertical-align:middle">
			                            	<form method="post" action="FacilitatorController">
			                                    <input type="HIDDEN" name="aAction" value="closeSitting" />
			                                    <input type="HIDDEN" name="sittingId" value="${sitting.id}">
			                                    <c:choose>
				                                    <c:when test="${sitting.status == 'Open'}">
				                                    	<button class="btn btn-primary" type="submit">Close Sitting</button>
				                                    </c:when>
				                                    <c:otherwise>
				                                    	<button class="btn btn-primary disabled" type="submit">Close Sitting</button>
				                                    </c:otherwise>
				                               	</c:choose>
			                                </form>
									    </td>
								   </tr>
								</c:forEach>
							</table>
						</div>
					</c:when>
					<c:otherwise>
						<p>You don't have any sittings yet. Why don't you <a href="FacilitatorController?aAction=navigation&amp;page=createSitting">create a new one</a>?</p>
					</c:otherwise>
				</c:choose>
                <div class="clearfix"></div>
            </div>
        </div>
 	</div>
 
	<jsp:include page="footer.jsp" />

</body>
</html>