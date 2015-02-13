require 'spec_helper'
require 'fakefs/safe'
require 'MehPlayer/song'

module MehPlayer
  describe Song do
    subject { Song }

    let(:sample_song)do
      File.dirname(__FILE__) + '/../fixtures/spam.mp3'
    end

    let(:second_sample)do
      File.dirname(__FILE__) + '/../fixtures/Terminal Frost.mp3'
    end

    after :each do
      FakeFS::FileSystem.clear
    end

    it 'reads correctly song`s duration' do
      song = subject.new(sample_song)
      expect(song.length).to eq(33)
    end

    it 'reads correctly song`s artist' do
      song = subject.new(sample_song)
      expect(song.artist).to eq('Monty Python')
    end

    it 'reads correctly song`s title' do
      song = subject.new(sample_song)
      expect(song.title).to eq('Spam Song')
    end

    it 'reads correctly song`s album' do
      song = subject.new(sample_song)
      expect(song.album).to eq('Monty Python Sings')
    end

    it 'reads correctly song`s track' do
      song = subject.new(sample_song)
      expect(song.track).to eq(25)
    end

    it 'reads correctly song`s filename' do
      song = subject.new(sample_song)
      expect(song.filename).to eq(sample_song)
    end

    it 'reads correctly song`s rating' do
      song = subject.new(sample_song)
      expect(song.rate).to eq(1)
    end

    it 'reads correctly song`s description' do
      song = subject.new(sample_song)
      expect(song.description).to eq('')
    end

    describe '.audio_file?' do
      it 'correctly identifies whether given file is an audio_file' do
        FakeFS do
          files = ['foo.mp3', 'foo.ogg', 'foo.flac', 'foo.aac', 'foo.ac3']
          files.each do |file|
            FileUtils.touch(file)
          end
          expect(subject.audio_file?('foo.mp3')).to be_truthy
          expect(subject.audio_file?('foo.ogg')).to be_truthy
          expect(subject.audio_file?('foo.flac')).to be_truthy
          expect(subject.audio_file?('foo.aac')).to be_truthy
          expect(subject.audio_file?('foo.ac3')).to be_truthy
        end
      end

      it 'correctly identifies whether given file is not an audio_file' do
        FakeFS do
          FileUtils.touch('foo.bar')
          expect(subject.audio_file?('foo.bar')).to be_falsey
        end
      end

      it 'returns false when the file doesn not exist' do
        FakeFS do
          expect(subject.audio_file?('foo.baz')).to be_falsey
        end
      end

      it 'returns false when given a folder' do
        FakeFS do
          Dir.mkdir('directory')
          expect(subject.audio_file?('directory')).to be_falsey
        end
      end
    end

    describe '#to_s' do
      it 'Creates a string representation of a song' do
        song = subject.new(sample_song)
        expect(
          song.to_s
          ).to eq('Monty Python - Spam Song (Monty Python Sings)')
      end
    end

    describe '#==' do
      it 'returns true if two songs are equal' do
        song = subject.new(sample_song)
        expect(song == song.dup).to be_truthy
      end
      it 'returns false if two songs are not equal' do
        first_song = subject.new(sample_song)
        second_song = subject.new(second_sample)
        expect(first_song == second_song).to be_falsey
      end
    end
  end
end
