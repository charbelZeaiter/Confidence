<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8" content="">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Survey Results</title>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Bootstrap -->
<link href="bootstrap-3.2.0-dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Custom CSS -->
<link rel="stylesheet" type="text/css" href="css/stylesheet.css">
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script type="text/javascript">

//Load the Visualization API and the piechart package.
google.load('visualization', '1.0', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.
google.setOnLoadCallback(drawChartExt);

function drawChartExt() {
	drawChart(1);
	drawChart(2);
	drawChart(3);
}
// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and
// draws it.
function drawChart(qid) {

        // Create the data table.
        
        var index;
        var sel = ["1","2","3","4","5"];
        var chartrows = new Array();
        var divname;
        var count = 0;
        var sum = 0;
        var average;
        
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Rating');
        data.addColumn('number', 'Votes');
        
        for	(index = 0; index < 5; index++) {
             divname = "div_"+qid+"_"+sel[index];
             
            if (document.getElementById(divname) != null) {
            	chartrows[index] =  parseInt(document.getElementById(divname).value);
            	count += chartrows[index];
            	sum += chartrows[index] * (index+1);
            }
        }
        
        data.addRows([
                [sel[0],chartrows[0]],
        		[sel[1],chartrows[1]],
        		[sel[2],chartrows[2]],
        		[sel[3],chartrows[3]],
        		[sel[4],chartrows[4]]
        		]);
        
        // Set chart options
        var options = {'title':"Question "+qid+"!",
                       'width':400,
                       'height':300};
        alert("bye");
        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.ColumnChart(document.getElementById("chart_div_"+qid));
        chart.draw(data, options);
        
        
        document.getElementById("chart_count_"+qid).innerHTML = count + " responses";
        if (count > 0) {
	        average = sum/count;
	        document.getElementById("chart_avg_"+qid).innerHTML = average + " average";
        }
       
      }
</script>
</head>
<body>
	
	<div class = "jumbotron">
		<h1> Survey Results </h1>
	</div>
	
	<div class="row">
		<div class="col-md-4">
			<button class="btn btn-primary" data-toggle="modal"
				data-target="#feedbackForm">Launch survey!</button>
		</div>
		<div class="col-md-4"></div>
		<div class="col-md-4"></div>
	</div>

	<!-- Modal Dialog -->
	<div class="modal fade" id="feedbackForm" tabindex="-1" role="dialog"
		aria-labelledby="feedbackFormLabel" aria-hidden="true">
		<div class="modal-dialog">
			<form action="Controller" method="post">
			<input type="hidden" id="aAction" name="aAction" value="submitSurvey" />
			<div class="input-group">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="modal-title" id="feedbackFormLabel">Lecture
						Feedback</h4>
				</div>
				<div class="modal-body col-md-12">
				<div class="col-md-2"></div>
				<div class="col-md-8">
					
					<c:forEach items="${question}" var="question">
									<label for = "choices_${question.q_id}">${question.question} </label>
									<ul class="list-inline" id = "choices_${question.q_id}">
									<c:forEach items="${choices}" var="choice">
										<li><div class = "radio"><label>
													<input type = "radio" name="${question.q_id}" value="${choice}"/> ${choice}
										</label></div></li>
									</c:forEach>
									</ul>
					</c:forEach>
					
				</div>
				<div class="col-md-2"></div>
				</div>
				<div class="modal-footer">
					<input type = "submit" class="btn btn-primary">
					<button type="button" class="btn btn-primary" data-dismiss = "modal">Close</button>
				</div>
				</div>
				</div>
				</form>
			</div>
		</div>
	
		<c:forEach items="${responses}" var="response">
		<input type="hidden"  id = "div_${response.q_id}_1" value = "${response.o_1}" />
		<input type="hidden"  id = "div_${response.q_id}_2" value = "${response.o_2}" />
		<input type="hidden"  id = "div_${response.q_id}_3" value = "${response.o_3}" />
		<input type="hidden"  id = "div_${response.q_id}_4" value = "${response.o_4}" />
		<input type="hidden"  id = "div_${response.q_id}_5" value = "${response.o_5}" />
		</c:forEach>
		
		<div class="col-md-12">
		<div class="col-md-2"></div>
		<div class="col-md-4">
		<c:forEach items="${questions}" var="question">
			<div class="container">
		 <label>${question.question} </label>
		 <ul>
		 	<li><div id = "chart_count_${question.q_id}"></div></li>
		 	<li><div id = "chart_avg_${question.q_id}"></div></li>
		 </ul>
		 <div id="chart_div_${question.q_id}"></div>
		 </div>
		</c:forEach>
		</div>
		<div class="col-md-6"></div>
		</div>
       
	<jsp:include page="footer.jsp" />

	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"
		type="text/javascript"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script src="bootstrap-3.2.0-dist/js/bootstrap.min.js"
		type="text/javascript"></script>
	<!-- Include some javascript stuff -->
	<script src="JavaScript/surveyResults.js" type="text/javascript"></script>
</body>
</html>