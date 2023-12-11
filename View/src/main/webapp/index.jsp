
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
		// API Request HTTP
		URL url = new URL("http://localhost:8081/api/bebidas");
		HttpURLConnection connection = (HttpURLConnection) url.openConnection();
		connection.setRequestMethod("GET");

		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		String line;
		StringBuilder result = new StringBuilder();

		while ((line = reader.readLine()) != null) {
			result.append(line);
		}

		reader.close();
		connection.disconnect();

		Gson gson = new Gson();
		List<Bebida> listaDeBebidas = gson.fromJson(result.toString(), new TypeToken<List<Bebida>>() {
		}.getType());
		
	%>
	<%
		List<Bebida> pedido = (List<Bebida>) session.getAttribute("pedido");
	
	    if (pedido == null) {
	        pedido = new ArrayList<>();
	        session.setAttribute("pedido", pedido);
	    }
	    
	    String clear = request.getParameter("clear");
	    
	    if(clear != null && clear.equals("yes"))
	    	pedido.clear();
	
	    // Verifica se o parâmetro "add" está presente na URL
	    String addBebidaId = request.getParameter("add");
	    if (addBebidaId != null && !addBebidaId.isEmpty()) {
	        int bebidaId = Integer.parseInt(addBebidaId);
	
	        // Encontre a bebida correspondente ao ID
	        Bebida bebidaSelecionada = null;
	        for (Bebida bebida : listaDeBebidas) {
	            if (bebida.getId() == bebidaId) {
	                bebidaSelecionada = bebida;
	                break;
	            }
	        }
	
	        // Adiciona a bebida selecionada ao array 'pedido'
	        pedido.add(bebidaSelecionada);
	        
	
	        // Redireciona de volta para a página principal (ou qualquer outra página)
	        response.sendRedirect("index.jsp");
	    }
	%>
	<header>
		<div class="logo">
			<img src="logo.png" alt="DRINK'S">
		</div>
		<a href="pedido.jsp"
			onclick="<%request.setAttribute("accomList", pedido);
			session.setAttribute("novoPedido", "false");%>"
			class="order-button">FINALIZAR PEDIDO</a>
	</header>
	<main>
	<%if (addBebidaId != null && !addBebidaId.isEmpty()) {
		System.out.println(addBebidaId);
	%>
		<div class="message"><p>
		Item adicionado ao seu pedido.
		</p></div>
	<%}%>
	<div class="menu">
		<%
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
				<a class="add-button" href="index.jsp?add=<%=bebida.getId()%>">Adicionar ao pedido</a>

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
