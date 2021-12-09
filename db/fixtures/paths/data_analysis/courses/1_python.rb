#######################
# Course - Python
#######################
course = @path.add_course do |course|
    course.title = 'Python Programming'
    course.description = "Time to dive deep into Python, one of the world's most popular languages. Python is used across the entire data analysis stack, from data collection to predictive modeling and machine learning. You'll cover object-oriented design, testing, and data structures – essential knowledge for learning other programming languages, too!"
    course.identifier_uuid = '693bf355-19f1-4326-a4ad-8ec57f9ea254'
  end
  
  # +++++++++++++++++++++++++++++++
  # SECTION - Introduction
  # +++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Introduction'
    section.description = "In this section, we'll look at the path ahead and install Python 3."
    section.identifier_uuid = 'a5854f3d-8171-4201-b53f-e325de69aca4'
  
    section.add_lessons(
      python_lessons.fetch('How this Course Will Work'),
      python_lessons.fetch('Installing Python'),
    )
  end
  
  # ++++++++++++++++++++
  # SECTION - Basic Python
  # ++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Basic Python'
    section.description = "In this section, we'll cover the basic building blocks of Python so you have them down cold. Everything else you'll learn in programming builds on these concepts, so you'll be in a great place to take on additional projects and languages in the future."
    section.identifier_uuid = 'bd6d7a38-5420-4869-b508-c4a2e1deba69'
  
    section.add_lessons(
      python_lessons.fetch('Basic Data Types'),
      python_lessons.fetch('Variables'),
      python_lessons.fetch('Input and Output'),
      python_lessons.fetch('Conditional Logic'),
      python_lessons.fetch('Loops'),
      python_lessons.fetch('Lists'),
      python_lessons.fetch('Dictionaries'),
      python_lessons.fetch('Methods'),
      python_lessons.fetch('Basic Enumerable Methods'),
      python_lessons.fetch('Nested Collections'),
      python_lessons.fetch('Debugging'),
    )
  end
  
  # +++++++++++++++++++++++++++++
  # SECTION - Basic Python Projects
  # +++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Basic Python Projects'
    section.description = 'In this section we will solidify your basic Python knowledge by practicing with a few small projects.'
    section.identifier_uuid = '866d62bc-420a-420f-9469-5ca2787d5bc8'
  
    section.add_lessons(
      python_lessons.fetch('Caesar Cipher'),
      python_lessons.fetch('Sub Strings'),
      python_lessons.fetch('Stock Picker'),
      python_lessons.fetch('Bubble Sort'),
    )
  end
  
  # ++++++++++++++++++++++++++++++++++++++++++++
  # SECTION - Object Oriented Programming Basics
  # ++++++++++++++++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Object Oriented Programming Basics'
    section.description = "You've got tools in your Python tool box and now it's time to combine them into more meaningful programs. In this section, you'll learn how to turn your spaghetti code into properly organized methods and classes."
    section.identifier_uuid = '0a790420-0824-4f32-b2b8-eedb2f47008d'
  
    section.add_lessons(
      python_lessons.fetch('Object Oriented Programming'),
      python_lessons.fetch('Tic Tac Toe'),
      python_lessons.fetch('Mastermind'),
    )
  end
  
  # +++++++++++++++++++++++++++++++++
  # SECTION - Files and Serialization
  # +++++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Files and Serialization'
    section.description = 'What if you want to save the state of your program? How about loading in a file? Some basic operations like these will be covered here.'
    section.identifier_uuid = '2222cd27-0169-4046-8b69-6921fff1764c'
  
    section.add_lessons(
      python_lessons.fetch('Files and Serialization'),
      python_lessons.fetch('Event Manager'),
      python_lessons.fetch('Hangman'),
    )
  end
  
  # +++++++++++++++++++++++++++++++++++
  # SECTION - Advanced Python
  # +++++++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Advanced Python'
    section.description = "In this section you'll learn about some of Python's most powerful features and how using these techniques can simplify your code."
    section.identifier_uuid = 'bf5655dc-bd79-4204-b8c8-69018f940f08'
  
    section.add_lessons(
      python_lessons.fetch('Comprehensions'),
      python_lessons.fetch('Generators'),
    )
  end
  
  # +++++++++++++++++++++++++++++++++++
  # SECTION - A Bit of Computer Science
  # +++++++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'A Bit of Computer Science'
    section.description = "In this section, you'll learn some fundamental computer science concepts that will help you when solving problems with a bit more complexity than just simple algorithms.  You get to try on your engineering hat and solve some pretty nifty problems."
    section.identifier_uuid = '1dc1d088-73be-4200-9eaa-73369f614b7c'
  
    section.add_lessons(
      python_lessons.fetch('A Very Brief Intro to CS'),
      python_lessons.fetch('Recursive Methods'),
      python_lessons.fetch('Recursion'),
      python_lessons.fetch('Common Data Structures and Algorithms'),
      python_lessons.fetch('Linked Lists'),
      python_lessons.fetch('Binary Search Trees'),
      python_lessons.fetch('Knights Travails'),
    )
  end
  
  # +++++++++++++++++++++++++++++++++
  # SECTION - Testing Python with pytest
  # +++++++++++++++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Testing Python with pytest'
    section.description = "You've been briefly introduced to testing in Python a couple of times before in the Foundations course, but now you're going to really learn why testing can be hugely helpful and how to apply it to your own projects."
    section.identifier_uuid = '1e8d5245-ed37-420e-a069-be208aced01f'
  
    section.add_lessons(
      python_lessons.fetch('Test Driven Development'),
      python_lessons.fetch('Introduction to pytest'),
      python_lessons.fetch('Connect Four'),
    )
  end
  
  # +++++++++++++
  # SECTION - GIT
  # +++++++++++++
  course.add_section do |section|
    section.title = 'GIT'
    section.description = "You should be familiar with the basic Git workflow since you've been using it to save your projects along the way (right?!). This section will start preparing you for for the more intermediate-level uses of Git that you'll find yourself doing."
    section.identifier_uuid = '42059547-a8fd-4269-b546-24c2222106c6'
  
    section.add_lessons(
      python_lessons.fetch('A Deeper Look at Git'),
      python_lessons.fetch('Using Git in the Real World'),
    )
  end
  
  # ++++++++++++++++++++
  # SECTION - Conclusion
  # ++++++++++++++++++++
  course.add_section do |section|
    section.title = 'Conclusion'
    section.description = "You've come an exceptional distance already, now there's just the matter of wrapping it all together into one coherant package and creating something real. This is your Final Exam and a major feather in your cap. Once you've completed this section, you should have the confidence to tackle pretty much anything."
    section.identifier_uuid = '42021d3c-c22e-420f-9885-9ef1156897c6'
  
    section.add_lessons(
      python_lessons.fetch('Python Final Project'),
      python_lessons.fetch('Conclusion'),
    )
  end
  
  # clean up any removed seeds from the database
  course.delete_removed_seeds
  