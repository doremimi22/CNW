package model.dao;

import java.sql.*;
import java.util.ArrayList;

import model.bean.Artist;
import model.bean.Song;
import model.bean.Album;
import config.DBConnect;

public class ArtistDAO {

    // Lấy tất cả nghệ sĩ
    public static ArrayList<Artist> getAll() {
        ArrayList<Artist> list = new ArrayList<>();
        String sql = "SELECT * FROM artists";

        try (Connection con = DBConnect.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                Artist a = new Artist();
                a.setArtistId(rs.getInt("artist_id"));
                a.setName(rs.getString("name"));
                a.setBiography(rs.getString("biography"));
                a.setBirthday(rs.getString("birthday"));
                a.setAvatar(rs.getString("avatar"));
                list.add(a);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    // Lấy 1 nghệ sĩ
    public Artist getById(int id) {
        Artist a = null;
        String sql = "SELECT * FROM artists WHERE artist_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                a = new Artist();
                a.setArtistId(rs.getInt("artist_id"));
                a.setName(rs.getString("name"));
                a.setBiography(rs.getString("biography"));
                a.setBirthday(rs.getString("birthday"));
                a.setAvatar(rs.getString("avatar"));
            }

        } catch (Exception e) { e.printStackTrace(); }

        return a;
    }

    // Tìm nghệ sĩ
    public ArrayList<Artist> searchArtists(String keyword) {
        ArrayList<Artist> list = new ArrayList<>();
        String sql = "SELECT * FROM artists WHERE name LIKE ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Artist a = new Artist();
                a.setArtistId(rs.getInt("artist_id"));
                a.setName(rs.getString("name"));
                a.setBiography(rs.getString("biography"));
                a.setBirthday(rs.getString("birthday"));
                a.setAvatar(rs.getString("avatar"));
                list.add(a);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    // Lấy bài hát của nghệ sĩ
    public ArrayList<Song> getSongsByArtist(int artistId) {
        ArrayList<Song> list = new ArrayList<>();

        String sql =
            "SELECT s.* FROM songs s " +
            "JOIN song_artists sa ON s.song_id = sa.song_id " +
            "WHERE sa.artist_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, artistId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Song s = new Song();
                s.setSongId(rs.getInt("song_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setYear(rs.getInt("year"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setLink(rs.getString("link"));
                list.add(s);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    // Lấy album có bài hát của nghệ sĩ
    public ArrayList<Album> getAlbumsByArtist(int artistId) {
        ArrayList<Album> list = new ArrayList<>();

        String sql =
            "SELECT DISTINCT a.* FROM albums a " +
            "JOIN album_songs als ON a.album_id = als.album_id " +
            "JOIN song_artists sa ON als.song_id = sa.song_id " +
            "WHERE sa.artist_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, artistId);
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

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    // Lấy nghệ sĩ của 1 bài hát
    public ArrayList<Artist> getArtistsBySong(int songId) {
        ArrayList<Artist> list = new ArrayList<>();

        String sql =
            "SELECT a.* FROM artists a " +
            "JOIN song_artists sa ON a.artist_id = sa.artist_id " +
            "WHERE sa.song_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, songId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Artist a = new Artist();
                a.setArtistId(rs.getInt("artist_id"));
                a.setName(rs.getString("name"));
                a.setBiography(rs.getString("biography"));
                a.setBirthday(rs.getString("birthday"));
                a.setAvatar(rs.getString("avatar"));
                list.add(a);
            }

        } catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    // Thêm nghệ sĩ
    public boolean insertArtist(Artist ar) {
        String sql =
            "INSERT INTO artists (name, biography, birthday, avatar, created_at) " +
            "VALUES (?, ?, ?, ?, NOW())";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, ar.getName());
            ps.setString(2, ar.getBiography());
            ps.setString(3, ar.getBirthday());
            ps.setString(4, ar.getAvatar());

            return ps.executeUpdate() > 0;

        } catch (Exception e) { e.printStackTrace(); }

        return false;
    }
    public boolean delete(int artistId) {
        try (Connection conn = DBConnect.getConnection()) {

            // Xoá liên kết bảng song_artist nếu có
            String sql1 = "DELETE FROM song_artists WHERE artist_id = ?";
            PreparedStatement ps1 = conn.prepareStatement(sql1);
            ps1.setInt(1, artistId);
            ps1.executeUpdate();
            ps1.close();

            // Xoá nghệ sĩ
            String sql2 = "DELETE FROM artists WHERE artist_id = ?";
            PreparedStatement ps2 = conn.prepareStatement(sql2);
            ps2.setInt(1, artistId);
            int rows = ps2.executeUpdate();
            ps2.close();

            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

}
