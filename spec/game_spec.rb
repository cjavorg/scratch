require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:word) { Word.create(text: "APPLE") }
  let(:game) { Game.create(word: word) }

  describe "validations" do
    it "requires a word" do
      game = Game.new
      expect(game).not_to be_valid
      expect(game.errors[:word]).to include("can't be blank")
    end
  end

  describe "#check_guess" do
    context "with invalid input" do
      it "raises error when guess is nil" do
        expect { game.check_guess(nil) }.to raise_error(ArgumentError, "Guess cannot be nil")
      end

      it "raises error when guess length is not 5" do
        expect { game.check_guess("ABC") }.to raise_error(ArgumentError, "Guess must be 5 letters")
      end

      # TODO: Add tests for invalid characters
    end

    context "with valid guesses" do
      it "returns all correct for exact match" do
        expect(game.check_guess("APPLE")).to eq([:correct, :correct, :correct, :correct, :correct])
      end

      it "returns all incorrect for no matches" do
        expect(game.check_guess("ZZZZZ")).to eq([:incorrect, :incorrect, :incorrect, :incorrect, :incorrect])
      end

      it "handles partial matches" do
        # Target: APPLE
        # Guess:  PAPEL (P and L are in wrong positions, E is correct)
        expect(game.check_guess("PAPEL")).to eq([:partial, :partial, :incorrect, :correct, :partial])
      end

      it "handles duplicate letters correctly" do
        # Target: APPLE
        # Guess:  PAPER (Only one P should be marked as correct)
        expect(game.check_guess("PAPER")).to eq([:correct, :correct, :correct, :incorrect, :incorrect])
      end
    end
  end
end
