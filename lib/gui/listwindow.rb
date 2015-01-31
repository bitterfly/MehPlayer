require './ui_listwindow.rb'
require 'song'
require 'playlist'
require 'player'

module MehPlayer
  module Gui  
    class ListWindow < Qt::MainWindow
      slots 'choose_song()', 'search()', 'enqueue_file()', 'enqueue_folder()' 

      def initialize(player, parent = nil)
        super(parent)
        @player = player
        @ui = Ui_ListWindow.new
        @ui.setupUi(self)
        connect(@ui.song_list, SIGNAL('itemDoubleClicked(QListWidgetItem* )'), self, SLOT('choose_song()'))
        connect(@ui.search, SIGNAL('textChanged(const QString &)'), self, SLOT('search()'))
        connect(@ui.enqueue_file, SIGNAL('clicked()'), self, SLOT('enqueue_file()'))
        connect(@ui.enqueue_folder, SIGNAL('clicked()'), self, SLOT('enqueue_folder()'))
      end

      def songs=(playlist)
        @ui.song_list.clear
        playlist.each do |song|
          Qt::ListWidgetItem.new(song.to_s, @ui.song_list)
        end
      end

      def remove
        p @ui.song_list.item(song).font
        item = @ui.song_list.takeItem(song).font.bold = true
      end

      def choose_song
        @player.play(@ui.song_list.currentRow())
      end

      def search
        keywords = @ui.search.text.split
        self.songs = @player.find_by_description(keywords) | @player.find_by_info(keywords)
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

    end
  end
end
