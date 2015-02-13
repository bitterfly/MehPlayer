require 'rubygame'
require 'MehPlayer/playlist'

module MehPlayer
  class Player
    attr_reader :action, :seek
    attr_accessor :playlist, :current_song, :shuffle, :repeat
    def initialize(playlist = Playlist.new, &block)
      @block = block
      @playlist = playlist.songs
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

    def next_song
      if shuffle
        @current_song = rand(@playlist.size)
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
        @current_song = rand(@playlist.size)
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

    def find_by_description(keywords)
      keywords.map do |keyword|
        @playlist.select do |song|
          song.description &&
            (song.description.downcase.split.include? keyword.downcase)
        end
      end.inject :&
    end

    def find_by_info(keywords)
      keywords.map do |keyword|
        @playlist.select do |song|
          song.title &&
            song.artist && (
            (
                song.title.downcase.split + song.artist.downcase.split
            ).include? keyword.downcase)
        end
      end.inject :&
    end

    private

    def start
      return unless current_song < playlist.size

      @action = Rubygame::Music.load(playlist[current_song].filename)
      @seek = 0
      action.play
      @block.call if @block
    end
  end
end
