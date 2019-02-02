# CREATE TRACKS
# *********************************

Rails.logger.info "\n\n***** STARTING TRACKS *****"

if Rails.env == "development"
  Track.delete_all
end

create_or_update_track(
  title: "Full Stack",
  description: "The OG Odin: RELOADED",
  position: 1,
  courses: [
    Course.find_by(title: "Web Development 101"),
    Course.find_by(title: "Ruby Programming"),
    Course.find_by(title: "Databases"),
    Course.find_by(title: "Ruby on Rails"),
    Course.find_by(title: "HTML and CSS"),
    Course.find_by(title: "Javascript"),
    Course.find_by(title: "Getting Hired")
  ]
)

