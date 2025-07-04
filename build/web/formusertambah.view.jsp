<%-- 
    Document   : formusertambah.view
    Created on : Jun 16, 2025, 6:08:09 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Tambah User</title>
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

        button {
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

        button:hover {
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

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .checkmark {
            width: 50px;
            height: 50px;
            display: block;
            margin: 0 auto 10px;
        }

        .checkmark-circle {
            stroke: #2ecc71;
            fill: #2ecc71;
            stroke-width: 2;
            stroke-miterlimit: 10;
        }

        .checkmark-check {
            stroke: #ffffff;
            fill: none;
            stroke-width: 5;
            stroke-linecap: round;
            stroke-miterlimit: 10;
            animation: draw-check 0.5s ease-in-out forwards;
        }

        @keyframes draw-check {
            0% { stroke-dasharray: 50; stroke-dashoffset: 50; }
            100% { stroke-dasharray: 50; stroke-dashoffset: 0; }
        }

        .success-text {
            font-size: 20px;
            color: #2ecc71;
            margin: 10px 0;
        }

        .success-message {
            font-size: 14px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Tambah User</h2>
        <% 
            String error = request.getParameter("error");
            if (error != null) {
        %>
            <div class="error"><%= java.net.URLDecoder.decode(error, "UTF-8") %></div>
        <% } %>
        <form action="usertambah.jsp" method="post">
            <input type="text" name="username" placeholder="Username" required><br>
            <input type="text" name="fullname" placeholder="Fullname" required><br>
            <input type="password" name="password" placeholder="Password" required><br>
            <div class="button-group">
                <a class="back-link" href="userlist.jsp">Kembali ke Daftar User</a>
                <button type="submit">Tambah</button>
            </div>
        </form>
    </div>

    <!-- Popup Sukses -->
    <div id="successPopup" class="success-popup">
        <svg class="checkmark" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 52 52">
            <circle class="checkmark-circle" cx="26" cy="26" r="25" />
            <path class="checkmark-check" d="M14 22 L22 30 L36 16" />
        </svg>
        <div class="success-text">Sukses!</div>
        <div class="success-message" id="successMessage">User berhasil ditambahkan.</div>
    </div>

    <script>
        // Fungsi untuk tampilkan popup dan redirect
        function showSuccessPopup(message) {
            const popup = document.getElementById('successPopup');
            const successMessage = document.getElementById('successMessage');
            successMessage.textContent = message;
            popup.classList.add('show');
            setTimeout(() => {
                popup.classList.remove('show');
                window.location.href = "userlist.jsp";
            }, 3000);
        }

        // Cek parameter sukses dari URL
        const urlParams = new URLSearchParams(window.location.search);
        const success = urlParams.get('success');
        if (success) {
            showSuccessPopup(success);
        }
    </script>
</body>
</html>