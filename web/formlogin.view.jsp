<%-- 
    Document   : formlogin.view
    Created on : Jun 16, 2025, 5:42:37 AM
    Author     : M Rafi RiyadhI
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - TOKO ATK</title>
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
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
        }

        .login-container {
            width: 100%;
            max-width: 400px;
            padding: 20px;
        }

        .login-box {
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69; /* Aksen ungu tua */
        }

        .logo-text {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 20px;
            text-align: center;
        }

        .login-title {
            font-size: 20px;
            font-weight: 600;
            color: #4a4e69;
            margin-bottom: 20px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            background: #f9f9f9;
            color: #333;
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-input:focus {
            border-color: #4a4e69;
            background: #fff;
        }

        .login-btn {
            width: 100%;
            padding: 12px;
            background: #4a4e69;
            color: #ffffff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .login-btn:hover {
            background: #3a3d52;
        }

        .error-message {
            color: #e74c3c;
            font-size: 12px;
            font-weight: 500;
            margin-top: 10px;
            padding: 8px;
            background: rgba(231, 76, 60, 0.1);
            border-radius: 4px;
            border-left: 3px solid #e74c3c;
            text-align: center;
        }

        @media (max-width: 480px) {
            .login-box {
                padding: 20px;
            }
            .logo-text {
                font-size: 20px;
            }
            .login-title {
                font-size: 18px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <div class="logo-text">TOKO ATK</div>
            <h1 class="login-title">Welcome Back</h1>
            
            <form id="loginForm" action="login.jsp" method="post">
                <div class="form-group">
                    <input type="text" name="username" class="form-input" placeholder="Username" required id="username">
                </div>
                
                <div class="form-group">
                    <input type="password" name="password" class="form-input" placeholder="Password" required id="password">
                </div>
                
                <% 
                    String error = request.getParameter("error");
                    if (error != null && error.equals("1")) { 
                %>
                    <div class="error-message" id="errorMessage">
                        ❌ Username atau password salah. Silakan coba lagi.
                    </div>
                <% } %>
                
                <div class="form-group">
                    <button type="submit" class="login-btn" id="loginBtn">Login</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const form = document.getElementById("loginForm");
        const btn = document.getElementById("loginBtn");
        const usernameInput = document.getElementById("username");
        const passwordInput = document.getElementById("password");

        form.addEventListener("submit", function(e) {
            e.preventDefault();
            form.submit();
        });

        [usernameInput, passwordInput].forEach(input => {
            input.addEventListener("focus", function() {
                this.classList.remove("error");
            });
        });
    </script>
</body>
</html>