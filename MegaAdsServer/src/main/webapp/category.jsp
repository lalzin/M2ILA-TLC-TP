<html>
<%-- //[START all]--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.google.appengine.api.users.User"%>
<%@ page import="com.google.appengine.api.users.UserService"%>
<%@ page import="com.google.appengine.api.users.UserServiceFactory"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%-- //[START imports]--%>
<%@ page import="com.example.category.Ads"%>
<%@ page import="com.example.category.Category"%>
<%-- //[END imports]--%>

<%@ page import="java.util.List"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>
<link type="text/css" rel="stylesheet" href="/stylesheets/main.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>MegaAds4U !</title>
</head>

<body>

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>

	<link rel="stylesheet"
		href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

	<div class="container">

		<img src="./megaads.jpg" alt="Logo Mega Ads">
		<h2>Welcome to MegaAds4U (by Simon LEDOUX-LEVIN & Alan MARZIN)</h2>


		<%
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm");

			String searchCriteria = request.getParameter("searchCriteria");

			String categoryName = request.getParameter("categoryName");
			if (categoryName == null) {
				categoryName = "default";
			}
			pageContext.setAttribute("categoryName", categoryName);
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			if (user != null) {
				pageContext.setAttribute("user", user);
		%>

		<p>
			Hello, ${fn:escapeXml(user.nickname)}! (You can <a
				href="<%=userService.createLogoutURL(request.getRequestURI())%>">sign
				out</a>.)
		</p>
		<%
			} else {
		%>
		<p>
			Hello! <a
				href="<%=userService.createLoginURL(request.getRequestURI())%>">Sign
				in</a>.
		</p>
		<%
			}
		%>

		<%-- //[START datastore]--%>
		<%
			// Create the correct Ancestor key
			Category theBook = new Category(categoryName);

			// Run an ancestor query to ensure we see the most up-to-date
			// view of the Adss belonging to the selected Category.
			List<Ads> adss = theBook.getAdss(searchCriteria);
		%>


		<div class="panel panel-default">

			<div class="panel-heading">
				<h4>Search Ads</h4>
			</div>
			<div class="panel-body">
				<form action="/sign" method="post">
					<div class="form-group">
						<input type="hidden" name="categoryName"
							value="${fn:escapeXml(categoryName)}" /> <input
							placeholder="Type the keyword to search" class="form-control"
							type="text" name="searchCriteria" />
					</div>
					<button type="submit" name="action" value="search" class="btn btn-info">
						Search <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
					</button>
					<button type="submit" name="action" value="delete_all" class="btn btn-danger">
						Delete all found Ads <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
					</button>
				</form>
				<form action="/">
					<button type="submit" value="Reset" class="btn btn-warning">
						Reset search <span class="glyphicon glyphicon-step-backward"
							aria-hidden="true"></span>
					</button>
				</form>
				

			</div>
		</div>

		<div class="panel panel-default">

			<div class="panel-heading">

				<%
					if (adss.isEmpty()) {
				%>
				<h3>Category '${fn:escapeXml(categoryName)}' has no Ads.</h3>
				<%
					} else {
				%>
				<h3>Ads in Category '${fn:escapeXml(categoryName)}'.</h3>
				<%
					}
				%>


				<%
					if (searchCriteria != null) {
				%>

				<h2>
					Search criteria :
					<%=searchCriteria%>
				</h2>
				<%
					}
				%>

			</div>
			<div class="panel-body">
				<%
					// Look at all of our adss
					for (Ads ads : adss) {
						pageContext.setAttribute("ads_title", ads.title);
						pageContext.setAttribute("ads_price", ads.price);
						pageContext.setAttribute("ads_content", ads.content);
						pageContext.setAttribute("ads_date", formatter.format(ads.date));
						pageContext.setAttribute("ads_key", ads.key.id());
				%>


				<table class="table table-dark">

					<!-- 
		            <tr>
		            <th scope="row">Identifiant</th>
		            <td>${fn:escapeXml(ads_key)}</td>
		            </tr>
		             -->
					<tr>
						<th scope="row">Title</th>
						<td>${fn:escapeXml(ads_title)}</td>
					</tr>

					<tr>
						<th scope="row">Description</th>
						<td>${fn:escapeXml(ads_content)}</td>
					</tr>

					<tr>
						<th scope="row">Price</th>
						<td>${fn:escapeXml(ads_price)}€</td>
					</tr>

					<tr>
						<th scope="row">Date</th>
						<td>${fn:escapeXml(ads_date)}</td>
					</tr>

				</table>


				<form action="/sign" method="post">
					<input type="hidden" name="categoryName"
						value="${fn:escapeXml(categoryName)}"><input type="hidden"
						name="delete" value="${fn:escapeXml(ads_key)}">
					<button type="submit" class="btn btn-danger">
						Delete Ads <span class="glyphicon glyphicon-trash"
							aria-hidden="true"></span>
					</button>
				</form>


				<br />
				<%
					}
				%>
			</div>

		</div>

		<div class="panel panel-default">
			<div class="panel-heading">
				<h4>Create new Ads</h4>
			</div>
			<div class="panel-body">


				<form action="/sign" method="post">

					<div class="form-group">

						<label for="title">Title: </label> <input class="form-control"
							placeholder="Title" type="text" name="title" id="title">
					</div>
					<div class="form-group">

						<label for="price">Price: </label> <input class="form-control"
							placeholder="Price (€)" type="text" name="price" id="price">
					</div>
					<div class="form-group">

						<label for="content">Description: </label> <input
							placeholder="Description" class="form-control" type="text"
							name="content" id="content">
					</div>

					<input class="form-control" type="hidden" name="categoryName"
						value="${fn:escapeXml(categoryName)}" />

					<button type="submit" value="Post Ads" class="btn btn-primary">
						Post Ads <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>
					</button>

				</form>

			</div>

		</div>


		<div class="panel panel-default">
			<div class="panel-heading">
				<h4>Create a list of Ads</h4>
			</div>
			<div class="panel-body">



				<button type="button" class="btn btn-info" data-toggle="modal"
					data-target="#exampleModal">
					Infos <span class="glyphicon glyphicon-info-sign"
						aria-hidden="true"></span>
				</button>
<br />
				<!-- Modal -->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">Informations</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<br /> Syntax of text area to create a list a Ads (';' is the
								separator) : <br />
								&#60;title&#62;;&#60;price&#62;;&#60;description&#62; <br />
								&#60;new line&#62; <br /> <br /> Example : <br /> <br />
								voici mon titre;1235.12;voici ma description <br /> deuxième
								titre;1235;deuxieme description <br /> troisieme
								titre;333;troisieme description <br /> ... <br />
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">Close</button>
							</div>
						</div>
					</div>
				</div>



				<form action="/sign" method="post">

					<div class="form-group">

						<label for="listAds">List of Ads </label>
						<textarea class="form-control" rows="5" type="text" name="listAds"
							id="listAds"></textarea>
					</div>

					<input class="form-control" type="hidden" name="categoryName"
						value="${fn:escapeXml(categoryName)}" />

					<button type="submit" value="Post Ads list" class="btn btn-primary">
						Post Ads list <span class="glyphicon glyphicon-plus"
							aria-hidden="true"></span>
					</button>

				</form>

			</div>

		</div>


		<div class="panel panel-default">
			<div class="panel-heading">
				<h4>Change category</h4>
			</div>

			<div class="panel-body">
				</form>
				<%-- //[END datastore]--%>
				<form action="/category.jsp" method="get">
					<div class="form-group">
						<input class="form-control" placeholder="Category name"
							type="text" name="categoryName"
							value="${fn:escapeXml(categoryName)}" />
					</div>
					<div>
						<button type="submit" value="Switch Category" class="btn btn-info">
							Switch Category <span class="glyphicon glyphicon-retweet"
								aria-hidden="true"></span>
						</button>
					</div>
				</form>

				<html>
			</div>
		</div>
	</div>

</body>
</html>
<%-- //[END all]--%>
