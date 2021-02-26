feature 'adding a new bookmark' do
  scenario 'it should allow me to add a new bookmark page' do
    visit('/bookmarks')
    p DatabaseConnection.db.exec("SELECT * FROM bookmarks")
    expect(page).to have_link('Add a bookmark', href: '/bookmarks/new')
    click_link('Add a bookmark')
    adds_a_bookmark
    expect(page).to have_content 'The Beeb'
  end
end
