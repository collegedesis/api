See WIP branch for undeployed changes

Version 2.3 - Jun 4, 2013

create organization slug before create
Add loading indicator for users show page.
restrict pagination info to new scope.
add the 404 image back. Fixes #108
downcase email addresses on create. Fixes #109
create the new bulletin reliably on ever enter. Fixes #110
Send an email when memberships are destroyed
postgres config for travis
hello travis
shortened url is stored in the db so we do not have to create them on every page load
login view is a height view
Add text and nav in footer
Do not serialize bulletins that have unapproved users
Serialize only shortened urls in production
Add failing tests for membership destroy mailers
WIP of revamping users profile page.
missing end. no wonder we need tests
Break down home_page method and add some tests
write some tests for bulletins
bulletin is not approved if the associated user is not approved
loading indicators for all bulletins
Delete unused assets

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
