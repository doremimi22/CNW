package model.bean;

import java.util.List;

public class Song {
    private int songId;
    private String title;
    private String description;
    private int year;
    private String thumbnail;
    private String link;

    private List<Artist> artists;  // nhiều ca sĩ

    public int getSongId() { return songId; }
    public void setSongId(int songId) { this.songId = songId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getThumbnail() { return thumbnail; }
    public void setThumbnail(String thumbnail) { this.thumbnail = thumbnail; }

    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }

    public List<Artist> getArtists() { return artists; }
    public void setArtists(List<Artist> artists) { this.artists = artists; }
}
