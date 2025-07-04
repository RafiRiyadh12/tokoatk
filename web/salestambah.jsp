<%-- 
    Document   : salestambah
    Created on : Jun 17, 2025, 11:07:34 AM
    Author     : M Rafi RiyadhI
--%>

<%@ page import="java.sql.*, java.io.StringWriter, java.io.PrintWriter" %>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<%@ page import="tokoatk2.DbConnection" %>
<%
    // Ambil data dari form
    String[] idBarangArray = request.getParameterValues("id_barang[]");
    String[] jumlahArray = request.getParameterValues("jumlah[]");

    if (idBarangArray == null || jumlahArray == null) {
        out.print("?? Data barang tidak ditemukan. Silakan pilih minimal 1 barang.");
        return;
    }

    try {
        Connection conn = DbConnection.connect();
        conn.setAutoCommit(false);

        int totalHarga = 0;

        // Insert transaksi kosong dulu
        String tanggal = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        String sqlTransaksi = "INSERT INTO transaksi (tanggal, total_harga) VALUES (?, ?)";
        PreparedStatement psTransaksi = conn.prepareStatement(sqlTransaksi, Statement.RETURN_GENERATED_KEYS);
        psTransaksi.setString(1, tanggal);
        psTransaksi.setInt(2, 0); // Diupdate nanti
        psTransaksi.executeUpdate();

        ResultSet rsKey = psTransaksi.getGeneratedKeys();
        rsKey.next();
        int idTransaksi = rsKey.getInt(1);

        for (int i = 0; i < idBarangArray.length; i++) {
            int idBarang = Integer.parseInt(idBarangArray[i]);
            int jumlah = Integer.parseInt(jumlahArray[i]);

            // Cek harga dan stok
            String sqlBarang = "SELECT harga, stok FROM barang WHERE id_barang = ?";
            PreparedStatement psBarang = conn.prepareStatement(sqlBarang);
            psBarang.setInt(1, idBarang);
            ResultSet rsBarang = psBarang.executeQuery();

            if (!rsBarang.next()) {
                out.print("? Barang dengan ID " + idBarang + " tidak ditemukan.<br>");
                conn.rollback();
                return;
            }

            int harga = rsBarang.getInt("harga");
            int stok = rsBarang.getInt("stok");

            if (jumlah > stok) {
                out.print("? Jumlah untuk ID " + idBarang + " melebihi stok (" + stok + ").<br>");
                conn.rollback();
                return;
            }

            int subtotal = harga * jumlah;
            totalHarga += subtotal;

            // Insert detail transaksi
            String sqlDetail = "INSERT INTO transaksi_detail (id_transaksi, id_barang, jumlah, harga_satuan, jam) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement psDetail = conn.prepareStatement(sqlDetail);
            psDetail.setInt(1, idTransaksi);
            psDetail.setInt(2, idBarang);
            psDetail.setInt(3, jumlah);
            psDetail.setInt(4, harga);
            psDetail.setTime(5, java.sql.Time.valueOf(java.time.LocalTime.now()));
            psDetail.executeUpdate();

            // Update stok
            String sqlUpdate = "UPDATE barang SET stok = stok - ? WHERE id_barang = ?";
            PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
            psUpdate.setInt(1, jumlah);
            psUpdate.setInt(2, idBarang);
            psUpdate.executeUpdate();
        }

        // Update total harga transaksi
        String sqlUpdateTotal = "UPDATE transaksi SET total_harga = ? WHERE id_transaksi = ?";
        PreparedStatement psTotal = conn.prepareStatement(sqlUpdateTotal);
        psTotal.setInt(1, totalHarga);
        psTotal.setInt(2, idTransaksi);
        psTotal.executeUpdate();

        conn.commit();
        conn.close();

        response.sendRedirect("saleslist.jsp");
    } catch (Exception e) {
        out.print("? Terjadi kesalahan saat menyimpan transaksi:<br>");
        StringWriter sw = new StringWriter();
        PrintWriter pw = new PrintWriter(sw);
        e.printStackTrace(pw);
        out.print("<pre>" + sw.toString() + "</pre>");
    }
%>
