<%-- 
    Document   : api.salestotal
    Created on : Jun 21, 2025, 9:01:26 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="java.util.*, tokoatk2.SalesDetail" %>
<%
    String idStr = request.getParameter("id");
    int id = Integer.parseInt(idStr);

    ArrayList<SalesDetail> list = SalesDetail.getListByTransaksiId(id);

    int total = 0;
    for (SalesDetail sd : list) {
        total += sd.jumlah * sd.harga;
    }

    out.print(total);
%>


