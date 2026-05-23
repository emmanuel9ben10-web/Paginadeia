<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page language="java" import="java.sql.*" %>
<%
    Connection conexion = null;
    PreparedStatement st = null;
    ResultSet rs = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conexion = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/plataforma_ia?useSSL=false&serverTimezone=UTC","root","");
    } catch(Exception e) {
        out.println("<div class='alert alert-danger m-3'>Error de conexión: " + e.getMessage() + "</div>");
    }
%>