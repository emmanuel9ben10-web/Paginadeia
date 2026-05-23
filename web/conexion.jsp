<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="java.sql.*" %>
<%
    Connection conexion = null;
    PreparedStatement st = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:mysql://localhost/plataforma_ia","root","");
    } catch(Exception e) {
        out.println("<div class='alert alert-danger m-3'>Error de conexión: " + e.getMessage() + "</div>");
    }
%>