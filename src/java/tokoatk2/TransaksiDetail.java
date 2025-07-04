/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk2;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Time;
import java.time.LocalTime;

public class TransaksiDetail {
    public int id;
    public int idTransaksi;
    public int idBarang;
    public int jumlah;
    public int hargaSatuan;

    public boolean tambah() {
        try {
            Connection conn = DbConnection.connect();

            String sql = "INSERT INTO transaksi_detail (id_transaksi, id_barang, jumlah, harga_satuan, jam) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql);

            st.setInt(1, this.idTransaksi);
            st.setInt(2, this.idBarang);
            st.setInt(3, this.jumlah);
            st.setInt(4, this.hargaSatuan);

            // Waktu sekarang
            LocalTime now = LocalTime.now();
            Time jamSekarang = Time.valueOf(now);
            st.setTime(5, jamSekarang);

            System.out.println("Jam yang dimasukkan: " + jamSekarang); // cek di log

            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
