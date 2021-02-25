
feature 'editing a bookmark' do
  scenario 'updates and changes bookmark information' do
    bookmark = Bookmark.create(url: 'http://www.bbc.co.uk', title: 'The Beeb')
    visit('/')
    click_button('Edit')
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"
    fill_in 'url', with: 'www.bbc.co.uk'
    fill_in 'title', with: 'Auntie'
    click_button 'Submit'
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('The Beeb', href: 'www.bbc.co.uk')
    expect(page).to have_link('Auntie', href: 'www.bbc.co.uk')
  end
end
