require 'spec_helper'
require 'fakefs/safe'
require 'MehPlayer/playlist'
require 'MehPlayer/song'

module MehPlayer
  describe Playlist do
    subject { Playlist }

    let(:first_file)do
      File.dirname(__FILE__) + '/../fixtures/spam.mp3'
    end

    let(:second_file)do
      File.dirname(__FILE__) + '/../fixtures/Terminal Frost.mp3'
    end

    let(:first_song)do
      Song.new(first_file)
    end

    let(:second_song)do
      Song.new(second_file)
    end

    let(:folder)do
      File.dirname(__FILE__) + '/../fixtures'
    end

    after :each do
      FakeFS::FileSystem.clear
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

    describe '.find_by_description' do
      it 'finds song by user`s descriprion' do
        playlist = subject.new([first_song, second_song])
        playlist.songs[0].description = 'Best song ever'
        expect(
          playlist.find_by_description(['Best', 'song', 'ever'])
          ).to eq([first_song])
      end
    end

    describe '.find_by_info' do
      it 'finds song by its title' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.find_by_info(['spam', 'song'])).to eq([first_song])
      end

      it 'finds song by matching at least one of its title`s words' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.find_by_info(['spam'])).to eq([first_song])
      end

      it 'finds song by artist' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.find_by_info(['python'])).to eq([first_song])
      end

      it 'is case insensitive' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.find_by_info(['SpAm'])).to eq([first_song])
      end

      it 'returns empty array if there isn`t a match' do
        playlist = subject.new([first_song, second_song])
        expect(playlist.find_by_info(['maps', 'gnos'])).to eq([])
      end
    end

    describe '.save' do
      it 'saves songs to yaml' do
        playlist = subject.new([first_song, second_song])
        FakeFS do
          playlist.save("foo.bar")
          expect(YAML.load(File.read("foo.bar"))).to eq(playlist.songs)
        end
      end
    end

    describe '.open' do
      it 'opens songs from yaml' do
        playlist = subject.new
        FakeFS do
          File.write("foo.bar", ([first_song, second_song]).to_yaml)
          playlist.open("foo.bar")
          expect(playlist.songs).to eq([first_song, second_song])
        end
      end
    end
  end
end
