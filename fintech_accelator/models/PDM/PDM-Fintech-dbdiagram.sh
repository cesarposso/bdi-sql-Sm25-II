// Credit Card Transaction System - dbdiagram Syntax
// link: https://dbdiagram.io/d/PDM-Fintech-dbdiagram-io-68123c961ca52373f50088ff

Table fintech.CLIENTS {
  client_id varchar(50) [pk]
  first_name varchar(100)
  middle_name varchar(100)
  last_name varchar(100)
  gender varchar(10)
  birth_date date
  email varchar(255)
  phone varchar(50)
  address varchar(255)
}

Table fintech.CREDIT_CARDS {
  card_id varchar(50) [pk]
  client_id varchar(50) [ref: > fintech.CLIENTS.client_id]
  issue_date date
  expiration_date date
  status varchar(20)
  franchise_id varchar(50) [ref: > fintech.FRANCHISES.franchise_id]
}

Table fintech.FRANCHISES {
  franchise_id varchar(50) [pk]
  name varchar(100)
  issuer_id varchar(50) [ref: > fintech.ISSUERS.issuer_id]
  country_code varchar(10) [ref: > fintech.COUNTRIES.country_code]
}

Table fintech.ISSUERS {
  issuer_id varchar(50) [pk]
  name varchar(100)
  bank_code varchar(50)
  contact_phone varchar(50)
  international boolean
  country_code varchar(10) [ref: > fintech.COUNTRIES.country_code]
}

Table fintech.COUNTRIES {
  country_code varchar(10) [pk]
  name varchar(100)
  currency varchar(10)
  region_id varchar(50) [ref: > fintech.REGIONS.region_id]
}

Table fintech.REGIONS {
  region_id varchar(50) [pk]
  name varchar(100)
}

Table fintech.TRANSACTIONS {
  transaction_id varchar(50) [pk]
  card_id varchar(50) [ref: > fintech.CREDIT_CARDS.card_id]
  amount decimal(15,2)
  currency varchar(10)
  transaction_date timestamp
  channel varchar(50)
  status varchar(20)
  device_type varchar(50)
  location_id varchar(50) [ref: > fintech.MERCHANT_LOCATIONS.location_id]
  method_id varchar(50) [ref: > fintech.PAYMENT_METHODS.method_id]
}

Table fintech.MERCHANT_LOCATIONS {
  location_id varchar(50) [pk]
  store_name varchar(100)
  category varchar(100)
  city varchar(100)
  country_code varchar(10) [ref: > fintech.COUNTRIES.country_code]
  latitude decimal(10,6)
  longitude decimal(10,6)
}

Table fintech.PAYMENT_METHODS {
  method_id varchar(50) [pk]
  name varchar(100)
}