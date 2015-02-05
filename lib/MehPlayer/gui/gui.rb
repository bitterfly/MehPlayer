require 'Qt'
require 'MehPlayer/gui/mainwindow.rb'

module MehPlayer
  module Gui
    app = Qt::Application.new(ARGV)
    mainwindow = MainWindow.new
    mainwindow.show
    app.exec
  end
end
