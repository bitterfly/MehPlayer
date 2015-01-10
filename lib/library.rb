require 'song'

module MehPlayer
  class Library
    
    def initialize
      @songs = []
    end

    def add_song(audio_file)
      @songs << Song.new(audio_file)
    end

    def add_songs(audio_files)
      audio_files.each do |file|
        add_song(file)
      end
    end

    def scan_folder(folder_name)
      Find.find(folder_name) do |file|
        @songs << file if Song.audio_file? file
      end
    end
  end
end
