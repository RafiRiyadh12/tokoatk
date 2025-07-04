<%-- 
    Document   : barangaktif.jsp
    Created on : Jun 23, 2025, 2:32:19 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="java.sql.*, tokoatk2.DbConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    try {
        conn = DbConnection.connect();
        String updateSql = "UPDATE barang SET is_active = TRUE WHERE id_barang=?";
        PreparedStatement updateSt = conn.prepareStatement(updateSql);
        updateSt.setInt(1, id);
        int rows = updateSt.executeUpdate();
        conn.close();
        if (rows > 0) {
            String successMessage = "Barang berhasil diaktifkan.";
            response.sendRedirect("baranglist.jsp?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));
        } else {
            String errorMessage = "Gagal mengaktifkan barang (data tidak ditemukan).";
            response.sendRedirect("baranglist.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        }
    } catch (Exception e) {
        if (conn != null) conn.close();
        String errorMessage = "Gagal mengaktifkan barang: " + e.getMessage();
        response.sendRedirect("baranglist.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
        e.printStackTrace();
    }
%>