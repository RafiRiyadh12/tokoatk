<%-- 
    Document   : barangedit
    Created on : Jun 16, 2025, 8:43:49 PM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="tokoatk2.Barang" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Barang barang = null;

    for (Barang b : Barang.getList()) {
        if (b.id == id) {
            barang = b;
            break;
        }
    }

    if (barang == null) {
        out.print("Barang tidak ditemukan.");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Barang</title>
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

        input[type="hidden"],
        input[type="text"],
        input[type="number"] {
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
        input[type="number"]:focus {
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

        @media (max-width: 480px) {
            .form-container {
                padding: 20px;
            }
            h2 {
                font-size: 20px;
            }
            input[type="text"],
            input[type="number"] {
                font-size: 13px;
                padding: 8px;
            }
            .button-group {
                flex-direction: column;
            }
            button, .back-link {
                margin: 5px 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Edit Barang</h2>
        <form action="barangeditproses.jsp" method="post">
            <input type="hidden" name="id" value="<%= barang.id %>">
            <input type="text" name="nama" placeholder="Nama Barang" value="<%= barang.nama %>">
            <input type="text" name="harga" placeholder="Harga" value="<%= barang.harga %>">
            <input type="number" name="stok" placeholder="Stok" value="<%= barang.stok %>">
            <div class="button-group">
                <a class="back-link" href="baranglist.jsp">Kembali ke Daftar Barang</a>
                <button type="submit">Simpan</button>
            </div>
        </form>
    </div>
</body>
</html>