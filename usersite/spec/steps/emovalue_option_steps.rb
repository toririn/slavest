require 'rails_helper'

step 'topにアクセスする' do
  Capybara.app_host = 'http://localhost:3000/'
end

step '設定画面を表示する' do
  visit user_emovalue_options_path(user_id: 1)
  page.save_screenshot "#{SCREEN_SHOTS}/emovalue_option/page.png"
end

step '設定画面が表示されていること' do
  expect(page).to have_content '設定'
end
