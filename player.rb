module MehPlayer
  class Player
    attr_reader :playlist
    def initialize(songs)
      @playlist = songs
    end

    def play(song)
      music_action = Rubygame::Music.load(song.filename)
      timer = Thread.new do
      unless music_action.playing?
        sleep(1)
      end  
    end

  end
end