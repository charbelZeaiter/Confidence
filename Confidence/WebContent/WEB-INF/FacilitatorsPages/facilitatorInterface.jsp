<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Facilitator Interface</title>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"	type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
    <link rel="stylesheet" href="bootstrap-theme/css/business-casual.css">
	
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    
        $(document).ready(function() {
        		setInterval(function() {
        			$.get("FacilitatorController?aAction=facilitatorAJAX", function(responseText) { $('#dynamicBox').html(responseText); });
            }, 2000);
        });
    </script>
        
	<script type="text/javascript">
		$(document).ready(function() {
			$(".tick").click(function() {
				$(this).parentsUntil(".questionPanel").fadeOut();
			});
		});
	</script>
</head>
<body>

	<div class="brand">Facilitator Home</div>
	
	<!-- Nav include -->
	<jsp:include page="nav.jsp" />
	
		<div class="container">
		<div class="row">
            <div class="box">
                <div class="col-lg-12">
                    <hr><h2 class="intro-text text-center"><strong>Sitting "${sittingName}"</strong></h2><hr>
                </div>
                <div class="col-sm-2"></div>
                <div class="col-sm-8 text-center">
					<c:choose>
						<c:when test="${ !empty error }">
							<p></p>
							<p style="color: red;">${error}</p>
						</c:when>
					</c:choose>
					<p><b>Sitting ID:</b> ${sittingId}</p>
					<p><b>Sitting Password:</b> ${sittingPwd}</p>
					
					<c:if test="${ !empty questions }">
						<p>Sort By:</p>
						<form method="post" action="FacilitatorController?aAction=sort">
							<div class="col-xs-3"></div>
							<div class="col-xs-6">	
								<select class="form-control" name="sortby" onchange='this.form.submit()'>
									<option value="upvote" <c:if test="${sorted =='upvote'}"> selected </c:if>>Up Votes</option>
									<option value="date" <c:if test="${sorted =='date'}"> selected </c:if>>Most Recent</option>
								</select>
							</div>
						</form>
						<br>
					</c:if>
					<br>
					<form method="post" action="FacilitatorController?aAction=canPost">
	               		<div class="col-xs-3"></div>
	                	<div class="col-xs-6">  
	                   		<select class="form-control" name="canPost" onchange='this.form.submit()'>
	                       		<option value="open" <c:if test="${canPost =='open'}"> selected </c:if>>Open Question Posting</option>
	                         	<option value="close" <c:if test="${canPost =='close'}"> selected </c:if>>Close Question Posting</option>
	                        </select>
	                    </div>
	                </form>
					<br><br><br>
					<div id="dynamicBox" name="dynamicBox">
						<!-- AJAX Content here -->
					</div>
				</div>
                <div class="clearfix"></div>
            </div>
        </div>
 	</div>
 
	<jsp:include page="footer.jsp" />
</body>
</html>