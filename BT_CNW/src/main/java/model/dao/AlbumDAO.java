package model.dao;

import java.sql.*;
import java.util.ArrayList;
import model.bean.Album;
import config.DBConnect;

public class AlbumDAO {

    public ArrayList<Album> getAll() {
        ArrayList<Album> list = new ArrayList<>();
        String sql = "SELECT * FROM albums";

        try (Connection con = DBConnect.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Album a = new Album();
                a.setAlbumId(rs.getInt("album_id"));
                a.setTitle(rs.getString("title"));
                a.setReleaseYear(rs.getInt("release_year"));
                a.setCover(rs.getString("cover"));
                a.setDescription(rs.getString("description"));
                list.add(a);
            }

        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    //lấy thông tin album
    public Album getAlbumById(int albumId) {
        Album a = null;
        String sql = "SELECT * FROM albums WHERE album_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, albumId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Album();
                a.setAlbumId(rs.getInt("album_id"));
                a.setTitle(rs.getString("title"));
                a.setReleaseYear(rs.getInt("release_year"));
                a.setCover(rs.getString("cover"));
                a.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return a;
    }
    public ArrayList<Album> searchAlbums(String keyword) {
        ArrayList<Album> list = new ArrayList<>();

        String sql = "SELECT * FROM albums WHERE title LIKE ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Album a = new Album();
                a.setAlbumId(rs.getInt("album_id"));
                a.setTitle(rs.getString("title"));
                a.setReleaseYear(rs.getInt("release_year"));
                a.setCover(rs.getString("cover"));
                a.setDescription(rs.getString("description"));

                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
