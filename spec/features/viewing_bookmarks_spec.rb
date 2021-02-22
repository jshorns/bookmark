feature 'viewing bookmarks' do
    scenario 'viewing bookmarks from the homepage' do
        visit '/'
        click_button 'View Bookmarks'
        expect(page).to have_content 'Here are your bookmarks'
    end
end