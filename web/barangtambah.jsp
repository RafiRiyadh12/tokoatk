<%-- 
    Document   : barangtambah
    Created on : Jun 16, 2025, 8:19:31 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.Barang" %>
<%
    String nama = request.getParameter("nama");
    String hargaStr = request.getParameter("harga").replace(".", ""); // Buang titik
    int harga = Integer.parseInt(hargaStr);
    int stok = Integer.parseInt(request.getParameter("stok"));

    Barang barang = new Barang();
    barang.nama = nama;
    barang.harga = harga;
    barang.stok = stok;
    barang.is_active = true; // Set is_active jadi true

    if (barang.tambah()) {
        String successMessage = "Barang berhasil ditambahkan.";
        response.sendRedirect("formbarangtambah.view.jsp?success=" + java.net.URLEncoder.encode(successMessage, "UTF-8"));
    } else {
        out.print("? Gagal menambahkan barang.<br>");
        out.print("<a href='formtambahbarang.jsp'>? Kembali ke Form</a>");
    }
%>
