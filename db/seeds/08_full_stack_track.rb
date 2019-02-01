# CREATE TRACKS
# *********************************

Rails.logger.info "\n\n***** STARTING TRACKS *****"

if Rails.env == "development"
  Track.delete_all
end

Track.create!(
  title: "Full Stack",
  description: "The OG Odin",
  position: 1
)
