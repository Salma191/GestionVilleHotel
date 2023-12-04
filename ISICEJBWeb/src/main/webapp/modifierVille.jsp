<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Modifier une ville</title>
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
            font-size: 2em;
            color: #228b22;
            text-shadow: 2px 2px 4px #000000;
            margin-right: 100px;
        }
    </style>
</head>
<body>
    <h1 class="hotels-heading">Modifier la ville</h1>
    <form action="VilleController" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= request.getParameter("idVille") %>">
        Nouveau nom de la ville : <input type="text" name="ville" /><br>
        <input type="submit" class="btn" value="Enregistrer">
    </form>
</body>
</html>

