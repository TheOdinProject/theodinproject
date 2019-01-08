if Rails.env.development?
  User.delete_all
  TrackUnit.delete_all
  Track.delete_all
end

User.create!(
  email: "andy@andy.com",
  username: "andy",
  password: "foobar",
  password_confirmation: "foobar"
)

TrackUnit.create!(
  name: "VueJS",
  lessons: [Lesson.first, Lesson.second]
)
TrackUnit.create!(
  name: "ReactJS",
  lessons: [Lesson.third, Lesson.fourth]
)

TrackUnit.create!(
  name: "Ruby",
  lessons: [Lesson.first, Lesson.second]
)
TrackUnit.create!(
  name: "Rails",
  lessons: [Lesson.third, Lesson.fourth]
)

Track.create!(
  title: "Track: Front End Frameworks",
  description: "Learn how to use 3 Front End Frameworks",
  track_units: [
    TrackUnit.find_by(name: "VueJS"),
    TrackUnit.find_by(name: "ReactJS")
  ]
)

Track.create!(
  title: "Track: Back End Infrastructure",
  description: "Learn how to make full web apps with Ruby on Rails",
  track_units: [
    TrackUnit.find_by(name: "Ruby"),
    TrackUnit.find_by(name: "Rails")
  ]
)
