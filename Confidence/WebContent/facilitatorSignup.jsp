<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-6 col-md-offset-3 panel panel-default" style="width: 430px">
	<h1 class="margin-top-vertical-mid">Facilitator Sign Up</h1>
	<div>
		<div>
			<c:choose>
	      		<c:when test="${ !empty error }">
	      			<p style="color: red;">${error}<p>
	      		</c:when>
	      		<c:otherwise>
	      			<br>
	      		</c:otherwise>
			</c:choose>
		</div>
		<form class="form-horizontal" method="post" action="FacilitatorController">
			<div>
				<div class="form-group">
					<label for="aFacilitatorId" class="col-md-4 control-label">Username:</label>
				    <div class="col-md-8">
				      <input type="text" class="form-control" id="aFacilitatorId" name="aFacilitatorId" maxLength="50" placeholder="Username" required>
				    </div>
			    </div>
			    <div class="form-group">
				    <label for="aPWD" class="col-md-4 control-label">Password:</label>
				    <div class="col-md-8">
				      <input type="password" class="form-control" id="aPWD" name="aPWD" maxLength="50" placeholder="Password" required>
				    </div>
			    </div>
			</div>
			<div class="margin-vertical-mid">
				<input type="hidden" id="aAction" name="aAction" value="signupRequest" />
				<input class="btn btn-large btn-primary" type="submit" value="Sign Up">
			</div>
		</form>
	</div>
</div>