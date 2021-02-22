feature 'viewing bookmarks' do
    scenario 'viewing bookmarks from the homepage' do
        visit '/'
        click_link 'View Bookmarks'
        expect(page).to have_content Bookmark.all
    end
end
