<%-- 
    Document   : api.baranggantinama
    Created on : Jun 19, 2025, 7:51:18 PM
    Author     : M Rafi RiyadhI
--%>

<%@page import="tokoatk2.Barang"%>
<%
    String id = request.getParameter("id");
    String namabaru = request.getParameter("namabaru");
    // out.println("Debug: id=" + id + ", nama=" + namabaru); // Hapus atau komentari ini
    Barang barang = new Barang();
    barang.baca(id); // baca data lama
    barang.nama = namabaru; // ubah nama
    if (barang.update()) {
        out.print("ok");
    } else {
        out.print("fail");
    }
%>