<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="model.Bebida"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="pedido.css">
<title>DRINK'S | Meu pedido</title>
</head>
<body>
	
		<%
		List<Bebida> pedido = (List<Bebida>) session.getAttribute("pedido");

		if (pedido == null) {
			pedido = new ArrayList<>();
			session.setAttribute("pedido", pedido);
		}

		// pegando informações para exibição
		int tempoPreparo = 2 * pedido.size();
		double valorTotal = 0.0;
		String qrCodeData = "Dados do pedido: ";
		for (Bebida itemPedido : pedido) {
			valorTotal += itemPedido.getCost();
			qrCodeData += itemPedido.getName() + "  ";
		}
		qrCodeData += "  |  Valor total: R$" + valorTotal;

		// Verifica se o parâmetro "add" está presente na URL
		String removeBebidaId = request.getParameter("remove");
		if (removeBebidaId != null && !removeBebidaId.isEmpty()) {
			int bebidaId = Integer.parseInt(removeBebidaId);

			// Encontre a bebida correspondente ao ID
			Bebida bebidaSelecionada = null;
			for (Bebida bebida : pedido) {
				if (bebida.getId() == bebidaId) {
					bebidaSelecionada = bebida;
					break;
				}
			}

			// Adiciona a bebida selecionada ao array 'pedido'
			pedido.remove(bebidaSelecionada);
			
			

			// Redireciona de volta para a página principal (ou qualquer outra página)
			response.sendRedirect("pedido.jsp");
		}
		%>
	<header>
		<div class="logo">
			<img src="logo.png" alt="DRINK'S" />
		</div>
		<a class="order-button" href="index.jsp">VOLTAR</a>
	</header>
	<main>
		<div class="pedido-box">
			<div class="pedido-info">
				<h2>REVISE SEU PEDIDO:</h2>
				<form action="#" method="post">
					<label for="total">Valor total:</label> <input type="text"
						id="total" name="total" value="R$ <%=valorTotal%>" disabled="disabled"/> <label
						for="titular">Titular do pedido:</label> <input class="enabled" type="text"
						id="titular" name="titular" required /> <label for="previsao">Previsão
						de preparo:</label> <input type="text" id="previsao" name="previsao"
						value="<%=tempoPreparo%> minutos" disabled="disabled"/>

					<a class="submit" href="https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=<%=qrCodeData%>">FINALIZAR PEDIDO</a>
					<a href="index.jsp?clear=yes" class="cancelar-button">CANCELAR PEDIDO</a>
				</form>
			</div>
			<div class="itens-pedido">
				<%
				System.out.println(pedido);
				if (!pedido.isEmpty()) {
					Iterator<Bebida> iterator = pedido.iterator();

					while (iterator.hasNext()) {
						Bebida item = iterator.next();
				%>
				<div class="card">
					<div class="image">
						<img height="200" src=<%=item.getImage_base64()%>
							alt="<%=item.getName()%>">
					</div>
					<div class="info">
						<h2><%=item.getName()%></h2>
						<p>
							R$
							<%=item.getCost()%></p>
						<a class="remove-button" href="pedido.jsp?remove=<%=item.getId()%>">Remover do pedido</a>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</main>
</body>
</html>
