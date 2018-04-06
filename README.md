# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

Generate ethereum addresses
rails runner "Ethereum::CreateAddressService.call(n)", n - number of ethereum addresses

Generate bitcoin addresses
rails runner "Bitcoin::CreateAddressService.call(n)", n - number of bitcoin addresses

Generate litecoin addresses
rails runner "Litecoin::CreateAddressService.call(n)", n - number of litecoin addresses
