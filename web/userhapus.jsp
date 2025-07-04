<%-- 
    Document   : userhapus
    Created on : Jun 16, 2025, 7:43:22 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.User" %>
<%
    String username = request.getParameter("username");

    // ? Cegah user menghapus dirinya sendiri
    String currentUser = (String) session.getAttribute("username");
    if (username != null && username.equals(currentUser)) {
        String errorMessage = "Tidak bisa menghapus user yang sedang login.";
        response.sendRedirect("userlist.view.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        return; // langsung hentikan proses
    }

    if (username != null && !username.trim().isEmpty()) {
        User user = new User();
        user.username = username;

        if (user.hapus()) {
            String successMessage = "User berhasil dihapus.";
            // Tambah parameter buat mastiin refresh
            response.sendRedirect("userlist.view.jsp?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8") + "&refresh=true");
        } else {
            String errorMessage = "Gagal menghapus user.";
            response.sendRedirect("userlist.view.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        }
    } else {
        String errorMessage = "Username tidak valid.";
        response.sendRedirect("userlist.view.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
    }
%>