<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Sign-Up</title>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Sign-Up</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<br />
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4">
						<form method="post" action="FacilitatorController">
							<p>Please Sign-Up:</p>
							<table>
								<tr>
									<td>Facilitator Id:</td>
									<td><input type="text" id="aFacilitatorId" name="aFacilitatorId" /></td>
								</tr>
								<tr>
									<td>Password:</td>
									<td><input type="text" id="aPWD" name="aPWD" /></td>
								</tr>
								<tr>
									<td><input type="hidden" id="aAction" name="aAction" value="signupRequest" /></td>
									<td><input class="btn btn-primary" type="submit" value="Sign-Up" /></td>
								</tr>
							</table>
						</form>
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