See WIP branch for undeployed changes


### Version 2.3.5 - Jun 12, 2013

* Disable tweeting
* Some responsive design changes

### Version 2.3.4 - Jun 9, 2013

* Various performance improvements
* Give more importance to organization display name

### Version 2.3.3 - Jun 9, 2013

* Some better instructions for how to submit bulletins
* Keep track of user approved status in users table. Fixes #122
* If a tweet fails, tweet the next bulletin
* clock task to update bulletin popularity scores. Fixes #117
* update window title in bulletin show. Fixes #121
* Update window title when the song changes
* aside needed a little cleaning
* update the welcome email
* fix bulletin promotion method
* fix twitter button

### Version 2.3.2

* design: bulletins list looks a little more airy
* design: bulletin posts are easier to read

### Version 2.3.1

* Independent Radio Channel 

### Version 2.3 - Jun 4, 2013

* performance do not serialize user_id with bulletins
* performance: store shortened_url in database 
* performance: Delete unused assets
* bugfix: create organization slug before create
* bugfix: restrict pagination info to new scope.
* bugfix: add the 404 image back. Fixes #108
* bugfix: downcase email addresses on create
* bugfix: create the new bulletin reliably on ever enter. Fixes #110
* bugfix: Do not serialize bulletins that have unapproved users
* bugfix: login view is a height view
* enhancement: Send an email when memberships are destroyed
* enhancehment: Add text and nav in footer
* internal: begin work for continuous deployment 
* internal: Serialize only shortened urls in production
* internal: write some tests for bulletins
* ux: loading indicators for all bulletins
* ux: Add loading indicator for users show page.
* ux: WIP of revamping users profile page.

### Version 2.2.1 - May 29, 2013

* bulletins posted without an approved membership assign author as the user
* Fix approved status bug for users
* classify some views as height views
* reinstate loading indicator
* Link  bulletins open in new window

### Version 2.2.0 - May 28, 2013

* Embelish about pages
* Rotating call to action on the home page
* Header subtitle
* name space radio info div css
* Add a couple views to height view
* Load directory info in application route
* align paddings
* About pages
* Paginate URL with page number. Fixes #103
* Home page is news route now
* remove old loading indicator
* Sticky footer

### Version 2.1.7 - May 24, 2013

* Fix capitalization bug for new bulletins
* Bug fix: link type bulletins do not save body attribute
* Bug fix: cannot create the same membership twice

### Version 2.1.6 - May 23, 2013

* Index slugs in database

### Version 2.1.5 - May 22, 2013

* Auto approve memberships based on settings
* Loading indicator for Bulletins on pagination
* Delete has_many associations when deleting a user

Verion 2.1.4 - May 21, 2013
