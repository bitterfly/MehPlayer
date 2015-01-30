require './ui_listwindow.rb'
require 'song'
require 'playlist'
require 'player'

module MehPlayer
  module Gui  
    class ListWindow < Qt::MainWindow
      slots 'choose_song()'

      def initialize(player, parent = nil)
        super(parent)
        @player = player
        @ui = Ui_ListWindow.new
        @ui.setupUi(self)
        connect(@ui.song_list, SIGNAL('itemDoubleClicked(QListWidgetItem* )'), self, SLOT('choose_song()'))
      end

      def songs=(playlist)
        @ui.song_list.clear
        playlist.each do |song|
          Qt::ListWidgetItem.new(song.to_s, @ui.song_list)
        end
      end

      def choose_song()
        @player.play(@ui.song_list.currentRow())
      end

    end
  end
end
