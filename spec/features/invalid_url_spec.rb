feature 'displays an error message if the user does not submit a real url' do
  scenario 'user has tried to add an invalid bookmark' do
    visit('/bookmarks/new')
    fill_in 'url', with: 'fakenews.fake'
    fill_in 'title', with: 'Really Fake bookmark'
    click_button 'Submit'
    expect(page).to have_content("That's not a valid url")
    expect(page).not_to have_link("Really Fake bookmark", href: 'fakenews.fake')
  end
end
