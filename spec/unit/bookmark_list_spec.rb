require 'Bookmark'

describe Bookmark do
  subject(:bookmark) { described_class.new("hello") }
  it {is_expected.to respond_to(:text)}

  describe '#self.all' do
    it 'returns array of Bookmark instances' do
      expect(Bookmark.all).to include("hello")
    end
  end
end
