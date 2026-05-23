<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%@include file="conexion.jsp"%>
<%
    if(session.getAttribute("id_usuario") == null){
        out.print("{\"ok\":false}"); return;
    }
    int id_usuario = (Integer) session.getAttribute("id_usuario");
    String modStr = request.getParameter("modulos");
    if(modStr != null){
        int modulos = Integer.parseInt(modStr);
        try {
            st = conexion.prepareStatement(
                "INSERT INTO progreso_usuarios(id_usuario,modulos_completados) VALUES(?,?) ON DUPLICATE KEY UPDATE modulos_completados=?");
            st.setInt(1, id_usuario);
            st.setInt(2, modulos);
            st.setInt(3, modulos);
            st.executeUpdate();
            out.print("{\"ok\":true}");
        } catch(Exception e){
            out.print("{\"ok\":false,\"error\":\"" + e.getMessage() + "\"}");
        }
    } else {
        out.print("{\"ok\":false}");
    }
%>