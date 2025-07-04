<%-- 
    Document   : baranglist
    Created on : Jun 16, 2025, 8:16:02 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, tokoatk2.Barang, javax.servlet.*" %>
<%
    ArrayList<Barang> barangList = Barang.getList();
    request.setAttribute("barangList", barangList);
    RequestDispatcher rd = request.getRequestDispatcher("baranglist.view.jsp");
    rd.forward(request, response);
%>

