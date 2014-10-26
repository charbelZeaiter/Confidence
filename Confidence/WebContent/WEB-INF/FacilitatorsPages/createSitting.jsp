<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Create A Sitting</title>
	
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
                <div class="col-sm-3"></div>
                <div class="col-sm-6 text-center">
					<c:choose>
						<c:when test="${ !empty error }">
							<p></p>
							<p style="color: red;">${error}</p>
						</c:when>
						<c:otherwise>
							<br>
						</c:otherwise>
					</c:choose>
					<form class="form-horizontal" method="post" action="FacilitatorController">
						<div>
							<div class="form-group">
								<label for="aFacilitatorId" class="col-md-4 control-label">Sitting Name:</label>
							    <div class="col-md-8">
							      <input type="text" class="form-control" id="aName" name="aName" maxLength="50" placeholder="e.g. COMP4920 Week 1" required>
							    </div>
						    </div>
						    <div class="form-group">
							    <label for="aPWD" class="col-md-4 control-label">Password:</label>
							    <div class="col-md-8">
							      <input type="password" class="form-control" id="aPWD" name="aPWD" maxLength="50" placeholder="Password to give students" required>
							    </div>
						    </div>
						</div>
						<br>
						<p><i>The Sitting ID will be auto-generated.</i></p>
						<br>
						<div class="margin-vertical-mid">
							<input type="hidden" id="aAction" name="aAction" value="createSittingRequest"/>
							<input class="btn btn-large btn-primary" type="submit" value="Create">
						</div>
					</form>
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
