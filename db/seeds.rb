# Drop all MySQL database tables except "users" and "schema_migrations" tables
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless table == "schema_migrations" || table == "users"
end

# Path to default seed images
images_path = './public/assets/images/seed'

# Seed new Page records
Page.create!([
  {
    name:  'Gaming Solution',
    header: File.open("#{images_path}/gaming_header.jpg"),
    title: 'For game developers and publishers: the game is on',
    body:  'To capture and impress players around the world, gain an advantage with the SoftLayer global high-performance hosting and delivery network, along with our integrated development platform.'
  },
  {
    name:  'DevOps Solution',
    header: File.open("#{images_path}/devops_header.jpg"),
    title: 'DevOps in the cloud: from idea to production in minutes',
    body:  'Your team depends on a collection of services for application development and deployment, but limited integration can slow you down. Consistently deliver high-quality software faster using IBM DevOps Services on our IBM Bluemix cloud platform — an end-to-end solution with the services you need to deliver your innovative ideas quickly.'
  },
  {
    name:  'Startups Solution',
    header: File.open("#{images_path}/startups_header.jpg"),
    title: 'As the leader of a startup company, do you dream of disruption?',
    body:  'Deliver radical innovation using the power of IBM Cloud. Ideal for propelling startups, cloud services can virtually eliminate resource constraints and connect you with the elements you need to get new products and services into the hands of customers fast.'
  }
]);
