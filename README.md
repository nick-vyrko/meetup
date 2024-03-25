# README

## Meetup app
This is an event ticket booking system


## Getting started

### Installation

This app requires:
- Ruby 3.2.3
- Rails 7.1.3
- PostgreSQL
- Redis

1. Clone the repo

   `git clone git@github.com:nick-vyrko/meetup.git`
2. Install all the dependencies

   Run `bundle install`
2. Setup ENV variables in `.env` file
3. Create and setup a database

   Run `bundle exec rails db:create db:schema:load`
3. Start the sidekiq

   Run `bundle exec sidekiq`
3. Start the server

   `bundle exec rails s`
4. Open browser `http://localhost:3000`

### Testing

Run RSpec tests:

`bundle exec rspec`

## Solution

### Authentication
Authentication is done via [ActiveModel::SecurePassword](https://api.rubyonrails.org/v7.1.3/classes/ActiveModel/SecurePassword/ClassMethods.html

### Async jobs
Asynchronous processing is done via [sidekiq](https://github.com/sidekiq/sidekiq) 

Tickets for the newly created event are created in `CreateTicketsJob`
Booked tickets counter is increased in `IncreaseBookedTicketsCounterJob`
When an event has passed we destroy unbooked tickets in `CleanUpUnusedTicketsJob`

## Database

Entity Relationship Diagram:
![ERD](https://github.com/nick-vyrko/meetup/assets/1536587/96e78d00-3b85-4ab3-a372-10ee896accd9)

## Challenges

### Concurrency Handling:
To avoid lost booking data `pessimistic loking` mechanism has been used.
Whenever a user tries to book tickets they are locked until the transaction finished. This prevents from booking by other users  
If we were able to get the requested amount of tickets then they are unlocked and unprocessable_entity response is returned

### Performance: 
> Implement caching to improve the performance of the application. Use Rails' built-in caching mechanisms.

To get better performance caching is used. 
- We cache the events collection that is returned on `events#index` for 5 minutes. 
This does not impact user experience and we have time to asynchronously generate the required amount of tickets for newly created events

- We use fragment caching to cache `events/index/event` partial and they are only updated when the amount of available tickets is changed

- We use Redis to store the amount of booked tickets per event. This is implemented using redis list data type. 
It allows us to insert new elements in O(1) time complexity. And to get the size of the list also in O(1) time.
Therefore when we successfully booked a certain amount of tickets we call `IncreaseBookedTicketsCounterJob` 
that pushes the same number of elements to the redis list

## Next Steps

1. We can use ETag caching for `attended_events_controller`, `organized_events_controller.rb` controllers' pages. 
This will improve the load speed of pages
2. Use database partitioning and split events by year and month. With this approach we can easily reduce events collections that are loaded on `events#index` page.
Also we will be able to easily archive/remove past events without any impact on the current/upcoming events 
