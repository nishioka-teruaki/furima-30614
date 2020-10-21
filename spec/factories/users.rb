FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}

    last_name             {Gimei::name.last.kanji}
    first_name            {Gimei::name.first.kanji}
    last_name_kana        {Gimei::name.last.katakana}
    first_name_kana       {Gimei::name.first.katakana}
    user_birth_date       {19300101}
  end
end