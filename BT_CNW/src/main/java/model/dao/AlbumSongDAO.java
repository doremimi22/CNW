package model.dao;

import java.sql.*;
import config.DBConnect;

public class AlbumSongDAO {

    public void addSongToAlbum(int albumId, int songId) {
        String sql = "INSERT INTO album_songs(album_id, song_id) VALUES (?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, albumId);
            ps.setInt(2, songId);
            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }
}
