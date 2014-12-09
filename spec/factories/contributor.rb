FactoryGirl.define do
  factory :contributor do
    username "Dummy"
    contributions 5
    avatar_url "https://avatars.githubusercontent.com/u/1574"
    name "Dummy"
    email "dummy@foobar.com"
    location "Galicia, Spain"
    latitude "42.242485"
    longitude "-8.720362"
    country "Spain"
    state "Pontevedra"
    city "Vigo"
  end
end