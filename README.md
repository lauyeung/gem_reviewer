Gem Reviewer README
===================

[![Build Status](http://allthebadges.io/lauyeung/gem_reviewer/travis.png)](http://allthebadges.io/lauyeung/gem_reviewer/travis)
[![Coverage](http://allthebadges.io/lauyeung/gem_reviewer/coveralls.png)](http://allthebadges.io/lauyeung/gem_reviewer/coveralls)
[![Code Climate](http://allthebadges.io/lauyeung/gem_reviewer/code_climate.png)](http://allthebadges.io/lauyeung/gem_reviewer/code_climate)

Gem Reviewer (http://gem-reviewer.herokuapp.com) is a review site for Ruby Gems.

With Gem Reviewer, you can:
* Submit a gem to review
* Write reviews about gems
* Upvote/downvote other people's reviews
* Comment on reviews

Technical Requirements
-------------------
* Ruby 2.0.0p247
* Rails 4.0.0
* PostgreSQL (<tt>rake db:migrate</tt> to set up the database, run <tt>rake db:test:prepare</tt> to set up the test database)
* Run tests using <tt>rake spec</tt> or <tt>rspec [TEST TO RUN]</tt>

ER Diagram
-------------------
![er-diagram](https://lh5.googleusercontent.com/-g9JYKnSlCZQ/UmXUpXngCuI/AAAAAAAANYg/-17izrsgudQ/w688-h421-no/gem_reviewer_er_diagram.png)

Review and Voting
-------------------
![logged-in](https://lh3.googleusercontent.com/-wmGWvBrtWXg/UmXUqjf3vaI/AAAAAAAANYs/9Twixgsl5eM/w968-h370-no/gem_reviewer.png)

Next Steps
-------------------
* Incorporate Ruby Gems API
* Add ability to edit/delete comments
* Add votes for gems and/or comments

Collaborators
-------------------
* [Louise Au Yeung](https://github.com/lauyeung)
* [Tom Corley](https://github.com/mgidea)
* [Alex Phinzy](https://github.com/Aphin715)
* [Stephanie Viccari](github[https://github.com/SViccari)

Team led by [Adam Sheehan](https://github.com/atsheehan)
