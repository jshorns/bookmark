feature 'viewing bookmarks' do
  scenario 'viewing bookmarks from the homepage' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")
    visit '/'
    click_link 'View Bookmarks'
    expect(page).to have_content('google.com')
    expect(page).to have_content('makersacademy')
    expect(page).to have_content('destroyallsoftware')
  end
end
