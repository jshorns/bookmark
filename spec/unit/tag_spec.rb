require 'tag'
require 'database_helpers'

describe Tag do
  describe '.create' do
    it 'creates a new tag' do
      tag = Tag.create(content: 'funny')
      expect(tag).to be_a Tag
      persisted_data = persisted_data_tag(id: tag.id)
      expect(tag.id).to eq persisted_data['id']
      expect(tag.content).to eq 'funny'
    end
  end
  describe '.find' do
    it 'returns a Tag instance with the appropriate values' do
      tag = Tag.create(content: 'funny')
      found_tag = Tag.find(id: tag.id)
      persisted_data = persisted_data_tag(id: tag.id)
      expect(found_tag.id).to eq persisted_data['id']
      expect(found_tag.content).to eq 'funny'
    end
  end
  describe '#self.all' do
    it 'returns list tags' do
      tag = Tag.create(content: 'funny')
      Tag.create(content: 'sad')
      Tag.create(content: 'discombobulating')
      tags = Tag.all
      expect(tags.length).to eq(3)
      expect(tags.first).to be_a Tag
      expect(tags.first.content).to eq("funny")
    end
  end
end
