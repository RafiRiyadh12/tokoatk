<%-- 
    Document   : api.barangstat
    Created on : Jun 19, 2025, 7:56:37 PM
    Author     : M Rafi RiyadhI
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk2.Barang"%>
<%
    ArrayList<Barang> list = Barang.getList();

    int banyak = list.size();
    int total = 0;
    double rata2 = 0.0;

    for (Barang b : list) {
        total += b.harga;
    }

    if (banyak > 0) {
        rata2 = (double) total / banyak;
    }

    out.print("{ \"banyak\": " + banyak + ", \"rata2\": " + rata2 + " }");
%>
