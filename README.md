# README

Look for nearest places based on https://data.sfgov.org/resource/rqzj-sfat.json data.

# Setup

```
rake db:seed
```

# Nearest japanese restaurant on union square

```
curl -H "Content-Type: application/json" -X GET "http://localhost:3000/nearest_food_places?address=union%20square&limit=1&fooditem=Japanese&facility_type=truck"
```
