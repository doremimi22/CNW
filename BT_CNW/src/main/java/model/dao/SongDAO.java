package model.dao;

import java.sql.*;
import java.util.ArrayList;

import config.DBConnect;
import model.bean.Artist;
import model.bean.Song;

public class SongDAO {

    /* ============================
        LẤY TẤT CẢ BÀI HÁT
       ============================ */
    public ArrayList<Song> getAll() {

        ArrayList<Song> list = new ArrayList<>();
        String sql = "SELECT * FROM songs ORDER BY song_id DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) 
        {
            while (rs.next()) {

                Song s = new Song();
                s.setSongId(rs.getInt("song_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setYear(rs.getInt("year"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setLink(rs.getString("link"));

                // 🔥 LẤY DANH SÁCH NGHỆ SĨ
                s.setArtists(getArtistsBySong(s.getSongId()));

                list.add(s);
            }
        } 
        catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    /* ============================
        LẤY BÀI HÁT THEO ID
       ============================ */
    public Song getSongById(int id) {

        Song s = null;
        String sql = "SELECT * FROM songs WHERE song_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                s = new Song();
                s.setSongId(rs.getInt("song_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setYear(rs.getInt("year"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setLink(rs.getString("link"));

                // 🔥 LẤY NGHỆ SĨ
                s.setArtists(getArtistsBySong(id));
            }
        } 
        catch (Exception e) { e.printStackTrace(); }

        return s;
    }
 // thêm vào SongDAO, ngay dưới getSongById chẳng hạn
    public Song getById(int id) {
        // tái sử dụng hàm đã có
        return getSongById(id);
    }
    public boolean delete(int songId) {
        String sql = "DELETE FROM songs WHERE song_id = ?";
        try {
        	Connection con = DBConnect.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, songId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /* ============================
        LẤY BÀI HÁT TRONG ALBUM
       ============================ */
    public ArrayList<Song> getSongsByAlbum(int albumId) {

        ArrayList<Song> list = new ArrayList<>();

        String sql = 
            "SELECT s.* FROM songs s " +
            "JOIN album_songs a ON s.song_id = a.song_id " +  // 👍 đúng bảng
            "WHERE a.album_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
            ps.setInt(1, albumId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Song s = new Song();
                s.setSongId(rs.getInt("song_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setYear(rs.getInt("year"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setLink(rs.getString("link"));

                // 🔥 LẤY NGHỆ SĨ
                s.setArtists(getArtistsBySong(s.getSongId()));

                list.add(s);
            }

        } 
        catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    /* ============================
        LẤY BÀI HÁT THEO NGHỆ SĨ
       ============================ */
    public ArrayList<Song> getSongsByArtist(int artistId) {

        ArrayList<Song> list = new ArrayList<>();

        String sql = 
            "SELECT s.* FROM songs s " +
            "JOIN song_artists sa ON s.song_id = sa.song_id " +
            "WHERE sa.artist_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
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

                // Không cần lấy artist ở đây (vì đang lấy theo artist)
                list.add(s);
            }
        } 
        catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    /* ============================
        SEARCH SONGS
       ============================ */
    public ArrayList<Song> searchSongs(String keyword) {

        ArrayList<Song> list = new ArrayList<>();
        String sql = "SELECT * FROM songs WHERE title LIKE ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Song s = new Song();
                s.setSongId(rs.getInt("song_id"));
                s.setTitle(rs.getString("title"));
                s.setDescription(rs.getString("description"));
                s.setYear(rs.getInt("year"));
                s.setThumbnail(rs.getString("thumbnail"));
                s.setLink(rs.getString("link"));

                s.setArtists(getArtistsBySong(s.getSongId()));

                list.add(s);
            }

        } 
        catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    /* ============================
        LẤY NGHỆ SĨ CỦA MỘT BÀI HÁT
       ============================ */
    public ArrayList<Artist> getArtistsBySong(int songId) {

        ArrayList<Artist> list = new ArrayList<>();

        String sql = 
            "SELECT a.* FROM artists a " +
            "JOIN song_artists sa ON a.artist_id = sa.artist_id " +
            "WHERE sa.song_id = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
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

        } 
        catch (Exception e) { e.printStackTrace(); }

        return list;
    }

    /* ============================
        THÊM BÀI HÁT
       ============================ */
    public boolean insert(Song s) {

        String sql =
            "INSERT INTO songs (title, year, thumbnail, description) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
            ps.setString(1, s.getTitle());
            ps.setInt(2, s.getYear());
            ps.setString(3, s.getThumbnail());
            ps.setString(4, s.getDescription());

            return ps.executeUpdate() > 0;
        } 
        catch (Exception e) { e.printStackTrace(); }

        return false;
    }

    /* ============================
        THÊM BÀI HÁT + TRẢ ID
       ============================ */
    public int insertAndReturnId(Song s) {

        String sql = 
            "INSERT INTO songs (title, year, thumbnail, description, link) "
           +"VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) 
        {
            ps.setString(1, s.getTitle());
            ps.setInt(2, s.getYear());
            ps.setString(3, s.getThumbnail());
            ps.setString(4, s.getDescription());
            ps.setString(5, s.getLink());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) return rs.getInt(1);
        } 
        catch (Exception e) { e.printStackTrace(); }

        return -1;
    }

    /* ============================
        SONG - ARTIST LINK
       ============================ */
    public boolean insertSongArtist(int songId, int artistId) {
        String sql =
            "INSERT INTO song_artists (song_id, artist_id) VALUES (?, ?)";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) 
        {
            ps.setInt(1, songId);
            ps.setInt(2, artistId);

            return ps.executeUpdate() > 0;
        } 
        catch (Exception e) { e.printStackTrace(); }

        return false;
    }
}
