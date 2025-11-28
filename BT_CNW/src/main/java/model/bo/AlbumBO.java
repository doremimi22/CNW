package model.bo;

import java.util.ArrayList;
import model.bean.*;
import model.dao.AlbumDAO;
import model.dao.SongDAO;
import model.dao.*;

public class AlbumBO {
	private AlbumDAO albumDAO = new AlbumDAO();
    private SongDAO songDAO = new SongDAO();
    
    public ArrayList<Album> getAllAlbums() {
        return albumDAO.getAll();
    }
    public Album getAlbumById(int albumId) {
        return albumDAO.getAlbumById(albumId);
    }

    public ArrayList<Song> getSongsOfAlbum(int albumId) {
        return songDAO.getSongsByAlbum(albumId);
    }
}
