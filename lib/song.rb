require 'taglib'
require 'rubygame'

module MehPlayer
  class Song
    attr_reader :title, :artist, :album, :length, :filename, :track
    attr_accessor :description
    def initialize(filename)
      @filename = filename
      TagLib::FileRef.open(filename) do |fileref|
        unless fileref.null?
          tag = fileref.tag
          @title = tag.title
          @artist = tag.artist
          @album = tag.album
          @length = fileref.audio_properties.length
          @track = tag.track
        end
        @description = (@title || "") + ' ' + (@artist || "")
      end
    end

    def self.audio_file?(filename)
      accepted_formats = %w(.ogg .mp3 .flac .aac .ac3)
      return false unless File.file?(filename) 
      accepted_formats.include? File.extname(filename)
    end

    def to_s
      "#{artist} - #{title} (#{album})"
    end
  end
end
