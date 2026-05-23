<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    if(session.getAttribute("id_usuario") == null){
        out.print("{\"modulos\":0}"); return;
    }
    int id_usuario = (Integer) session.getAttribute("id_usuario");
    try {
        st = conexion.prepareStatement("SELECT modulos_completados FROM progreso_usuarios WHERE id_usuario=?");
        st.setInt(1, id_usuario);
        rs = st.executeQuery();
        int modulos = 0;
        if(rs.next()) modulos = rs.getInt("modulos_completados");
        out.print("{\"modulos\":" + modulos + "}");
    } catch(Exception e){
        out.print("{\"modulos\":0,\"error\":\"" + e.getMessage() + "\"}");
    }
%>