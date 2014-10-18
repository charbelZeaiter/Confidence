<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Student Sitting Access</title>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<h1>Student Sitting Access</h1>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4"></div>
		<div class="col-md-4"></div>
		<div class="col-md-4">
			<c:if test="${ !empty invalidSitting }">
				<p style="color: red;">Access Failed!<p>
			</c:if>
		</div>
	</div>
	<br />
	<div class="row">
		<div class="col-md-12">
			<form method="post" action="Controller">
				<table>
					<tr>
						<td>Sitting Id:</td>
						<td><input type="text" id="aSittingId" name="aSittingId" /></td>
					</tr>
					<tr>
						<td>Sitting Password:</td>
						<td><input type="text" id="aPWD" name="aPWD" /></td>
					</tr>
					<tr>
						<td><input type="hidden" id="aAction" name="aAction" value="sittingAccessRequest" /></td>
						<td><input class="btn btn-primary" type="submit" value="Access" /></td>
					</tr>
				</table>
			</form>
		</div>
	</div>

	<jsp:include page="footer.jsp" />

</body>
</html>