<%-- 
    Document   : userlist.view
    Created on : Jun 16, 2025, 5:56:29 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="tokoatk2.User, java.util.ArrayList" %>
<%
    // Ambil data user terbaru kalau ada parameter refresh
    ArrayList<User> users = null;
    String refresh = request.getParameter("refresh");
    if ("true".equals(refresh)) {
        users = User.getList();
        pageContext.setAttribute("users", users);
    } else {
        // Asumsi data udah diset dari servlet, kalau nggak ada servlet, paksa ambil dari database
        if (pageContext.getAttribute("users") == null) {
            users = User.getList();
            pageContext.setAttribute("users", users);
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Daftar User</title>
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
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
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
            text-align: center;
            margin-bottom: 20px;
        }

        .button-group {
            text-align: center;
            margin-bottom: 20px;
        }

        .button-group a {
            display: inline-block;
            background: #4a4e69;
            color: #ffffff;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 4px;
            font-weight: 600;
            margin: 0 10px;
            transition: background 0.3s ease;
        }

        .button-group a:hover {
            background: #3a3d52;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #ecf0f1;
            color: #4a4e69;
            font-weight: 600;
        }

        td {
            color: #34495e;
        }

        tr:hover {
            background: #f9f9f9;
        }

        a.aksi-link {
            color: #4a4e69;
            font-weight: 600;
            text-decoration: none;
            margin: 0 5px;
            transition: color 0.3s ease;
        }

        a.aksi-link:hover {
            color: #3a3d52;
        }

        @media (max-width: 768px) {
            .container {
                margin: 20px;
                padding: 20px;
            }
            table {
                font-size: 14px;
            }
            .button-group a {
                padding: 10px 15px;
                margin: 0 5px;
            }
        }

        @media (max-width: 480px) {
            .container {
                width: 90%;
                margin: 10px;
                padding: 15px;
            }
            h1 {
                font-size: 20px;
            }
            table th, table td {
                padding: 8px;
            }
            .button-group a {
                display: block;
                margin: 5px 0;
            }
        }

        /* Styles untuk Popup Sukses */
        .success-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1000;
            width: 300px;
        }

        .success-popup.show {
            display: block;
            animation: fadeIn 0.3s ease-in;
        }

        /* Styles untuk Popup Konfirmasi/Hapus */
        .confirm-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1001; /* Di atas popup sukses */
            width: 300px;
        }

        .confirm-popup.show {
            display: block;
            animation: fadeIn 0.3s ease-in;
        }

        .confirm-text {
            font-size: 18px;
            color: #e74c3c;
            margin-bottom: 20px;
        }

        .confirm-buttons {
            display: flex;
            justify-content: space-around;
        }

        .confirm-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .confirm-btn.yes {
            background: #e74c3c;
            color: #ffffff;
        }

        .confirm-btn.yes:hover {
            background: #c0392b;
        }

        .confirm-btn.no {
            background: #bdc3c7;
            color: #ffffff;
        }

        .confirm-btn.no:hover {
            background: #95a5a6;
        }

        /* Styles untuk Popup Gagal */
        .fail-popup {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            z-index: 1000;
            width: 300px;
        }

        .fail-popup.show {
            display: block;
            animation: fadeIn 0.3s ease-in;
        }

        .fail-icon {
            width: 50px;
            height: 50px;
            display: block;
            margin: 0 auto 10px;
        }

        .fail-circle {
            stroke: #e74c3c;
            fill: #e74c3c;
            stroke-width: 2;
            stroke-miterlimit: 10;
        }

        .fail-cross {
            stroke: #ffffff;
            fill: none;
            stroke-width: 5;
            stroke-linecap: round;
            stroke-miterlimit: 10;
            animation: draw-cross 0.5s ease-in-out forwards;
        }

        @keyframes draw-cross {
            0% { stroke-dasharray: 50; stroke-dashoffset: 50; }
            100% { stroke-dasharray: 50; stroke-dashoffset: 0; }
        }

        .fail-text {
            font-size: 20px;
            color: #e74c3c;
            margin: 10px 0;
        }

        .fail-message {
            font-size: 14px;
            color: #333;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Daftar User</h1>
        <div class="button-group">
            <a href="home.jsp">Kembali ke Home</a>
            <a href="formusertambah.jsp">Tambah User</a>
        </div>
        <table>
            <tr>
                <th>Username</th>
                <th>Fullname</th>
                <th>Aksi</th>
            </tr>
            <c:forEach var="user" items="${users}">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.fullname}</td>
                    <td>
                        <a class="aksi-link" href="useredit.jsp?username=${user.username}">Edit</a> |
                        <a class="aksi-link" href="#" class="delete-btn" data-username="${user.username}" onclick="showConfirmPopup('${user.username}'); return false;">Hapus</a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>

    <!-- Popup Sukses -->
    <div id="successPopup" class="success-popup">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" />
            <path class="checkmark-check" d="M14 22 L22 30 L36 16" />
        </svg>
        <div class="success-text">Sukses!</div>
        <div class="success-message" id="successMessage">User berhasil dihapus.</div>
    </div>

    <!-- Popup Konfirmasi Hapus -->
    <div id="confirmPopup" class="confirm-popup">
        <div class="confirm-text">Yakin ingin menghapus user ini?</div>
        <div class="confirm-buttons">
            <button class="confirm-btn yes" onclick="confirmDelete()">Ya</button>
            <button class="confirm-btn no" onclick="hideConfirmPopup()">Tidak</button>
        </div>
    </div>

    <!-- Popup Gagal -->
    <div id="failPopup" class="fail-popup">
        <svg class="fail-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="fail-circle" cx="26" cy="26" r="25" />
            <path class="fail-cross" d="M16 16 L36 36 M36 16 L16 36" />
        </svg>
        <div class="fail-text">Gagal!</div>
        <div class="fail-message" id="failMessage">Penggunaan dibatalkan atau gagal dihapus.</div>
    </div>

    <script>
        // Variabel global untuk menyimpan username yang akan dihapus
        let deleteUsername = null;

        // Fungsi untuk tampilkan popup konfirmasi
        function showConfirmPopup(username) {
            deleteUsername = username;
            const popup = document.getElementById('confirmPopup');
            popup.classList.add('show');
        }

        // Fungsi untuk sembunyikan popup konfirmasi
        function hideConfirmPopup() {
            const popup = document.getElementById('confirmPopup');
            popup.classList.remove('show');
            showFailPopup("Penggunaan dibatalkan.");
        }

        // Fungsi untuk konfirmasi hapus dan redirect
        function confirmDelete() {
            if (deleteUsername) {
                window.location.href = "userhapus.jsp?username=" + encodeURIComponent(deleteUsername);
            }
            hideConfirmPopup();
        }

        // Fungsi untuk tampilkan popup gagal
        function showFailPopup(message) {
            const popup = document.getElementById('failPopup');
            const failMessage = document.getElementById('failMessage');
            failMessage.textContent = message;
            popup.classList.add('show');
            setTimeout(() => {
                popup.classList.remove('show');
            }, 3000);
        }

        // Cek parameter sukses atau error dari URL
        const urlParams = new URLSearchParams(window.location.search);
        const success = urlParams.get('success');
        const error = urlParams.get('error');
        if (success) {
            showSuccessPopup(success);
        } else if (error) {
            showFailPopup(decodeURIComponent(error));
        }
    </script>
</body>
</html>