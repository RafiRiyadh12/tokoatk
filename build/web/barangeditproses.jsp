<%-- 
    Document   : barangeditproses
    Created on : Jun 16, 2025, 8:44:10 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.Barang" %>
<%@ page import="tokoatk2.Barang" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, tokoatk2.DbConnection" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nama = request.getParameter("nama");
    String hargaStr = request.getParameter("harga").replace(".", "");
    int harga = Integer.parseInt(hargaStr);
    int stok = Integer.parseInt(request.getParameter("stok"));

    Barang barang = new Barang();
    barang.id = id;
    barang.nama = nama;
    barang.harga = harga;
    barang.stok = stok;

    try {
        Connection conn = tokoatk2.DbConnection.connect();
        String sql = "UPDATE barang SET nama_barang=?, harga=?, stok=? WHERE id_barang=?";
        PreparedStatement st = conn.prepareStatement(sql);
        st.setString(1, barang.nama);
        st.setInt(2, barang.harga);
        st.setInt(3, barang.stok);
        st.setInt(4, barang.id);
        st.executeUpdate();
        conn.close();
        response.sendRedirect("baranglist.jsp");
    } catch (Exception e) {
        out.print("? Gagal update.<br>");
        out.print("<a href='barangedit.jsp?id=" + id + "'>? Kembali ke Edit</a>");
        e.printStackTrace();
    }
%>
