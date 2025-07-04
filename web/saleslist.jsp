<%-- 
    Document   : saleslist
    Created on : Jun 17, 2025, 11:11:24 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, tokoatk2.DbConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Calendar" %>
<%
    String[] namaBulan = {
        "Januari", "Februari", "Maret", "April", "Mei", "Juni",
        "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    };

    Calendar cal = Calendar.getInstance();
    int bulanIndex = cal.get(Calendar.MONTH); // 0 = Januari
    String namaBulanSekarang = namaBulan[bulanIndex];

    // Hitung Total Keseluruhan
    int totalKeseluruhan = 0;
    try {
        Connection conn = DbConnection.connect();
        String sqlTotal = "SELECT SUM(d.harga_satuan * d.jumlah) as total_keseluruhan " +
                         "FROM transaksi t JOIN transaksi_detail d ON t.id_transaksi = d.id_transaksi " +
                         "WHERE MONTH(t.tanggal) = ?";
        PreparedStatement stTotal = conn.prepareStatement(sqlTotal);
        stTotal.setInt(1, bulanIndex + 1); // +1 karena bulanIndex dimulai dari 0
        ResultSet rsTotal = stTotal.executeQuery();
        if (rsTotal.next()) {
            totalKeseluruhan = rsTotal.getInt("total_keseluruhan");
        }
        conn.close();
    } catch (Exception e) {
        out.print("❌ Gagal menghitung total keseluruhan.");
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Transaksi</title>
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
            overflow: hidden;
        }

        .container {
            max-width: 800px;
            width: 100%;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69;
            text-align: center;
        }

        h1 {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 10px;
        }

        h3 {
            font-family: 'Inter', sans-serif;
            font-size: 16px;
            color: #4a4e69;
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

        .aksi-link {
            color: #4a4e69;
            font-weight: 600;
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .aksi-link:hover {
            color: #3a3d52;
        }

        #totalKeseluruhan {
            text-align: left;
            margin-bottom: 15px;
            padding: 12px 15px;
            background: #f0f4f8;
            border-left: 4px solid #4a4e69;
            border-radius: 4px;
            font-size: 16px;
            color: #2c3e50;
            font-weight: 600;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            display: block; /* Pastikan selalu tampil */
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
            #totalKeseluruhan {
                font-size: 14px;
                padding: 10px;
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
            h3 {
                font-size: 14px;
            }
            table th, table td {
                padding: 8px;
            }
            .button-group a {
                display: block;
                margin: 5px 0;
            }
            #totalKeseluruhan {
                font-size: 12px;
                padding: 8px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Daftar Transaksi</h1>
        <h3>Bulan: <%= namaBulanSekarang %></h3>
        <div class="button-group">
            <a href="formsalestambah.jsp">Tambah Transaksi</a>
            <a href="home.jsp">Kembali ke Home</a>
        </div>

        <!-- Tambah Total Keseluruhan di atas tabel, sebelah kiri -->
        <div id="totalKeseluruhan">
            Total Keseluruhan Bulan Ini: Rp<fmt:formatNumber value="<%= totalKeseluruhan %>" type="number" groupingUsed="true"/>
        </div>

        <table>
            <tr>
                <th>No</th>
                <th>Tanggal</th>
                <th>Total</th>
                <th>Aksi</th>
            </tr>

            <%
                try {
                    Connection conn = DbConnection.connect();
                    String sql = "SELECT t.tanggal, SUM(d.harga_satuan * d.jumlah) as total_harian " +
                                 "FROM transaksi t JOIN transaksi_detail d ON t.id_transaksi = d.id_transaksi " +
                                 "GROUP BY t.tanggal ORDER BY t.tanggal ASC";
                    PreparedStatement st = conn.prepareStatement(sql);
                    ResultSet rs = st.executeQuery();

                    int no = 1;
                    while (rs.next()) {
                        String tanggal = rs.getString("tanggal");
                        int total = rs.getInt("total_harian");
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= tanggal %></td>
                <td>Rp<fmt:formatNumber value="<%= total %>" type="number" groupingUsed="true"/></td>
                <td><a class="aksi-link" href="transaksidetail.jsp?tanggal=<%= tanggal %>">Lihat Detail</a></td>
            </tr>
            <%
                    }
                    conn.close();
                } catch (Exception e) {
                    out.print("❌ Gagal mengambil data transaksi.");
                    e.printStackTrace();
                }
            %>
        </table>
    </div>
</body>
</html>