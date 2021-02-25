feature 'editing a bookmark' do
  scenario 'updates and changes bookmark information' do
    visit('/')
    adds_a_bookmark
    click_button('Edit')
    fill_in 'url', with: 'www.bbc.co.uk'
    fill_in 'title', with: 'Auntie'
    click_button 'Submit'
    expect(page).not_to have_content('The Beeb')
    expect(page).to have_content('Auntie')
  end
end
