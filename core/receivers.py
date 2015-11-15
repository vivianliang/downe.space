from django.db.models.signals import post_save
from django.dispatch import receiver
from .location_utils import get_coords
from .models import Event, Coords


@receiver(post_save, sender=Event, weak=False)
def create_coords(sender, **kwargs):
  if kwargs['created'] is True:
    coords = get_coords(kwargs['instance'].location)
    Coords.objects.create(event=kwargs['instance'], lat=coords['lat'], lon=coords['lng'])
