create_or_update_track(
  title: "Full Stack JavaScript",
  description: "This track takes you through our entire JavaScript curriculum.  You'll learn everything you need to know to create beautiful responsive websites from scratch using JavaScript and NodeJs.",
  position: 1,
  track_courses: [
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Web Development 101"), track_position: 1),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Javascript"), track_position: 2),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "HTML and CSS"), track_position: 3),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "NodeJS"), track_position: 4),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Getting Hired"), track_position: 5)
  ]
)
