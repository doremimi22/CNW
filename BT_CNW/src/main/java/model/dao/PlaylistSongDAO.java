
package model.dao;

import model.bean.PlaylistSongItem;
import model.bean.Song;
import java.sql.*;
import java.util.ArrayList;

import config.DBConnect;

public class PlaylistSongDAO {

    private Connection conn;

    public PlaylistSongDAO() {
        try {
            conn = DBConnect.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ============================================================
    // 1) THÊM BÀI HÁT VÀO PLAYLIST
    // ============================================================
    public void addSong(int playlistId, int songId) {
        String sql = "INSERT INTO playlist_song (playlistId, songId) VALUES (?, ?)";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, playlistId);
            ps.setInt(2, songId);
            ps.executeUpdate();
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ============================================================
    // 2) XOÁ 1 BÀI HÁT KHỎI PLAYLIST
    // ============================================================
    public void removeSong(int playlistSongId) {
        String sql = "DELETE FROM playlist_song WHERE id = ?";

        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, playlistSongId);
            ps.executeUpdate();
        } 
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ============================================================
    // 3) LẤY TOÀN BỘ BÀI HÁT TRONG 1 PLAYLIST
    // ============================================================
    public ArrayList<PlaylistSongItem> getSongsByPlaylist(int playlistId) {

        ArrayList<PlaylistSongItem> list = new ArrayList<>();

        String sql = "SELECT ps.id AS playlistSongId, s.* " +
                     "FROM playlist_song ps " +
                     "JOIN songs s ON ps.songId = s.song_id " + // 🔥 SỬA Ở ĐÂY
                     "WHERE ps.playlistId = ?";

        try {
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, playlistId);
            ResultSet rs = pst.executeQuery();

            while (rs.next()) {
                PlaylistSongItem item = new PlaylistSongItem();

                // id trong bảng playlist_song
                item.setPlaylistSongId(rs.getInt("playlistSongId"));

                // map Song
                Song song = new Song();
                song.setSongId(rs.getInt("song_id"));   // 🔥 NHỚ LÀ song_id
                song.setTitle(rs.getString("title"));
                song.setYear(rs.getInt("year"));
                song.setThumbnail(rs.getString("thumbnail"));
                song.setDescription(rs.getString("description"));
                song.setLink(rs.getString("link"));

                item.setSong(song);

                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}