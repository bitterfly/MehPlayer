require "taglib"
require "rubygame"

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
  end
end