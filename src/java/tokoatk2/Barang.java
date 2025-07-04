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

public class Barang {
    public int id;
    public String nama;
    public int harga;
    public int stok;
    public boolean is_active; // Pastikan ada

    public boolean tambah() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "INSERT INTO barang (nama_barang, harga, stok, is_active) VALUES (?, ?, ?, ?)";
            PreparedStatement st = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, this.nama);
            st.setInt(2, this.harga);
            st.setInt(3, this.stok);
            st.setBoolean(4, this.is_active); // Pastikan diset di sini
            int rows = st.executeUpdate();
            if (rows > 0) {
                ResultSet generatedKeys = st.getGeneratedKeys();
                if (generatedKeys.next()) {
                    this.id = generatedKeys.getInt(1);
                }
            }
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static ArrayList<Barang> getList() {
        ArrayList<Barang> list = new ArrayList<>();
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM barang";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Barang b = new Barang();
                b.id = rs.getInt("id_barang");
                b.nama = rs.getString("nama_barang");
                b.harga = rs.getInt("harga");
                b.stok = rs.getInt("stok");
                b.is_active = rs.getBoolean("is_active");
                list.add(b);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void baca(String id) {
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM barang WHERE id_barang = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                this.id = rs.getInt("id_barang");
                this.nama = rs.getString("nama_barang");
                this.harga = rs.getInt("harga");
                this.stok = rs.getInt("stok");
                this.is_active = rs.getBoolean("is_active");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean update() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "UPDATE barang SET nama_barang = ?, harga = ?, stok = ?, is_active = ? WHERE id_barang = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, this.nama);
            st.setInt(2, this.harga);
            st.setInt(3, this.stok);
            st.setBoolean(4, this.is_active);
            st.setInt(5, this.id);
            int rows = st.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateNama() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "UPDATE barang SET nama_barang = ? WHERE id_barang = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, this.nama);
            st.setInt(2, this.id);
            int rows = st.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hapus() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "UPDATE barang SET is_active = FALSE WHERE id_barang = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setInt(1, this.id);
            int rows = st.executeUpdate();
            conn.close();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public int getId() { return id; }
    public String getNama() { return nama; }
    public int getHarga() { return harga; }
    public int getStok() { return stok; }
    public boolean isActive() { return is_active; }
}