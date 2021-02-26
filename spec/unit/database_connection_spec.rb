require 'database_connection'

describe DatabaseConnection do
  let(:bookmark) { double(:double, :url => 'https://rupaul.com/', :title => 'Rupaul') }
  describe '.setup' do
    it 'returns database connection as class instance variable' do
      testdb = 'bookmark_manager_test'
      described_class.setup(testdb)
      expect(DatabaseConnection.db).to be_a PG::Connection
    end
  end
  describe '.query' do
    it 'executes an SQL query on the appropriate database' do
      testdb = 'bookmark_manager_test'
      described_class.setup(testdb)
      described_class.query("INSERT INTO bookmarks (url, title) VALUES('#{bookmark.url}', '#{bookmark.title}') RETURNING id, title, url;")
      result = described_class.query("SELECT * FROM bookmarks WHERE title = '#{bookmark.title}';")
      expect(result[0]['title']).to eq(bookmark.title)
      expect(result[0]['url']).to eq(bookmark.url)
    end

  end
end
