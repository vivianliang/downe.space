from django.conf import settings
from django.contrib.auth import logout as auth_logout
from django.shortcuts import redirect
from rest_framework.views import APIView


class LogoutView(APIView):
  def get(self, request):
    auth_logout(request)
    return redirect(settings.APP_URL)
