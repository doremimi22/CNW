package model.dao;

import java.sql.*;
import java.util.ArrayList;

import config.DBConnect;
import model.bean.Album;

public class AlbumDAO {

    // Lấy tất cả album
    public ArrayList<Album> getAll() {
        ArrayList<Album> list = new ArrayList<>();
        String sql = "SELECT * FROM albums ORDER BY album_id DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

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

    // Lấy album theo ID
    public Album getAlbumById(int id) {
        Album a = null;
        String sql = "SELECT * FROM albums WHERE album_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                a = new Album();
                a.setAlbumId(rs.getInt("album_id"));
                a.setTitle(rs.getString("title"));
                a.setReleaseYear(rs.getInt("release_year"));
                a.setCover(rs.getString("cover"));
                a.setDescription(rs.getString("description"));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return a;
    }


    // Insert album và return ID
    public int insert(Album a) {
        int id = -1;

        String sql = "INSERT INTO albums (title, cover, description, release_year) "
                   + "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, a.getTitle());
            ps.setString(2, a.getCover());
            ps.setString(3, a.getDescription());
            ps.setInt(4, a.getReleaseYear());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                id = rs.getInt(1);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return id;
    }


    // Thêm bài hát vào album
    public void addSongToAlbum(int albumId, int songId) {

        System.out.println("[AlbumDAO] addSongToAlbum: album=" + albumId + ", song=" + songId);

        String sql = "INSERT INTO album_songs (album_id, song_id) VALUES (?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, albumId);
            ps.setInt(2, songId);
            ps.executeUpdate();

        } catch (Exception e) {
            System.out.println("ERROR in addSongToAlbum:");
            e.printStackTrace();
        }
    }
    // ⭐ TÌM KIẾM ALBUM
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
                a.setCover(rs.getString("cover"));
                a.setDescription(rs.getString("description"));
                a.setReleaseYear(rs.getInt("release_year"));
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
