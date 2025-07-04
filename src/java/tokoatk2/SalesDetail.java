/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk2;

/**
 *
 * @author M Rafi RiyadhI
 */
import java.sql.*;
import java.util.ArrayList;

public class SalesDetail {
    public int id;
    public int id_transaksi;
    public int id_barang;
    public int jumlah;
    public int harga;

    public static ArrayList<SalesDetail> getListByTransaksiId(int idTransaksi) {
        ArrayList<SalesDetail> list = new ArrayList<>();
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM transaksi_detail WHERE id_transaksi = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, idTransaksi);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                SalesDetail sd = new SalesDetail();
                sd.id = rs.getInt("id_detail");
                sd.id_transaksi = rs.getInt("id_transaksi");
                sd.id_barang = rs.getInt("id_barang");
                sd.jumlah = rs.getInt("jumlah");
                sd.harga = rs.getInt("harga_satuan");
                list.add(sd);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}