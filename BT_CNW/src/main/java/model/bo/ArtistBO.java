package model.bo;

import java.util.ArrayList;
import model.dao.ArtistDAO;
import model.bean.Artist;

public class ArtistBO {

    private ArtistDAO dao = new ArtistDAO();

    public ArrayList<Artist> getAllArtists() {
        return dao.getAll();
    }
    public ArrayList<Artist> searchArtists(String keyword) {
        return dao.searchArtists(keyword);
    }

}
