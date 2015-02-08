require 'spec_helper'
require 'fakefs/safe'
require 'MehPlayer/playlist'
require 'MehPlayer/song'
require 'MehPlayer/player'

module MehPlayer
  describe Player do
    subject{Player}
   
    let(:first_file)do
      File.dirname(__FILE__) + "/../fixtures/spam.mp3"
    end

    let(:second_file)do
      File.dirname(__FILE__) + "/../fixtures/Terminal Frost.mp3"
    end

    let(:first_song)do
      Song.new(first_file)
    end
    
    let(:second_song)do
      Song.new(second_file)
    end

    let(:playlist)do
      Playlist.new([first_song, second_song])
    end

    before :each do
     @player = subject.new(playlist)
    end

    describe '.find_by_description' do
      it 'finds song by user`s descriprion' do
        @player.playlist[0].description = "Best song ever"
        expect(@player.find_by_description(["Best", "song", "ever"])).to eq([first_song])
      end
    end

    describe '.find_by_info' do
      it 'finds song by its title' do
        expect(@player.find_by_info(["spam", "song"])).to eq([first_song])
      end

      it 'finds song by matching at least one of its title`s words' do
        expect(@player.find_by_info(["spam"])).to eq([first_song])
      end

      it 'finds song by artist' do
        expect(@player.find_by_info(["python"])).to eq([first_song])
      end

      it 'is case insensitive' do
        expect(@player.find_by_info(["SpAm"])).to eq([first_song])
      end

      it 'returns empty array if there isn`t a match' do
        expect(@player.find_by_info(["maps", "gnos"])).to eq([])
      end
    end
  end
end