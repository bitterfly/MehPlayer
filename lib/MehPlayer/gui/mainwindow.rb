require 'MehPlayer/gui/ui_mainwindow.rb'
require 'MehPlayer/gui/listwindow'
require 'MehPlayer/song'
require 'MehPlayer/playlist'
require 'MehPlayer/player'
require 'yaml'

module MehPlayer
  module Gui
    class MainWindow < Qt::MainWindow
      slots 'open_file()', 'open_folder()', 'play()', 'stop()', 'seek()',
            'color()', 'volume()', 'mute()', 'next()', 'prev()', 'shuffle()',
            'show_list()', 'save_playlist()', 'open_playlist()', 'rate()',
            'repeat()', 'set_description()'

      def initialize(parent = nil)
        super(parent)
        @ui = Ui_MainWindow.new
        @ui.setupUi(self)
        @player = Player.new do
          if @ui.mute.checked?
            mute
            set_current_song_preferences
          else
            @ui.slider.maximum = @player.playlist[@player.current_song].length
            @ui.slider.value = @player.seek
            @ui.artist.text = @player.playlist[@player.current_song].artist
            @ui.title.text = @player.playlist[@player.current_song].title
            @ui.album.text = @player.playlist[@player.current_song].album
            @ui.rating.text = '-' +
                              @player.playlist[@player.current_song]
                              .rate.to_s + '★-'
            @ui.track.text = '(' +
                             @player.playlist[@player.current_song]
                             .track.to_s + ')'
            @ui.rate.value = @player.playlist[@player.current_song].rate
          end
        end
        set_style_sheets
        @list = ListWindow.new(@player, self)
        set_skin_colors
        color
        set_icons
        flatten_buttons
        connect_play_open
        connect_volume_progress
        connect_specials
      end

      def set_style_sheets
        @mute_stylesheet = @ui.mute.styleSheet
        @shuffle_stylesheet = @ui.shuffle.styleSheet
        @repeat_stylesheet = @ui.repeat.styleSheet
        @screen_stylesheet = @ui.horizontalFrame_2.styleSheet
      end

      def connect_volume_progress
        connect(@ui.volume, SIGNAL('sliderReleased()'), self, SLOT('volume()'))
        connect(@ui.mute, SIGNAL('stateChanged(int)'), self, SLOT('mute()'))
        connect(@ui.slider, SIGNAL('sliderReleased()'), self, SLOT('seek()'))
      end

      def connect_play_open
        connect(@ui.play_button, SIGNAL('clicked()'), self, SLOT('play()'))
        connect(@ui.stop_button, SIGNAL('clicked()'), self, SLOT('stop()'))
        connect(@ui.next, SIGNAL('clicked()'), self, SLOT('next()'))
        connect(
          @ui.prev, SIGNAL('clicked()'), self, SLOT('prev()')
        )
        connect(
          @ui.open_folder, SIGNAL('clicked()'), self, SLOT('open_folder()')
        )
        connect(@ui.open_file, SIGNAL('clicked()'), self, SLOT('open_file()'))
        connect(
          @ui.open_playlist, SIGNAL('clicked()'), self, SLOT('open_playlist()')
        )
        connect(
          @ui.save_playlist, SIGNAL('clicked()'), self, SLOT('save_playlist()')
        )
      end

      def connect_specials
        connect(@ui.rate, SIGNAL('valueChanged(int)'), SLOT('rate()'))
        connect(@ui.color, SIGNAL('clicked()'), self, SLOT('color()'))
        connect(
          @ui.shuffle, SIGNAL('stateChanged(int)'), self, SLOT('shuffle()')
        )
        connect(@ui.repeat, SIGNAL('clicked()'), self, SLOT('repeat()'))
        connect(
          @ui.set_description,
          SIGNAL('clicked()'), self, SLOT('set_description()')
        )
        connect(@ui.show_list, SIGNAL('clicked()'), self, SLOT('show_list()'))
      end

      def flatten_buttons
        @ui.show_list.flat = true
        @ui.open_file.flat = true
        @ui.open_folder.flat = true
        @ui.play_button.flat = true
        @ui.stop_button.flat = true
        @ui.next.flat = true
        @ui.prev.flat = true
        @ui.save_playlist.flat = true
        @ui.open_playlist.flat = true
        @ui.set_description.flat = true
      end

      def set_skin_colors
        @colors = [['sky', '139, 188, 175'],
                   ['main', '88, 127, 122'],
                   ['mellon', '255, 146, 149']]
        @skin = 0
      end

      def color
        @skin = (@skin < @colors.size - 1) ? @skin + 1 : 0
        @ui.color.styleSheet = format(
          'background:rgb(%s)',
          @colors[(@skin < @colors.size - 1) ? (@skin + 1) : 0][1]
        )
        @ui.widget.styleSheet = format('background:rgb(%s)', @colors[@skin][1])
        @ui.horizontalFrame.styleSheet = format(
          'background:rgb(%s)', @colors[@skin][1]
        )
        load_icons(@colors[@skin][0])
        @list.color(@skin)
        bright_screen if @player.playing?
      end

      def load_icons(folder)
        @file_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/file.png'
        )
        @folder_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/folder.png'
        )
        @play_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/play.png'
        )
        @pause_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/pause.png'
        )
        @stop_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/stop.png'
        )
        @next_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/next.png'
        )
        @prev_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/prev.png'
        )
        @list_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/playlist.png'
        )
        @save_playlist_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/save_playlist.png'
        )
        @open_playlist_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/open_playlist.png'
        )
        @description_icon = Qt::Icon.new(
          File.dirname(__FILE__) + '/resources/' + folder + '/description.png'
        )
        @ui.horizontalFrame_2.styleSheet = format(
          @screen_stylesheet,
          folder: File.dirname(__FILE__), subfolder: folder
        )
        @ui.mute.styleSheet = format(
          @mute_stylesheet,
          folder: File.dirname(__FILE__), subfolder: folder
        )
        @ui.shuffle.styleSheet = format(
          @shuffle_stylesheet,
          folder: File.dirname(__FILE__), subfolder: folder
        )
        @ui.repeat.styleSheet = format(
          @repeat_stylesheet,
          folder: File.dirname(__FILE__), subfolder: folder
        )
        @list.load_icons(folder)
        set_icons
      end

      def set_icons
        @ui.play_button.icon = @play_icon
        @ui.stop_button.icon = @stop_icon
        @ui.open_file.icon = @file_icon
        @ui.open_folder.icon = @folder_icon
        @ui.next.icon = @next_icon
        @ui.prev.icon = @prev_icon
        @ui.open_playlist.icon = @open_playlist_icon
        @ui.save_playlist.icon = @save_playlist_icon
        @ui.show_list.icon = @list_icon
        @ui.set_description.icon = @description_icon
        @ui.info.hide
      end

      def open_file
        file_name = Qt::FileDialog.getOpenFileName(self)
        return if file_name.nil? || !Song.audio_file?(file_name)
        stop if @player.playing?
        @playlist = Playlist.new([Song.new(fileame)])
        @player.playlist = @playlist.songs
        @list.songs = @player.playlist
        @ui.info.hide
        play_mode
      end

      def open_folder
        folder_name = Qt::FileDialog.getExistingDirectory(self)
        return if folder_name.nil?
        stop if @player.playing?
        @playlist = Playlist.new
        @playlist.scan_folder(folder_name)
        @player.playlist = @playlist.songs
        @list.songs = @player.playlist
        @ui.info.hide
        play_mode
      end

      def play_mode
        @ui.play_button.icon = @play_icon
      end

      def pause_mode
        @ui.play_button.icon = @pause_icon
      end

      def bright_screen
        @ui.horizontalFrame_2.styleSheet = 'background: rgb(255, 250, 255)'
        @ui.info.show
        pause_mode
      end

      def dead_screen
        @ui.horizontalFrame_2.styleSheet = format(
          @screen_stylesheet,
          folder: File.dirname(__FILE__), subfolder: @colors[@skin][0]
        )
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
          unless @player.playlist.empty?
            bright_screen
            @player.play(0)
          end
        end
        mute
      end

      def stop
        dead_screen
        @player.stop
        @ui.info.hide
        play_mode
      end

      def seek
        @player.seek = @ui.slider.value unless @player.playlist.empty?
      end

      def volume
        if @player.playing?
          @ui.volume.enabled = true
          @player.action.volume = @ui.volume.value.to_f / 100
        else
          @ui.volume.enabled = false
        end
      end

      def mute
        return unless @player.playing?
        if @ui.mute.checked?
          @player.action.volume = 0
          @ui.volume.enabled = false
        else
          @player.action.volume = @ui.volume.value.to_f / 100
          @ui.volume.enabled = true
        end
      end

      def next
        if @player.playlist.empty?
          stop
        else
          @player.next_song
          if @player.current_song <= @player.playlist.size
            @player.play(@player.current_song)
            mute
          else
            if @player.repeat
              @player.play(0)
            else
              @player.play(@player.playlist.size - 1)
            end
          end
        end
      end

      def prev
        return if @player.playlist.empty?
        @player.prev_song
        if @player.current_song >= 0
          @player.play(@player.current_song)
          mute
        else
          @player.play(0)
        end
      end

      def shuffle
        @player.shuffle = (!@player.shuffle)
      end

      def repeat
        @player.repeat = (!@player.repeat)
      end

      def show_list
        @list.show
      end

      def save_playlist
        return unless @player.playlist
        file_name = Qt::FileDialog.getSaveFileName(self)
        File.write(file_name, @player.playlist.to_yaml)
      end

      def open_playlist
        file_name = Qt::FileDialog.getOpenFileName(self)
        return if file_name.nil?
        stop if @player.playing?
        dead_screen
        @player.playlist = YAML.load(File.read(file_name))
        @list.songs = @player.playlist
      end

      def set_description
        return if @player.playlist.empty?
        description = Qt::InputDialog.getText(
          self, @player.playlist[@player.current_song].title,
          'Enter description', Qt::LineEdit::Normal,
          @player.playlist[@player.current_song].description)
        @player.playlist[@player.current_song].description = description
      end

      def rate
        if @player.playing?
          @ui.rate.enabled = true
          @player.playlist[@player.current_song].rate = @ui.rate.value
        else
          @ui.rate.enabled = false
        end
      end
    end
  end
end
