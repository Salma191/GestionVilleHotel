<%@page import="services.HotelService"%>
<%@page import="entities.Hotel"%>
<%@page import="dao.IDaoLocale"%>
<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Modifier un hôtel</title>
<style>
        body {
            background: linear-gradient(to right, #7fff00, #00ced1);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .form-container {
            width: 50%;
            text-align: center;
        }

        .form-container input[type="text"],
        .form-container select {
            width: 100%;
            margin-bottom: 10px;
            padding: 5px;
            border-radius: 3px;
        }

        h1 {
            color: #228b22;
            text-shadow: 2px 2px 4px #000000;
            text-align: center;
            margin-bottom: 20px;
        }

        .btn {
            background-color: #00ff7f;
            border-color: #228b22;
            color: #228b22;
            padding: 5px 10px;
            text-decoration: none;
            display: inline-block;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #00ff00;
            border-color: #008000;
            color: #008000;
        }
        h1.hotels-heading {
            font-size: 2.2em;
            color: #228b22;
            text-shadow: 2px 2px 4px #000000;
            margin-right: 100px;
        }
    </style>
</head>

<body>
	<h1 class="hotels-heading">Modifier un hôtel</h1>
	 <%-- Récupérer la liste des villes --%>
  <%-- Récupérer la liste des villes --%>
<%
    List<Ville> villes = (List<Ville>) request.getAttribute("villes");

  
%>

	<form action="HotelController" method="post">
		<input type="hidden" name="action" value="update">
		 <input type="hidden" name="id" value="<%=request.getParameter("idHotel")%>"> Nouveau nom
		de l'hôtel : <input type="text" name="hotel" /><br> Nouvelle
		adresse : <input type="text" name="adresse" /><br> Nouveau
		numéro de téléphone : <input type="text" name="telephone" /><br>
		 <label for="villeSelect">Changer la ville :</label>
        <select id="villeSelect" name="villeId">
            <option value="">Sélectionnez une ville</option>
            <c:forEach var="ville" items="${villes}">
                <option value="${ville.id}">${ville.nom}</option>
            </c:forEach> 
            <input type="submit" class="btn" value="Enregistrer">
	</form>
</body>
</html>
