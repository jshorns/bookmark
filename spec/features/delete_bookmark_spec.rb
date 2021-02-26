feature 'deleting bookmarks' do
  scenario 'when user has entered a bookmark and then decided to delete it' do
    bookmark = Bookmark.create(url: 'http://www.bbc.co.uk', title: 'The Beeb')
    visit('/bookmarks')
    click_button('Delete')
    expect(page).not_to have_content "#{bookmark.title}"
  end
end
