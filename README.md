# Greg Martin - T2A2
## mArtketplace: Ruby on Rails two-sided marketplace application
---------
### R10. GitHub repository: https://github.com/GregM1991/mArtketplace
### R9. Deployed app: https://martketplace.herokuapp.com/
---
### R7. Identification of the problem you are trying to solve
Art is the universal language. Everyone across the globe recognises and understands to a degree, graphical images. Especially with the recent events of covid-19, people need now more than ever, an area in which they can access artwork and prints, to lift their spirits and boost their home office moods. There is a gap in the market for an application that allows for buying and swapping of artworks online. At the moment there are plenty of websites out there (Society6 and RedBubble for example) that allow for purchase of an artwork, but it doesn't allow for users to post their own artwork, unless they themselves have created it.

---
### R8. Why does this need solving?
This is where my two way marketplace app, mArtketplace, comes in. People can post their very own prints and artworks on the mArtketplace allowing for others to view and contact for buying of that art. Without this mArtketplace application, there's no centralised online presence for people to sell the prints that they own, as well as in the same swift visit, buy another persons print that they are selling.

---
### R11. Description of mArtketplace
#### Purpose
People can post their very own prints and artworks on the mArtketplace allowing for others to view and contact for buying of that art.

#### Functionality / Features
1. Users can create an account. 
2. They can view the range of listings. 
3. They can create, read, update and delete their own listings. 
4. They can donate to the website, $10 at a time.

#### Sitemap
![Sitemap]( /mArtketplace/documentation/wireframesSitemap/SiteMap.png )

#### Screenshots
Home/Splash page
![Home/Splashpage]( /mArtketplace/documentation/websiteScreenshots/4.png )
Showroom Page
![ShowroomPage]( /mArtketplace/documentation/websiteScreenshots/5.png )
Showroom Mobile Page
![ShowroomMobile]( /mArtketplace/documentation/websiteScreenshots/6.png )
Login Page
![Login]( /mArtketplace/documentation/websiteScreenshots/3.png )
Edit Print Page
![Edit]( /mArtketplace/documentation/websiteScreenshots/2.png )
Show Page
![Showpage]( /mArtketplace/documentation/websiteScreenshots/1.png )

#### Target Audience
The target audience for this website would range between young families to middle aged couples looking to refresh their living/office/bedroom space. They would have art ready to be taken down and put on the market, or have created the art themselves as a producer. 

#### The Tech Stack
**Front End:**  HTML5, CSS3/Custom CSS, Embedded Ruby.<br>
**Back End:** Ruby 2.7, Ruby on Rails 6.0.3.<br>
**Database:** PostgreSQL, DBeaver.<br>
**Deployment:** Heroku. <br>
**Business Tools:** Pivotal Tracker. <br>
**Utilities:** Stripe, Devise, AWS S3. <br>
**DevOps:** Git, GitHub, VS Code, Bundler, Balsamiq Wireframes. <br>

---
### R12. User stories
1. As a user, I want to be able to create an account to view and upload prints.
2. As a user, I want to be able to see all the listings on the page.
3. As a user, I want to be able to create, update and/or delete a post that I have created.
4. As a user, I don't want other users to alter or delete my post.
5. As a user, I want to be able to see the contact info of the person who posted the listing.
6. As a user, I want to see the price of the listing from the showroom page.
7. As a user, I'd like to be able to see a decent preview before clicking through to the whole listing.

---
### R13. Wireframes
I've developed wireframes for three screen sizes; desktop, tablet and mobile. 

### Home/Splash Page
![Home/Splashpage]( /mArtketplace/documentation/wireframesSitemap/Home_Splashpage.png )

### Login/Signup Page
![Login/Signup]( /mArtketplace/documentation/wireframesSitemap/Login_signup.png )

### Show Page
![Showpage]( /mArtketplace/documentation/wireframesSitemap/ShowPage.png )

### Showroom
![ShowroomPage]( /mArtketplace/documentation/wireframesSitemap/Showroom.png )

---
### R14. ERD
![ShowroomPage]( /mArtketplace/documentation/ERD/mArtketplaceERD.png )

---
### R15. The components of the application
mArtketplace is an application written using Ruby on Rails and PostgreSQL as the database. It utilises the model-view-controller (MVC) to compartmentalise the applications tasks, and how data is retrieved, executed and sent around the application. CRUD capabilities are implemented and the use of RESTful routes are implemented for ease of use and control by the user.

The mArtketplace at it's core is a very simple app, with the primary feature being able to post listings for other users to view and potentially contact the poster to buy.

To do this, a user would have to create an account within the app. They do this by way of entering a user name and password. This is handled by the 3rd party app Devise. It is capable of handling encryption of passwords as well as user authorisation and authentication. It limits what a user is able to see/do within the app, such as deleting or editing another users listing and vice versa.

Once logged in, the user is then able to browse listings as well as create a new listing of their own. They have the ability to provide info on the listing which includes images. Images are handled with active storage on AWS' S3 buckets. This listing is stored to the PostgreSQL database as a child of the user who created the listing, and the users name is attached and presented along with the listing, so users interested in buying can get in contact. The exchange of goods and payment is handled offsite as it is not set up to handle such actions.

If a user is tickled by the website, they may choose to donate to the website $10, which is handled by the Stripe API, they are taken off site to be handled securely by Stripe itself, where they enter their card details and finish the transaction.

---
### R16. Third Party Services
**Devise:** Devise has been used to handle user authentication. It allows users to sign up through the app, which is handled by devise regarding the encryption of their password as well as the storing to the database.

**Stripe:** The stripe API allows users to securely donate to the mArtketplace team.

**Amazon S3 Buckets:** Allows for the uploading and cloud-based storage for listing pictures.

---
### R17. Model relationships
A user ```has_many``` listings, ```dependent: :destroy``` <br>
A listing ```belongs_to``` user <br>
A listing ```has_one_attached``` picture

```
    class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
            :recoverable, :rememberable, :validatable
    has_many :listings, dependent: :destroy
    end

    class Listing < ApplicationRecord
    belongs_to :user
    validates :title, :description, :price, presence: true
    has_one_attached :picture
    end
```

---
### R18. Database Relations
Once again the simplicity of the mArtketplace app is the winner here. With the only database relationships being that of the listing to the user, and the user to the listing. There are many users, each user can have many listings, but a listing can only have one user.

---
### R19. Databse Schema Design
#### Active_Storage_Attachments
```
    t.string "name"
    t.string "record_type"
    t.bigint "record_id"
    t.bigint "blob_id"
```
#### Active_Storage_Blobs
```
    t.string "key"
    t.string "filename"
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size"
    t.string "checksum"
```
#### Listings
```
    t.bigint "user_id", null: false
    t.string "title"
    t.text "description"
```
#### Users
```
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
```

### R20. Task Tracking and Allocation
The team is a small one, consisting of just one Dev. To keep himself accountable and to track his progress through the app, as well as to gain experience in dealing with project management on a bigger scale, the team used Pivotal Tracker.

In an attempt and effort to follow the AGILE method of project management, a plan was laid out at the very beginning to tick off as the project progressed. Due to a lack of experience with building websites, and general unsured-ness (totally a word) this plan missed a whole bunch of things that needed to be done. Luckily AGILE accounts for this, and these tasks were added in when they came to the front of the teams mind. Below is a collection of screenshots throughout the course of the project.

![pivotalTracker]( /mArtketplace/documentation/pivotalTrackerScreenshots/11:05_Monday/11.34.55am.png )
![pivotalTracker]( /mArtketplace/documentation/pivotalTrackerScreenshots/11:05_Monday/3.08.06pm.png )
![pivotalTracker]( /mArtketplace/documentation/pivotalTrackerScreenshots/14:05_Thursday/11.47.41am.png )
![pivotalTracker]( /mArtketplace/documentation/pivotalTrackerScreenshots/18:05_Monday/9.42.14am.png )
![pivotalTracker]( /mArtketplace/documentation/pivotalTrackerScreenshots/20:05_Wednesday/4.09.09pm.png )
