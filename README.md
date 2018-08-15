# README
### Link Shortener

#### This app has been deployed to Heroku - [Link Shortener Heroku App](https://link-shortener-x.herokuapp.com/).

* The Root path renders a form in which you can drop a URL. When you do, you'll get redirected to a page with a shortened URL and an admin URL.
* When you go to a shortened URL, you're redirected to the original URL that was submitted, as long as the URL is active. There is a counter which is incremented whenever a short URL is clicked.
* When you go to the Admin URL, you have the ability to expire the shortened link and see how many times the link has been used. When an expired link is clicked an empty 404 is rendered.

#### Automated Specs

Here are the test cases which are covered by automated Rspec tests:
```
Admin::LinksController
  #edit
    renders the Edit Link form
  #update
    returns a 404 if the ID is invalid
    Admin user can de-activate a short URL
    redirects to the Show URLs page

LinksController
  #new
    renders the new link template
  #create
    does not create a short URL if the submitted long URL is invalid
    creates a new link
    generates a shortened link
    generates an admin link
  #decode
    counts the usage of the short URL
    redirects to the original URL if it's active
    renders an empty 404 if the short URL is inactive
    returns a 404 if the ID is invalid
  #show
    returns a 404 if the ID is invalid

Finished in 0.78346 seconds (files took 0.84912 seconds to load)
14 examples, 0 failures```