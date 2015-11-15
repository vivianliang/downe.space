from django.conf import settings
import googlemaps


def get_coords(address):
  gmaps = googlemaps.Client(key=settings.GOOGLEMAPS_KEY)
  geocode_result = gmaps.geocode(address)
  if len(geocode_result) > 1:
    raise Exception('too many results')
  return geocode_result[0]['geometry']['location']


def mi_to_km(miles):
  return miles / 0.62137


def km_to_mi(kilometers):
  return kilometers * 0.62137
