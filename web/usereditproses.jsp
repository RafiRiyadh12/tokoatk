<%-- 
    Document   : usereditproses
    Created on : Jun 16, 2025, 7:31:04 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.User" %>
<%
    String oldUsername = request.getParameter("oldUsername");
    String newUsername = request.getParameter("username");
    String fullname = request.getParameter("fullname");
    String password = request.getParameter("password");

    User user = new User();
    user.username = newUsername;
    user.fullname = fullname;

    boolean suksesUpdateData = false;
    boolean suksesUpdatePassword = true; // default true

    // Cek apakah username baru sudah ada (kecuali sama dengan username lama)
    if (!oldUsername.equals(newUsername) && User.isUsernameExists(newUsername)) {
        String errorMessage = "Username tidak boleh sama.";
        response.sendRedirect("useredit.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8") + "&username=" + java.net.URLEncoder.encode(oldUsername, "UTF-8"));
        return;
    }

    // update data utama
    if (!oldUsername.equals(newUsername)) {
        // ubah username ? hapus lama, tambah baru
        User oldUser = new User();
        oldUser.username = oldUsername;
        suksesUpdateData = oldUser.hapus() && user.tambah(password != null && !password.trim().isEmpty() ? password : "123"); // default password jika tidak diisi
    } else {
        // hanya update fullname
        suksesUpdateData = user.update();

        // jika password diisi, update password
        if (password != null && !password.trim().isEmpty()) {
            suksesUpdatePassword = user.updatePassword(password);
        }
    }

    if (suksesUpdateData && suksesUpdatePassword) {
        String successMessage = "User berhasil diupdate.";
        response.sendRedirect("userlist.jsp?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8")); // Redirect ke userlist.jsp
    } else {
        String errorMessage = "Gagal mengubah data user.";
        response.sendRedirect("useredit.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8") + "&username=" + java.net.URLEncoder.encode(oldUsername, "UTF-8"));
    }
%>