<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
%>
<!DOCTYPE html>
<html><body><script>
    localStorage.removeItem('doneCount');
    window.location.href = 'index.jsp';
</script></body></html>