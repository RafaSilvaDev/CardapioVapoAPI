<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.net.URL"%>
<%@ page import="java.net.HttpURLConnection"%>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.InputStreamReader"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.reflect.TypeToken"%>
<%@ page import="model.Bebida"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<title>DRINK'S</title>
<link rel="stylesheet" href="style.css">
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<%
		session.setAttribute("novoPedido", "true");
		String novoPedido = session.getAttribute("novoPedido").toString();

		List<Bebida> pedido = new ArrayList<Bebida>();

		if (novoPedido == "true") {
			pedido.clear();
		}
	%>
	<header>
		<div class="logo">
			<img src="logo.png" alt="DRINK'S">
		</div>
		<a href="pedido.jsp"
			onclick=<%request.setAttribute("accomList", pedido);
			session.setAttribute("novoPedido", "false");%>
			class="order-button">FINALIZAR PEDIDO</a>
	</header>
	<main>
	<div class="menu">
		<%
			// Fazer a requisição HTTP para a sua API Spring
			URL url = new URL("http://localhost:8081/api/bebidas");
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			connection.setRequestMethod("GET");

			// Ler a resposta da API
			BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			StringBuilder result = new StringBuilder();

			while ((line = reader.readLine()) != null) {
				result.append(line);
			}

			reader.close();
			connection.disconnect();

			// Converter a resposta JSON para uma lista de objetos usando o Gson
			Gson gson = new Gson();
			List<Bebida> listaDeBebidas = gson.fromJson(result.toString(), new TypeToken<List<Bebida>>() {
			}.getType());

			// Iterar sobre as bebidas e gerar o HTML dinamicamente
			for (Bebida bebida : listaDeBebidas) {
		%>
		<div class="card">
			<div class="image">
				<img height="200" src=<%=bebida.getImage_base64()%>
					alt="<%=bebida.getName()%>">
			</div>
			<div class="info">
				<h2><%=bebida.getName()%></h2>
				<p>
					R$
					<%=bebida.getCost()%></p>
				<button class="add-button" onclick=<%pedido.add(bebida); System.out.println(pedido);%>>Adicionar
					ao pedido</button>
			</div>
		</div>
		<%
			}
		%>
	</div>
	</main>
	<script src="script.js"></script>
</body>
</html>
