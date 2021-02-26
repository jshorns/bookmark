feature 'user can add a comment' do
  scenario 'comment shows on homepage after it has been added' do
    bookmark = Bookmark.create(url: 'https://www.bbc.co.uk', title: 'The Beeb')
    visit('/')
    click_button('Add comment')
    fill_in 'comment', with: 'Wow love to get me some news'
    click_button('Submit')
    expect(page).to have_content 'Wow love to get me some news'
  end
end
