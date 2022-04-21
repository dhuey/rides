# LINK Rides
LINK Rides is a ride-sharing web application designed to connect international students in Manhattan, Kansas with volunteer drivers. It has over 200 users and has been the platform responsible for over 100 rides given to international students in the Manhattan, Kansas community.

**Production:** [link-rides.com](https://link-rides.com)
**Staging:** [link-rides-staging.herokuapp.com](http://link-rides-staging.herokuapp.com)


### 🛠 Tech Stack
* Ruby on Rails
* Devise for authentication
* Rollbar for error tracking
* Codeship for CI/CD
* SendGrid for email handling
* Bootstrap CSS framework
* SASS
* PostgreSQL for the database
* Rspec for testing
* A pinch of custom JavaScript
* A few calls to the GroupMe Bots API

#### How It Works
When a user signs up, they indicate whether they are an international student or a driver. When an international student requests a ride, we call the GroupMe API and post a message in the corresponding GroupMe chat (male or female)*. After being manually verified by the LINK Rides admin team, drivers are inducted into the GroupMe and allowed to see these ride request messages.

From there, a driver clicks on the link in the GroupMe and is taken to the ride details page. If they decide to claim** the ride, they will either select which vehicle they will be driving or be prompted to create a new one. Once the ride is claimed, the international student will receive an email notification detailing who their driver is and what vehicle they will be driving.

On the ride detail page, users are able to view both the requester's and the driver's profiles. This is where each person's contact information is stored, so that drivers and international students can connect and hash out further details for the ride.

After the ride has been given, drivers go back to LINK Rides and mark the ride as complete. If they forget to do so, an email reminder will be sent 24 hours after the original pickup time for the ride.

*Drivers are placed in GroupMe chats based on their gender because drivers are only able to see rides requested by international students of their same gender. This is an intentional design decision to protect international students and drivers, uphold customs, and in general avoid potentially uncomfortable situations for some users.

**A claimed ride means that the ride now "belongs" to the driver, and is no longer claimable by other drivers.

#### For Developers
LINK Rides operates on a fairly standard Ruby on Rails development environment.

We're currently running `Ruby v2.6.5` and `Rails 6.0.0`.

If you'd like to run LINK Rides locally, you'll need to install ImageMagick, which you can do by [following the instructions here](https://imagemagick.org/script/download.php) (hint: `brew install imagemagick` if you're on MacOS).

Additionally, you'll need to reach out to myself, [Dalton Huey](https://github.com/dhuey), for an invite into the Development GroupMe and the appropriate `bot_id` environment variables.

**Other tools you'll need:**
* Postgres and a PostgreSQL server
* Node
* Yarn

##### A word about emails
LINK Rides uses the `letter_opener` gem to handle viewing emails in the development and staging environments. In a local development environment, `letter_opener` will open a new tab with the email content whenever an email is sent.

In the staging environment, emails can be viewed at http://link-rides-staging.herokuapp.com/letter_opener in a mock inbox.

### 📖 The Story
In my time working with International LINK, and ministry that serves international students, I was tasked with creating a personal project. I noticed that the public transportation system in Manhattan was lacking, and that many international students came to our city and struggled to get around.

At that time (fall 2019), I was also working a part-time job as a web developer. As I thought through what type of project I could make, a web application like LINK Rides made a lot of sense. I developed what became the bones of LINK Rides—affectionately named "Not Uber," just to make it clear.

The project got some nods, and a little bit of excitement, but no real drive to move forward. It seemed that LINK Rides was placed firmly in the "maybe someday" pile of projects.

But when the COVID-19 pandemic hit the following spring, things changed (to put it lightly). We realized that with the new restrictions, our ministry wasn't able to meet and serve international students very easily. LINK Rides moved to the front of the line.

The first production iteration of LINK Rides was released in the fall of 2020, and turned out to be a great tool for our ministry, and a great aid to the international students of our community. It continues to be a tool that International LINK uses to serve international students.

To date, LINK Rides has over **200 users** and has been the platform responsible for over **100 ride**s given to international students in the Manhattan, Kansas community.
