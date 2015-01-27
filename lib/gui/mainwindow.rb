require './ui_mainwindow.rb'
require 'song'
require 'playlist'
require 'player'

module MehPlayer
  module Gui  
    class MainWindow < Qt::MainWindow

      slots 'open_file()', 'play()', 'stop()', 'seek()'

      def initialize(parent = nil)
        super(parent)
        @ui = Ui_MainWindow.new
        @ui.setupUi(self)
        @player = Player.new do
          @ui.slider.maximum = @player.playlist[@player.current_song].length
          @ui.slider.value = @player.seek
        end
        load_icons
        @ui.play_button.icon = @play_icon
        @ui.stop_button.icon = @stop_icon
        @ui.info.hide

        connect(@ui.open_button, SIGNAL('clicked()'), self, SLOT('open_file()'))
        connect(@ui.play_button, SIGNAL('clicked()'), self, SLOT('play()'))
        connect(@ui.stop_button, SIGNAL('clicked()'), self, SLOT('stop()'))
        connect(@ui.slider, SIGNAL('sliderReleased()'), self, SLOT('seek()'))
      end

      def load_icons
        @play_icon = Qt::Icon.new("resources/play.png")
        @pause_icon = Qt::Icon.new("resources/pause.png")
        @stop_icon = Qt::Icon.new("resources/stop.png")
      end

      def open_file
        fileName = Qt::FileDialog.getOpenFileName(self)
          if !fileName.nil?
            @playlist = Playlist.new([Song.new(fileName)])
            @player.playlist = @playlist.songs
            @ui.info.hide
            play_mode
          end
      end

      def play_mode
        @ui.play_button.icon = @play_icon
      end

      def pause_mode
        @ui.play_button.icon = @pause_icon
      end

      def play
        if @player.playing? 
          if @player.paused?
            pause_mode
            @player.unpause
          else
            play_mode
            @player.pause
          end
        else
          @player.play(0)
          @ui.info.show
          @ui.artist.text = @player.playlist[@player.current_song].artist
          @ui.title.text = @player.playlist[@player.current_song].title
          @ui.album.text = @player.playlist[@player.current_song].album
          pause_mode
        end
      end

      def stop
        @player.stop
        @ui.info.hide
        play_mode
      end

      def seek
        @player.seek = @ui.slider.value
      end
    end
  end
end