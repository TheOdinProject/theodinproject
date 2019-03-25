# CREATE TRACKS
# *********************************

Rails.logger.info "\n\n***** STARTING TRACKS *****"

create_or_update_track(
  title: "Full Stack Ruby on Rails",
  description: "This track takes you through our entire curriculum.  You'll learn everything you need to know to create beautiful responsive websites from scratch. This is our default track. If you do not know where to start, select this track.",
  position: 1,
  track_courses: [
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Web Development 101"), track_position: 1),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Ruby Programming"), track_position: 2),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Databases"), track_position: 3),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Ruby on Rails"), track_position: 4),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "HTML and CSS"), track_position: 5),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Javascript"), track_position: 6),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Getting Hired"), track_position: 7)
  ]
)

create_or_update_track(
  title: "Front End Only",
  description: "This track takes you through all of the front-end content in our curriculum. You'll learn HTML, CSS and JavaScript, but you will not encounter any Ruby or Rails.",
  position: 1,
  track_courses: [
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Web Development 101"), track_position: 1),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Javascript"), track_position: 2),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "HTML and CSS"), track_position: 3),
    TrackCourse.create(track: Track.find_by(title: "Full Stack"), course: Course.find_by(title: "Getting Hired"), track_position: 4)
  ]
)
