package model.bean;

public class PlaylistSongItem {
    private int playlistSongId;  // id trong playlist_song
    private Song song;           // object Song đầy đủ thông tin

    public int getPlaylistSongId() { return playlistSongId; }
    public void setPlaylistSongId(int playlistSongId) { this.playlistSongId = playlistSongId; }

    public Song getSong() { return song; }
    public void setSong(Song song) { this.song = song; }
}

