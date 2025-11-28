package model.bean;

public class Album {
 private int albumId;
 private String title;
 private int releaseYear;
 private String cover;
 private String description;
 
 public int getAlbumId( ) {
	 return this.albumId;
 }
 public void setAlbumId(int albumId) { this.albumId = albumId; }

 public String getTitle() { return title; }
 public void setTitle(String title) { this.title = title; }

 public int getReleaseYear() { return releaseYear; }
 public void setReleaseYear(int releaseYear) { this.releaseYear = releaseYear; }

 public String getCover() { return cover; }
 public void setCover(String cover) { this.cover = cover; }

 public String getDescription() { return description; }
 public void setDescription(String description) { this.description = description; }
}
