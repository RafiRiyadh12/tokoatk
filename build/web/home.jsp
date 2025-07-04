<%-- 
    Document   : home
    Created on : Jun 16, 2025, 5:43:07 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="javax.servlet.http.HttpSession" %>
<%
    String fullname = (String) session.getAttribute("fullname");
    if (fullname == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Toko ATK</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: #f5f1e9;
            font-family: 'Inter', sans-serif;
            color: #333;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        .login-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69;
        }

        h1 {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 20px;
            text-align: center;
        }

        h2 {
            font-size: 18px;
            color: #4a4e69;
            margin-bottom: 20px;
            text-align: center;
        }

        .menu-button {
            display: block;
            width: 100%;
            padding: 12px;
            background: #4a4e69;
            color: #ffffff;
            text-decoration: none;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            margin: 10px 0;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .menu-button:hover {
            background: #3a3d52;
        }

        .logout-button {
            background: #e74c3c;
        }

        .logout-button:hover {
            background: #c0392b;
        }

        @media (max-width: 480px) {
            .login-box {
                padding: 20px;
            }
            h1 {
                font-size: 20px;
            }
            h2 {
                font-size: 16px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-box">
            <h1>Selamat datang</h1>
            <h2><%= fullname %></h2>
            <a href="userlist.jsp" class="menu-button">Kelola User</a>
            <a href="baranglist.jsp" class="menu-button">Kelola Barang</a>
            <a href="formsalestambah.jsp" class="menu-button">Tambah Transaksi</a>
            <a href="logout.jsp" class="menu-button logout-button">Logout</a>
        </div>
    </div>
</body>
</html>