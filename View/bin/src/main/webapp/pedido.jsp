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
    <header>
      <div class="logo">
        <img src="logo.png" alt="DRINK'S" />
      </div>
      <a class="order-button" href="index.jsp" onclick=<%session.setAttribute("novoPedido", "true");%>>NOVO PEDIDO</a>
    </header>
    <main>
    <%
    		List<Bebida> pedido = new ArrayList<Bebida>();
        	pedido = (List<Bebida>) request.getSession().getAttribute("pedido");
        	
        	
    %>
      <div class="pedido-box">
        <div class="pedido-info">
          <h2>REVISE SEU PEDIDO:</h2>
          <form action="#" method="post">
            <label for="total">Valor total:</label>
            <input type="text" id="total" name="total" />

            <label for="titular">Titular do pedido:</label>
            <input type="text" id="titular" name="titular" required />

            <label for="previsao">Previsão de preparo:</label>
            <input type="text" id="previsao" name="previsao" />

            <button type="submit">FINALIZAR PEDIDO</button>
            <a href="index.jsp" class="cancelar-button">CANCELAR PEDIDO</a>
          </form>
        </div>
        <div class="itens-pedido">
        <%
        System.out.println(pedido);
        if(pedido != null) {
        	for(Bebida item : pedido) {
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
              <button class="remove-button" onclick=<%pedido.remove(item);%>>Remover</button>
            </div>
          </div>
        </div>
      </div>
      <%
        	}
        }
      %>
    </main>
  </body>
</html>
