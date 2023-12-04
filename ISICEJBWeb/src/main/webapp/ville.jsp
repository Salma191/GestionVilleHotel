<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>

<head>
<link
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
	integrity="sha512-ay2eApsZbY/uVKLr+Z8TO0JB58dRr5qV+zl2TpYY7ZlUV2HVGpr0/2W1uPg3LsR8SvMf8ViFA9OqnU5Lqj7U3ow=="
	crossorigin="anonymous" />
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<meta charset="UTF-8">
<title>La liste des villes</title>
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

.data-table th {
	background-color: #6c757d; /* Nouvelle couleur de fond */
	color: #fff; /* Nouvelle couleur du texte */
}

/* Exemple de couleur au survol des lignes du tableau */
.data-table tr:hover {
	background-color: #e9ecef; /* Nouvelle couleur au survol */
}

/* Exemple de couleur pour le bouton principal */
.btn-primary {
	background-color: #28a745; /* Nouvelle couleur de fond */
	color: #fff; /* Nouvelle couleur du texte */
}
</style>
</head>

<body>
	<div class="container">
		<div class="text-center">
			<form action="VilleController" method="post">
				<div class="d-flex justify-content-center">
					<!-- Ajout de la classe pour centrer -->
					<div class="form-group row">
						<label for="nom" class="col-sm-2 col-form-label">Nom:</label>
						<div class="col-sm-10">
							<input type="text" name="nom" class="form-control"
								style="width: 150px;" required>
						</div>
					</div>

				</div>
				<button type="submit" class="btn btn-success">Ajouter une
					ville</button>
			</form>
		</div>



		<table class="table data-table">
			<thead class="thead-light">
				<tr>
					<th class="text-center">Nom</th>
					<th class="text-center">Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${villes}" var="ville">
					<tr>
						<td class="text-center">${ville.nom}</td>
						<td class="text-center">
							<form id="deleteForm_${ville.id}" action="VilleController"
								method="post">
								<input type="hidden" name="action" value="delete"> <input
									type="hidden" name="id" value="${ville.id}">
								<button type="button" class="btn btn-danger"
									onclick="confirmDelete(${ville.id})">Supprimer</button>
							</form>
							<button type="button" class="btn btn-warning ml-2"
								data-toggle="modal" data-target="#ModifyvilleModal"
								data-ville-id="${ville.id}" data-ville-name="${ville.nom}">
								Modifier</button>
						</td>

					</tr>
				</c:forEach>
			</tbody>
		</table>
		<!-- Ajoutez ce code après votre table et avant la fermeture du div container -->
		<div class="modal fade" id="ModifyvilleModal" tabindex="-1"
			role="dialog" aria-labelledby="ModifyvilleModalTitle"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<form action="VilleController" method="post">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="ModifyvilleModalTitle">Modifier
								une ville</h5>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<label class="custom-modal-label" for="nom">Nom:</label> <input
								type="text" name="nom" id="modalvilleName" class="form-control"
								style="width: 150px;" required> <input type="hidden"
								name="action" value="update"> <input type="hidden"
								name="id" id="modalvilleId">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<input type="submit" class="btn btn-success" value="Save Changes">
						</div>
					</div>
				</form>
			</div>
		</div>

	</div>

	<script>
		$('#ModifyvilleModal').on('show.bs.modal', function(event) {
			var button = $(event.relatedTarget);
			var villeId = button.data('ville-id');
			var villeName = button.data('ville-name');
			var modal = $(this);
			modal.find('#modalvilleName').val(villeName);
			modal.find('#modalvilleId').val(villeId);
		});
		
		function confirmDelete(id) {
	        if (confirm("Êtes-vous sûr de vouloir supprimer la ville de Casablanca ?")) {
	            // Soumettre le formulaire de suppression
	            document.getElementById(`deleteForm_${id}`).submit();
	        } else {
	            // Annuler l'action de suppression
	            return false;
	        }
	    }

	    $('#ModifyvilleModal').on('show.bs.modal', function(event) {
	        var button = $(event.relatedTarget);
	        var villeId = button.data('ville-id');
	        var villeName = button.data('ville-name');
	        var modal = $(this);
	        modal.find('#modalvilleName').val(villeName);
	        modal.find('#modalvilleId').val(villeId);
	    });
	</script>
</body>

</html>
