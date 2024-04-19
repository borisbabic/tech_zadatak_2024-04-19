# tech_zadatak_2024-0419
Tech part of an interview

# Running
* `asdf install` 
* `docker-compose up -d`
* `mix deps.get` 
* `mix ecto.setup` # setup db
* `iex -S mix phx.server` -- run project

# Task
- DB model and REST api to support graph and calendar, no gui or auth
- **Assumption** For the purpose of the interview it's not necessary to care about things like timezones, ie approach it like when physicists assume there is no friction

# Entities
## User
- first name
- last name
- dob
- email
- phone number
## Device
- manufacturer
- model
- serial number
## Device Reading
- timestamp
- glucose value (int  1024)
- assume mg/dL
- device serial number

## Account setup
- select device(s)
- reading belongs to user if device associated with the user
- **Assumption** - a device can only belong to one user (at a time) 

# Overviews 
## User Overview (Graph)
 - How is the user doing 
 - Timespan - days, max 90, default 14 
 - **Assumption** - Graphing is done on the client, we don't need to generate it and then send it,

## Device Overview (Calendar)
- Is there a problem with the device (too much data, no data)
- last 30 days, per day device readings for a user