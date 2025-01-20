require 'spec_helper'

RSpec.describe Word do
  describe 'validations' do
    it 'requires text to be present' do
      word = Word.new
      expect(word).not_to be_valid
      expect(word.errors[:text]).to include("can't be blank")
    end

    it 'requires text to be unique' do
      Word.create!(text: 'HELLO')
      duplicate_word = Word.new(text: 'HELLO')
      expect(duplicate_word).not_to be_valid
      expect(duplicate_word.errors[:text]).to include('has already been taken')
    end
  end

  describe 'associations' do
    it 'can have many games' do
      word = Word.create!(text: 'HELLO')
      game1 = Game.create!(word: word)
      game2 = Game.create!(word: word)

      expect(word.games).to include(game1, game2)
    end
  end
end
