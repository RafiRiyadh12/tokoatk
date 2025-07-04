<%-- 
    Document   : logout
    Created on : Jun 16, 2025, 5:46:23 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    session.invalidate();
    response.sendRedirect("formlogin.jsp");
%>

