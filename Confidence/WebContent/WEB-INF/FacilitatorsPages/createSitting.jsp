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
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Create a Sitting</h1>
			</div>
		</div>
		<div class="row">
			<!-- Nav include -->
			<jsp:include page="nav.jsp" />
		</div>
		<div class="row">
			<div class="col-md-12">
				<br>
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4">
						<c:if test="${ !empty formError }">
							<p style="color: red;">${formError}</p>
						</c:if>
				
						<form method="post" action="FacilitatorController">
							Name: <input type="text" id="aName" name="aName" />
							<p>Please enter a password:</p>
							<br>
							<div class="input-group">
								<input type="hidden" id="aAction" name="aAction" value="createSittingRequest"/>
								<input class="form-control" type="text" id="aPWD" name="aPWD" />
								<span class="input-group-btn">
									<button class="btn btn-primary" type="submit">Create</button>
								</span>
							</div>
						</form>
						<br><br>
						<p>(Your sitting ID will be auto generated)</p>
					</div>
					<div class="col-md-4"></div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>

</body>
</html>