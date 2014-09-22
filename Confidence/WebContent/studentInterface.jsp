<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Student Interface</title>

    <!-- Bootstrap -->
    <link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    
  </head>
  <body>
      
    <!-- Content Here -->
		
		<div class="row">
		  <div class="col-md-12"><h1>Student Interface</h1></div>
		</div>
		<div class="row">
		  	<div class="col-md-12">
				<ul class="nav nav-tabs" role="tablist">
				  <li><a href="Controller?aAction=navigation&page=home">Home</a></li>
				  <li class="active" ><a href="Controller?aAction=navigation&page=studentInterface">Student Interface</a></li>
				  <li><a href="Controller?aAction=navigation&page=home">Etc...</a></li>
				</ul>
			</div>
		</div>
		<div class="row">
		  <div class="col-md-12">
		  	<br />
		  	<form method="post" action="Controller">
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4">
						<input type="hidden" id="aAction" value="post_text" />
						<div class="input-group">
					    	<input class="form-control" type="text" id="aText" />
					      	<span class="input-group-btn">
					        	<button class="btn btn-primary" type="submit">Post!</button>
					      	</span>
					    </div><!-- /input-group -->
					</div>
		  			<div class="col-md-4"></div>
				</div>
			</form>
		  </div>
		</div>
		<br />
		<div class="row">
		  <div class="col-md-4">.col-md-4</div>
		  <div class="col-md-4">
		  	<div class="panel panel-default">
			  <div class="panel-body">
			    Current lecture questions/comments go here...
			  </div>
			</div>
		  </div>
		  <div class="col-md-4">.col-md-4</div>
		</div>
		

	<!-- Content Here -->

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="bootstrap-3.2.0-dist/js/bootstrap.min.js"></script>
  </body>
</html>