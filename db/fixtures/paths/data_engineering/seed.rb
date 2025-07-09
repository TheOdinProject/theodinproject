# ************************
# Path - Data Engineering
# ************************
path = Seeds::PathBuilder.build do |path|
  path.title = 'Data Engineering'
  path.short_title = 'Data Engineering Path'
  path.description = "This is a comprehensive Data Engineering course where you'll learn everything from Python to distributed data systems. You'll work with real-world tools and systems used by data engineers."
  path.badge_uri = 'badge-data-engineering.svg'
  path.identifier_uuid = 'b2c2b4cf-6125-412b-9616-c2d1d3808c35'  # Unique identifier for the path
  path.position = 3  # Position of the path in the list of courses
  # path.default_path = false  # Set as the default path
end

#######################
# Course - Data Engineering
#######################

course = path.add_course do |course|
  course.title = 'Data Engineering'
  course.description = "A hands-on course in Data Engineering, teaching you Python, SQL, ETL pipelines, data storage, distributed processing, and analytics."
  course.identifier_uuid = '4bf81824-6cb2-4b8c-8fa4-25a5a97ae93d'  # Unique identifier for the course
  course.badge_uri = 'badge-data-engineering.svg'
end

# +++++++++++++++++++++++++++++++
# SECTION - Python for Data Engineering
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Python for Data Engineering'
  section.description = 'This section introduces you to Python basics for data engineering tasks, including data processing and automation.'
  section.identifier_uuid = '1be111f4-2e5e-4cbc-8df7-3073c00c5746'

  section.add_lessons(
    data_engineering_lessons.fetch('Python Introduction')  # Only Python Introduction
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - SQL & SQLite
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'SQL & SQLite'
  section.description = 'This section covers SQL queries and working with SQLite for data manipulation and storage.'
  section.identifier_uuid = '0195da75-5cbc-40cc-a910-67f4ef4e41ea'

  section.add_lessons(
    data_engineering_lessons.fetch('SQL & SQLite Intro'),
    data_engineering_lessons.fetch('SQL for Data Engineering'),
    data_engineering_lessons.fetch('SQLite: Power and Pitfalls')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Data Engineering End-to-End
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Data Engineering End-to-End'
  section.description = 'Learn how to build a complete data engineering pipeline, from data ingestion to processing and storage.'
  section.identifier_uuid = '3177f650-c996-40f1-854d-28c54df1c108'

  section.add_lessons(
    data_engineering_lessons.fetch('End-to-End Data Engineering Intro'),
    data_engineering_lessons.fetch('End-to-End Project')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Data Visualization Tools
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Data Visualization Tools'
  section.description = 'Learn to visualize and interpret data using tools like Tableau and PowerBI, and AWS CLI for setup.'
  section.identifier_uuid = '29398ecf-fd42-4b90-9498-64506e264536'

  section.add_lessons(
    data_engineering_lessons.fetch('Data Visualization Tools Intro'),
    data_engineering_lessons.fetch('Data Visualization Tools Overview')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Storage Systems
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Storage Systems'
  section.description = 'This section focuses on different storage systems, including DuckDB, PostgreSQL, and ClickHouse.'
  section.identifier_uuid = 'a892c4b8-5fb4-4d17-bf6f-433308615262'

  section.add_lessons(
    data_engineering_lessons.fetch('Storage 01_duckdb Intro'),
    data_engineering_lessons.fetch('Storage 01_duckdb DuckDB'),
    data_engineering_lessons.fetch('Storage 02_postgresql Intro'),
    data_engineering_lessons.fetch('Storage 02_postgresql Data Types'),
    data_engineering_lessons.fetch('Storage 02_postgresql Scale and Speed'),
    data_engineering_lessons.fetch('Storage 02_postgresql Extensions'),
    data_engineering_lessons.fetch('Storage 03_clickhouse Intro'),
    data_engineering_lessons.fetch('Storage 03_clickhouse Columnar Storage'),
    data_engineering_lessons.fetch('Storage 03_clickhouse Data Compression'),
    data_engineering_lessons.fetch('Storage 03_clickhouse Performance'),
    data_engineering_lessons.fetch('Storage 04_lakehouse Intro'),
    data_engineering_lessons.fetch('Storage 04_lakehouse Delta Intro'),
    data_engineering_lessons.fetch('Storage 04_lakehouse Polars Delta')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - ETL Workflows
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'ETL Workflows'
  section.description = 'Learn how to automate ETL (Extract, Transform, Load) workflows with tools like Airflow and Dagster.'
  section.identifier_uuid = '1559f4fc-89b4-4a5d-8a2b-1b550ee59053'

  section.add_lessons(
    data_engineering_lessons.fetch('ETL 01_data_preprocessing Intro'),
    data_engineering_lessons.fetch('ETL 01_data_preprocessing Polars'),
    data_engineering_lessons.fetch('ETL 02_workflow_orchestration Intro'),
    data_engineering_lessons.fetch('ETL 02_workflow_orchestration Airflow'),
    data_engineering_lessons.fetch('ETL 02_workflow_orchestration Dagster'),
    data_engineering_lessons.fetch('ETL 02_workflow_orchestration Flyte')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Analytics and Reporting
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Analytics and Reporting'
  section.description = 'Learn how to perform data analytics and create reports to visualize the outcomes using tools like Seaborn and Superset.'
  section.identifier_uuid = 'b7e4c844-f91e-47de-84db-1defd1a40870'

  section.add_lessons(
    data_engineering_lessons.fetch('Analytics 00_intro'),
    data_engineering_lessons.fetch('Analytics 01_intro_visualization'),
    data_engineering_lessons.fetch('Analytics 02_tools'),
    data_engineering_lessons.fetch('Analytics 03_seaborn'),
    data_engineering_lessons.fetch('Analytics 04_superset')
  )
end

# +++++++++++++++++++++++++++++++
# SECTION - Distributed Data Processing
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Distributed Data Processing'
  section.description = 'This section will teach you the fundamentals of distributed data processing using frameworks like Spark and Hadoop.'
  section.identifier_uuid = 'e62ae789-6bc7-496d-9404-964925944de5'

  section.add_lessons(
    data_engineering_lessons.fetch('Distributed Data Processing Introduction')
  )
end

# Clean up removed seeds
course.delete_removed_seeds
path.delete_removed_courses
