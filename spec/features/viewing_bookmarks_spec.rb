feature 'viewing bookmarks' do
  scenario 'viewing bookmarks from the homepage' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
     Bookmark.create(url: "http://www.makersacademy.com")
     Bookmark.create(url: "http://www.destroyallsoftware.com")
     Bookmark.create(url: "http://www.google.com")
    visit '/'
    click_link 'View Bookmarks'
    expect(page).to have_content('google.com')
    expect(page).to have_content('makersacademy')
    expect(page).to have_content('destroyallsoftware')
  end
end
