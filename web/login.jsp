<%-- 
    Document   : login
    Created on : Jun 16, 2025, 5:42:55 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk2.User"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    // Cek jika parameter kosong
    if (username == null || password == null || username.trim().isEmpty() || password.trim().isEmpty()) {
        response.sendRedirect("formlogin.jsp?error=1");
        return;
    }
    
    User user = new User();
    if(user.login(username, password)) {
        session.setAttribute("username", user.getUsername());
        session.setAttribute("fullname", user.getFullname());
        response.sendRedirect("home.jsp");
    } else {
        // Tambah parameter error=1 saat gagal login
        response.sendRedirect("formlogin.jsp?error=1");
    }
%>
