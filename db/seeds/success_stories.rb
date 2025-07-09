success_stories = [
  {
    student_name: 'Nijo Nelson',
    avatar_path_name: 'nijo_nelson.png',
    story_content: '<p>This looks awesome, I just skimmed through all the folders and feel like I can learn a lot from this.
Yeah, I genuinely think I can get better with this whole development thing with the contents.
 Like it feels like the most important parts of software development is highlighted here. Thanks for this treasure trove of information..</p>',
    job_title: 'B-tech CSE IES college of engineering',
    social_media_link: 'https://www.linkedin.com/in/nijo-nel/'
  },
  {
    student_name: 'Aashima Ladha',
    avatar_path_name: 'ashima_ladha.png',
    story_content: '<p>It was truly a great session, and I would like to thank the Data Monk team for being so helpful and kind to us.</p>',
    job_title: 'Data Analyst at Chegg',
    social_media_link: 'https://www.linkedin.com/in/ashimaladha/',
  },
  {
    student_name: 'Shahid Khan',
    avatar_path_name: 'shahid_khan.png',
    story_content: "<p> Today's session was great. I understood the importance of Docker. I learnt that if you want to work on an industry project, then the foundation must be clear.</p>",
    job_title: 'Student at PDUSU, Sikar',
    social_media_link: 'https://www.linkedin.com/in/shahidkhanofficialprofile/',
  }

]

seeded_stories = success_stories.flat_map do |success_story|
  SuccessStory.seed(:student_name, success_story)
end

# destroy any removed seeds
[SuccessStory.all - seeded_stories].flatten.each(&:destroy)
