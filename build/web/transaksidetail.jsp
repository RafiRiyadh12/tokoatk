<%-- 
    Document   : transaksidetail
    Created on : Jun 17, 2025, 11:47:27 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, tokoatk2.DbConnection" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Detail Transaksi</title>
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
            max-width: 850px;
            width: 100%;
            margin: 40px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-left: 4px solid #4a4e69;
            max-height: 90vh;
            overflow-y: auto;
            text-align: center;
        }

        h1 {
            font-family: 'Roboto', sans-serif;
            font-size: 24px;
            font-weight: 500;
            color: #4a4e69;
            margin-bottom: 20px;
        }

        .back-button {
            display: inline-block;
            background: #4a4e69;
            color: #ffffff;
            text-decoration: none;
            padding: 12px 20px;
            border-radius: 4px;
            font-weight: 600;
            margin-bottom: 20px;
            transition: background 0.3s ease;
        }

        .back-button:hover {
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
            table th, table td {
                padding: 8px;
            }
            .back-button {
                padding: 10px 15px;
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
        <h1>Detail Transaksi Tanggal: <%= request.getParameter("tanggal") %></h1>
        <a class="back-button" href="saleslist.jsp">Kembali ke Daftar Transaksi</a>

        <%
            String tanggal = request.getParameter("tanggal");
            int totalKeseluruhan = 0;
            Connection conn = null;
            PreparedStatement st = null;
            ResultSet rs = null;
            try {
                conn = DbConnection.connect();
                // Hitung Total Keseluruhan
                String sqlTotal = "SELECT SUM(d.harga_satuan * d.jumlah) as total_harian " +
                                 "FROM transaksi t " +
                                 "JOIN transaksi_detail d ON t.id_transaksi = d.id_transaksi " +
                                 "WHERE t.tanggal = ?";
                st = conn.prepareStatement(sqlTotal);
                st.setString(1, tanggal);
                rs = st.executeQuery();
                if (rs.next()) {
                    totalKeseluruhan = rs.getInt("total_harian");
                }
                // Query Detail
                String sql = "SELECT d.jam, d.id_transaksi, b.nama_barang, d.jumlah, d.harga_satuan " +
                             "FROM transaksi t " +
                             "JOIN transaksi_detail d ON t.id_transaksi = d.id_transaksi " +
                             "JOIN barang b ON d.id_barang = b.id_barang " +
                             "WHERE t.tanggal = ? " +
                             "ORDER BY d.jam ASC";
                st = conn.prepareStatement(sql);
                st.setString(1, tanggal);
                rs = st.executeQuery();

                int no = 1;
        %>
        <!-- Tambah Total Keseluruhan di atas tabel, sebelah kiri -->
        <div id="totalKeseluruhan">
            Total Keseluruhan Hari Ini: Rp<fmt:formatNumber value="<%= totalKeseluruhan %>" type="number" groupingUsed="true"/>
        </div>

        <table>
            <tr>
                <th>No</th>
                <th>Jam</th>
                <th>ID Transaksi</th>
                <th>Nama Barang</th>
                <th>Jumlah</th>
                <th>Harga Satuan</th>
                <th>Total</th>
            </tr>

            <%
                while (rs.next()) {
                    Time jam = rs.getTime("jam");
                    int idTransaksi = rs.getInt("id_transaksi");
                    String nama = rs.getString("nama_barang");
                    int jumlah = rs.getInt("jumlah");
                    int harga = rs.getInt("harga_satuan");
                    int total = jumlah * harga;
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= jam %></td>
                <td><%= idTransaksi %></td>
                <td><%= nama %></td>
                <td><%= jumlah %></td>
                <td>Rp<fmt:formatNumber value="<%= harga %>" type="number" groupingUsed="true"/></td>
                <td>Rp<fmt:formatNumber value="<%= total %>" type="number" groupingUsed="true"/></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
            } catch (Exception e) {
                out.print("❌ Gagal mengambil detail transaksi.");
                e.printStackTrace();
            } finally {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (conn != null) conn.close();
            }
        %>
    </div>
</body>
</html>