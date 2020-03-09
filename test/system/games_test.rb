require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Submitting a word not in the grid" do
    visit new_url
    fill_in 'word', with: 'asdf'
    click_on 'submit'
    # assert test: "New game"
    assert_text('Sorry but asdf is not a word')
  end

end

