require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector ".box", count: 10
  end

  test "doesn't pass letter check" do
    visit new_url
    fill_in('word', with: '999')
    click_on('play')
    assert test: "Sorry can't be built of"
  end
end
