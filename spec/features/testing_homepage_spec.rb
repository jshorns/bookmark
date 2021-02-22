feature 'homepage test' do
  scenario 'it should open the page with hello world' do
    visit '/'
    expect(page).to have_content "View Bookmarks"
  end

end
