require 'Bookmark'
require 'database_helpers'

describe Bookmark do

  describe '#self.all' do
    it 'returns list of bookmark instances' do
      connection = DatabaseConnection.setup('bookmark_manager_test')
      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "Makers")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq(3)
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.title).to eq("Makers")
      expect(bookmarks.first.url).to eq("http://www.makersacademy.com")
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      expect(bookmark).to be_a Bookmark
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Rupaul'
      expect(bookmark.url).to eq 'https://rupaul.com/'
    end
    it 'does not create a bookmark if url is invalid' do
      Bookmark.create(url: 'fake news', title: 'Rupaul')
      expect(Bookmark.all).to be_empty
    end
  end

  describe '.delete' do
    it 'deletes a bookmark from the table' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      Bookmark.delete(id: bookmark.id)
      expect(persisted_data(id: bookmark.id)).to be_nil
      expect(Bookmark.all).not_to include(bookmark)
    end
  end

  describe '.find' do
    it 'returns a Bookmark instance with the appropriate values' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      found_bookmark = Bookmark.find(id: bookmark.id)
      persisted_data = persisted_data(id: bookmark.id)
      expect(found_bookmark.id).to eq persisted_data['id']
      expect(found_bookmark.title).to eq 'Rupaul'
      expect(found_bookmark.url).to eq 'https://rupaul.com/'
    end
  end

  describe '.edit' do
    it 'edits and updates a bookmark from the table' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      Bookmark.edit(id: bookmark.id, url: 'https://www.bbc.co.uk/programmes/p07kt8b4', title: 'Rupaul UK')
      persisted_data = persisted_data(id: bookmark.id)
      expect(persisted_data["title"]).to eq 'Rupaul UK'
      expect(persisted_data["url"]).to eq 'https://www.bbc.co.uk/programmes/p07kt8b4'
    end
  end

  describe 'comments' do
    it 'returns a list of comments for that bookmark' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      comment = Comment.create(text: 'what a lovely comment', bookmark_id: bookmark.id)
      expect(bookmark.comments.length).to eq 1
      expect(bookmark.comments.first.text).to eq('what a lovely comment')
      expect(bookmark.comments.first.bookmark_id).to eq("#{bookmark.id}")
    end
  end

  describe 'comments' do
    it 'returns a list of comments for that bookmark' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      comment = Comment.create(text: 'what a lovely comment', bookmark_id: bookmark.id)
      expect(bookmark.comments.length).to eq 1
      expect(bookmark.comments.first.text).to eq('what a lovely comment')
      expect(bookmark.comments.first.bookmark_id).to eq("#{bookmark.id}")
    end
  end

  describe 'tags' do
    it 'returns tags for that bookmark' do
      tag = Tag.create(content: 'funny')
      tag2 = Tag.create(content: 'sad')
      tag3 = Tag.create(content: 'discombobulating')
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      bookmark.add_tag(tag_id: tag.id)
      bookmark.add_tag(tag_id: tag2.id)
      bookmark.add_tag(tag_id: tag3.id)
      expect(bookmark.tags.length).to eq(3)
      expect(bookmark.tags.first).to be_a Tag
      expect(bookmark.tags.first.content).to eq("funny")
    end
  end

end
