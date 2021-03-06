require 'MehPlayer/gui/ui_listwindow.rb'
require 'MehPlayer/song'
require 'MehPlayer/playlist'
require 'MehPlayer/player'
require 'Qt'

module MehPlayer
  module Gui
    class ListWindow < Qt::MainWindow
      slots 'choose_song()', 'search()', 'enqueue_file()', 'enqueue_folder()',
            'remove()', 'delete_all()', 'sort_by_author()', 'sort_by_title()',
            'sort_by_rating()'

      def initialize(player, parent = nil)
        super(parent)
        @player = player
        @ui = Ui_ListWindow.new
        @ui.setupUi(self)
        @song_list_stylesheet = @ui.song_list.styleSheet
        connect_general_buttons
        connect_open_buttons
        connect_delete_buttons
        connect_sort_buttons
      end

      def connect_general_buttons
        connect(
          @ui.song_list,
          SIGNAL('itemDoubleClicked(QListWidgetItem* )'),
          self, SLOT('choose_song()')
        )
        connect(
          @ui.search,
          SIGNAL('textChanged(const QString &)'),
          self, SLOT('search()')
        )
      end

      def connect_open_buttons
        connect(
          @ui.enqueue_file,
          SIGNAL('clicked()'),
          self, SLOT('enqueue_file()')
        )
        connect(
          @ui.enqueue_folder,
          SIGNAL('clicked()'),
          self, SLOT('enqueue_folder()')
        )
      end

      def connect_delete_buttons
        connect(
          @ui.remove,
          SIGNAL('clicked()'),
          self, SLOT('remove()')
        )
        connect(
          @ui.delete_all,
          SIGNAL('clicked()'),
          self, SLOT('delete_all()')
        )
      end

      def connect_sort_buttons
        connect(
          @ui.sort_by_author,
          SIGNAL('clicked()'), self,
          SLOT('sort_by_author()')
        )
        connect(
          @ui.sort_by_title,
          SIGNAL('clicked()'), self,
          SLOT('sort_by_title()')
        )
        connect(
          @ui.sort_by_rating,
          SIGNAL('clicked()'), self,
          SLOT('sort_by_rating()')
        )
      end

      def color(index)
        colors = ['157, 167, 181',
                  '163, 190, 135',
                  '170, 209, 102']
        @ui.centralwidget.styleSheet = format(
          'background:rgb(%s)', colors[index]
        )
      end

      def load_icons(folder)
        @ui.song_list.styleSheet = format(
          @song_list_stylesheet,
          folder: File.dirname(__FILE__), subfolder: folder
        )
      end

      def songs=(playlist)
        @ui.song_list.clear
        playlist.each_with_index do |song, _index|
          Qt::ListWidgetItem.new(song.to_s, @ui.song_list)
            .setData(Qt::UserRole, Qt::Variant
            .new(@player.playlist.songs.index(song)))
        end
      end

      def remove
        selected_song = @ui.song_list.takeItem(@ui.song_list.currentRow)
                        .data(Qt::UserRole)
                        .to_i
        return if selected_song.nil?
        @player.playlist.songs.delete_at(selected_song)
        self.songs = @player.playlist.songs
        if @player.playlist.songs.empty?
          parent.stop
        else
          if @player.current_song == selected_song
            @player.play(@player.current_song)
          end
        end
      end

      def delete_all
        parent.stop
        @ui.song_list.clear
        @player.playlist.clear
      end

      def choose_song
        parent.bright_screen
        @player.play(@ui.song_list.currentItem.data(Qt::UserRole).to_i)
      end

      def search
        keywords = @ui.search.text.split
        self.songs = (
          (@player.playlist.find_by_description(keywords) |
          @player.playlist.find_by_info(keywords)) ||
          @player.playlist.songs
        )
      end

      def enqueue_file
        file_name = Qt::FileDialog.getOpenFileName(self)
        return unless !file_name.nil? && Song.audio_file?(file_name)
        @player.playlist.add_song(file_name)
        self.songs = @player.playlist.songs
      end

      def enqueue_folder
        folder_name = Qt::FileDialog.getExistingDirectory(self)
        return if folder_name.nil?
        @player.playlist.scan_folder(folder_name)
        self.songs = @player.playlist.songs
      end

      def sort_by_title
        self.songs = @player.playlist.songs.sort! do |x, y|
          if (x.title == y.title)
            (x.artist <=> y.artist)
          else
            (x.title <=> y.title)
          end
        end
      end

      def sort_by_author
        self.songs = @player.playlist.songs.sort! do |x, y|
          if (x.artist == y.artist)
            (x.title <=> y.title)
          else
            (x.artist <=> y.artist)
          end
        end
      end

      def sort_by_rating
        self.songs = @player.playlist.songs.sort! do |x, y|
          y.rate <=> x.rate
        end
      end
    end
  end
end
