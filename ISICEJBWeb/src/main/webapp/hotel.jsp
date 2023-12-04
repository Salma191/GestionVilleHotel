<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<!DOCTYPE html>
<html>
<head>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-ay2eApsZbY/uVKLr+Z8TO0JB58dRr5qV+zl2TpYY7ZlUV2HVGpr0/2W1uPg3LsR8SvMf8ViFA9OqnU5Lqj7U3ow=="
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<title>Gestion des hotels</title>
<style>
.container {
	margin-top: 20px;
}

.data-table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 20px;
	border-radius: 5px;
	overflow: hidden;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.custom-modal-size {
	max-width: 50%; /* Taille maximale du modal */
}

.custom-modal-style {
	border-radius: 15px; /* Coins arrondis du modal */
	box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
	/* Ombre autour du modal */
}

.custom-modal-label {
	font-weight: bold; /* Police en gras pour les labels */
}

.data-table th, .data-table td {
	padding: 12px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

.data-table th {
	background-color: #007bff;
	color: #fff;
}

.data-table tr:hover {
	background-color: #f5f5f5;
}

.form-group {
	margin-bottom: 15px;
}

.form-label {
	font-weight: bold;
}

.input-group {
	display: flex;
	align-items: center;
}

.select-filter {
	flex-grow: 1;
	margin-right: 10px;
}

.btn {
	padding: 10px 20px;
	margin: 5px;
	cursor: pointer;
}

.btn-primary {
	background-color: #007bff;
	color: #fff;
}
</style>
</head>
<body>
	<div class="container">
	<div class="text-center">
		<form action="HotelController" method="post">
		<div class="d-flex justify-content-center">
			<div class="form-group">
			 <label class="custom-modal-label" for="nom">Nom:</label>
				<input type="text" name="nom" class="form-control" style="width: 200px;" required><br>
			<br><label class="custom-modal-label" for="adresse">Adresse:</label>
				<input type="text" name="adresse" class="form-control" style="width: 200px;" required><br>
				<br> <label class="custom-modal-label" for="telephone">Telephone:</label>
				<input type="text" name="telephone" class="form-control" style="width: 200px;" required><br>
				<br> <label class="custom-modal-label" for="ville">Ville:</label>
				<select name="ville" class="form-control" style="width: 200px;">
					<c:forEach items="${villes}" var="ville">
						<option value="${ville.id}">${ville.nom}</option>
					</c:forEach>
				</select>
				<input type="submit" class="btn btn-success mt-3" value="Ajouter un hotel">
			</div>
			</div>
		</form>
		</div>

		<table class="table data-table">
			<thead class="thead-light">
				<tr>
					<th>ID</th>
					<th>Adresse</th>
					<th>Nom</th>
					<th>Telephone</th>
					<th>Ville</th>
					<th>Supprimer</th>
					<th>Modifier</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${hotels}" var="hotel">
					<tr>
						<td>${hotel.id}</td>
						<td>${hotel.adresse}</td>
						<td>${hotel.nom}</td>
						<td>${hotel.telephone}</td>
						<td>${hotel.ville.nom}</td>
						<td>
							<form action="HotelController" method="post">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" value="${hotel.id}">
								<button type="submit" class="btn btn-danger">Supprimer</button>
							</form>
						</td>
						<td>
							<form action="HotelController" method="post">
								<input type="hidden" name="action" value="edit"> <input
									type="hidden" name="id" value="${hotel.id}">
								<button type="submit" class="btn btn-secondary">Modifier</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>
