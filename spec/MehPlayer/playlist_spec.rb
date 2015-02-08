require 'spec_helper'
require 'fakefs/safe'
require 'MehPlayer/playlist'
require 'MehPlayer/song'

module MehPlayer
  describe Playlist do
    subject{Playlist}
   
    let(:sample_song)do
      File.dirname(__FILE__) + "/../fixtures/spam.mp3"
    end

    let(:song)do
      Song.new(sample_song)
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
          playlist = subject.new([song])
          expect(playlist.songs).to eq([song])
        end
      end
    end

    describe '.add_song' do
      it 'adds a song to the playlist`s array' do
        playlist = subject.new
        expect(playlist.songs[0]).to match_array(song)
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
        expect(playlist.songs[0]).to match_array(song)
      end
    end

  end
end