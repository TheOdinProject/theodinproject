# ************************
# Path - Data Engineering
# ************************
path = Seeds::PathBuilder.build do |path|
  path.title = 'Data Engineering'
  path.short_title = 'Data Engineering Path'
  path.description = "This is a comprehensive Data Engineering course where you'll learn everything from Python to distributed data systems. You'll work with real-world tools and systems used by data engineers."
  path.badge_uri = 'badge-data-engineering.svg'
  path.identifier_uuid = 'new-path-uuid'  # Unique identifier for the path
  path.position = 3  # Position of the path in the list of courses
  # path.default_path = true  # Set as the default path
end

#######################
# Course - Data Engineering
#######################

course = path.add_course do |course|
  course.title = 'Data Engineering'
  course.description = "A hands-on course in Data Engineering, teaching you Python, SQL, ETL pipelines, data storage, distributed processing, and analytics."
  course.identifier_uuid = 'new-course-uuid'  # Unique identifier for the course
  course.badge_uri = 'badge-data-engineering.svg'
end

# +++++++++++++++++++++++++++++++
# SECTION - Python for Data Engineering
# +++++++++++++++++++++++++++++++
course.add_section do |section|
  section.title = 'Python for Data Engineering'
  section.description = 'This section introduces you to Python basics for data engineering tasks, including data processing and automation.'
  section.identifier_uuid = 'python-section-uuid'

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
  section.identifier_uuid = 'sql-section-uuid'

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
  section.identifier_uuid = 'end-to-end-section-uuid'

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
  section.identifier_uuid = 'visualization-section-uuid'

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
  section.identifier_uuid = 'storage-section-uuid'

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
  section.identifier_uuid = 'etl-section-uuid'

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
  section.identifier_uuid = 'analytics-section-uuid'

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
  section.identifier_uuid = 'distributed-section-uuid'

  section.add_lessons(
    data_engineering_lessons.fetch('Distributed Data Processing Introduction')
  )
end

# Clean up removed seeds
course.delete_removed_seeds
path.delete_removed_courses
