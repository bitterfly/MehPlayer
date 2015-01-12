require 'rubygame'

module MehPlayer
  class Player
    attr_reader :playlist, :action
    def initialize(songs)
      @playlist = songs
    end

    def play(index)
      @action = Rubygame::Music.load(playlist[index].filename)
      action.play
      timer = Thread.new do
        while action.playing?
          sleep(1)
        end
        play(index + 1)
      end  
    end



  end
end