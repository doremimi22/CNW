package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import config.DBConnect;
import model.bean.Artist;
import model.bean.Song;

public class SongDAO {
 public ArrayList<Song> getAll(){
	 System.out.println(">>> SongDAO.getAll() CALLED");

	 ArrayList<Song> list = new ArrayList<>();
	 
	 String sql = "Select * from songs";
	 
	 try( Connection con = DBConnect.getConnection();
			 PreparedStatement ps = con.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery();
			 ){
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
	 } catch (Exception e) {
		 e.printStackTrace();
	 }
	 System.out.println("Rows = " + list.size());

	 return list;
 }
 public Song getSongById(int id) {
	    Song s = null;
	    String sql = "SELECT * FROM songs WHERE song_id = ?";

	    try (Connection con = DBConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

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
	        }

	    } catch (Exception e) { e.printStackTrace(); }

	    return s;
	}

 public ArrayList<Song> getSongsByAlbum(int albumId) {
	    ArrayList<Song> list = new ArrayList<>();

	    String sql = "SELECT s.* FROM songs s "
	               + "JOIN album_songs a ON s.song_id = a.song_id "
	               + "WHERE a.album_id = ?";

	    try (Connection con = DBConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

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

	            list.add(s);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
 public ArrayList<Song> getSongsByArtist(int artistId) {
	    ArrayList<Song> list = new ArrayList<>();

	    String sql = "SELECT s.* FROM songs s "
	               + "JOIN song_artists sa ON s.song_id = sa.song_id "
	               + "WHERE sa.artist_id = ?";

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
 public ArrayList<Song> searchSongs(String keyword) {
	    ArrayList<Song> list = new ArrayList<>();
	    String sql = "SELECT * FROM songs WHERE title LIKE ?";

	    try (Connection con = DBConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

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
	            list.add(s);
	        }

	    } catch (Exception e) { e.printStackTrace(); }
	    return list;
	}
 public Song getById(int id) {
	    Song s = null;
	    String sql = "SELECT * FROM songs WHERE song_id = ?";

	    try (Connection con = DBConnect.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

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
	        }

	    } catch (Exception e) { e.printStackTrace(); }

	    return s;
	}
 public ArrayList<Artist> getArtistsBySong(int songId) {
	    ArrayList<Artist> list = new ArrayList<>();

	    String sql = "SELECT a.* FROM artists a "
	               + "JOIN song_artists sa ON a.artist_id = sa.artist_id "
	               + "WHERE sa.song_id = ?";

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

}
