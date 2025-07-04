<%-- 
    Document   : userlist
    Created on : Jun 16, 2025, 5:54:54 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, tokoatk2.User, javax.servlet.*" %>
<%
    ArrayList<User> users = User.getList();
    request.setAttribute("users", users);
    RequestDispatcher rd = request.getRequestDispatcher("userlist.view.jsp");
    rd.forward(request, response);
%>

