require 'taglib'
require 'rubygame'

module MehPlayer
  class Song
    attr_reader :title, :artist, :album, :length, :filename
    def initialize(filename)
      @filename = filename
      TagLib::FileRef.open(filename) do |fileref|
        unless fileref.null?
          tag = fileref.tag
          @title = tag.title
          @artist = tag.artist
          @album = tag.album
          @length = fileref.audio_properties.length
        end
      end
    end

    def self.audio_file?(filename)
      accepted_extensions = %w(ogg mp3 flac aac ac3)
      return false unless File.file?(filename) 
      accepted_formats.include? File.extname(filename)
    end
  end
end
