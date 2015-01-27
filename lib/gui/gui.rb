require 'Qt'
require './mainwindow.rb'

module MehPlayer
  module Gui
    app = Qt::Application.new(ARGV)
    calculator = MainWindow.new
    calculator.show
    app.exec
  end
end