require 'comment'
require 'database_helpers'

describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      comment = Comment.create(text: 'what a lovely comment', bookmark_id: bookmark.id)
      persisted_data = persisted_data_comment(id: comment.id)
      expect(comment.id).to eq persisted_data['id']
      expect(comment.text).to eq 'what a lovely comment'
      expect(comment.bookmark_id).to eq bookmark.id
    end
  end
  describe '.all' do
    it 'shows list of comments for given bookmark' do
      bookmark = Bookmark.create(url: 'https://rupaul.com/', title: 'Rupaul')
      comment = Comment.create(text: 'what a lovely comment', bookmark_id: bookmark.id)
      comments = Comment.all(bookmark_id: "#{bookmark.id}")
      expect(comments.length).to eq(1)
      expect(comments.first).to be_a Comment
      expect(comments.first.text).to eq("what a lovely comment")
      expect(comments.first.bookmark_id).to eq("#{bookmark.id}")
    end
  end
end
