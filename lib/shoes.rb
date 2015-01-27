Shoes.setup do
  gem 'taglib-ruby'
  gem 'rubygame'
end
require 'song'

module MehPlayer
  Shoes.app do
    song = button "Add song"
    song.click{
      filename = ask_open_file
      new_song = Song.new(filename)
      alert(new_song.title)
    }
    folder = button "Add folder"
    folder.click{
      folder_name = ask_open_folder
      p "grrr"
      library = Library.new
      p folder_name
      library.scan_folder(folder_name)
      player = Player.new(library)
    }
    play = button "Play"
    play.click{
      alert("gs")
      puts "gs"
      player.play(0)
    }
    stop = button "Stop"
    stop.click{
      player.stop
    }

  end
end