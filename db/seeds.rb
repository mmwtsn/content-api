# Drop all MySQL database tables except "users" and "schema_migrations" tables
ActiveRecord::Base.establish_connection
ActiveRecord::Base.connection.tables.each do |table|
  ActiveRecord::Base.connection.execute("TRUNCATE #{table}") unless table == "schema_migrations" || table == "users"
end

# Path to default seed images
images_path = './public/assets/images/seed'

# Seed data for Solutions Pages and their nested Scenarios and Resources
solutions = [
  {
    page: {
      name:  'Gaming Solution',
      header: File.open("#{images_path}/gaming_header.jpg"),
      title: 'For game developers and publishers: the game is on',
      body:  'To capture and impress players around the world, gain an advantage with the SoftLayer global high-performance hosting and delivery network, along with our integrated development platform.'
    },
    scenarios: [
      {
        name:  'Gaming IaaS Scenario',
        quote: 'I want to power up our games\' performance globally',
        pitch: 'High-performance, self-service SoftLayer IaaS for gaming',
        avatar: File.open("#{images_path}/gaming_iaas_persona.png")
      },
      {
        name:  'Gaming Bluemix Scenario',
        quote: 'I want to test and deploy our games on the same platform',
        pitch: 'IBM Bluemix platform services',
        avatar: File.open("#{images_path}/gaming_bluemix_persona.png")
      }
    ]
  },
  {
    page: {
      name:  'DevOps Solution',
      header: File.open("#{images_path}/devops_header.jpg"),
      title: 'DevOps in the cloud: from idea to production in minutes',
      body:  'Your team depends on a collection of services for application development and deployment, but limited integration can slow you down. Consistently deliver high-quality software faster using IBM DevOps Services on our IBM Bluemix cloud platform — an end-to-end solution with the services you need to deliver your innovative ideas quickly.'
    },
    scenarios: [
      {
        name:  'DevOps Mobile Scenario',
        quote: 'I want to build, deploy and optimize mobile and cloud applications quickly',
        pitch: 'Experience a rapid development environment with integrated services for DevOps',
        avatar: File.open("#{images_path}/devops_mobile_persona.png")
      },
      {
        name:  'DevOps UX Scenario',
        quote: 'I need to monitor the user experience of mobile and cloud apps and respond quickly',
        pitch: 'Improve mobile and cloud app quality and manage risks with visibility into the user experience',
        avatar: File.open("#{images_path}/devops_ux_persona.png")
      }
    ]
  },
  {
    page: {
      name:  'Mobile Solution',
      header: File.open("#{images_path}/mobile_header.jpg"),
      title: 'Accelerated mobile app development with IBM Bluemix',
      body:  'Quickly develop and deliver custom mobile applications using the powerful, integrated services of our IBM Bluemix platform. With backend services for data and security, SDKs for iOS, Android and JavaScript, and a rich set of mobile-ready APIs – you can mix and match services to quickly power your mobile apps.'
    },
    scenarios: [
      {
        name:  'Mobile Scenario',
        quote: 'I want to develop mobile apps quickly and easily…with a thriving ecosystem of services',
        pitch: 'Services for mobile application development',
        avatar: File.open("#{images_path}/mobile_persona.png")
      }
    ],
    resources: [
      {
        body: 'Mobile app development technical library',
        url:  'http://www.ibm.com/developerworks/mobile/index.html'
      },
      {
        body: 'Mobile development offerings and free trials',
        url:  'http://www.ibm.com/developerworks/mobile/products.html'
      },
      {
        body: 'Mobile communities and blogs',
        url:  'http://www.ibm.com/developerworks/mobile/connect.html'
      }
    ]
  }
]

# Seed new Solutions Pages with Scenarios and Resources
solutions.each do |solution|
  s = Page.new solution[:page]

  if solution[:scenarios]
    solution[:scenarios].each do |scenario|
      s.scenarios.new scenario
    end
  end

  if solution[:resources]
    solution[:resources].each do |resource|
      s.resources.new resource
    end
  end

  s.save!
end
