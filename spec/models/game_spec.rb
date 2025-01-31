require 'spec_helper'

RSpec.describe Game do
  let(:word) { Word.create!(text: "hello") }
  let(:game) { Game.create!(word: word, guesses: []) }

  describe "#check_guess" do
    context "with a correct guess" do
      it "returns all correct markers" do
        result = game.check_guess("hello")
        expect(result).to eq([:correct, :correct, :correct, :correct, :correct])
      end
    end

    context "with a partially correct guess" do
      it "marks letters in correct positions" do
        result = game.check_guess("helps")
        expect(result[0..1]).to eq([:correct, :correct])
      end

      it "marks letters in wrong positions as partial" do
        result = game.check_guess("ehllo")
        expect(result).to eq([:partial, :partial, :correct, :correct, :correct])
      end
    end

    context "with an incorrect guess" do
      it "marks non-matching letters as incorrect" do
        result = game.check_guess("world")
        expect(result).to eq([:incorrect, :incorrect, :partial, :partial, :incorrect])
      end
    end

    context "with duplicate letters in guess" do
      let(:word) { Word.create!(text: "happy") }
      let(:game) { Game.create!(word: word, guesses: []) }

      it "handles duplicate letters correctly" do
        result = game.check_guess("puppy")
        expect(result).to eq([:partial, :incorrect, :correct, :correct, :correct])
      end
    end
  end

  describe "validations" do
    it "requires a word" do
      game = Game.new(guesses: [])
      expect(game).not_to be_valid
      expect(game.errors[:word]).to include("must exist")
    end
  end

  describe "guesses" do
    it "initializes with empty guesses array" do
      expect(game.guesses).to eq([])
    end

    it "stores guesses with their results" do
      game.guesses << { text: "world", result: [:incorrect, :incorrect, :partial, :partial, :incorrect] }
      game.save
      reloaded_game = Game.find(game.id)
      expect(reloaded_game.guesses.first[:text]).to eq("world")
      expect(reloaded_game.guesses.first[:result]).to eq([:incorrect, :incorrect, :partial, :partial, :incorrect])
    end
  end

  describe "game completion" do
    it "is not completed by default" do
      expect(game.completed).to be false
    end

    it "can be marked as completed" do
      game.update(completed: true)
      expect(game.reload.completed).to be true
    end
  end

  describe "edge cases" do
    it "handles empty guess string" do
      expect { game.check_guess("") }.to raise_error(ArgumentError)
    end

    it "handles nil guess" do
      expect { game.check_guess(nil) }.to raise_error(ArgumentError)
    end

    it "handles guess with wrong length" do
      expect { game.check_guess("too_long") }.to raise_error(ArgumentError)
    end
  end
end