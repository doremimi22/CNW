
package model.dao;

import model.bean.Playlist;
import java.sql.*;
import java.util.ArrayList;

import config.DBConnect;

public class PlaylistDAO {
    private Connection conn;

    public PlaylistDAO() {
        try {
            conn = DBConnect.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Playlist> getAllByUser(int userId) {
        ArrayList<Playlist> list = new ArrayList<>();
        String sql = "SELECT * FROM playlists WHERE userId = ? ORDER BY playlistId DESC";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Playlist(
                        rs.getInt("playlistId"),
                        rs.getInt("userId"),
                        rs.getString("name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void createPlaylist(int userId, String name) {
        String sql = "INSERT INTO playlists(userId, name) VALUES (?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, name);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public int getTotalSongs(int playlistId) {
        String sql = "SELECT COUNT(*) FROM playlist_song WHERE playlistId=?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, playlistId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {}
        return 0;
    }

    public Playlist getById(int playlistId) {
        String sql = "SELECT * FROM playlists WHERE playlistId = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, playlistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new Playlist(
                        rs.getInt("playlistId"),
                        rs.getInt("userId"),
                        rs.getString("name")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public int createPlaylistReturnId(int userId, String name) {
        String sql = "INSERT INTO playlists(userId, name) VALUES (?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setString(2, name);
            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) { e.printStackTrace(); }

        return -1;
    }

}