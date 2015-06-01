module Features
  module SnippetsHelpers
    def create_snippet(snippet)
      visit root_path
      click_button 'Create Snippet'
      expect(page).to have_content('New Snippet')
      fill_in 'Name', with: snippet.name
      fill_in 'Content', with: snippet.content
      click_button 'Save'
    end
    
    def update_snipet(snippet)
      expect(page).to have_content('Editing Snippet')
      fill_in 'Name', with: snippet.name
      fill_in 'Content', with: snippet.content
      click_button 'Save'
    end
  end
end

World(Features::SnippetsHelpers)