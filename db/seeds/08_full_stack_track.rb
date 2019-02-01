# CREATE TRACKS
# *********************************

Rails.logger.info "\n\n***** STARTING TRACKS *****"

track_position = 0

create_or_update_track(
  title: "Full Stack",
  description: "The OG Odin",
  position: track_position,
  courses: [
      Course.find_by(title: "Web Development 101"),
      Course.find_by(title: "Ruby Programming"),
      Course.find_by(title: "Databases"),
      Course.find_by(title: "Ruby on Rails"),
      Course.find_by(title: "HTML and CSS"),
      Course.find_by(title: "Javascript"),
      Course.find_by(title: "Getting Hired"),
    ]
)

track_position += 1
create_or_update_track(
  title: "Ruby on Rails",
  description: "Chugga Chugga",
  position: track_position,
  courses: [
      Course.find_by(title: "Ruby Programming"),
      Course.find_by(title: "Databases"),
      Course.find_by(title: "Ruby on Rails"),
    ]
)

