require 'rubygame'
require 'playlist'

module MehPlayer
  class Player
    attr_reader :playlist, :action, :seek
    attr_accessor :current_song, :shuffle, :repeat
    def initialize(playlist = Playlist.new, &block)
      @block = block
      @playlist = playlist.songs
      @shuffle = false
      @repeat = false
      @timer = Thread.new(block) do |block|
        loop do
          while action and (action.playing? or action.paused?)
            sleep(1)
            @seek += 1 unless paused?
            block.call if block
          end
          if playing?
            next_song
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

    def next_song
      unless shuffle
        if repeat
          @current_song = 0
        else
          @current_song += 1
        end
      else
        @current_song = rand(@playlist.size)
      end
    end

    def prev_song
      unless shuffle
        @current_song -= 1
      else
        @current_song = rand(@playlist.size)
      end
    end

    def playing?
      @playing
    end

    def paused?
      @action.paused?
    end

    def playlist=(playlist)
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

    def find_by_description(keywords)
      keywords.map do |keyword|
        @playlist.select { |song| song.description && (song.description.downcase.split.include? keyword.downcase) }
      end.inject :&
    end

    def find_by_info(keywords)
      keywords.map do |keyword|
        @playlist.select { |song| song.title and song.artist and (song.title.downcase.split + song.artist.downcase.split).include? keyword.downcase }
      end.inject :&
    end

    private

    def start
      if current_song < playlist.size
        @action = Rubygame::Music.load(playlist[current_song].filename)
        @seek = 0
        action.play
        @block.call
      end
    end

  end
end