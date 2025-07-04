<%-- 
    Document   : usertambah
    Created on : Jun 16, 2025, 6:08:28 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="tokoatk2.User, java.util.ArrayList" %>
<%
    String username = request.getParameter("username");
    String fullname = request.getParameter("fullname");
    String password = request.getParameter("password");
    String message = "";

    if (username != null && fullname != null && password != null) {
        ArrayList<User> userList = User.getList();
        boolean usernameExists = false;

        for (User u : userList) {
            if (u.username != null && u.username.equals(username)) {
                usernameExists = true;
                break;
            }
        }

        if (!usernameExists) {
            User user = new User();
            user.username = username;
            user.fullname = fullname;
            try {
                if (user.tambah(password)) {
                    message = "User berhasil ditambahkan.";
                    response.sendRedirect("formusertambah.view.jsp?success=" + java.net.URLEncoder.encode(message, "UTF-8"));
                } else {
                    message = "Username sudah ada atau gagal menambahkan user.";
                    response.sendRedirect("formusertambah.view.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
                }
            } catch (Exception e) {
                message = "Error: " + e.getMessage();
                response.sendRedirect("formusertambah.view.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
            }
        } else {
            message = "Username tidak boleh sama";
            response.sendRedirect("formusertambah.view.jsp?error=" + java.net.URLEncoder.encode(message, "UTF-8"));
        }
    } else {
        response.sendRedirect("formusertambah.view.jsp");
    }
%>