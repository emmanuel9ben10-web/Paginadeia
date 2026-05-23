<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    String correo   = request.getParameter("correo");
    String password = request.getParameter("password");

    if(correo != null && password != null){
        try {
            st = conexion.prepareStatement(
                "SELECT * FROM usuarios WHERE correo=? AND password=?");
            st.setString(1, correo.toLowerCase().trim());
            st.setString(2, password);
            rs = st.executeQuery();

            if(rs.next()){
                session.setAttribute("usuario", rs.getString("nombre"));
                session.setAttribute("id_usuario", rs.getInt("id"));
                response.sendRedirect("contenido.jsp");
                return;
            } else {
                response.sendRedirect("index.jsp?error=1");
                return;
            }
        } catch(Exception e){
            response.sendRedirect("index.jsp?error=2");
            return;
        }
    }
    response.sendRedirect("index.jsp");
%>