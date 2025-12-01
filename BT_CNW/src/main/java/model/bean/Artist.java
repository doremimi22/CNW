package model.bean;

public class Artist {
    private int artistId;
    private String name;
    private String biography;
    private String birthday;
    private String avatar;
    private String createdAt;

    public Artist() {}

    public Artist(int artistId, String name, String biography,
                  String birthday, String avatar, String createdAt) {
        this.artistId = artistId;
        this.name = name;
        this.biography = biography;
        this.birthday = birthday;
        this.avatar = avatar;
        this.createdAt = createdAt;
    }

    // GETTERS + SETTERS
    public int getArtistId() { return artistId; }
    public void setArtistId(int artistId) { this.artistId = artistId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getBiography() { return biography; }
    public void setBiography(String biography) { this.biography = biography; }

    public String getBirthday() { return birthday; }
    public void setBirthday(String birthday) { this.birthday = birthday; }

    public String getAvatar() { return avatar; }
    public void setAvatar(String avatar) { this.avatar = avatar; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
