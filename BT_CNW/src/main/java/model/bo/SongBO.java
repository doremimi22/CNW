package model.bo;

import java.util.ArrayList;
import model.dao.SongDAO;
import model.bean.Song;

public class SongBO {
    private SongDAO dao = new SongDAO();

    public ArrayList<Song> getAllSongs() {
        return dao.getAll();
    }
    public ArrayList<Song> getSongsByArtist(int artistId) {
        return dao.getSongsByArtist(artistId);
    }
    public ArrayList<Song> searchSongs(String keyword) {
        return dao.searchSongs(keyword);
    }

}
