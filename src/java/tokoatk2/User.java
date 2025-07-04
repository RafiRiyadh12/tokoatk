/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk2;

import java.sql.*;
import java.util.ArrayList;

public class User {
    public String username;
    public String fullname;

    public boolean login(String username, String password) {
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM users WHERE username=? AND password=MD5(?)";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                this.username = rs.getString("username");
                this.fullname = rs.getString("fullname");
                conn.close();
                return true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean baca(String username) {
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM users WHERE username=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                this.username = rs.getString("username");
                this.fullname = rs.getString("fullname");
                conn.close();
                return true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean tambah(String password) {
        try (Connection conn = DbConnection.connect()) {
            // Cek duplikat di database
            String checkSql = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement checkSt = conn.prepareStatement(checkSql);
            checkSt.setString(1, this.username);
            ResultSet rs = checkSt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                return false; // Username sudah ada
            }

            // Insert jika unik
            String sql = "INSERT INTO users (username, fullname, password) VALUES (?, ?, MD5(?))";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, this.username);
            st.setString(2, this.fullname);
            st.setString(3, password);
            int rows = st.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean update() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "UPDATE users SET fullname=? WHERE username=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, this.fullname);
            st.setString(2, this.username);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePassword(String password) {
        try {
            Connection conn = DbConnection.connect();
            String sql = "UPDATE users SET password=MD5(?) WHERE username=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, this.username);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean hapus() {
        try {
            Connection conn = DbConnection.connect();
            String sql = "DELETE FROM users WHERE username=?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, this.username);
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static ArrayList<User> getList() {
        ArrayList<User> list = new ArrayList<>();
        try {
            Connection conn = DbConnection.connect();
            String sql = "SELECT * FROM users";
            PreparedStatement st = conn.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                User user = new User();
                user.username = rs.getString("username");
                user.fullname = rs.getString("fullname");
                list.add(user);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public String getFullname() {
        return fullname;
    }

    public String getUsername() {
        return username;
    }

    // Method baru untuk cek apakah username sudah ada
    public static boolean isUsernameExists(String username) {
        try (Connection conn = DbConnection.connect()) {
            String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
            PreparedStatement st = conn.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}