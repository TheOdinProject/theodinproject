if Rails.env.development?
  TrackUnit.delete_all
  Track.delete_all
end

Track.create!(
  title: "Track: Front End Frameworks",
  description: "Learn how to use 3 Front End Frameworks",
)

Track.create!(
  title: "Track: Back End Infrastructure",
  description: "Learn how to make full web apps with Ruby on Rails",
)

TrackUnit.create!(
  title: "TrackUnit: VueJS",
  lessons: [Lesson.first, Lesson.second],
  track: Track.find_by(title: "Track: Front End Frameworks")
)
TrackUnit.create!(
  title: "TrackUnit: ReactJS",
  lessons: [Lesson.third, Lesson.fourth],
  track: Track.find_by(title: "Track: Front End Frameworks")
)

TrackUnit.create!(
  title: "TrackUnit: Ruby",
  lessons: [Lesson.first, Lesson.second],
  track: Track.find_by(title: "Track: Back End Infrastructure")
)
TrackUnit.create!(
  title: "TrackUnit: Rails",
  lessons: [Lesson.third, Lesson.fourth],
  track: Track.find_by(title: "Track: Back End Infrastructure")
)
