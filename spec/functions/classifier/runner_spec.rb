
require 'functions/classifier/runner'

describe ManagerClassifier::Functions::Classifier::Runner do

  subject{ described_class.new(text) }

  context 'matching buzzwords' do

    let(:text){
      "Hi John, nice idea, let's align on this issue and loop back on any redundancies in our internal customer profile"
    }

    it 'returns three buzzword matches' do
      expect(subject.matches).to eq ["customer profile", "align", "loop back"]
    end

    it 'returns a score of 0.25 as 5 of the 20 words are from buzzwords' do
      expect(subject.score).to eq 0.25
    end

    it 'returns the buzzwords and score' do
      expect(subject.classify).to eq ({ buzzwords: ["customer profile", "align", "loop back"], score: 0.25})
    end

  end

  context 'matching buzzwords' do

    let(:text){
      "It is my desire, if not my duty, to try to talk to you journeymen with some candor about what is happening to radio and television in this generous and capacious land. I have no technical advice or counsel to offer those of you who labor in this vineyard the one that produces words and pictures. "
    }

    it 'returns three buzzword matches' do
      expect(subject.matches).to eq []
    end

    it 'returns a score' do
      expect(subject.score).to eq 0
    end

  end
end