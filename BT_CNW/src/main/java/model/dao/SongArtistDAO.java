package model.dao;

import java.sql.*;
import config.DBConnect;

public class SongArtistDAO {

    public void add(int songId, int artistId) {
        String sql = "INSERT INTO song_artists(song_id, artist_id) VALUES (?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, songId);
            ps.setInt(2, artistId);
            ps.executeUpdate();

        } catch (Exception e) { e.printStackTrace(); }
    }
}
