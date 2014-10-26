<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    <link rel="stylesheet" href="bootstrap-theme/css/business-casual.css">	
</head>
<body>

	<div class="brand">Survey Results</div>
	
	<div class="container">
		<div class="row">
            <div class="box">
                <div class="col-lg-12">
                    <hr><h2 class="intro-text text-center"><strong>Facilitator Search</strong></h2><hr>
                </div>
                <div>
                <div class="col-sm-3"></div>
                <div class="col-sm-6 text-center">
	                <form class="form-horizontal" method="post" action="Controller">
	                	<div>
						<div class="form-group">
							<label for="firstName" class="col-md-4 control-label">First Name:</label>
							<div class="col-md-8">
								<input class="form-control" type="text" id="firstName" name="firstName" />
							</div>
						</div>
						<div class="form-group">
							<label for="lastName" class="col-md-4 control-label">Last Name:</label>
							<div class="col-md-8">
								<input class="form-control" type="text" id="lastName" name="lastName" />
							</div>  
						</div>
						<div class="form-group">
							<INPUT TYPE="HIDDEN" NAME="aAction" VALUE="surveySearch">
							<button class="btn btn-primary" type="submit">Search</button>
						</div>
						</div>
					</form>
					<c:if test="${ !empty searchError }">
			          	<p style="color:red;"> ${searchError} </p>
		           	</c:if>
		       	</div>
		       	</div>
					<c:forEach items="${facSur}" var="facSur">
						<div class="row">
							<div class="col-md-4"></div>
							<div class="col-md-4">
								<div class="panel panel-default question">
									<div class="panel-body">
										<table>
											<tr>
												<td class="col-md-9">${facSur.fname} ${facSur.lname}</td>
												<td class="col-md-1">
												<FORM NAME="form1" METHOD="POST"action="Controller?aAction=surveyResults">
													<INPUT TYPE="HIDDEN" NAME="fac_id" VALUE="${facSur.f_id}">
													<button type="submit" class="btn btn-link">View Stats</button>
												</FORM>
												</td>
											</tr>
											
										</table>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
                <div class="clearfix"></div>
            </div>
        </div>
 	</div>

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>