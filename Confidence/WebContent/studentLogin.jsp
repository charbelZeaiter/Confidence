<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-6 col-md-offset-3 panel panel-default">
	<h1 class="margin-top-vertical-mid">Student Login</h1>
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
		<form class="form-horizontal" method="post" action="Controller">
			<div>
				<div class="form-group">
					<label for="aFacilitatorId" class="col-md-4 control-label">ID:</label>
				    <div class="col-md-8">
				      <input type="text" class="form-control" id="aSittingId" name="aSittingId" placeholder="Sitting ID" required>
				    </div>
			    </div>
			    <div class="form-group">
				    <label for="aPWD" class="col-md-4 control-label">Password:</label>
				    <div class="col-md-8">
				      <input type="password" class="form-control" id="aPWD" name="aPWD" placeholder="Sitting Password" required>
				    </div>
			    </div>
			</div>
			<div class="margin-vertical-mid">
				<input type="hidden" id="aAction" name="aAction" value="sittingAccessRequest" />
				<input class="btn btn-large btn-primary" type="submit" value="Login">
			</div>
		</form>
	</div>
</div>