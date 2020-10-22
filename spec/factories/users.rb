FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials }
    email                 { Faker::Internet.free_email }
    password              { 'zxcvasd1' }
    password_confirmation { password }

    last_name             { Gimei.name.last.kanji }
    first_name            { Gimei.name.first.kanji }
    last_name_kana        { Gimei.name.last.katakana }
    first_name_kana       { Gimei.name.first.katakana }
    user_birth_date       { 19_300_101 }
  end
end
