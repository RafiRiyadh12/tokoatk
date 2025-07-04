<%-- 
    Document   : formlogin
    Created on : Jun 16, 2025, 5:42:25 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    RequestDispatcher rd = request.getRequestDispatcher("formlogin.view.jsp");
    rd.forward(request, response);
%>
