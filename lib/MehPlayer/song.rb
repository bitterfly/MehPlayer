require 'taglib'
require 'rubygame'

module MehPlayer
  class Song
    attr_reader :title, :artist, :album, :length, :filename, :track
    attr_accessor :description, :rate
    def initialize(filename)
      @filename = filename
      TagLib::FileRef.open(filename) do |fileref|
        unless fileref.null?
          tag = fileref.tag
          @title = tag.title
          @title = ' ' if tag.title.nil?
          @artist = tag.artist
          @artist = ' ' if tag.artist.nil?
          @album = tag.album
          @length = fileref.audio_properties.length
          @track = tag.track
          @rate = 1
          @description = ''
        end
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

    def ==(other)
      self.instance_variables.each do |variable|
        if self.instance_variable_get(variable) != other.instance_variable_get(variable)
          return false
        end
      end
      true
    end
  end
end
