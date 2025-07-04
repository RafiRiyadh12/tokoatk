<%-- 
    Document   : useredit
    Created on : Jun 16, 2025, 7:30:32 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.User" %>
<%
    String oldUsername = request.getParameter("username");
    User user = new User();
    boolean found = user.baca(oldUsername);

    if (!found) {
        out.print("User tidak ditemukan.");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
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
            overflow: auto;
        }

        .form-container {
            max-width: 400px;
            width: 100%;
            padding: 30px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69;
            text-align: center;
        }

        h2 {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 20px;
        }

        input[type="hidden"],
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background: #f9f9f9;
            color: #333;
            outline: none;
            text-align: left;
            transition: border-color 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: #4a4e69;
            background: #fff;
        }

        .button-group {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        input[type="submit"] {
            flex: 1;
            padding: 12px;
            background: #4a4e69;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-left: 5px;
        }

        input[type="submit"]:hover {
            background: #3a3d52;
        }

        .back-link {
            flex: 1;
            padding: 12px;
            background: #ffffff;
            color: #4a4e69;
            text-decoration: none;
            border: 1px solid #4a4e69;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            display: inline-block;
            margin-right: 5px;
            transition: background 0.3s ease, color 0.3s ease;
        }

        .back-link:hover {
            background: #4a4e69;
            color: #ffffff;
        }

        .error {
            color: #e74c3c;
            margin-top: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit User</h2>
        <% 
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error"><%= java.net.URLDecoder.decode(error, "UTF-8") %></div>
        <% } %>
        <form action="usereditproses.jsp" method="post">
            <input type="hidden" name="oldUsername" value="<%= user.getUsername() %>">
            <input type="text" name="username" placeholder="Username" value="<%= user.getUsername() %>" required><br>
            <input type="text" name="fullname" placeholder="Fullname" value="<%= user.getFullname() %>" required><br>
            <input type="password" name="password" placeholder="Password Baru"><br>
            <div class="button-group">
                <a class="back-link" href="userlist.jsp">Kembali ke Daftar User</a>
                <input type="submit" value="Simpan">
            </div>
        </form>
    </div>
</body>
</html>