require './ui_mainwindow.rb'
require 'gui/listwindow'
require 'song'
require 'playlist'
require 'player'
require 'yaml'

module MehPlayer
  module Gui  
    class MainWindow < Qt::MainWindow

      slots 'open_file()', 'open_folder()', 'play()', 'stop()', 'seek()',
            'volume()', 'mute()', 'next()', 'prev()', 'shuffle()', 'show_list()',
            'save_playlist()', 'open_playlist()'

      def initialize(parent = nil)
        super(parent)
        @ui = Ui_MainWindow.new
        @ui.setupUi(self)
        @player = Player.new do
          unless @ui.mute.checked?
            @player.action.volume = @ui.volume.value.to_f/100
          else
            mute
          end
          @ui.slider.maximum = @player.playlist[@player.current_song].length
          @ui.slider.value = @player.seek
          @ui.artist.text = @player.playlist[@player.current_song].artist
          @ui.title.text = @player.playlist[@player.current_song].title
          @ui.album.text = @player.playlist[@player.current_song].album
          @ui.track.text = '(' + @player.playlist[@player.current_song].track.to_s + ')'
        end
        @list = ListWindow.new(@player, self)
        load_icons
        @ui.play_button.icon = @play_icon
        @ui.stop_button.icon = @stop_icon
        @ui.open_file.icon = @file_icon
        @ui.open_folder.icon = @folder_icon
        @ui.next.icon = @next_icon
        @ui.prev.icon = @prev_icon
        @ui.info.hide

        connect(@ui.show_list, SIGNAL('clicked()'), self, SLOT('show_list()'))
        connect(@ui.open_file, SIGNAL('clicked()'), self, SLOT('open_file()'))
        connect(@ui.open_folder, SIGNAL('clicked()'), self, SLOT('open_folder()'))
        connect(@ui.play_button, SIGNAL('clicked()'), self, SLOT('play()'))
        connect(@ui.stop_button, SIGNAL('clicked()'), self, SLOT('stop()'))
        connect(@ui.slider, SIGNAL('sliderReleased()'), self, SLOT('seek()'))
        connect(@ui.volume, SIGNAL('sliderReleased()'), self, SLOT('volume()'))
        connect(@ui.mute, SIGNAL('stateChanged(int)'), self, SLOT('mute()'))
        connect(@ui.next, SIGNAL('clicked()'), self, SLOT('next()'))
        connect(@ui.prev, SIGNAL('clicked()'), self, SLOT('prev()'))
        connect(@ui.shuffle, SIGNAL('stateChanged(int)'), self, SLOT('shuffle()'))
        connect(@ui.save_playlist, SIGNAL('clicked()'), self, SLOT('save_playlist()'))
        connect(@ui.open_playlist, SIGNAL('clicked()'), self, SLOT('open_playlist()'))
      end

      def load_icons
        @file_icon = Qt::Icon.new("resources/file.png")
        @folder_icon = Qt::Icon.new("resources/folder.png")
        @play_icon = Qt::Icon.new("resources/play.png")
        @pause_icon = Qt::Icon.new("resources/pause.png")
        @stop_icon = Qt::Icon.new("resources/stop.png")
        @next_icon = Qt::Icon.new("resources/next.png")
        @prev_icon = Qt::Icon.new("resources/prev.png")
      end

      def open_file
        fileName = Qt::FileDialog.getOpenFileName(self)
          if !fileName.nil? and Song.audio_file?(fileName)
            stop if @player.playing?
            @playlist = Playlist.new([Song.new(fileName)])
            @player.playlist = @playlist.songs
            @list.songs = @player.playlist
            @ui.info.hide
            play_mode
          end
      end

      def open_folder
        folderName = Qt::FileDialog.getExistingDirectory(self)
          if !folderName.nil?
            stop if @player.playing?
            @playlist = Playlist.new
            @playlist.scan_folder(folderName)
            @player.playlist = @playlist.songs
            @list.songs = @player.playlist
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

      def bright_screen
        @ui.horizontalFrame_2.styleSheet = "background: rgb(255, 250, 255)"
      end

      def dead_screen
        @ui.horizontalFrame_2.styleSheet = "background:rgb(80, 120, 114)"
      end

      def play
        if @ui.mute.checked?
          mute
        end
        if @player.playing? 
          if @player.paused?
            pause_mode
            @player.unpause
          else
            play_mode
            @player.pause
          end
        else
          unless @player.playlist.empty?
            bright_screen
            @player.play(0)
            @ui.info.show
            pause_mode
          end
        end
      end

      def stop
        unless @player.playlist.empty?
         dead_screen
         @player.stop
         @ui.info.hide
         play_mode
        end
      end

      def seek
        @player.seek = @ui.slider.value unless @player.playlist.empty?
      end

      def volume
        unless @player.playlist.empty? 
          @player.action.volume = @ui.volume.value.to_f/100
        end
      end

      def mute
        if @player.playing? 
          if @ui.mute.checked?
            @player.action.volume = 0
            @ui.volume.enabled = false
          else
            @player.action.volume = @ui.volume.value.to_f/100
            @ui.volume.enabled = true
          end
        end
      end

      def next
        unless @player.playlist.empty?
          @player.next_song
          if @player.current_song <= @player.playlist.size
            @player.play(@player.current_song)
            mute if @ui.mute.checked?
          else
            stop
          end
        end  
      end
      
      def prev
        unless @player.playlist.empty?
          if @player.current_song >= 1
            @player.current_song -= 1
            @player.play(@player.current_song)
            if @ui.mute.checked?
              mute
            end
          else
            @player.play(0)
          end
        end
      end

      def shuffle
        @player.shuffle = (not @player.shuffle)
      end

      def show_list
        @list.show
      end

      def save_playlist
        if @player.playlist
          fileName = Qt::FileDialog.getSaveFileName(self)
          File.write(fileName, @player.playlist.to_yaml)
        end
      end

      def open_playlist
        fileName = Qt::FileDialog.getOpenFileName(self)
          if !fileName.nil?
            stop if @player.playing?
            dead_screen
            @player.playlist = YAML.load(File.read(fileName))
            @list.songs = @player.playlist
          end
      end
    end
  end
end