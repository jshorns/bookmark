require 'Bookmark'

describe Bookmark do
  subject(:bookmark) { described_class.new("hello") }
  it {is_expected.to respond_to(:text)}

  describe '#self.all' do
    it 'returns array of Bookmark instances' do
      expect(Bookmark.all).to include("http://www.makersacademy.com")
      expect(Bookmark.all).to include("http://www.destroyallsoftware.com")
      expect(Bookmark.all).to include("http://www.google.com")
    end
  end
end
