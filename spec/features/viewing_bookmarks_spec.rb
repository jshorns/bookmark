feature 'viewing bookmarks' do
    scenario 'viewing bookmarks from the homepage' do
        visit '/'
        click_link 'View Bookmarks'
        expect(page).to have_content('google.com')
        expect(page).to have_content('makersacademy')
        expect(page).to have_content('destroyallsoftware')
    end
end
