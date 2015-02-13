require 'rubygame'
require 'MehPlayer/playlist'

module MehPlayer
  class Player
    attr_reader :action, :seek
    attr_accessor :playlist, :current_song, :shuffle, :repeat
    def initialize(playlist = Playlist.new, &block)
      @block = block
      @playlist = playlist
      @shuffle = false
      @repeat = false
      @timer = Thread.new(block) do |thread_block|
        loop do
          timer_while thread_block
          if playing?
            next_song
            start
          end
          sleep(1)
        end
      end
    end

    def timer_while(block)
      while action && (action.playing? || action.paused?)
        sleep(1)
        @seek += 1 unless paused?
        block.call if block
      end
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

    def next_song
      if shuffle
        @current_song = rand(@playlist.songs.size)
      else
        if repeat
          @current_song = 0
        else
          @current_song += 1
        end
      end
    end

    def prev_song
      if shuffle
        @current_song = rand(@playlist.songs.size)
      else
        @current_song -= 1
      end
    end

    def playing?
      @playing
    end

    def paused?
      @action.paused?
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
      return if current_song >= playlist.songs.size
      @action = Rubygame::Music.load(playlist.songs[current_song].filename)
      @seek = 0
      action.play
      @block.call if @block
    end
  end
end
