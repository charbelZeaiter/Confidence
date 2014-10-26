<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Facilitator Search</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<br />
				<form method="post"
					action="Controller">
					<div class="row">
						<div class="col-md-4"></div>
						<div class="col-md-4">
							<div class="input-group">
							<div class="col-md-4">
								First Name<input class="form-control" type="text" id="firstName"
									name="firstName" />
									</div>
									<div class="col-md-4">
									Last Name<input class="form-control" type="text" id="lastName"
									name="lastName" />  
									</div>
									<div class="col-md-4">
									
									<INPUT TYPE="HIDDEN" NAME="aAction" VALUE="surveySearch">
									<button class="btn btn-primary" type="submit">Search!</button>
								   
								    </div>
								    
							</div>
							
							<c:if test="${ !empty searchError }">
							
				                      <p style="color:red;"> ${searchError} </p>
			                       </c:if>
						</div>
						<div class="col-md-4"></div>
					</div>
				</form>
			</div>
		</div>
		<br />

		

		<c:forEach items="${facSur}" var="facSur">
			<div class="row">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="panel panel-default question">
						<div class="panel-body">
							<table>
								<tr>
									<td class="col-md-1">
										<FORM NAME="form1" METHOD="POST"
											action="Controller?aAction=surveyResults">
											<INPUT TYPE="HIDDEN" NAME="fac_id" VALUE="${facSur.f_id}">
											<input type="image" src="images/upvote-small.png"
												value="Upvote" style="width: 40px;" />
										</FORM>
									</td>
									<td class="col-md-9">${facSur.fname}
										${facSur.lname}</td>
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
</body>
</html>