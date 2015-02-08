require 'spec_helper'
require 'fakefs/safe'
require 'MehPlayer/playlist'
require 'MehPlayer/song'

module MehPlayer
  describe Playlist do
    subject{Playlist}
   
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

    let(:folder)do
      File.dirname(__FILE__) + "/../fixtures"
    end

    describe '#initialize' do
      context 'withot files' do
        it 'creates an empty song, when list`s not given' do
          playlist = subject.new
          expect(playlist.songs).to eq([])
        end
      end
      context 'with files' do
        it 'creates list array with the given songs' do
          playlist = subject.new([first_song])
          expect(playlist.songs).to eq([first_song])
        end
      end
    end

    describe '.add_song' do
      it 'adds a song to the playlist`s array' do
        playlist = subject.new
        playlist.add_song(first_file)
        expect(playlist.songs).to eq([first_song])
      end
    end

    describe '.clear' do
      it 'removes all the songs from a playlist' do
        playlist = subject.new
        playlist.clear
        expect(playlist.songs).to eq([])
      end
    end

    describe '.scan_folder' do
      it 'Gets all the song files in a directory' do
        playlist = subject.new
        playlist.scan_folder(folder)
        expect(playlist.songs).to match_array([first_song, second_song])
      end
    end

    describe '.album' do
      it 'returns array with all the songs in a given album' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.album("Monty Python", "Monty Python Sings")).to eq(["Monty Python Sings", [first_song]])
      end
    end

    describe '.artist' do
      it 'returns hash of album and their contents' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.artist("Monty Python")).to eq({"Monty Python Sings" => [first_song]})
      end
    end

  end
end