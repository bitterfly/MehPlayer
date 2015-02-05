require 'MehPlayer/gui/ui_listwindow.rb'
require 'MehPlayer/song'
require 'MehPlayer/playlist'
require 'MehPlayer/player'
require 'Qt'

module MehPlayer
  module Gui  
    class ListWindow < Qt::MainWindow
      slots 'choose_song()', 'search()', 'enqueue_file()', 'enqueue_folder()', 'remove()', 'delete_all()',
            'sort_by_author()', 'sort_by_title()', 'sort_by_rating()'

      def initialize(player, parent = nil)
        super(parent)
        @player = player
        @ui = Ui_ListWindow.new
        @ui.setupUi(self)
        @song_list_stylesheet = @ui.song_list.styleSheet
        connect(@ui.song_list, SIGNAL('itemDoubleClicked(QListWidgetItem* )'), self, SLOT('choose_song()'))
        connect(@ui.search, SIGNAL('textChanged(const QString &)'), self, SLOT('search()'))
        connect(@ui.enqueue_file, SIGNAL('clicked()'), self, SLOT('enqueue_file()'))
        connect(@ui.enqueue_folder, SIGNAL('clicked()'), self, SLOT('enqueue_folder()'))
        connect(@ui.remove, SIGNAL('clicked()'), self, SLOT('remove()'))
        connect(@ui.delete_all, SIGNAL('clicked()'), self, SLOT('delete_all()'))
        connect(@ui.sort_by_author, SIGNAL('clicked()'), self, SLOT('sort_by_author()'))
        connect(@ui.sort_by_title, SIGNAL('clicked()'), self, SLOT('sort_by_title()'))
        connect(@ui.sort_by_rating, SIGNAL('clicked()'), self, SLOT('sort_by_rating()'))
      end

      def color(index)
        colors = ["157, 167, 181",
                  "163, 190, 135",
                  "170, 209, 102"] 
        @ui.centralwidget.styleSheet = "background:rgb(%s)" % colors[index]
      end

      def load_icons(folder)
        @ui.song_list.styleSheet = @song_list_stylesheet % {folder: File.dirname(__FILE__), subfolder: folder}
      end

      def songs=(playlist)
        @ui.song_list.clear
        playlist.each_with_index do |song, index|
          Qt::ListWidgetItem.new(song.to_s, @ui.song_list).setData(Qt::UserRole, Qt::Variant.new(@player.playlist.index(song)))
        end
      end

      def remove
        selected_song = @ui.song_list.takeItem(@ui.song_list.currentRow()).data(Qt::UserRole).to_i
        @player.playlist.delete_at(selected_song)
        self.songs = @player.playlist
        if @player.playlist.empty?
          parent.stop
        else
          @player.play(@player.current_song) if @player.current_song == selected_song
        end
      end

      def delete_all
        parent.stop
        @ui.song_list.clear
        @player.playlist = []
      end

      def choose_song
        parent.bright_screen
        @player.play(@ui.song_list.currentItem().data(Qt::UserRole).to_i)
      end

      def search
        keywords = @ui.search.text.split
        self.songs = ((@player.find_by_description(keywords) | @player.find_by_info(keywords)) or @player.playlist)
      end

      def enqueue_file
        fileName = Qt::FileDialog.getOpenFileName(self)
        if !fileName.nil? and Song.audio_file?(fileName)
          playlist = Playlist.new([Song.new(fileName)])
          @player.playlist += playlist.songs
          self.songs = @player.playlist
        end
      end

      def enqueue_folder
        folderName = Qt::FileDialog.getExistingDirectory(self)
        if !folderName.nil?
          playlist = Playlist.new
          playlist.scan_folder(folderName)
          @player.playlist += playlist.songs
          self.songs = @player.playlist
        end
      end

      def sort_by_title
        self.songs = @player.playlist.sort! do |x, y|
          if (x.title == y.title) 
            (x.artist <=> y.artist)
          else
            (x.title <=> y.title)
          end
        end
      end

      def sort_by_author
        self.songs = @player.playlist.sort! do |x, y|
          if (x.artist == y.artist) 
            (x.title <=> y.title)
          else
            (x.artist <=> y.artist)
          end
        end
      end

      def sort_by_rating
        self.songs = @player.playlist.sort! do |x, y|
          y.rate <=> x.rate
        end
      end

    end
  end
end
