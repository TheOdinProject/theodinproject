Feature: Update user profile

In order to update my information
As a learner
I want to be able to edit my profile

Background: Editing data to the database

Scenario: Getting the profile page
  Given The course page with lessons
  When I should see the edit user page
  Then I have user email example@gmail.com
  And I have user username Gigs
  And I have user skype Gigs
  And I have user facebook Gigs
  And I have user twitter Gigs
  And I have user linkedin Gigs
  And I have user github Gigs
  And I have user google_plus Gigs

Scenario: Updating the user profile
  Given When l press edit
  When I enter "Mike" in the "username" field
  And I enter "Mike" in the "skype" field
  And I enter "Mike" in the "facebook" field
  And I enter "Mike" in the "twitter" field
  And I enter "Mike" in the "linkedin" field
  And I enter "Mike" in the "github" field
  And I enter "Mike" in the "google_plus" field
  Then I press the update button
  And I see Your profile was updated successfully