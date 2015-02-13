require 'MehPlayer/song'
require 'find'
require 'yaml'

module MehPlayer
  class Playlist
    attr_reader :songs

    def initialize(songs = [])
      @songs = songs
    end

    def add_song(audio_file)
      @songs << Song.new(audio_file)
    end

    def clear
      @songs = []
    end

    def scan_folder(folder_name)
      return unless File.directory? folder_name
      Find.find(folder_name) do |file|
        add_song(file) if Song.audio_file? file
      end
    end

    def list_contains_pair(list, pair)
      list.each { |element| return true if element.first == pair.first }
      false
    end

    def find_by_description(keywords)
      keywords.map do |keyword|
        @songs.select do |song|
          song.description &&
            (song.description.downcase.split.include? keyword.downcase)
        end
      end.inject :&
    end

    def find_by_info(keywords)
      keywords.map do |keyword|
        @songs.select do |song|
          song.title &&
            song.artist && (
            (
                song.title.downcase.split + song.artist.downcase.split
            ).include? keyword.downcase)
        end
      end.inject :&
    end

    def save(filename)
      File.write(filename, @songs.to_yaml)
    end

    def open(filename)
      @songs = YAML.load(File.read(filename))
    end
  end
end
