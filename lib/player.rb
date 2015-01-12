require 'rubygame'

module MehPlayer
  class Player
    attr_reader :playlist, :action, :current_song
    def initialize(songs)
      @playlist = songs
      @timer = Thread.new do
        loop do
          while action and action.playing?
            sleep(1)
          end
          puts "puts1"
          if playing?
            @current_song += 1
            start
          end
          sleep(1)
        end
      end
    end

    def join_timer
      @timer.join
    end

    def seek=(ratio)
      action.jump_to(ratio * playlist[current_song].length)
    end

    def stop
      @playing = false
      action.stop if action
    end

    def playing?
      @playing
    end

    def playlist=(playlist)
      stop
      @playlist = playlist
    end

    def play(index)
      @current_song = index
      start
      @playing = true  
    end

    private

    def start
      unless current_song >= playlist.size
        @action = Rubygame::Music.load(playlist[current_song].filename)
        action.play
      end
    end

  end
end