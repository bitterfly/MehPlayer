require 'rubygame'
require 'playlist'

module MehPlayer
  class Player
    attr_reader :playlist, :action, :seek
    attr_accessor :current_song
    def initialize(playlist = Playlist.new, &block)

      @playlist = playlist.songs
      @timer = Thread.new(block) do |block|
        loop do
          while action and (action.playing? or action.paused?)
            sleep(1)
            @seek += 1 unless paused?
            block.call if block
          end
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

    def seek=(progress)
      action.jump_to(progress)
      @seek = progress
    end

    def stop
      @playing = false
      @seek = 0
      action.stop if action
    end

    def playing?
      @playing
    end

    def paused?
      @action.paused?
    end

    def playlist=(playlist)
      stop
      @playlist = playlist
    end

    def pause
      @action.pause
    end

    def unpause
      @action.unpause
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
        @seek = 0
        action.play
      end
    end

  end
end