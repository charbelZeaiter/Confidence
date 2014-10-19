<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8" content="">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Facilitator Interface</title>
	
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js" type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js" type="text/javascript"></script>
	
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	<!-- Bootstrap -->
	<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
	<!-- Custom CSS -->
	<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
	
	<script>
		$(document).ready(function() {
			$(".tick").click(function() {
				$(this).parentsUntil(".questionPanel").fadeOut();
			});
		});
	</script>
</head>
<body>
	<div id="wrap">
		<div class="row">
			<div class="col-md-12">
				<h1>Facilitator Interface</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<ul class="nav nav-tabs" role="tablist">
					<li><a href="FacilitatorController?aAction=navigation&amp;page=home">Home</a></li>
					<li><a href="FacilitatorController?aAction=navigation&amp;page=home">Etc...</a></li>
				</ul>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-4">
				<a href="FacilitatorController?aAction=navigation&amp;page=createSitting">Create A Sitting</a>
			</div>
			<div class="col-md-4"></div>
			<div class="col-md-4">
				<c:if test="${ !empty sittingId }">
					<p style="color: green;">Sitting ID: ${sittingId}<p>
					<p style="color: green;">Access password: ${accessPWD}<p>
				</c:if>
			</div>
		</div>
		<div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <div>
                    <div class="panel-body">
                        Sort By:
                        <form method="post" action="FacilitatorController?aAction=sort">
                            <select name="sortby" onchange='this.form.submit()'>
                                <option value="upvote"
                                    <c:if test="${sorted =='upvote'}"> selected </c:if>>Up
                                    votes</option>
                                <option value="date"
                                    <c:if test="${sorted =='date'}"> selected </c:if>>Most Recent</option>
                            </select>

                        </form>
                    </div>
                </div>
            </div>
        </div>
		<c:forEach items="${questions}" var="question">
			<div class="row questionPanel">
				<div class="col-md-4"></div>
				<div class="col-md-4">
					<div class="panel panel-default question">
						<div class="panel-body">
							<table>
								<tr>
									<td class="col-md-1">
									<FORM NAME="form1" METHOD="POST" action="FacilitatorController?aAction=remove">
                                        <INPUT TYPE="HIDDEN" NAME="que_id" VALUE="${question.id}">
                                        <INPUT TYPE="HIDDEN" NAME="sorted" VALUE="${sorted}"> 
                                        <input type="image" src="images/tick.png" value="Remove" style="width: 40px;"/>
                                    </FORM></td>
									<td class="col-md-9">[ID${question.id}] ${question.description}</td>
									<td class="col-md-2" style="text-align: center;">${question.num_votes}</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</div>
    <form method="post" action="FacilitatorController?aAction=refresh">
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <input type="hidden" id="aAction" value="refresh" />
                <INPUT TYPE="HIDDEN" NAME="sorted" VALUE="${sorted}"> 
                <div class="input-group">
                    <button class="btn btn-primary" type="submit">Refresh!</button>
                </div>
            </div>
            <div class="col-md-4"></div>
        </div>
    </form>
	<jsp:include page="footer.jsp" />

</body>
</html>