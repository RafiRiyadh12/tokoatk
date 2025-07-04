/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk2;

import java.sql.*;
import java.util.Date;

public class Transaksi {
    public int id;
    public Date tanggal;
    public int totalHarga;

    public boolean tambah() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "INSERT INTO transaksi (tanggal, total_harga) VALUES (NOW(), ?)";
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setInt(1, this.totalHarga);
            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    this.id = rs.getInt(1); // ambil id_transaksi yang baru
                }
                rs.close();
                st.close();
                conn.close();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getId() {
        return this.id;
    }
}

