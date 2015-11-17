from django.db import models

from .event import Event


class CoordsManager(models.Manager):
  def nearby(self, lat, lon, proximity):
    # proximity in kilometers
    formula = """
      6371 * acos(
       cos(radians(%s)) * cos(radians(lat))
       * cos(radians(lon) - radians(%s))
       + sin(radians(%s)) * sin(radians(lat))
      )
      """
    distance_lt = "{} < %s".format(formula)
    return (self.get_queryset()
      .extra(
        select={'distance': formula},
        select_params=[lat, lon, lat],
        where=[distance_lt],
        params=[lat, lon, lat, proximity],
        order_by=['distance']))


class Coords(models.Model):
  event = models.ForeignKey(Event, related_name='coords')
  lat = models.FloatField()
  lon = models.FloatField()

  objects = CoordsManager()
