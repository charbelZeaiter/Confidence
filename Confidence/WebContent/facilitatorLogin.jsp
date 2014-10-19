<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="col-md-6 col-md-offset-3 panel panel-default">
	<h1 class="margin-top-vertical-mid">Facilitator Login</h1>
	<div>
		<div>
			<c:choose>
	      		<c:when test="${ !empty loginFailed }">
	      			<p style="color: red;">Login Failed!</p>
	      		</c:when>
	      		<c:otherwise>
	      			<br>
	      		</c:otherwise>
			</c:choose>
		</div>
		<form class="form-horizontal" method="post" action="FacilitatorController">
			<div>
				<div class="form-group">
					<label for="aFacilitatorId" class="col-md-4 control-label">ID:</label>
				    <div class="col-md-8">
				      <input type="text" class="form-control" id="aFacilitatorId" name="aFacilitatorId" placeholder="Facilitator ID">
				    </div>
			    </div>
			    <div class="form-group">
				    <label for="aPWD" class="col-md-4 control-label">Password:</label>
				    <div class="col-md-8">
				      <input type="password" class="form-control" id="aPWD" name="aPWD" placeholder="Password">
				    </div>
			    </div>
			</div>
			<div class="margin-vertical-mid">
				<input type="hidden" id="aAction" name="aAction" value="loginRequest" />
				<input class="btn btn-large btn-primary" type="submit" value="Login"></a>
				&nbsp;&nbsp;&nbsp;
				<a class="btn btn-large btn-primary" href="FacilitatorController?aAction=navigation&amp;page=signup">Sign Up</a>
			</div>
		</form>
	</div>
</div>