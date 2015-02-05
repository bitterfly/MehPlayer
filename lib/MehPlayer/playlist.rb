require 'MehPlayer/song'
require 'find'

module MehPlayer
  class Playlist
    
    attr_reader :songs
    
    def initialize(songs = [])
      @songs = songs
    end

    def add_song(audio_file)
      @songs << Song.new(audio_file)
    end

    def add_songs(audio_files)
      audio_files.each do |file|
        add_song(file)
      end
    end

    def clear
      @songs = []
    end

    def scan_folder(folder_name)
      Find.find(folder_name) do |file|
        add_song(file) if Song.audio_file? file
      end
    end

    def album(artist_name, album_name)
      songs = @songs.select do |song|
        song.artist == artist_name && song.album == album_name
      end
      [ album_name, songs ]
    end

    def list_contains_pair(list, pair)
      list.each{|element| return true if element.first == pair.first}
      return false
    end

    def artist(artist_name)
      songs = @songs.select { |song| song.artist == artist_name}
      albums = []
      songs.each do |song|
        unless list_contains_pair(albums, album(artist_name, song.album))
          albums << album(artist_name, song.album)
        end
      end
      albums.to_h
    end

    def print(albums)
      albums.each do |album, songs| 
        puts "******#{album}******\n"
        songs.each { |song| puts song }
      end
      return nil
    end
  end
end
